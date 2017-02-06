package com.sp.tphoto;

import java.io.File;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.FileManager;
import com.sp.common.MyUtil;
import com.sp.common.dao.CommonDAO;
import com.sp.member.SessionInfo;

@Controller("tphoto.tphotoController")
public class PhotoController {

	
	@Autowired
	private PhotoService service;
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private MyUtil util;
	
	
	
	@RequestMapping(value="/tphoto/list")
	public String list(@RequestParam (value="page" ,defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="searchKey") String searchKey,
			@RequestParam(value="searchValue",defaultValue="")String searchValue,
			HttpServletRequest req, Model model)throws Exception{
		String cp= req.getContextPath();
		
		
		int numPerPage=8;
		int total_page;
		int dataCount;
		

		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		
        // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("searchKey", searchKey);
        map.put("searchValue", searchValue);

		dataCount = service.dataCount(map);
		total_page =util.pageCount(numPerPage, dataCount);

		if (total_page < current_page)
			current_page = total_page;

		int start = (current_page - 1) * numPerPage + 1;
		int end = current_page * numPerPage;

		map.put("start", start);
		map.put("end", end);

		List<Photo> list = service.listPhoto(map);

		// 글번호 만들기
				int listNum, n = 0;
				Iterator<Photo> it = list.iterator();
				while (it.hasNext()) {
					Photo data = it.next();
					listNum = dataCount - (start + n - 1);
					data.setListNum(listNum);
					n++;
				}

		        String params = "";
		        String urlList = cp+"/tphoto/list";
		        String urlArticle = cp+"/tphoto/article?page=" + current_page;
		        if(searchValue.length()!=0) {
		        	params = "searchKey=" +searchKey + 
		        	             "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");	
		        }
		        
		        if(params.length()!=0) {
		            urlList = cp+"/tphoto/list?" + params;
		            urlArticle = cp+"/tphoto/article?page=" + current_page + "&"+ params;
		        }
				
		        String paging = util.paging(current_page, total_page, urlList);
		        		
				
				model.addAttribute("list", list);
				model.addAttribute("dataCount", dataCount);
				model.addAttribute("total_page", total_page);
				model.addAttribute("urlArticle", urlArticle);
				model.addAttribute("page", current_page);
				model.addAttribute("paging", paging);
		
		
		return ".tphoto.list";
	}
	
	@RequestMapping(value="/tphoto/created",method=RequestMethod.GET)
	public String createdForm(HttpSession session,Model model) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info==null){
			return "redirect:/";
			
		}
		
		model.addAttribute("mode", "created");
		
		return ".tphoto.created";
	}
	
	
	@RequestMapping(value="/tphoto/created",method=RequestMethod.POST)
	public String createdSubmit(Photo dto, Model model, HttpSession session)throws Exception{
		
		
		String root= session.getServletContext().getRealPath("/");
		String path = root+File.separator+"uploads"+File.separator+"tphoto";
		
		SessionInfo info =(SessionInfo)session.getAttribute("member");
		if(info==null){
			return "redirect:/";
			
		}
		
		dto.setUserId(info.getUserId());
		service.insertPhoto(dto, path);
		
		
		return "redirect:/tphoto/list";
	}
	
	@RequestMapping(value="/tphoto/article",method=RequestMethod.GET)
	public String article(@RequestParam(value="num")int num,
			@RequestParam(value="page") String page,
			@RequestParam(value="searchKey",defaultValue ="searchKey") String searchKey,
			@RequestParam(value="searchValue",defaultValue="")String searchValue,
			Model model, HttpSession session)throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null){
			return "redirect:/";
			
		}
	    
		Photo dto = service.readPhoto(num);
		service.updateHitCount(num);
		

		if(dto==null){
			return "redirect:/tphoto/list?page="+page;
		}
				
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("num", num);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		//map.put("page", page);
		
		Photo preReadDto = service.preReadPhoto(map);
		Photo nextReadDto = service.nextReadPhoto(map);
		
		System.out.println(preReadDto);
		System.out.println(nextReadDto);
		
		String params ="page="+page;
		if(searchValue.length()!=0){
			
			params += "&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue,"utf-8");
			
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("nextReadDto",nextReadDto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("page", page);
		model.addAttribute("params", params);
		return ".tphoto.article";
	}
	
	@RequestMapping(value="/tphoto/update",method=RequestMethod.GET)
	public String updateForm(@RequestParam int num, @RequestParam String page, Model model, HttpSession session)throws Exception{
		SessionInfo info =(SessionInfo)session.getAttribute("member");
		
		if(info==null){
			return "redirect:/";
			
		}
		
		Photo dto = service.readPhoto(num);
		
		if(dto == null){
			return "redirect:/tphoto/list?page="+page;
		}
		
		if(!dto.getUserId().equals(info.getUserId())){
			return "redirect:/tphoto/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		
		
		return ".tphoto.created";
	}
	
	@RequestMapping(value="/tphoto/update", method=RequestMethod.POST)
	public String updateSubmit(Photo dto, String page, HttpSession session ) throws Exception{
		
		String root= session.getServletContext().getRealPath("/");
		String pathname =root+File.separator+"uploads"+File.separator+"tphoto";
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info==null){
			return "redirect:/";
			
		}
		
		service.updatePhoto(dto, pathname);
		
		return "redirect:/tphoto/list?page="+page;

		//	"redirect:/tphoto/artice?num="+dto.getNum()+"&page="+page;
		
	}
	@RequestMapping(value="/tphoto/delete",method=RequestMethod.GET)
	public String delete(@RequestParam int num, @RequestParam String page, HttpSession session)throws Exception{
		
		String root= session.getServletContext().getRealPath("/");
		String pathname= root+File.separator+"uploads"+File.separator+"tphoto";
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info==null){
			return "redirect:/";
		}
		
		Photo dto = service.readPhoto(num);
	  System.out.println(dto.getNum());
		
		if(!dto.getUserId().equals(info.getUserId()) && !info.getUserId().equals("admin")){
			return "redirect:/tphoto/list?page="+page;
		}
		
		service.deletePhoto(num, dto.getImageFilename(), pathname);
		System.out.println(dto.getNum());
		
		return "redirect:/tphoto/list?page="+page;
	}
	
	
	
	///댓글 가자
	
	@RequestMapping(value="/tphoto/listReply")
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
		
		
		
		return ".single.tphoto.listReply";
	}
	
	
	
	@RequestMapping(value="/tphoto/listReplyAnswer")
	public String listReplyAnswer(@RequestParam int answer , Model model)throws Exception{
		
		List<Reply> listReplyAnswer = service.listReplyAnswer(answer);
		
		Iterator<Reply> it= listReplyAnswer.iterator();
		while(it.hasNext()){
			 Reply dto = it.next();
			 dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		
		
		return ".single.tphoto.listReplyAnswer";
	}
	
	@RequestMapping(value="/tphoto/replyCountAnswer", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyCountAnswer(@RequestParam int answer)throws  Exception{
		
		int count = 0;
		count = service.replyCountAnswer(answer);
		
		Map<String, Object> model = new HashMap<>();
		
		model.put("count", count);
		
		return model;
	}
	
	
	
	@RequestMapping(value="/tphoto/createdReply" ,method=RequestMethod.POST)
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
	@RequestMapping(value="/tphoto/deleteReply",method=RequestMethod.POST)
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
	
	
	@RequestMapping(value="/tphoto/tphotoLike",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> photoLike(Photo dto , HttpSession session)throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String state = "true";
		if(info==null){
			state="loginFail";
		}else{ dto.setUserId(info.getUserId());
			int result = service.insertPhotoLike(dto);
			if(result==0)
				state="false";
		}
		Map<String, Object> model =new HashMap<>();
		model.put("state", state);	
		return model;
	}

	@RequestMapping(value="/tphoto/tcountLike", method=RequestMethod.POST)
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
	
	@RequestMapping(value="/tphoto/repleLike",method=RequestMethod.POST)
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
	
	
	@RequestMapping(value="/tphoto/countLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countLike(@RequestParam int repleNum)throws Exception{
		int likeCount=0, disLikeCount=0;
		Map<String, Object> map = service.replyCountLike(repleNum);
		if(map!=null){
			likeCount=((BigDecimal)map.get("LIKECOUNT")).intValue();
			disLikeCount=((BigDecimal)map.get("DISLIKECOUNT")).intValue();
			}
		
		Map<String, Object> model = new HashMap<>();
		model.put("likeCount", likeCount);
		model.put("dislikeCount", disLikeCount);
		
		return model;
	}
	
}
