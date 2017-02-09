package com.sp.sch;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.member.SessionInfo;

@Controller("sch.scheduleController")
public class ScheduleController {
	@Autowired
	private ScheduleService service;
	
	@RequestMapping(value="/sch/sch")
	public String sch(HttpSession session) throws Exception {
		
		return "/sch/sch";
	}

	// 대화상자에 출력 할 일정 추가 폼
	@RequestMapping(value="/sch/inputForm")
	public String inputForm() throws Exception {
		return "/sch/inputForm";
	}

	// 대화상자에 출력 할 상세 일정 폼
	@RequestMapping(value="/sch/articleForm")
	public String articleForm() throws Exception {
		return "/sch/articleForm";
	}
	
	@RequestMapping(value="/sch/created", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> created(Schedule sch, HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}
		
		sch.setUserId(info.getUserId());
		service.insertSchedule(sch);
	
		Map<String, Object> model = new HashMap<>(); 
		model.put("isLogin", "true");
		model.put("state", "true");
		return model;		
	}
	
	@RequestMapping(value="/sch/month")
	@ResponseBody
	public Map<String, Object> month(
			@RequestParam(value="start") String start,
			@RequestParam(value="end") String end,
			@RequestParam(value="group", defaultValue="all") String group,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}

		Map<String, Object> map=new HashMap<String, Object>();
		map.put("group", group);
		map.put("start", start);
		map.put("end", end);
		map.put("userId", info.getUserId());
		
		List<Schedule> list=service.listMonthSchedule(map);
		
	 	List<ScheduleJSON> listJSON=new ArrayList<>();
	    Iterator<Schedule> it=list.iterator();
		while(it.hasNext()) {
			Schedule sch=it.next();
			// if(sch.getContent()!=null)
			//   sch.setContent(sch.getContent().replaceAll("\n", "<br>"));
			
			ScheduleJSON dto=new ScheduleJSON();
	    	dto.setId(sch.getNum());
	    	dto.setTitle(sch.getTitle());
	    	dto.setUserName(sch.getUserName());
	    	dto.setColor(sch.getColor());
	    	if(sch.getAllDay().equals("true"))
	    	    dto.setAllDay(true);
	    	else
	    		dto.setAllDay(false);
	    	
	    	if(sch.getStartTime()!=null && sch.getStartTime().length()!=0)
		    	dto.setStart(sch.getStartDay()+" " + sch.getStartTime());
	    	else
	    		dto.setStart(sch.getStartDay());
	    	
	    	if(sch.getEndTime()!=null && sch.getEndTime().length()!=0)
	    		dto.setEnd(sch.getEndDay()+" " + sch.getEndTime());
	    	else
	    		dto.setEnd(sch.getEndDay());
	    	dto.setContent(sch.getContent());
	    	dto.setCreated(sch.getCreated());
	    	listJSON.add(dto);
		}
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("isLogin", "true");
		model.put("list", listJSON);
		return model;
	}
	
	@RequestMapping(value="/sch/delete", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(
			HttpSession session,
			@RequestParam(value="num") int num
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}
		
		String state="false";
		int result=service.deleteSchedule(num);
		if(result==1)
			state="true";

		Map<String, Object> model = new HashMap<>(); 
		model.put("isLogin", "true");
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/sch/update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  update(
			Schedule sch,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}
		
		String state="false";
		int result=service.updateSchedule(sch);
		if(result==1)
			state="true";
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("isLogin", "true");
		model.put("state", state);
		return model;
	}
}
