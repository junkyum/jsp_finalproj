package com.sp.group;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

import net.sf.json.JSONObject;

@Controller("group.groupController")
public class GroupContoller {
	
	@Autowired
	private GroupService service;
	@Autowired
	private MyUtil myUtil;
	//역할군 - 그룹 생성 및 그룹페이지들간의 연결
	//그룹페이지로 연결
	@RequestMapping(value="/group", method=RequestMethod.GET)
	public String main(HttpSession session,
			@RequestParam String groupName,
			Model model
			) throws Exception {
		   
			
			Group dto = service.readGroup(groupName);
			model.addAttribute("dto",dto);
			
			return ".group.main";	
	}
	//그룹만들기
	@RequestMapping(value="/group/created", method=RequestMethod.POST)
	public void groupCreated(
			HttpSession session,
			HttpServletResponse resp,
			Group dto) throws Exception {
			
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		dto.setUserId(info.getUserId());
		dto.setCondition("1");
		int result = service.insertGroup(dto);
		JSONObject job = new JSONObject();
		if(result==0)
		{
			job.put("res","false");
			
		}
		else
		{
			job.put("res",dto.getGuroupName());
		}
		PrintWriter out = resp.getWriter();
		  out.println(job.toString());
	}
	//그룹리스트
	@RequestMapping(value="/group/list")
	public void groupList(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="name") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpServletRequest req,
			HttpServletResponse resp
			)throws Exception {
		  String cp = req.getContextPath();
	   	    
			int numPerPage = 5; 
			int total_page = 0;
			int dataCount = 0;
	   	    
			if(req.getMethod().equalsIgnoreCase("GET")) { 
				searchValue = URLDecoder.decode(searchValue, "utf-8");
			}
	
	        Map<String, Object> map = new HashMap<String, Object>();
	        map.put("searchKey", searchKey);
	        map.put("searchValue", searchValue);

	        dataCount = service.dataCount(map);
	        total_page = myUtil.pageCount(numPerPage, dataCount);
	        
	        if (total_page < current_page)
				current_page = total_page;

			int start = (current_page - 1) * numPerPage + 1;
			int end = current_page * numPerPage;

			map.put("start", start);
			map.put("end", end);
			
	        List<Group> list = service.listGroup(map);
	   
	        int listNum, n = 0;
			Iterator<Group> it = list.iterator();
			while (it.hasNext()) {
				Group data = it.next();
				listNum = dataCount - (start + n - 1);
				data.setListNum(listNum);
				n++;
			}
			String urlList = cp + "/group/list";
			
			String paging = myUtil.paging(current_page, total_page, urlList);
			JSONObject	job = new JSONObject();
			PrintWriter out = resp.getWriter();
			
		    job.put("list", list);
		    job.put("page", current_page);
		    job.put("paging", paging);

		    out.println(job.toString());
	     
	}
	@RequestMapping(value="/group/update")
	public void updateGroup(
			HttpServletRequest req,
			HttpServletResponse resp,
			@RequestParam String groupName
			)throws Exception {
			
			
			
	}
	@RequestMapping(value="/group/delete")
	public void deleteGroup()throws Exception {
		
	}
	
	
}
