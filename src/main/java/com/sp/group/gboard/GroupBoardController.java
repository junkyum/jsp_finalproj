package com.sp.group.gboard;

import java.io.File;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.FileManager;
import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

import net.sf.json.JSONObject;

@Controller("group.groupBoardController")
public class GroupBoardController {

	@Autowired private GroupBoardService service;
	@Autowired private MyUtil util;
	@Autowired private FileManager fileManager;
	
	@RequestMapping(value="/group/groupBoard")
	public String groupBoard(
			@RequestParam String groupName,
			@RequestParam String userId,
			Model model
			) throws Exception{
		model.addAttribute("groupName",groupName);
		model.addAttribute("userId",userId);
		return "group/groupBoard";
	}
	@RequestMapping(value="/group/groupBoardList")
	public void groupBoardList(
			@RequestParam(value ="page",defaultValue="1") int current_page,
			@RequestParam String groupName,  @RequestParam String userId, 
			@RequestParam(value="searchKey", defaultValue ="subject") String searchKey,
			@RequestParam(value="searchValue",defaultValue="") String searchValue,
			HttpServletRequest req, Model model, HttpSession session) throws Exception{
		if(req.getMethod().equalsIgnoreCase("GET")){
			searchValue =URLDecoder.decode(searchValue,"UTF-8");
		}
		int numPerPage=10;
		int dataCount=0, total_page=0;
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("groupName", groupName);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		dataCount = service.dataCount(map);
		if (dataCount != 0)
			total_page= util.pageCount(numPerPage, dataCount);
		if (total_page < current_page)
			current_page = total_page;
		int start = (current_page-1)*numPerPage+1;
		int end = current_page*numPerPage;
		map.put("start", start);
		map.put("end",end);
		//글리스트
		List<GroupBoard> boardList = service.listGroupBoard(map);
		Date endDate = new Date();
		long gap;
		//리스트의 번호
		int listNum , n=0;
		Iterator<GroupBoard> it = boardList.iterator();
		while(it.hasNext()){
			GroupBoard data = it.next();
			data.setContent(data.getContent().replaceAll("\n", "<br>"));
			listNum = dataCount-(start+n-1);
			data.setListNum(listNum);
			SimpleDateFormat formatter= new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
			Date beginDate = formatter.parse(data.getCreated());
			gap =(endDate.getTime()-beginDate.getTime())/(60*60*1000);
			data.setGap(gap);
			data.setCreated(data.getCreated().substring(0,10));
			n++;
		}
		String paging =util.pagingMethod(current_page, total_page, "groupBoardListpage");
		model.addAttribute("boardList",boardList);
		model.addAttribute("page",current_page);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("groupName", groupName);
		model.addAttribute("userId",userId);
		model.addAttribute("paging",paging);
		model.addAttribute("searchKey", searchKey);
	    model.addAttribute("searchValue", URLDecoder.decode(searchValue, "utf-8"));
	}
	@RequestMapping(value="/group/gboard/created", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdForm( 
			GroupBoard dto, HttpSession session,
			HttpServletResponse resp, HttpServletRequest req
			) throws Exception {
		String cp = req.getContextPath();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null){
			resp.sendRedirect(cp+"/member/login");
		}
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "groupBoard";
		dto.setUserId(info.getUserId());
		int res = service.insertGroupBoard(dto, pathname);
		String result="true";
		if(res==0)
			result="false";
		Map <String, Object> model = new HashMap<>();
		model.put("result", result);
		return model;		
	}

	
	@RequestMapping(value="/group/gboard/boardArticle")
	public String article(
			@RequestParam int boardNum, 
			@RequestParam int page,
			@RequestParam String groupName,
			@RequestParam String userId, 
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpSession session, Model model) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null){
			return "redirect:/member/login";
		}
		searchValue = URLDecoder.decode(searchValue,"UTF-8");
		service.updateHitCount(boardNum);
		GroupBoard dto = service.readGroupBoard(boardNum);
		if(dto==null)
			return "redirect:/group/gboard/boardList?page="+page;
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		Map<String, Object> map = new HashMap<>();
		map.put("boardNum", boardNum);
		map.put("groupName", groupName);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		GroupBoard preReadDto = service.preReadGroupBoard(map);
		GroupBoard nextReadDto = service.nextReadGroupBoard(map);
		String params="page="+page;
		if(searchValue.length()!=0)
			params+="&searchKey="+searchKey+"&searchValue="+searchValue;
		List<GroupBoard> gboardList = service.listFile(boardNum);
		model.addAttribute("gboardList", gboardList);
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto",preReadDto);
		model.addAttribute("nextReadDto",nextReadDto);
		model.addAttribute("page", page);
		model.addAttribute("params", params);
		model.addAttribute("userId", userId);
		return "group/boardArticle";
	}
	@RequestMapping(value="/group/gboard/download")
	public void download(
			HttpServletResponse resp, HttpSession session,
			@RequestParam(value="boardNum") int boardNum
			) throws Exception{
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"groupBoard";
		List<GroupBoard> fileList = service.listFile(boardNum);
		GroupBoard dto = null;
		if(fileList.size()>0){
			dto = fileList.get(0);
		}
		boolean flag = false;
		
		if(dto!=null){
			flag = fileManager.doFileDownload(dto.getSaveFilename(), dto.getOriginalFilename(), pathname, resp);
		}
				
		if(! flag) {
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out=resp.getWriter();
			out.print("<script>alert('파일 다운로드가 실패했습니다.');history.back();</script>");
		}
	}
	@RequestMapping(value="/group/gboard/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam(value="boardNum") int boardNum ,
			@RequestParam(value="page") String page, 
			Model model,
			HttpSession session			
			) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info==null){
			return "redirect:/member/login";
		}
		GroupBoard dto = service.readGroupBoard(boardNum);
		if(dto==null||!dto.getUserId().equals(info.getUserId())){
			return "redirect:/group/gboard/boardList?page="+page;
		}
		List<GroupBoard> listFile=service.listFile(boardNum);
		model.addAttribute("listFile", listFile);
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		return "group/boardUpdate";
	}
	@RequestMapping(value="/group/gboard/update", method=RequestMethod.POST)
	@ResponseBody
	public  Map<String, Object>  updateSubmit(
			GroupBoard dto,
			@RequestParam(value="page") String page,
			@RequestParam String userId,
			HttpSession session,
			HttpServletResponse resp, HttpServletRequest req) throws Exception {
		String cp = req.getContextPath();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			resp.sendRedirect(cp+"/member/login");
		}
		if(! info.getUserId().equals(userId))
			resp.sendRedirect(cp+"/group/groupBoardList?page="+page+"&groupName="+dto.getGroupName()+"&userId="+userId);
		String result = "true";
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "GroupBoard";	
		service.updateGroupBoard(dto, pathname);
		Map <String, Object> model = new HashMap<>();
		model.put("page", page);
		model.put("result", result);
		return model;
	} 
	@RequestMapping(value="/group/gboard/delete", method=RequestMethod.POST)
	public void delete(
			@RequestParam int boardNum,
			@RequestParam String page,
			@RequestParam(value="fileNum") int fileNum, 
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "GroupBoard";	
		service.deleteGroupBoard(boardNum, pathname);
		GroupBoard dto = service.readFile(fileNum);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("field", "fileNum");
		map.put("num", fileNum);
		service.deleteFile(map);
		JSONObject ob=new JSONObject();
		ob.put("state", "false");		
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.print(ob.toString());	
	}
	@RequestMapping(value="/group/gboard/deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
			@RequestParam int fileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "GroupBoard";
		GroupBoard dto=service.readFile(fileNum);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("field", "fileNum");
		map.put("boarNum", fileNum);
		service.deleteFile(map);
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", "true");
		return model;
	}
	@RequestMapping(value="/group/gboard/listReply")
	public String listReply(
			@RequestParam int boardNum,
			@RequestParam(value="page", defaultValue="1") int current_page,
			Model model
			) throws Exception {
		int numPerPage=5;
		int total_page=0;
		int dataCount=0;
		dataCount=service.replyDataCount(boardNum);
		total_page=util.pageCount(numPerPage, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		int start=(current_page-1)*numPerPage+1;
		int end=current_page*numPerPage;
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("boardNum", boardNum);
		map.put("start", start);
		map.put("end", end);
		List<GroupBoardReply> gboardReplyList=service.listReply(map);
		Iterator<GroupBoardReply> it=gboardReplyList.iterator();
		while(it.hasNext()) {
			GroupBoardReply dto=it.next();
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		String paging=util.pagingMethod(current_page, total_page, "gboardReplyListpage");
		model.addAttribute("gboardReplyList", gboardReplyList);
		model.addAttribute("page", current_page);
		model.addAttribute("ReplydataCount", dataCount);
		model.addAttribute("paging", paging);
		model.addAttribute("total_page",total_page);
		
		return "group/groupBoardListReply";
	}
	
	
	@RequestMapping(value="/group/gboard/insertReply", method=RequestMethod.POST)
	public void insertReply(
			GroupBoardReply dto,
			HttpSession session,
			HttpServletResponse resp
			) throws Exception {
	
		SessionInfo info=(SessionInfo) session.getAttribute("member");
		String state="true";
		if(info==null) { // 로그인이 되지 않는 경우
			state="loginFail";
		} else {
			//dto.setUserId(info.getUserId());
			int result=service.insertReply(dto);
			if(result==0)
				state="false";
		}
		
		JSONObject job=new JSONObject();
		job.put("state", state);
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.print(job.toString());
		
	}
	
	@RequestMapping(value="/group/gboard/deleteBoardReply", method=RequestMethod.POST)
	public void deletReply(GroupBoardReply dto,HttpServletResponse resp,HttpSession session)throws Exception{
						
		String loginChk="true";
		String state="false";

		int result=service.deleteReply(dto);
		if(result!=0)
			state="true";
				
		JSONObject job=new JSONObject();
		job.put("state", state);
		job.put("loginChk", loginChk);
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.print(job.toString());
	}
	
	@RequestMapping(value="/group/gboard/insertReplyAnswer", method=RequestMethod.POST)
	public void insertReplyAnswer(GroupBoardReply dto,HttpServletResponse resp)throws Exception{

		String loginChk="true";
		String state="false";

		int result = service.insertReply(dto);		
		if(result==1)
			state="true";

		JSONObject job=new JSONObject();
		
		job.put("state", state);
		job.put("loginChk", loginChk);
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.print(job.toString());
		
	}
	
	@RequestMapping(value="/group/gboard/listReplyAnswer")
	public String listReplyAnswer(@RequestParam int replyAnswer, Model model)throws Exception{
		
	List<GroupBoardReply> listAnswer=service.listReplyAnswer(replyAnswer);
	Iterator<GroupBoardReply> it=listAnswer.iterator();
	while(it.hasNext()){
		GroupBoardReply dto= it.next();
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
	}
	model.addAttribute("listAnswer",listAnswer);
					
	return "group/boardAnswerList";		
	}
	
	
	@RequestMapping(value="/group/gboard/deleteReplyAnswer", method=RequestMethod.POST)
	public void deleteReplyAnswer(GroupBoardReply dto, HttpServletResponse resp) throws Exception{
		
		String loginChk="true"; 
		String state="false";
		
		int result=service.deleteReplyAnswer(dto);
		if(result !=0){
			state="true";
		}
			
		JSONObject job=new JSONObject();
		job.put("loginChk", loginChk);
		job.put("state", state);
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.print(job.toString());
	}
	
	@RequestMapping(value="/group/gboard/replyCountAnswer", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyCountAnswer(@RequestParam int replyAnswer)throws  Exception{
		
		int count = 0;
		count = service.replyGroupCountAnswer(replyAnswer);
		Map<String, Object> model = new HashMap<>();
		
		model.put("count", count);
		
		return model;
	}
	
	@RequestMapping(value="/group/gboard/boardReplyLike",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyLike(GroupBoardReply dto, HttpSession session)throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String state = "true";
		if(info==null){
			state="loginFail";
		}else{
			dto.setUserId(info.getUserId());
			int result = service.insertBoardReplyLike(dto);
			if(result==0)
				state="false";
		}
		
		Map<String, Object>model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/group/gboard/groupgboardCountLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> groupCountLike(@RequestParam int replyNum)throws Exception{
		int likeCount=0, disLikeCount=0;
		Map<String, Object> map = service.groupReplyCountLike(replyNum);
		if(map!=null){
			likeCount=((BigDecimal)map.get("LIKECOUNT")).intValue();
			disLikeCount=((BigDecimal)map.get("DISLIKECOUNT")).intValue();
			}
		
		Map<String, Object> model = new HashMap<>();
		model.put("likeCount", likeCount);
		model.put("dislikeCount", disLikeCount);
		
		return model;
	}

	//게시물 좋아요 하는 곳 
	@RequestMapping(value="/group/gboard/boardLike",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertBoardLike(GroupBoard dto , HttpSession session)throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String state = "true";
		
		if(info==null){
			state="false";
		}else{ dto.setUserId(info.getUserId());
			int result = service.insertBoardLike(dto);
			if(result==0)
				state="false";
		}
		Map<String, Object> model =new HashMap<>();
		model.put("state", state);	
		return model;
	}
	
	@RequestMapping(value="/group/gboard/groupBoardLikeCount", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> groupBoardLikeCount(@RequestParam int boardNum)throws Exception{
		int boardLikeCount=0;
		Map<String, Object> map = service.groupBoardLikeCount(boardNum);
		if(map!=null){
			boardLikeCount=((BigDecimal)map.get("BOARDLIKECOUNT")).intValue();
			}
		//gallyLikeCount   gallyLikeCountG
		Map<String, Object> model = new HashMap<>();
		model.put("boardLikeCount", boardLikeCount);
		
		return model;
	}
}
