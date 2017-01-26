package com.sp.group;

import java.util.List;
import java.util.Map;

public interface GroupService {

	public int insertGroup(Group dto);
	public Group readGroup(String groupName);
	public int deleteGroup(String groupName);
	public int dataCount(Map<String, Object> map);
	public List <Group> listGroup(Map<String, Object> map);
	
}
