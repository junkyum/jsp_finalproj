package com.sp.group.sch;

import java.util.List;
import java.util.Map;

public interface GroupSchService {
	public int insertSchedule(GroupSch sch);
	public List<GroupSch> listMonthSchedule(Map<String, Object> map);
	
	public GroupSch readSchedule(int num);
	public int updateSchedule(GroupSch sch);
	public int deleteSchedule(int num);
}
