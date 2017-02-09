package com.sp.sch;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("sch.scheduleService")
public class ScheduleServiceImpl implements ScheduleService{
	@Autowired
	CommonDAO dao;
	
	@Override
	public int insertSchedule(Schedule sch) {
		int result=0;
		
		try {
			result=dao.insertData("sch.insertSchedule", sch);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public List<Schedule> listMonthSchedule(Map<String, Object> map) {
		List<Schedule> list=null;
			
		try {
			list=dao.getListData("sch.listMonthSchedule", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public Schedule readSchedule(int num) {
		Schedule sch=null;
		
		try{
			// 게시물 가져오기
			sch=dao.getReadData("sch.readSchedule", num);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return sch;
	}

	@Override
	public int updateSchedule(Schedule sch) {
		int result=0;

		try{
			result=dao.updateData("sch.updateSchedule", sch);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteSchedule(int num) {
		int result=0;

		try{
			result=dao.deleteData("sch.deleteSchedule", num);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
}
