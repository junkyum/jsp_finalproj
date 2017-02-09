package com.sp.sch;

import java.util.List;
import java.util.Map;

public interface ScheduleService {
	public int insertSchedule(Schedule sch);
	public List<Schedule> listMonthSchedule(Map<String, Object> map);
	
	public Schedule readSchedule(int num);
	public int updateSchedule(Schedule sch);
	public int deleteSchedule(int num);
}
