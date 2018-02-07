package com.tospur.modules.email.service;



import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.email.dao.EmailMessageDao;
import com.tospur.modules.email.entity.EmailMessage;

/**
 * emailService
 * @author kiss
 * @version 2017-05-19
 */
@Service
@Transactional(readOnly = true)
public class EmailMessageService extends CrudService<EmailMessageDao, EmailMessage> {

	public EmailMessage get(String id) {
		return super.get(id);
	}
	
	public List<EmailMessage> findList(EmailMessage emailMessage) {
		return super.findList(emailMessage);
	}
	
	public Page<EmailMessage> findPage(Page<EmailMessage> page, EmailMessage emailMessage) {
		return super.findPage(page, emailMessage);
	}
	
	@Transactional(readOnly = false)
	public void save(EmailMessage emailMessage) {
		super.save(emailMessage);
	}
	
	@Transactional(readOnly = false)
	public void delete(EmailMessage emailMessage) {
		super.delete(emailMessage);
	}
	
	
	
	
}