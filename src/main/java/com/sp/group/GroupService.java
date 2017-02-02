package com.sp.group;

import java.util.List;
import java.util.Map;

public interface GroupService {
	//그룹관련
	public int insertGroup(Group dto);
	public Group readGroup(String groupName);
	public int updateGroup(Map<String, Object> map);
	public int deleteGroup(String groupName);
	public int dataCount(Map<String, Object> map);
	public List <Group> listGroup(Map<String, Object> map);
	//맴버관련
	public int insertGroupMember(Group dto);
	public int dataCountMember(Map<String, Object> map);
	public List <Group> listGroupMemer(String groupName);
	public int deleteGroupMember(String userId);
}	
