package com.tospur.modules.sys.dao;

import org.apache.ibatis.annotations.Param;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.sys.entity.MailTemplate;

/**
 * 邮件模板DAO接口
 * @author zhangfeng
 * @version 2016-08-12
 */
@MyBatisDao
public interface MailTemplateDao extends CrudDao<MailTemplate>
{
    public int pitchOn(int mtId);
    
    public int unPitchOn(@Param("mtType") int mtType, @Param("mtId") int mtId);
}