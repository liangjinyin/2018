package com.tospur.modules.partner.dao;


import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.partner.entity.Partner;

/**
 * 合作伙伴信息DAO接口
 * @author kiss
 * @version 2017-02-24
 */
@MyBatisDao
public interface PartnerDao extends CrudDao<Partner> {

	
}