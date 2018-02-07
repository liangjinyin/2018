package com.tospur.modules.niche.dao;


import java.util.List;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.ShangJiDao;
import com.tospur.modules.niche.entity.InvestmentInfo;

/**
 * 招标信息DAO接口
 * @author canyu
 * @version 2016-08-12
 */
@ShangJiDao
public interface InvestmentInfoDao extends CrudDao<InvestmentInfo> {

	public List<InvestmentInfo> getMailBody();

    public void updateMailStatus(InvestmentInfo investmentInfo);

}