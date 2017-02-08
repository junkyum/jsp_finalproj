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
			@RequestParam(value="searchKeyC", defaultValue="chSubject") String searchKeyC,
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

        String paging= myUtil.paging(current_page, total_page);
        
      
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

		
		dto.setUserId(info.getUserId());//아이디저장.	
		System.out.println(dto.getGroupName()+"  구릅이름");
		System.out.println(dto.getContent()+"    내용");
		System.out.println(dto.getSubject()+"  재목");
		
		int result=service.insertReplyBoard(dto, "created");
		String state="ture";
		if(result==0)
				state="flase";
		Map<String, Object> model= new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	
	//group/reply/article
	@RequestMapping(value="/group/reply/article")
	public String article(@RequestParam(value="replyBoardNum") int replyBoardNum,
			@RequestParam(value="pageNo", defaultValue="1")int pageNo,
			@RequestParam(value="searchKeyC", defaultValue="chSubject") String searchKeyC,
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
		map.put("replyBoardNum", dto.getReplyBoardNum());
		map.put("orderNo", dto.getOrderNo());
		
		String params = "page=" + pageNo;
		if (searchValueC.length()!=0) {
			params += "&searchKeyC=" + searchKeyC + "&searchValue="
					+ URLEncoder.encode(searchValueC, "utf-8");
		}
		
		model.addAttribute("dto",dto);
		model.addAttribute("page",pageNo);
		model.addAttribute("params",params );
		
		
		return "group/replyGroupBoardArticle";
	}
	
	
/*	<%@ page contentType="text/html; charset=UTF-8"%>
	<%@ page trimDirectiveWhitespaces="true" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%
	   String cp=request.getContextPath();
		//글보기창
	%>

	ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ


					<h2 class="text-center">[${dto.groupName}]&nbsp;그룹의&nbsp; 질문&nbsp;&nbsp;과&nbsp;&nbsp;답변<br> 
					<i class="glyphicon glyphicon-info-sign"></i> 궁금한 점은 이곳에 글을 남겨 주시면 성심껏 답변 해드리겠습니다.</h2>

			<table style="width: 600px; margin: 20px auto 0px; border-spacing: 0px;">
				  <tr><td colspan="2" height="3" bgcolor="#507CD1"></td></tr>
				
				  <tr align="left" height="40"> 
				      <td width="100" bgcolor="#EEEEEE" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				      <td width="500" style="padding-left:10px;">      
				      	${dto.subject}
				      </td>
				  </tr>	
				  <tr align="left"> 
				      <td width="100" bgcolor="#EEEEEE" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
				      <td width="500" valign="top" style="padding:5px 0px 5px 10px;"> 
				       	${dto.content}
				      </td>
				  </tr>
			</table>
			<table>
				<tr>
					<td>
						<div style="margin-left: 450px; border-bottom:10px;">
						
						</div>
					</td>
				</tr>
			</table>

	
	
	
	
	
	
	
	
	
	
	
	
	*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
