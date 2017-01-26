package com.sp.group;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.sp.common.dao.CommonDAO;

public class GroupServiceImpl implements GroupService {
	@Autowired 
	private CommonDAO dao;
	@Override
	public int insertGroup(Group dto) {
		int result = 0;
		try {
			result = dao.insertData("group.insertGroup", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public Group readGroup(String groupName){
		Group dto = null;
		try {
			dto = dao.getReadData("group.readGroup",groupName);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int deleteGroup(String groupName) {
		int result = 0;
		try {
			result = dao.deleteData("group.deleteGroup", groupName);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.getIntValue("group.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Group> listGroup(Map<String, Object> map) {
		List<Group> list=null;
		try {
			list = dao.getListData("group.listGroup", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

}
