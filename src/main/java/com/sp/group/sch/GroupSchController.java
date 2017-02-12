package com.sp.group.sch;

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

@Controller("groupSch.groupSchController")
public class GroupSchController {
	@Autowired
	private GroupSchService service;
	
	@RequestMapping(value="/group/sch")
	public String sch(HttpSession session) throws Exception {
		
		return "/groupsch/sch";
	}

	// 대화상자에 출력 할 일정 추가 폼
	@RequestMapping(value="/group/sch/inputForm")
	public String inputForm() throws Exception {
		return "/groupsch/inputForm";
	}

	// 대화상자에 출력 할 상세 일정 폼
	@RequestMapping(value="/group/sch/articleForm")
	public String articleForm() throws Exception {
		return "/groupsch/articleForm";
	}
	
	@RequestMapping(value="/group/sch/created", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> created(GroupSch sch, HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}
		sch.setUserId(info.getUserId());
		sch.setGroupName("디자인이");
		service.insertSchedule(sch);
	
		Map<String, Object> model = new HashMap<>(); 
		model.put("isLogin", "true");
		model.put("state", "true");
		return model;		
	}
	
	@RequestMapping(value="/group/sch/month")
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
		map.put("groupName", "디자인이");
		
		List<GroupSch> list=service.listMonthSchedule(map);
		
	 	List<GroupSchJSON> listJSON=new ArrayList<>();
	    Iterator<GroupSch> it=list.iterator();
		while(it.hasNext()) {
			GroupSch sch=it.next();
			// if(sch.getContent()!=null)
			//   sch.setContent(sch.getContent().replaceAll("\n", "<br>"));
			
			GroupSchJSON dto=new GroupSchJSON();
	    	dto.setId(sch.getSchNum());
	    	dto.setSubject(sch.getSubject());
	    	dto.setUserName(sch.getUserName());
	    	dto.setColor(sch.getColor());
	    	if(sch.getAllDay().equals("true"))
	    	    dto.setAllDay(true);
	    	else
	    		dto.setAllDay(false);
	    	
	    	if(sch.getStartTime()!=null && sch.getStartTime().length()!=0)
		    	dto.setStart(sch.getStartDate()+" " + sch.getStartTime());
	    	else
	    		dto.setStart(sch.getStartDate());
	    	
	    	if(sch.getEndTime()!=null && sch.getEndTime().length()!=0)
	    		dto.setEnd(sch.getEndDate()+" " + sch.getEndTime());
	    	else
	    		dto.setEnd(sch.getEndDate());
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
	
	@RequestMapping(value="/group/sch/delete", method=RequestMethod.POST)
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
	
	@RequestMapping(value="/group/sch/update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  update(
			GroupSch sch,
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
