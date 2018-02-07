package com.tospur.modules.sys.dao;

import com.tospur.common.persistence.annotation.ShangJiDao;
import com.tospur.modules.sys.entity.User;


@ShangJiDao
public interface ActUserDao {
	public int insertActUserShip(User param);
	public int insertActUser(User param);
	public int updateActUser(User param);
	public int updateActPassword(User param);
	
    public void deleteActship(User user);
    public void deleteActUser(User user);
 }