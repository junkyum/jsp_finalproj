package com.sp.group.sch;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String sch(HttpSession session,
			Model model,
			@RequestParam String groupName,
			@RequestParam String userId
			) throws Exception {
		model.addAttribute("chef",userId);
		model.addAttribute("groupName",groupName);
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
			@RequestParam String groupName,
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
		map.put("groupName", groupName);
		
		List<GroupSch> list=service.listMonthSchedule(map);
		
	 	List<GroupSchJSON> listJSON=new ArrayList<>();
	    Iterator<GroupSch> it=list.iterator();
		while(it.hasNext()) {
			GroupSch sch=it.next();
			GroupSchJSON dto=new GroupSchJSON();
	    	dto.setId(sch.getSchNum());
	    	dto.setTitle(sch.getSubject());
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
	@RequestMapping(value="/group/sch/map")
	public String sch(HttpSession session ,Model model) throws Exception {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			List<GroupSch> list=service.listPerSonalSchedule(info.getUserId());
			List<String> lats = new ArrayList<>();
			List<String> lngs = new ArrayList<>();
			List<String> title = new ArrayList<>();
			Iterator<GroupSch> it=list.iterator();
			while(it.hasNext()) {
				GroupSch sch=it.next();
				if(sch.getCoord()!=null){
				title.add(sch.getSubject());
				String [] coord = sch.getCoord().split(",");
				lats.add(coord[0]);
				lngs.add(coord[1]);
				}
			}
			model.addAttribute("lats",lats);
			model.addAttribute("lngs",lngs);
			model.addAttribute("title",title);
			return ".map.map";
		}
	
}
