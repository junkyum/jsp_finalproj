package com.sp.tboard;

import java.io.File;
import java.io.PrintWriter;
import java.math.BigDecimal;
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

@Controller("tboard.TBoardController")
public class TBoardController {
	@Autowired
	private TBoardService service;
	@Autowired
	private MyUtil util;

	@Autowired
	private FileManager fileManager;
	//11

	@RequestMapping(value="/tboard/list")
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
		List<TBoard> list = service.listTBoard(map);
		Date endDate = new Date();
		long gap;
		//리스트의 번호
		int listNum , n=0;
		Iterator<TBoard> it = list.iterator();
		while(it.hasNext()){
			TBoard data = it.next();
			listNum = dataCount-(start+n-1);
			data.setListNum(listNum);

			SimpleDateFormat formatter= new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
			Date beginDate = formatter.parse(data.getCreated());

			//날짜 차이 (일)
			//gap =(endDate.getTime()-beginDate.getTime())/(24*60*60*1000);
			//data.setGap(gap);

			//날짜 차이(시간)
			gap =(endDate.getTime()-beginDate.getTime())/(60*60*1000);
			data.setGap(gap);

			data.setCreated(data.getCreated().substring(0,10));

			n++;
		}
		
		String cp= req.getContextPath();
		String listUrl= cp+"/tboard/list";
		String articleUrl=cp+"/tboard/article?page="+current_page;

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


		return ".tboard.list";
	}

	@RequestMapping(value="/tboard/created", method=RequestMethod.GET)
	public String createdForm( HttpSession session, Model model) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null){
			return "redirect:/member/login";
		}

		model.addAttribute("mode","created");



		return ".tboard.created";
	}

	@RequestMapping(value="/tboard/created", method=RequestMethod.POST)
	public String createdSubmit( TBoard dto, HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"TBoard";

		dto.setUserId(info.getUserId());

		service.insertTBoard(dto, pathname);

		return "redirect:/tboard/list";
	}

	@RequestMapping(value="/tboard/article")
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

		TBoard dto = service.readTBoard(num);
		if(dto==null)
			return "redirect:/tboard/list?page="+page;

		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

		Map<String, Object> map = new HashMap<>();
		map.put("num", num);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);

		TBoard preReadDto = service.preReadTBoard(map);
		TBoard nextReadDto = service.nextReadTBoard(map);

		String params="page="+page;

		if(searchValue.length()!=0)
			params+="&searchKey="+searchKey+"&searchValue="+searchValue;

		List<TBoard> listFile = service.listFile(num);

		model.addAttribute("listFile", listFile);
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto",preReadDto);
		model.addAttribute("nextReadDto",nextReadDto);
		model.addAttribute("page", page);
		model.addAttribute("params", params);
		return ".tboard.article";
	}

	@RequestMapping(value="/tboard/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam(value="num") int num,
			@RequestParam(value="page") String page,
			Model model,
			HttpSession session) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		TBoard dto = (TBoard) service.readTBoard(num);
		if(dto==null) {
			return "redirect:/tboard/list?page="+page;
		}

		List<TBoard> listFile=service.listFile(num);


		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);

		return ".tboard.created";
	}

	@RequestMapping(value="tboard/update", method=RequestMethod.POST)
	public String updateSubmit(
			TBoard dto,
			@RequestParam String page,
			HttpSession session) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		if(! info.getUserId().equals("admin"))
			return "redirect:/tboard/list?page="+page;

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "TBoard";		

		dto.setUserId(info.getUserId());
		service.updateTBoard(dto, pathname);

		return "redirect:/tboard/list?page="+page;
	}

	@RequestMapping(value="/tboard/delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "TBoard";		

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		if(! info.getUserId().equals("admin"))
			return "redirect:/tboard/list?page="+page;

		// 내용 지우기
		service.deleteTBoard(num, pathname);

		return "redirect:/tboard/list?page="+page;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="/tboard/download")
	public void download(
			@RequestParam int fileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "TBoard";

		boolean b = false;

		TBoard dto = service.readFile(fileNum);
		if(dto!=null) {
			String saveFilename = dto.getSaveFilename();
			String originalFilename = dto.getOriginalFilename();

			b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
		}

		if (!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>");
			} 
			catch (Exception e) {
				System.out.println(e.toString());
			}
		}
	}

	@RequestMapping(value="/tboard/deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
			@RequestParam int fileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "TBoard";

		TBoard dto=service.readFile(fileNum);
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
	
	
	@RequestMapping(value="/tboard/article", method=RequestMethod.POST)
	public String insertRepleSubmit( TBoard dto, HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"TBoard";

		dto.setUserId(info.getUserId());

		service.insertTBoard(dto, pathname);

		return "redirect:/tboard/article";
	}
	
	

	///댓글 가자
	
	@RequestMapping(value="/tboard/listReply")
	public String listReply(@RequestParam int num, @RequestParam(value="pageNo",defaultValue="1") int current_page,Model model)throws Exception{
		
		int numPerPage = 5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("num", num);
		
		dataCount = service.dataCount(map);
		total_page = util.pageCount(numPerPage, dataCount);
		
		if(total_page <current_page)
			current_page= total_page;
		
		int start =(current_page-1)*numPerPage +1;
		int end = current_page * numPerPage;
		
		map.put("start", start);
		map.put("end", end);
		
		List<Reply> listReply = service.listReply(map);
		
		int listNum, n =0;
		
		Iterator<Reply> it=listReply.iterator();
		
		
		while(it.hasNext()){
			Reply dto = it.next();
			listNum = dataCount - (start+n-1);
			dto.setListNum(listNum);
			
			n++;
			
		}
		
		String paging = util.paging(current_page, total_page);
		
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		
		
		return ".single.tboard.listReply";
	}
	
	
	
	@RequestMapping(value="/tboard/listReplyAnswer")
	public String listReplyAnswer(@RequestParam int answer , Model model)throws Exception{
		
		List<Reply> listReplyAnswer = service.listReplyAnswer(answer);
		
		Iterator<Reply> it= listReplyAnswer.iterator();
		while(it.hasNext()){
			 Reply dto = it.next();
			 dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		
		
		return ".single.tboard.listReplyAnswer";
	}
	
	@RequestMapping(value="/tboard/replyCountAnswer", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyCountAnswer(@RequestParam int answer)throws  Exception{
		
		int count = 0;
		count = service.replyCountAnswer(answer);
		
		Map<String, Object> model = new HashMap<>();
		
		model.put("count", count);
		
		return model;
	}
	
	
	
	@RequestMapping(value="/tboard/createdReply" ,method=RequestMethod.POST)
	@ResponseBody
    public Map<String, Object> createdReply(Reply dto , HttpSession session)throws  Exception{
    	
    	SessionInfo info = (SessionInfo)session.getAttribute("member");
    	
    	String state="true";
    	if(info == null){
    		state= "loginFail";
    	}else{
    		dto.setUserId(info.getUserId());
    		int result= service.insertReply(dto);
    		if(result==0)
    			state ="false";
    	}
    	
    	Map<String, Object> model = new HashMap<>();
    	model.put("state", state);
    	
    	
    	return model;
    }
	@RequestMapping(value="/tboard/deleteReply",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(@RequestParam int repleNum, @RequestParam String mode, HttpSession session)throws Exception{
		
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String state = "true";
		if(info==null){
			state="loginFail";
		}else{
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("mode", mode);
			map.put("repleNum", repleNum);
		
		int result= service.deleteReply(map);
		if(result==0)
			state="false";
		}
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	
	@RequestMapping(value="/tboard/tBoardLike",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> boardLike(TBoard dto , HttpSession session)throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String state = "true";
		if(info==null){
			state="loginFail";
		}else{ dto.setUserId(info.getUserId());
			int result = service.insertBoardLike(dto);
			if(result==0)
				state="false";
		}
		Map<String, Object> model =new HashMap<>();
		model.put("state", state);	
		return model;
	}

	@RequestMapping(value="/tboard/tlikeCount", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> tcountLike(@RequestParam int num)throws Exception{
		int tlikeCount=0, tdisLikeCount=0;
		Map<String, Object> map = service.countLike(num);
		if(map!=null){
			tlikeCount=((BigDecimal)map.get("TLIKECOUNT")).intValue();
			tdisLikeCount=((BigDecimal)map.get("TDISLIKECOUNT")).intValue();
			}
		
		Map<String, Object> model = new HashMap<>();
		model.put("tlikeCount", tlikeCount);
		model.put("tdislikeCount", tdisLikeCount);
		
		return model;
	}
	
	@RequestMapping(value="/tboard/repleLike",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyLike(Reply dto, HttpSession session)throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String state = "true";
		if(info==null){
			state="loginFail";
		}else{
			dto.setUserId(info.getUserId());
			int result= service.insertReplyLike(dto);
			if(result==0)
				state="false";
		}
		
		Map<String, Object>model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	
	@RequestMapping(value="/tboard/countLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countLike(@RequestParam int repleNum)throws Exception{
		int tlikeCount=0, disLikeCount=0;
		Map<String, Object> map = service.replyCountLike(repleNum);
		if(map!=null){
			tlikeCount=((BigDecimal)map.get("LIKECOUNT")).intValue();
			disLikeCount=((BigDecimal)map.get("DISLIKECOUNT")).intValue();
			}
		
		Map<String, Object> model = new HashMap<>();
		model.put("tlikeCount", tlikeCount);
		model.put("dislikeCount", disLikeCount);
		
		return model;
	}
}
















