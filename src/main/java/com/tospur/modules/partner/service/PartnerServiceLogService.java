/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.partner.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.partner.entity.PartnerServiceLog;
import com.tospur.modules.partner.dao.PartnerServiceLogDao;

/**
 * 接入方管理Service
 * @author liminfang
 * @version 2016-07-06
 */
@Service
@Transactional(readOnly = true)
public class PartnerServiceLogService extends CrudService<PartnerServiceLogDao, PartnerServiceLog> {

	public PartnerServiceLog get(String id) {
		return super.get(id);
	}
	
	public List<PartnerServiceLog> findList(PartnerServiceLog partnerServiceLog) {
		return super.findList(partnerServiceLog);
	}
	
	public Page<PartnerServiceLog> findPage(Page<PartnerServiceLog> page, PartnerServiceLog partnerServiceLog) {
		return super.findPage(page, partnerServiceLog);
	}
	
	@Transactional(readOnly = false)
	public void save(PartnerServiceLog partnerServiceLog) {
		super.save(partnerServiceLog);
	}
	
	@Transactional(readOnly = false)
	public void delete(PartnerServiceLog partnerServiceLog) {
		super.delete(partnerServiceLog);
	}
	
	
	
	
}