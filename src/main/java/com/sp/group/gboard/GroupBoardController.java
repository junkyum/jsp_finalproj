package com.sp.group.gboard;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
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

@Controller("group.groupBoardController")
public class GroupBoardController {

	@Autowired private GroupBoardService service;
	@Autowired private MyUtil util;
	@Autowired private FileManager fileManager;
	
	@RequestMapping(value="/group/boardList")
	public String list(
			@RequestParam(value="gbnum", defaultValue = "1") int gbnum,
			@RequestParam(value ="page",defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue ="subject") String searchKey,
			@RequestParam(value="searchValue",defaultValue="") String searchValue,
			HttpServletRequest req, Model model) throws Exception{

		if(req.getMethod().equalsIgnoreCase("GET")){
			searchValue =URLDecoder.decode(searchValue,"UTF-8");
		}

		int numPerPage=10;
		int dataCount=0, total_page=0;
		Map<String, Object> map= new HashMap<>();

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
		List<GroupBoard> list = service.listGroupBoard(map);
		Date endDate = new Date();
		long gap;
		//리스트의 번호
		int listNum , n=0;
		Iterator<GroupBoard> it = list.iterator();
		while(it.hasNext()){
			GroupBoard data = it.next();
			listNum = dataCount-(start+n-1);
			data.setListNum(listNum);

			SimpleDateFormat formatter= new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
			Date beginDate = formatter.parse(data.getGbcreated());

			//날짜 차이 (일)
			//gap =(endDate.getTime()-beginDate.getTime())/(24*60*60*1000);
			//data.setGap(gap);

			//날짜 차이(시간)
			gap =(endDate.getTime()-beginDate.getTime())/(60*60*1000);
			data.setGap(gap);

			data.setGbcreated(data.getGbcreated().substring(0,10));

			n++;
		}
		
		String cp= req.getContextPath();
		String listUrl= cp+"/group/boardList";
		String articleUrl=cp+"/group/boardArticle?page="+current_page;

		String params="";
		if(searchValue.length()!=0){
			params="searchKey="+searchKey+"&searchValue"+URLEncoder.encode(searchValue,"UTF-8");

		}
		if(params.length()!=0){
			listUrl=listUrl+"?"+params;
			articleUrl=articleUrl+"&"+params;
		}

		String paging =util.paging(current_page, total_page, listUrl);

		model.addAttribute("list",list);
		model.addAttribute("page",current_page);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("total_page",total_page);

		model.addAttribute("articleUrl",articleUrl);
		model.addAttribute("paging",paging);


		return "group/boardList";
	}

	@RequestMapping(value="/group/created", method=RequestMethod.GET)
	public String createdForm( HttpSession session, Model model) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null){
			return "redirect:/member/login";
		}

		model.addAttribute("mode","created");
		
		return ".group.created";
	}

	@RequestMapping(value="/group/created", method=RequestMethod.POST)
	public String createdSubmit( GroupBoard dto, HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"GroupBoard";

		dto.setUserId(info.getUserId());

		service.insertGroupBoard(dto, pathname);

		return "redirect:/gboard/list";
	}

	@RequestMapping(value="/gboard/boardArticle")
	public String article(
			@RequestParam int gbnum, @RequestParam int page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpSession session, Model model) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null){
			return "redirect:/member/login";
		}
		searchValue = URLDecoder.decode(searchValue,"UTF-8");
		service.updateHitCount(gbnum);

		GroupBoard dto = service.readGroupBoard(gbnum);
		if(dto==null)
			return "redirect:/gboard/boardList?page="+page;

		dto.setGbcontent(dto.getGbcontent().replaceAll("\n", "<br>"));

		Map<String, Object> map = new HashMap<>();
		map.put("gbnum", gbnum);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);

		GroupBoard preReadDto = service.preReadGroupBoard(map);
		GroupBoard nextReadDto = service.nextReadGroupBoard(map);

		String params="page="+page;

		if(searchValue.length()!=0)
			params+="&searchKey="+searchKey+"&searchValue="+searchValue;

		List<GroupBoard> listFile = service.listFile(gbnum);

		model.addAttribute("listFile", listFile);
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto",preReadDto);
		model.addAttribute("nextReadDto",nextReadDto);
		model.addAttribute("page", page);
		model.addAttribute("params", params);
		return ".gboard.boardArticle";
	}

	@RequestMapping(value="/gboard/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam(value="gbnum") int gbnum,
			@RequestParam(value="page") String page,
			Model model, HttpSession session) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		GroupBoard dto = (GroupBoard) service.readGroupBoard(gbnum);
		if(dto==null) {
			return "redirect:/gboard/list?page="+page;
		}

		List<GroupBoard> listFile=service.listFile(gbnum);

		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);

		return ".gboard.created";
	}

	@RequestMapping(value="gboard/update", method=RequestMethod.POST)
	public String updateSubmit(
			GroupBoard dto,
			@RequestParam String page,
			HttpSession session) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		if(! info.getUserId().equals("admin"))
			return "redirect:/gboard/list?page="+page;

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "GroupBoard";		

		dto.setUserId(info.getUserId());
		service.updateGroupBoard(dto, pathname);

		return "redirect:/gboard/list?page="+page;
	}

	@RequestMapping(value="/gboard/delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam int gbnum,
			@RequestParam String page,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "GroupBoard";		

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		if(! info.getUserId().equals("admin"))
			return "redirect:/gboard/list?page="+page;

		// 내용 지우기
		service.deleteGroupBoard(gbnum, pathname);

		return "redirect:/gboard/boardList?page="+page;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="/gboard/download")
	public void download(
			@RequestParam int gbfileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "GroupBoard";

		boolean b = false;

		GroupBoard dto = service.readFile(gbfileNum);
		if(dto!=null) {
			String saveFilename = dto.getSaveFilename();
			String originalFilename = dto.getOriginalFilename();

			b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
		}

		if (!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다');history.back();</script>");
			} 
			catch (Exception e) {
				System.out.println(e.toString());
			}
		}
	}

	@RequestMapping(value="/gboard/deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
			@RequestParam int gbfileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "GroupBoard";

		GroupBoard dto=service.readFile(gbfileNum);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}

		Map<String, Object> map=new HashMap<String, Object>();
		map.put("field", "gbfileNum");
		map.put("gbnum", gbfileNum);
		service.deleteFile(map);

		Map<String, Object> model = new HashMap<>(); 
		model.put("state", "true");
		return model;
	}
	
	
	@RequestMapping(value="/gboard/boardArticle", method=RequestMethod.POST)
	public String insertRepleSubmit( GroupBoard dto, HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"GroupBoard";

		dto.setUserId(info.getUserId());

		service.insertGroupBoard(dto, pathname);

		return "redirect:/gboard/boardArticle";
	}
}
