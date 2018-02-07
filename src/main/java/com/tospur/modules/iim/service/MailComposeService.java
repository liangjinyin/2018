package com.tospur.modules.iim.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.iim.dao.MailComposeDao;
import com.tospur.modules.iim.entity.MailCompose;
import com.tospur.modules.iim.entity.MailPage;
import com.tospur.modules.sys.utils.UserUtils;

/**
 * 发件箱Service
 * @author jeeplus
 * @version 2015-11-13
 */
@Service
@Transactional(readOnly = true)
public class MailComposeService extends CrudService<MailComposeDao, MailCompose> {
	@Autowired
	private MailComposeDao mailComposeDao;
	public MailCompose get(String id) {
		return super.get(id);
	}
	
	public List<MailCompose> findList(MailCompose mailCompose) {
	    
	    List<MailCompose> list = super.findList(mailCompose);
	    return list;
	}
	
	public Page<MailCompose> findPage(MailPage<MailCompose> page, MailCompose mailCompose) {
	    StringBuilder sqlString = new StringBuilder();
        sqlString.append(" AND (a.senderid = '"+mailCompose.getCurrentUser().getId().toString()+"')  ");
        mailCompose.getSqlMap().put("dsfs",sqlString.toString());
        mailCompose.setPage(page);
        page.setList(mailComposeDao.findList(mailCompose));
        return page;
	}
	
	@Transactional(readOnly = false)
	public void save(MailCompose mailCompose) {
		super.save(mailCompose);
	}
	
	@Transactional(readOnly = false)
	public void delete(MailCompose mailCompose) {
		super.delete(mailCompose);
	}

	public int getCount(MailCompose mailCompose) {
		return mailComposeDao.getCount(mailCompose);
	}
	
}