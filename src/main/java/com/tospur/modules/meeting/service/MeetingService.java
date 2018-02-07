
package com.tospur.modules.meeting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.meeting.dao.MeetingDao;
import com.tospur.modules.meeting.entity.Meeting;



/**
 * 会议纪要Service
 * @author jinyin
 * @version 2017-08-08
 */
@Service
@Transactional(readOnly = true)
public class MeetingService extends CrudService<MeetingDao, Meeting> {

    @Autowired
    private MeetingDao meetingDao;
    
	public Meeting get(String id) {
		return super.get(id);
	}
	
	public List<Meeting> findList(Meeting meeting) {
		return super.findList(meeting);
	}
	
	public Page<Meeting> findPage(Page<Meeting> page, Meeting meeting) {
		return super.findPage(page, meeting);
	}
	
	@Transactional(readOnly = false)
	public void save(Meeting meeting) {
		super.save(meeting);
	}
	
	@Transactional(readOnly = false)
	public void delete(Meeting meeting) {
		super.delete(meeting);
	}

    public Meeting findMeeting(String create){
        
        return meetingDao.findMeeting(create);
    }
	
	
	
	
}