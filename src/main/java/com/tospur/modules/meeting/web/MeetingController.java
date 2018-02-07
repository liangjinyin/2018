
package com.tospur.modules.meeting.web;

import java.util.Date;

import java.util.List;




import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.tospur.common.config.Global;

import com.tospur.common.utils.DateUtils;

import com.tospur.common.utils.StringUtils;
import com.tospur.common.web.BaseController;
import com.tospur.modules.iim.entity.Mail;
import com.tospur.modules.iim.entity.MailBox;
import com.tospur.modules.iim.entity.MailCompose;
import com.tospur.modules.iim.service.MailBoxService;
import com.tospur.modules.iim.service.MailComposeService;
import com.tospur.modules.iim.service.MailService;
import com.tospur.modules.meeting.entity.Meeting;
import com.tospur.modules.meeting.service.MeetingService;

import com.tospur.modules.sys.entity.User;

import com.tospur.modules.sys.utils.DictUtils;
import com.tospur.modules.sys.utils.UserUtils;


/**
 * 会议纪要Controller
 * @author jinyin
 * @version 2017-08-08
 */
@Controller
@RequestMapping(value = "${adminPath}/meeting/meeting")
public class MeetingController extends BaseController {

	@Autowired
	private MeetingService meetingService;
	
	
	 
	
	/**
	 * 查看会议纪要
	 * @param meeting 
	 * @param model
	 * @return
	 */
	
	@RequiresPermissions(value={"meeting:meeting:view","meeting:meeting:add","meeting:meeting:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(Meeting meeting, Model model) {
  
	    User user = UserUtils.getUser();
	    String create = user.getId();
	    Meeting temp =  meetingService.findMeeting(create);
        if(temp!=null){
            model.addAttribute("meeting", temp);
        }
		return "modules/meeting/meetingForm";
	}
	/**
	 * 取消功能
	 * @param meeting
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "toFirst")
	public String toFirst(Meeting meeting, Model model) {
		
		return "redirect:"+Global.getAdminPath();
	}

	/**
	 * 保存会议,将会议内容一草稿的方式保存起来
	 * @param meeting
	 * @param model
	 * @param redirectAttributes
	 * @return
	 * @throws Exception
	 */
	 
	@RequiresPermissions(value={"meeting:meeting:add","meeting:meeting:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(Meeting meeting, Model model, RedirectAttributes redirectAttributes) throws Exception{
		  
	        meeting.setStatus(0);//将会议的状态标记为未发送的状态
	        meetingService.save(meeting);//保存
		    model.addAttribute("meeting", meeting);
		    
    		/*将邮件保存到草稿箱中*/
            if(!StringUtils.isEmpty(meeting.getMainEmail())){  
                String beginTime = DateUtils.formatDateTime(meeting.getBeginTime());
                String content="会议主题:&nbsp;"+meeting.getTheme()+"<br/>"+
                                "召集人:&nbsp;"+meeting.getCaller()+"<br/>"+   
                                "会议时间:&nbsp;"+beginTime+"<br/>"+   
                                "会议地点:&nbsp;"+meeting.getAddress()+"<br/>"+   
                                "记录人:&nbsp;"+meeting.getRecorder()+"<br/>"+   
                                "会议目标:&nbsp;"+meeting.getPurpose()+"<br/>"+   
                                "会议出席人员:&nbsp;"+meeting.getAttender()+"<br/>"+   
                                "会议缺席人员:&nbsp;"+meeting.getAbsentee()+"<br/>"+   
                                "会议耗时:&nbsp;"+meeting.getMeetingTime()+"<br/>"+   
                                "会议内容:&nbsp;"+meeting.getContent()+"<br/>" ;
                
                Mail mail=new Mail(meeting.getTheme()+"会议纪要", meeting.getTheme()+"会议纪要", content);
               
                sendMassage(mail, meeting.getMainEmail(),"0");//保存会议内容到草稿
                //SendEmailUtils.sendMassage(mail, meeting.getMainEmail(),"0");//保存会议内容到草稿
                addMessage(redirectAttributes, "保存会议成功！");
               
    		
    		/*return "redirect:"+Global.getAdminPath()+"/meeting/meeting/?repage";*/
		}
		
    		return "redirect:"+Global.getAdminPath()+"/meeting/meeting/form";
	}
	/**
	 * 保存会议纪要，并发送到主送人和抄送人的邮箱
	 * @param meeting
	 * @param model
	 * @param redirectAttributes
	 * @return
	 * @throws Exception
	 */
	
	@RequiresPermissions(value={"meeting:meeting:add","meeting:meeting:edit"},logical=Logical.OR)
	@RequestMapping(value = "sendEmail")
	public String sendEmail(@Validated Meeting meeting, Model model, RedirectAttributes redirectAttributes ,Errors errors) throws Exception{
	   
	    if (errors.hasErrors()) {
            model.addAttribute("errors", errors);
            return "meetingForm";
	    }
	    meeting.setStatus(1);
        meetingService.save(meeting);//保存
	   
        if(!StringUtils.isEmpty(meeting.getMainEmail())){
            String beginTime = DateUtils.formatDateTime(meeting.getBeginTime());
            String content="会议主题:&nbsp;"+meeting.getTheme()+"<br/>"+
                            "召集人:&nbsp;"+meeting.getCaller()+"<br/>"+   
                            "会议时间:&nbsp;"+beginTime+"<br/>"+   
                            "会议地点:&nbsp;"+meeting.getAddress()+"<br/>"+   
                            "记录人:&nbsp;"+meeting.getRecorder()+"<br/>"+   
                            "会议目标:&nbsp;"+meeting.getPurpose()+"<br/>"+   
                            "会议出席人员:&nbsp;"+meeting.getAttender()+"<br/>"+   
                            "会议缺席人员:&nbsp;"+meeting.getAbsentee()+"<br/>"+   
                            "会议耗时:&nbsp;"+meeting.getMeetingTime()+"<br/>"+   
                            "会议内容:&nbsp;"+meeting.getContent()+"<br/>" ;
            
            Mail mail=new Mail(meeting.getTheme()+"会议纪要", meeting.getTheme()+"会议纪要", content);
           
            sendMassage(mail, meeting.getMainEmail()+","+meeting.getAddEmail(),"1");
           // SendEmailUtils.sendMassage(mail, meeting.getMainEmail()+","+meeting.getAddEmail(),"1");
        }else{
            
            addMessage(redirectAttributes, "会议不能为空！");
        }
        addMessage(redirectAttributes, "发送会议成功！");
   
        return "redirect:"+Global.getAdminPath()+"/meeting/meeting/form";
	}
	/*
	邮件的发送*/
	@Autowired
    private MailComposeService mailComposeService;
    
    @Autowired
    private MailBoxService mailBoxService;
    @Autowired
    private MailService mailService;
   
   /**
     * 发送邮件
     * @param mail 邮件
     * @param receiverNames 接收者
     * @param status 0 草稿  1 发送
     */
    private void sendMassage(Mail mail,String receiverNames,String status){
        
        List<User> receiverList=Lists.newArrayList();
        for (User user : DictUtils.fundUsers())
        {
            if(receiverNames!=null&&receiverNames.contains(user.getName())){
                receiverList.add(user);
            }
        }
        MailCompose mailCompose=new MailCompose();
        mailCompose.setStatus(status);
        mailCompose.setReceiverList(receiverList);
        mailService.saveOnlyMain(mail);
        mailCompose.setMail(mail);
        Date date = new Date(System.currentTimeMillis());
        mailCompose.setSender(UserUtils.getUser());
        mailCompose.setSendtime(date);
        for(User receiver : receiverList){
            mailCompose.setReceiver(receiver);
            mailCompose.setId(null);//标记为新纪录，每次往发件箱插入一条记录
            mailCompose.setIsNewRecord(true);
            mailComposeService.save(mailCompose);//0 显示在草稿箱，1 显示在已发送需同时保存到收信人的收件箱。
            if(mailCompose.getStatus().equals("1"))//已发送，同时保存到收信人的收件箱
            {
                MailBox mailBox = new MailBox();
                mailBox.setReadstatus("0");
                mailBox.setReceiver(receiver);
                mailBox.setSender(UserUtils.getUser());
                mailBox.setMail(mailCompose.getMail());
                mailBox.setSendtime(date);
                mailBoxService.save(mailBox);
            }
        }
    }

}