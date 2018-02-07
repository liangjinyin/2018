package com.tospur.modules.niche;

import com.tospur.common.mail.MailSendUtils;
import com.tospur.modules.email.dao.EmailMessageDao;
import com.tospur.modules.email.entity.EmailMessage;

public class SendEmail extends Thread
{
    /**
     * 发送地址 多个逗号隔开
     */
    String toEmails;
    
    /**
     * 抄送地址 多个逗号隔开
     */
    String copyEmail;
    
    /**
     * 主题
     */
    String theme;
    
    /**
     * 内容html文本
     */
    String contents;
    
    EmailMessageDao emailMessageDao;
    
    public SendEmail(String toEmails, String copyEmail, String theme,
            String contents, EmailMessageDao emailMessageDao)
    {
        this.toEmails = toEmails;
        this.copyEmail = copyEmail;
        this.theme = theme;
        this.contents = contents;
        this.emailMessageDao = emailMessageDao;
    }
    
    @Override
    public void run()
    {
        try
        {
            boolean flag = MailSendUtils.sentEmail(toEmails,
                    copyEmail,
                    theme,
                    contents);
            EmailMessage mail = new EmailMessage();
            mail.setALL(toEmails, copyEmail, theme, contents);
            if (flag) {
                mail.setMessageStatus(1);
            }  else {
                mail.setMessageStatus(0);
            }
            emailMessageDao.insert(mail);
        }
        catch (Exception e)
        {
           System.out.println(e.getMessage());
        }
    }
    
}
