package com.sp.group.replyBoard;



import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("group.replyBoardController")
public class ReplyBoardController {
	
	@Autowired
	private ReplyBoardService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/group/bbs")
	public String gally(Model model,@RequestParam String groupName)throws Exception{
		model.addAttribute("groupName",groupName);
		return "group/replyGroupBoard";
	}
	
	
	@RequestMapping(value="/group/reply/list")
	public String list(@RequestParam(value="pageNo", defaultValue="1")int current_page,
			@RequestParam(value="searchKeyC", defaultValue="subject") String searchKeyC,
			@RequestParam(value="searchValueC", defaultValue="") String searchValueC,
			@RequestParam String groupName,
			HttpServletRequest req,
			Model model
			) throws Exception {
		 
		int numPerPage=10;
		int total_page=0;
		int dataCount=0;
		

		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValueC = URLDecoder.decode(searchValueC, "utf-8");
		}
		
		Map<String, Object> map= new HashMap<>();
		map.put("searchKeyC", searchKeyC);
		map.put("searchValueC", searchValueC);
		map.put("groupName", groupName);
		
		dataCount=service.dataCount(map);
		
		if(dataCount !=0)
				total_page=myUtil.pageCount(numPerPage, dataCount);

		if(total_page< current_page)
			current_page=total_page;

        int start = (current_page - 1) * numPerPage + 1;
        int end = current_page * numPerPage;
   
        map.put("start", start);
        map.put("end", end);
    
        List<ReplyBoard> leplyLlist= service.listReplyBoard(map);
        
        int listNum, n=0;
        Iterator<ReplyBoard> it= leplyLlist.iterator();
        while(it.hasNext()){
        	ReplyBoard data=it.next();
        	listNum= dataCount-(start + n - 1);
        	data.setListNum(listNum);
        	n++;
        }
 
        String paging= myUtil.pagingMethod(current_page, total_page, "replyBoardList");
        
        System.out.println(searchValueC+"                                  1");
        System.out.println(searchKeyC+"                                  2");
        model.addAttribute("leplyLlist", leplyLlist);
        model.addAttribute("total_page", total_page);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("paging", paging);
		
	    return "group/replyGroupList";
	}

	@RequestMapping(value="/group/reply/created", method=RequestMethod.GET)
	public String createdForm(Model model,@RequestParam String groupName){
			model.addAttribute("groupName", groupName);
			model.addAttribute("mode", "created");
		return "group/replyGroupCreated";
	}
	
	@RequestMapping(value="/group/reply/created", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdSubmit(HttpSession session, ReplyBoard dto){
		SessionInfo info=(SessionInfo)session.getAttribute("member");

		
		dto.setUserId(info.getUserId());

		int result=service.insertReplyBoard(dto, "created");
		String state="ture";
		if(result==0)
				state="flase";
		Map<String, Object> model= new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	
	@RequestMapping(value="/group/reply/answer/created", method=RequestMethod.GET)
	public String createdAnswerForm(Model model, @RequestParam int replyBoardNum, @RequestParam int pageNo,HttpSession session){
			
			SessionInfo info=(SessionInfo)session.getAttribute("member");

		
		
			ReplyBoard dto = service.readReplyBoard(replyBoardNum);
			
			dto.setUserId(info.getUserId());
			
			//String my= "["+dto.getUserId()+"] 님의 답변입니다";
			//String str ="["+dto.getSubject()+"("+dto.getUserId()+"님에)"+"] 대한 답변입니다. \n";
			String my= "("+dto.getUserId()+"님의)답변!, \n";
			String str ="["+dto.getSubject()+"]답변 !! \n";

			dto.setSubject(my);
			dto.setContent(str);
			
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("dto", dto);
			model.addAttribute("mode", "reply");
		return "group/replyGroupCreated";
	}
	
	//group/reply/answer/created
	@RequestMapping(value="/group/reply/answer/created", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdAnswer(HttpSession session, ReplyBoard dto){
		SessionInfo info=(SessionInfo)session.getAttribute("member");

		
		dto.setUserId(info.getUserId());

		int result=service.insertReplyBoard(dto, "reply");
			String state="ture";
			if(result==0)
					state="flase";
			Map<String, Object> model= new HashMap<>();
			model.put("state", state);
		
		return model;
	}
	

	

	@RequestMapping(value="/group/reply/article")
	public String article(@RequestParam(value="replyBoardNum") int replyBoardNum,
			@RequestParam(value="pageNo", defaultValue="1")int pageNo,
			@RequestParam(value="searchKeyC", defaultValue="subject") String searchKeyC,
			@RequestParam(value="searchValueC", defaultValue="") String searchValueC,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValueC = URLDecoder.decode(searchValueC, "utf-8");
		}
		
		service.updateHitCount(replyBoardNum);
		
		ReplyBoard dto = service.readReplyBoard(replyBoardNum);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("searchKeyC", searchKeyC);
		map.put("searchValueC", searchValueC);
		map.put("groupNumber", dto.getGroupNumber());
		map.put("orderNo", dto.getOrderNo());

		
		ReplyBoard beforeReadDto= service.preReadReplyBoard(map);
		ReplyBoard afterReadDto=service.nextReadReplyBoard(map);
		
		String params = "page=" + pageNo;
		if (searchValueC.length()!=0) {
			params += "&searchKeyC=" + searchKeyC + "&searchValueC="
					+ URLEncoder.encode(searchValueC, "utf-8");
		}
		model.addAttribute("beforeReadDto",beforeReadDto);
		model.addAttribute("afterReadDto",afterReadDto);
		model.addAttribute("dto",dto);
		model.addAttribute("page",pageNo);
		model.addAttribute("params",params );
		
		
		return "group/replyGroupBoardArticle";
	}


	@RequestMapping(value="/group/reply/delete")
	@ResponseBody
	public Map<String, Object> delete(@RequestParam(value="replyBoardNum") int replyBoardNum)throws Exception{
		
		int result= service.deleteReplyBoard(replyBoardNum);
		String state= "true";
		if(result==0)
			state= "false";
		Map<String, Object> model= new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
//replyBoardNum, pageNo:pageNo
		@RequestMapping(value="/group/reply/update", method=RequestMethod.GET)
		public String updateReplyForm(
				@RequestParam(value="replyBoardNum") int replyBoardNum,
				@RequestParam(value="pageNo") int pageNo, Model model){
			
			System.out.println(replyBoardNum+" , "+pageNo+"                        ????");
			ReplyBoard dto =service.readReplyBoard(replyBoardNum);
			
			model.addAttribute("mode", "update");
			model.addAttribute("dto", dto);
			model.addAttribute("pageNo", pageNo);
			return "group/replyGroupCreated";
		}

		@RequestMapping(value="/group/reply/update", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> updateReplySubmit(ReplyBoard dto){
			
			int result= service.updateReplyBoard(dto);
			String state="true";
			if(result==0)
					state="false";
			Map<String, Object> model= new HashMap<>();
			model.put("state",state);
			
			return model;
		}
	
	
	
}
