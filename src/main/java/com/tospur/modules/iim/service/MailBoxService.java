package com.tospur.modules.iim.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.iim.dao.MailBoxDao;
import com.tospur.modules.iim.entity.MailBox;
import com.tospur.modules.iim.entity.MailPage;

/**
 * 收件箱Service
 * @author jeeplus
 * @version 2015-11-13
 */
@Service
@Transactional(readOnly = true)
public class MailBoxService extends CrudService<MailBoxDao, MailBox> {

	@Autowired
	private MailBoxDao mailBoxDao;
	public MailBox get(String id) {
		return super.get(id);
	}
	
	public List<MailBox> findList(MailBox mailBox) {
		return super.findList(mailBox);
	}
	
	public Page<MailBox> findPage(MailPage<MailBox> page, MailBox mailBox) {
		return super.findPage(page, mailBox);
	}
	
	@Transactional(readOnly = false)
	public void save(MailBox mailBox) {
		super.save(mailBox);
	}
	
	@Transactional(readOnly = false)
	public void delete(MailBox mailBox) {
		super.delete(mailBox);
	}
	
	public int getCount(MailBox mailBox) {
		return mailBoxDao.getCount(mailBox);
	}
	
}