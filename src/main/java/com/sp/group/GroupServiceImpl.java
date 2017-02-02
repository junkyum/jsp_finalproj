package com.sp.group;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("group.groupServiceImpl")
public class GroupServiceImpl implements GroupService {
	@Autowired 
	private CommonDAO dao;
	@Override
	public int insertGroup(Group dto) {
		int result = 0;
		try {
			result = dao.insertData("group.insertGroup", dto);
			System.out.println(result);
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
			result = dao.getIntValue("group.dataCountGroup", map);
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

	@Override
	public int updateGroup(Map<String, Object> map) {
		int res = 0;
		try {
			res = dao.updateData("group.updateGroup", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

	@Override
	public int insertGroupMember(Group dto) {
		int res = 0;
		try {
			res=dao.insertData("group.insertGroupMember",dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

	@Override
	public int dataCountMember(Map<String, Object> map) {
		int res = 0;
		try {
			res=dao.getIntValue("group.dataCountMember", map);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return res;
	}

	@Override
	public List<Group> listGroupMemer(String groupName) {
		List<Group> list=null;
		try {
			list = dao.getListData("group.listGroupMember", groupName);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int deleteGroupMember(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.deleteData("group.deleteGroupMember", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

}
