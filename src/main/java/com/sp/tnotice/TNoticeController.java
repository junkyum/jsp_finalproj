package com.sp.tnotice;

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

@Controller("tnotice.tnoticeController")
public class TNoticeController {
	@Autowired
	private TNoticeService service;
	@Autowired
	private MyUtil util;
	@Autowired
	private FileManager fileManager;


	@RequestMapping(value="/tnotice/list")
	public String list(
			@RequestParam(value ="page",defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue ="subject") String searchKey,
			@RequestParam(value="searchValue",defaultValue="") String searchValue,
			HttpServletRequest req, Model model) throws Exception{

		if(req.getMethod().equalsIgnoreCase("GET")){
			searchValue =URLDecoder.decode(searchValue,"UTF-8");
		}

		int numPerPage=10;
		int dataCount, total_page;
		Map<String, Object> map= new HashMap<>();

		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);

		dataCount = service.dataCount(map);

		total_page= util.pageCount(numPerPage, dataCount);

		if(current_page>total_page)
			current_page=total_page;
		int start = (current_page-1)*numPerPage+1;
		int end = current_page*numPerPage;

		map.put("start", start);
		map.put("end",end);

		//글리스트
		List<TNotice> list = service.listTNotice(map);
		Date endDate = new Date();
		long gap;
		//리스트의 번호
		int listNum , n=0;
		Iterator<TNotice> it = list.iterator();
		while(it.hasNext()){
			TNotice data = it.next();
			listNum = dataCount-(start+n-1);
			data.setListNum(listNum);

			SimpleDateFormat formatter= new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
			Date beginDate = formatter.parse(data.getCreated());
			gap =(endDate.getTime()-beginDate.getTime())/(60*60*1000);
			data.setGap(gap);

			data.setCreated(data.getCreated().substring(0,10));

			n++;
		}
		//공지
		List<TNotice> listTop =null;
		if(current_page==1){
			listTop = service.listTNoticeTop();
		}
		String cp= req.getContextPath();
		String listUrl= cp+"/tnotice/list";
		String articleUrl=cp+"/tnotice/article?page="+current_page;

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
		model.addAttribute("listTop",listTop);
		return ".tnotice.list";
	}

	@RequestMapping(value="/tnotice/created", method=RequestMethod.GET)
	public String createdForm( HttpSession session, Model model) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null){
			return "redirect:/member/login";
		}
		if(! info.getUserId().equals("admin")){
			return "redirect:/tnotice/list";
		}
		model.addAttribute("mode","created");

		return ".tnotice.created";
	}

	@RequestMapping(value="/tnotice/created", method=RequestMethod.POST)
	public String createdSubmit( TNotice dto, HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}
		if(! info.getUserId().equals("admin")){
			return "redirect:/tnotice/list";
		}

		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"tnotice";

		dto.setUserId(info.getUserId());

		service.insertTNotice(dto, pathname);

		return "redirect:/tnotice/list";
	}

	@RequestMapping(value="/tnotice/article")
	public String article(
			@RequestParam int num,
			@RequestParam int page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpSession session, Model model) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null){
			return "redirect:/member/login";
		}
		searchValue = URLDecoder.decode(searchValue,"UTF-8");
		service.updateHitCount(num);

		TNotice dto = service.readTNotice(num);
		if(dto==null)
			return "redirect:/tnotice/list?page="+page;

		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

		Map<String, Object> map = new HashMap<>();
		map.put("num", num);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);

		TNotice preReadDto = service.preReadTNotice(map);
		TNotice nextReadDto = service.nextReadTNotice(map);

		String params="page="+page;

		if(searchValue.length()!=0)
			params+="&searchKey="+searchKey+"&searchValue="+searchValue;

		List<TNotice> listFile = service.listFile(num);

		model.addAttribute("listFile", listFile);
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto",preReadDto);
		model.addAttribute("nextReadDto",nextReadDto);
		model.addAttribute("page", page);
		model.addAttribute("params", params);
		return ".tnotice.article";
	}

	@RequestMapping(value="/tnotice/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam(value="num") int num,
			@RequestParam(value="page") String page,
			Model model,
			HttpSession session) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		if(! info.getUserId().equals("admin"))
			return "redirect:/tnotice/list?page="+page;

		TNotice dto = (TNotice) service.readTNotice(num);
		if(dto==null) {
			return "redirect:/tnotice/list?page="+page;
		}

		List<TNotice> listFile=service.listFile(num);

		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);

		return ".tnotice.created";
	}

	@RequestMapping(value="/tnotice/update", method=RequestMethod.POST)
	public String updateSubmit(
			TNotice dto,
			@RequestParam String page,
			HttpSession session) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		if(! info.getUserId().equals("admin"))
			return "redirect:/tnotice/list?page="+page;

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "tnotice";		

		dto.setUserId(info.getUserId());
		service.updateTNotice(dto, pathname);

		return "redirect:/tnotice/list?page="+page;
	}

	@RequestMapping(value="/tnotice/delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "tnotice";		

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		if(! info.getUserId().equals("admin"))
			return "redirect:/tnotice/list?page="+page;

		// 내용 지우기
		service.deleteTNotice(num, pathname);

		return "redirect:/tnotice/list?page="+page;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="/tnotice/download")
	public void download(
			@RequestParam int fileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "tnotice";

		boolean b = false;

		TNotice dto = service.readFile(fileNum);
		if(dto!=null) {
			String saveFilename = dto.getSaveFilename();
			String originalFilename = dto.getOriginalFilename();

			b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
		}

		if (!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가');history.back();</script>");
			} 
			catch (Exception e) {
				System.out.println(e.toString());
			}
		}
	}

	@RequestMapping(value="/tnotice/deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
			@RequestParam int fileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "tnotice";

		TNotice dto=service.readFile(fileNum);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}

		Map<String, Object> map=new HashMap<String, Object>();
		map.put("field", "fileNum");
		map.put("num", fileNum);
		service.deleteFile(map);

		// 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", "true");
		return model;
	}
}
















