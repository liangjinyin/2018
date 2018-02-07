
 
package com.tospur.modules.meeting.dao;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.meeting.entity.Meeting;

/**
 * 会议纪要DAO接口
 * @author jinyin
 * @version 2017-08-08
 */
@MyBatisDao
public interface MeetingDao extends CrudDao<Meeting> {

   public  Meeting findMeeting(String create);
}