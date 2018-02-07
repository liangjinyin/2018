package com.tospur.modules.niche.service;


import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.mail.MailSendUtils;
import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.common.utils.StringUtils;
import com.tospur.modules.niche.dao.InvestmentInfoDao;
import com.tospur.modules.niche.entity.InvestmentInfo;
import com.tospur.modules.sys.entity.User;
import com.tospur.modules.sys.utils.UserUtils;

/**
 * 招标信息Service
 * @author canyu
 * @version 2016-08-12
 */
@Service
@Transactional(readOnly = false)
public class InvestmentInfoService extends CrudService<InvestmentInfoDao, InvestmentInfo> {
	public Page<InvestmentInfo> findPage(Page<InvestmentInfo> page, InvestmentInfo investmentInfo) {
		return super.findPage(page, investmentInfo);
	}
	/**
	 * 
	 * @param toEmail  收件人的邮箱
	 * @param copyEmail 抄送人的邮箱
	 */
	public void sendMail(){
	    User admin=UserUtils.getEmails("admin");
	    String toEmails=admin.getEmail();
	    String copyEmail=admin.getCopyEmails();
	    List<InvestmentInfo> contents = dao.getMailBody();
	    String theme="今日的商机信息";;
	    String content="";
	    for (InvestmentInfo investmentInfo : contents)
        {   
	        content+="<div style='font-size:15px'>[商机信息]:<a href='"+investmentInfo.getUrl()+"'>" 
                +investmentInfo.getProgramName()+"</a></div>"+ investmentInfo.getContent();
        }
	    if(!StringUtils.isEmpty(content)){
	        boolean flag=MailSendUtils.sentEmail(toEmails, copyEmail, theme, content);
	        if(flag){
	            for (InvestmentInfo investmentInfo : contents)
	            {
	                investmentInfo.setStatus(1);
	                dao.updateMailStatus(investmentInfo);
	            }
	        }
	    }
	}
	
	
	
}