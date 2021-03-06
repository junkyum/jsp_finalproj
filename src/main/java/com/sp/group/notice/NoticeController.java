package com.sp.group.notice;

import java.io.File;
import java.io.PrintWriter;
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

@Controller("group.noticeController")
public class NoticeController {
	@Autowired private NoticeService service;
	@Autowired private MyUtil myUtil;
	@Autowired private FileManager fileManager;

	
	@RequestMapping(value="/group/notice")
	public String notice(
			@RequestParam String groupName,
			@RequestParam String userId,
			Model model
			) throws Exception{
		model.addAttribute("groupName",groupName);
		model.addAttribute("userId",userId);
		return "group/notice";
	}
	
	@RequestMapping(value="/group/noticeList")
	public void noticeList(
			Model model,HttpServletRequest req, HttpSession session,
			@RequestParam(value="num", defaultValue = "1") int num,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam String groupName, @RequestParam String userId, 
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue
			) throws Exception{
		

		int numPerPage = 3; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}

		GroupNotice dto = service.readNotice(num);
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("groupName", groupName);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);

		dataCount = service.dataCount(map);
		if (dataCount != 0)
			total_page = myUtil.pageCount(numPerPage, dataCount);

		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if (total_page < current_page)
			current_page = total_page;

		// 리스트에 출력할 데이터를 가져오기
		int start = (current_page - 1) * numPerPage + 1;
		int end = current_page * numPerPage;
		map.put("start", start);
		map.put("end", end);

		// 글 리스트
		List<GroupNotice> noticeList = service.listNotice(map);
		Date endDate = new Date();
		long gap;
		int listNum, n = 0;
		Iterator<GroupNotice> it=noticeList.iterator();
		while(it.hasNext()) {
			GroupNotice data=it.next();
			data.setContent(data.getContent().replaceAll("\n", "<br>"));
			listNum = dataCount - (start + n - 1);
			data.setListNum(listNum);
			if(dto!=null){
			data.setGroupName(dto.getGroupName());
			}

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date beginDate = formatter.parse(data.getCreated());
			gap = (endDate.getTime() - beginDate.getTime()) / (60 * 60 * 1000);
			data.setGap(gap);

			data.setCreated(data.getCreated().substring(0, 10));

			n++;
		}
		
        String paging = myUtil.pagingMethod(current_page, total_page,"noticeListpage");
	    model.addAttribute("total_page", total_page);
	    model.addAttribute("searchKey", searchKey);
	    model.addAttribute("searchValue", URLDecoder.decode(searchValue, "utf-8"));
        model.addAttribute("dto", dto);
        model.addAttribute("groupName", groupName);
        model.addAttribute("userId",userId);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
	}
	
	
	@RequestMapping(value="/group/notice/created",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdSubmit(
			GroupNotice dto,
			HttpSession session,  
			HttpServletResponse resp,
			HttpServletRequest req) throws Exception {
		
		String cp = req.getContextPath();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info==null){
			resp.sendRedirect(cp+"/member/login");
		}
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "notice";
		/*dto.setGroupName(dto.getGroupName()); */
		dto.setUserId(info.getUserId());
		int res = service.insertNotice(dto, pathname);
		
		String result="true";
		if(res==0)
			result="false";
		
		Map <String, Object> model = new HashMap<>();
		model.put("result", result);
		return model;		
	}

/*	@RequestMapping(value="/group/notice/update", method=RequestMethod.POST)
	public String updateSubmit(
			@RequestParam int num, 
			@RequestParam String page,
			HttpServletResponse resp, HttpSession session ) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}
		
		if(! info.getUserId().equals("admin"))
			return "redirect:/notice/list?page="+page;
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "notice";		
		
		GroupNotice dto = service.readNotice(num);
		service.updateNotice(dto, pathname);

		JSONObject job = new JSONObject();		
		job.put("subject", dto.getSubject());
		job.put("content", dto.getContent());
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.print(job.toString());
		
		//dto.setUserId(info.getUserId());
		
		return "group/notice";
	}*/
	@RequestMapping(value="/group/notice/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam(value="num") int num ,
			@RequestParam(value="page") String page, 
			Model model,
			HttpSession session			
			) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info==null){
			return "redirect:/member/login";
		}
		GroupNotice dto = service.readNotice(num);
		if(dto==null||!dto.getUserId().equals(info.getUserId())){
			return "redirect:/group/noticeList?page="+page;
		}
		List<GroupNotice> listFile=service.listFile(num);
		
		model.addAttribute("listFile", listFile);
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		return "group/noticeUpdate";
	}

	@RequestMapping(value="/group/notice/update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  updateSubmit(
			GroupNotice dto,
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
			resp.sendRedirect(cp+"/group/noticeList?page="+page+"&groupName="+dto.getGroupName()+"&userId="+userId);
		String result = "true";
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "GroupBoard";		

		service.updateNotice(dto, pathname);
		
		Map <String, Object> model = new HashMap<>();
		model.put("page", page);
		model.put("result", result);
		return model;
	} 

	
	
	@RequestMapping(value="/group/notice/delete")
	public void delete(
			@RequestParam(value="num") int num,
			@RequestParam(value="page") String page, 
			@RequestParam(value="fileNum") int fileNum, 
			HttpServletResponse resp, HttpSession session ) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "notice";
		
		service.deleteNotice(num, pathname);
		GroupNotice dto = service.readFile(fileNum);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("field", "fileNum");
		map.put("num", fileNum);
		service.deleteFile(map);
		
		JSONObject ob=new JSONObject();
		ob.put("state", "true");
		
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out=resp.getWriter();
		
		out.print(ob.toString());	
		
	}
	
	@RequestMapping(value="/group/notice/deleteFile", method=RequestMethod.POST)
	public void deleteFile(
			HttpServletResponse resp, HttpSession session,
			@RequestParam(value="fileNum") int fileNum ) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "notice";
		
		GroupNotice dto=service.readFile(fileNum);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("field", "fileNum");
		map.put("num", fileNum);
		service.deleteFile(map);
		
		JSONObject ob=new JSONObject();
		ob.put("state", "true");
		
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out=resp.getWriter();
		
		out.print(ob.toString());			
	}
	
	
	@RequestMapping(value="/group/notice/download")
	public void download(
			HttpServletResponse resp, HttpSession session,
			@RequestParam(value="num") int num
			) throws Exception{
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"notice";
		
		List<GroupNotice> fileList = service.listFile(num);
		GroupNotice dto = null;
		if(fileList.size()>0){
			dto = fileList.get(0); //노티
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
}
