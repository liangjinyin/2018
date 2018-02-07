package com.tospur.modules.partner.service;


import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.partner.dao.PartnerDao;
import com.tospur.modules.partner.entity.Partner;

/**
 * 合作伙伴信息Service
 * @author kiss
 * @version 2017-02-24
 */
@Service
@Transactional(readOnly = true)
public class PartnerService extends CrudService<PartnerDao, Partner> {

	public Partner get(String id, String op) {
		return super.get(id);
	}
	
	public List<Partner> findList(Partner partner) {
		return super.findList(partner);
	}
	
	public Page<Partner> findPage(Page<Partner> page, Partner partner) {
		return super.findPage(page, partner);
	}
	
	@Transactional(readOnly = false)
	public void save(Partner partner) {
		super.save(partner);
	}
	
	@Transactional(readOnly = false)
	public void delete(Partner partner) {
		super.delete(partner);
	}
	
}