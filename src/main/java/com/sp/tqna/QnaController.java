package com.sp.tqna;

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

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("tqna.qnaController")
public class QnaController {
	@Autowired
	private QnaService service;
	
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/tqna/list")
	public String list(@RequestParam(value="page",defaultValue="1")int current_page,
			          @RequestParam(value="searchKey",defaultValue="subject")String searchKey,
			          @RequestParam(value="searchValue",defaultValue="")String searchValue,
			          Model model,HttpServletRequest req)throws Exception{
		
		String cp =req.getContextPath();
		
		int numPerPage = 10;
		int total_page;
		int dataCount;
		if(req.getMethod().equalsIgnoreCase("GET")){
			searchValue=URLDecoder.decode(searchValue,"utf-8");
		}
		
		Map<String, Object> map= new HashMap<String,Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		dataCount = service.dataCount(map);
		total_page = util.pageCount(numPerPage, dataCount);

		if (total_page < current_page)
			current_page = total_page;

		int start = (current_page - 1) * numPerPage + 1;
		int end = current_page * numPerPage;

		map.put("start", start);
		map.put("end", end);

		List<Qna> list = service.listQna(map);

		// 글번호 만들기
		int listNum, n = 0;
		Iterator<Qna> it = list.iterator();
		while (it.hasNext()) {
			Qna data = it.next();
			listNum = dataCount - (start + n - 1);
			data.setListNum(listNum);
			n++;
		}

		String params = "";
		String urlList = cp + "/tqna/list";
		String urlArticle = cp + "/tqna/article?page=" + current_page;
		
		
		if (searchValue.length() != 0) {
			params = "searchKey=" + searchKey + "&searchValue="
					+ URLEncoder.encode(searchValue, "UTF-8");
		}

		if (params.length() != 0) {
			urlList += "?" + params;
			urlArticle += "&" + params;
		}
		
		String paging = util.paging(current_page, total_page, urlList);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("urlArticle",urlArticle);
		model.addAttribute("paging",paging);
		
		return ".tqna.list";
	}
	@RequestMapping(value="/tqna/created", method=RequestMethod.GET)
	public String createFrom(Model model , HttpSession session)throws Exception{
		
		SessionInfo info =(SessionInfo)session.getAttribute("member");
		
		if(info==null){
			return "redirect:/";
		}
		
		
		model.addAttribute("mode","created");
		
		return ".tqna.created";
	}
	
	@RequestMapping(value="/tqna/created",method=RequestMethod.POST)
	public String createdSubmit(Qna dto, HttpSession session)throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info==null){
			return "redirect:/";
		}
		dto.setUserId(info.getUserId());
		service.insertQna(dto, "created");
		return "redirect:/tqna/list";
	}
	@RequestMapping(value="/tqna/article",method=RequestMethod.GET)
	public String article(
			@RequestParam(value="qnaNum")int qnaNum,
			@RequestParam(value="page",defaultValue="1")String page,
			@RequestParam(value="searchKey",defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue",defaultValue="")String searchValue,
			Model model)throws Exception {
		
	searchValue = URLDecoder.decode(searchValue,"utf-8");
	
	service.hitCount(qnaNum);
	
	Qna dto = service.readQna(qnaNum);
	
	if(dto==null)
		return "redirect:/tqna/list?page="+page;
	
	dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
	Map<String, Object> map = new HashMap<String,Object>();
	map.put("searchKey", searchKey);
	map.put("searchValue", searchValue);
	map.put("groupNum", dto.getGroupNum());
	map.put("orderNo", dto.getOrderNo());
	
	Qna preReadDto = service.preReadBoard(map);
	Qna nextReadDto = service.nextReadBoard(map);
	
	String params= "page="+ page;
	if(searchValue.length()!=0){
		params += "&searchKey=" + searchKey + "&searchValue="
				+ URLEncoder.encode(searchValue, "utf-8"); 
	
	}
	
	
	model.addAttribute("dto",dto);
	model.addAttribute("preReadDto", preReadDto);
	model.addAttribute("nextReadDto", nextReadDto);
	model.addAttribute("page", page);
	model.addAttribute("params", params);
	
	return ".tqna.article";	
	}
	
	@RequestMapping(value="/tqna/delete",method=RequestMethod.GET)
	public String delete(@RequestParam(value="qnaNum") int qnaNum,
			             @RequestParam(value="page",defaultValue="1") String page,
			             HttpSession session)	throws Exception{
		
		SessionInfo info =(SessionInfo)session.getAttribute("member");
		if(info == null)
			return "redirect:/";
		
		service.deleteQna(qnaNum);
		
		return "redirect:/tqna/list?page="+page;
	}
	
	
	@RequestMapping(value="/tqna/update", method=RequestMethod.GET)
	public String updateForm (@RequestParam int qnaNum,
			                  @RequestParam String page,
			                   Model model, HttpSession session) throws Exception
	{
		SessionInfo info =(SessionInfo)session.getAttribute("member");
		
		if(info==null){
			return "redirect:/";
		}


		Qna dto =service.readQna(qnaNum);
		if(dto == null){
			return "redirect:/tqna/list";
		}
		System.out.println(dto.getGroupNum()+"업댓");
		
		
		model.addAttribute("mode","update");
		model.addAttribute("page",page);
		model.addAttribute("dto",dto);
		
		return ".tqna.created";
	}
	
	@RequestMapping(value="/tqna/update", method=RequestMethod.POST)
	public String updateSubmit(Qna qna, @RequestParam String page, HttpSession session) throws Exception {
	
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info==null){
		return "redirect:/";
		}
		
		service.updateQna(qna);
		return "redirect:/tqna/list?page="+page;
	}

	@RequestMapping(value="/tqna/reply", method=RequestMethod.GET)
	public String replyForm(
			@RequestParam int qnaNum,
			@RequestParam String page,
			Model model,
			HttpSession session
			) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return "redirect:/member/login";
		}
		
		Qna dto = service.readQna(qnaNum);
		if (dto == null) {
			return "redirect:/tqna/list?page="+page;
		}
		System.out.println(dto.getGroupNum()+"리플 폼");
		String str = "["+dto.getSubject()+"] 에 대한 답변입니다.\n";
		dto.setContent(str);
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("mode", "reply");

		return ".tqna.created";
	}
	
	@RequestMapping(value="/tqna/reply", method = RequestMethod.POST)
	public String replySubmit(
			Qna dto,
		    @RequestParam String page,
		    HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		if (info == null) {
			return "redirect:/";
		}


	
		dto.setUserId(info.getUserId());
		
		System.out.println(dto.getGroupNum()+"리플 서브밋");
		service.insertQna(dto, "reply");
		return "redirect:/tqna/list?page="+page;
	}

}
	
	

