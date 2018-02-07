package com.tospur.modules.email.entity;


import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.excel.annotation.ExcelField;

/**
 * emailEntity
 * @author kiss
 * @version 2017-05-19
 */
public class EmailMessage extends DataEntity<EmailMessage> {
	
	private static final long serialVersionUID = 1L;
	private String messageId;		// 消息id
	private Integer messageType;		// 消息类型。1：邮件、2：短信
	private Integer messageStatus;		// 消息状态。-1：未发送、0：发送失败、1：发送成功
	private Integer messageTemplate;		// 消息模板。
	private Date finishTime;		// 消息发送完成时间
	private String receiveNum;		// 消息接收人。可以为多个，以逗号分隔
	private String copytoNum;		// 消息抄送人。可以为多个，以逗号分隔
	private String recipientName;		// 邮件正文昵称。
	private String messageTitle;		// 邮件标题
	private String messageContent;		// 邮件正文。
	private String messageFile;		// 附件路径，没有实现文件服务器，暂时只能存放在调度服务器
	public void setALL(String toEmails, String copyEmail, String theme,
            String contents){
        this.finishTime=new Date();
        this.receiveNum=toEmails;
        this.copytoNum=copyEmail;
        this.messageTitle=theme;
        this.messageContent=contents;
    }
	public EmailMessage() {
		super();
	}

	public EmailMessage(String id){
		super(id);
	}

	@Length(min=1, max=100, message="消息id长度必须介于 1 和 100 之间")
	@ExcelField(title="消息id", align=2, sort=0)
	public String getMessageId() {
		return messageId;
	}

	public void setMessageId(String messageId) {
		this.messageId = messageId;
	}
	
	@NotNull(message="消息类型。1：邮件、2：短信不能为空")
	@ExcelField(title="消息类型。1：邮件、2：短信", align=2, sort=1)
	public Integer getMessageType() {
		return messageType;
	}

	public void setMessageType(Integer messageType) {
		this.messageType = messageType;
	}
	
	@NotNull(message="消息状态。-1：未发送、0：发送失败、1：发送成功不能为空")
	@ExcelField(title="消息状态。-1：未发送、0：发送失败、1：发送成功", align=2, sort=2)
	public Integer getMessageStatus() {
		return messageStatus;
	}

	public void setMessageStatus(Integer messageStatus) {
		this.messageStatus = messageStatus;
	}
	
	@NotNull(message="消息模板。不能为空")
	@ExcelField(title="消息模板。", align=2, sort=3)
	public Integer getMessageTemplate() {
		return messageTemplate;
	}

	public void setMessageTemplate(Integer messageTemplate) {
		this.messageTemplate = messageTemplate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="消息发送完成时间", align=2, sort=4)
	public Date getFinishTime() {
		return finishTime;
	}

	public void setFinishTime(Date finishTime) {
		this.finishTime = finishTime;
	}
	
	@Length(min=1, max=200, message="消息接收人。可以为多个，以逗号分隔长度必须介于 1 和 200 之间")
	@ExcelField(title="消息接收人。可以为多个，以逗号分隔", align=2, sort=5)
	public String getReceiveNum() {
		return receiveNum;
	}

	public void setReceiveNum(String receiveNum) {
		this.receiveNum = receiveNum;
	}
	
	@Length(min=0, max=200, message="消息抄送人。可以为多个，以逗号分隔长度必须介于 0 和 200 之间")
	@ExcelField(title="消息抄送人。可以为多个，以逗号分隔", align=2, sort=6)
	public String getCopytoNum() {
		return copytoNum;
	}

	public void setCopytoNum(String copytoNum) {
		this.copytoNum = copytoNum;
	}
	
	@Length(min=0, max=20, message="邮件正文昵称。长度必须介于 0 和 20 之间")
	@ExcelField(title="邮件正文昵称。", align=2, sort=7)
	public String getRecipientName() {
		return recipientName;
	}

	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}
	
	@Length(min=0, max=100, message="邮件标题长度必须介于 0 和 100 之间")
	@ExcelField(title="邮件标题", align=2, sort=8)
	public String getMessageTitle() {
		return messageTitle;
	}

	public void setMessageTitle(String messageTitle) {
		this.messageTitle = messageTitle;
	}
	
	@ExcelField(title="邮件正文。", align=2, sort=9)
	public String getMessageContent() {
		return messageContent;
	}

	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}
	
	@Length(min=0, max=100, message="附件路径，没有实现文件服务器，暂时只能存放在调度服务器长度必须介于 0 和 100 之间")
	@ExcelField(title="附件路径，没有实现文件服务器，暂时只能存放在调度服务器", align=2, sort=10)
	public String getMessageFile() {
		return messageFile;
	}

	public void setMessageFile(String messageFile) {
		this.messageFile = messageFile;
	}
	
    @Override
    public String toString()
    {
        return "EmailMessage [messageId=" + messageId + ", messageType="
                + messageType + ", messageStatus=" + messageStatus
                + ", messageTemplate=" + messageTemplate + ", finishTime="
                + finishTime + ", receiveNum=" + receiveNum + ", copytoNum="
                + copytoNum + ", recipientName=" + recipientName
                + ", messageTitle=" + messageTitle + ", messageContent="
                + messageContent + ", messageFile=" + messageFile + "]";
    }

}