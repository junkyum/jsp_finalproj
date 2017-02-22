package com.sp.group.sch;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("groupSch.groupSchService")
public class GroupSchServiceImpl implements GroupSchService{
	@Autowired
	CommonDAO dao;
	
	@Override
	public int insertSchedule(GroupSch sch) {
		int result=0;
		
		try {
			result=dao.insertData("groupSch.insertSchedule", sch);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public List<GroupSch> listMonthSchedule(Map<String, Object> map) {
		List<GroupSch> list=null;
			
		try {
			list=dao.getListData("groupSch.listMonthSchedule", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public GroupSch readSchedule(int num) {
		GroupSch sch=null;
		
		try{
			// 게시물 가져오기
			sch=dao.getReadData("groupSch.readSchedule", num);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return sch;
	}

	@Override
	public int updateSchedule(GroupSch sch) {
		int result=0;

		try{
			result=dao.updateData("groupSch.updateSchedule", sch);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteSchedule(int num) {
		int result=0;

		try{
			result=dao.deleteData("groupSch.deleteSchedule", num);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<GroupSch> listPerSonalSchedule(String userId) {
		List<GroupSch> list=null;
		
		try {
			list=dao.getListData("groupSch.listPersonalSchedule", userId);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
}
