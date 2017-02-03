package com.sp.group.gally;


import java.io.File;
import java.io.PrintWriter;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

import net.sf.json.JSONObject;


@Controller("group.groupGallyController")
public class PhotoController {
	
	@Autowired
	private PhotoService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/groupGally/gally")
	public String gally()throws Exception{
		return "group/gally";
	}
	
	@RequestMapping(value="/groupGally/list")
	public String list(Model model,HttpServletRequest req,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="groupSubject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue
			)throws Exception{
		
		int numPerPage = 6;
		int total_page;
		int dataCount;
		
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		//전체 페이지수.
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
			    
		dataCount= service.dataCount(map);
		total_page= myUtil.pageCount(numPerPage, dataCount);
	    
	    if(total_page < current_page)
	    	current_page= total_page;
	    
	    int start = (current_page-1) * numPerPage+1;
	    int end = current_page* numPerPage;
	    
	    map.put("start", start);
	    map.put("end", end);
	    List<GroupGally> list =service.listPhoto(map);
	    
	  
	  
		 int listNum, n=0;
	
		 Iterator<GroupGally> it= list.iterator();
		  while(it.hasNext()){
			  GroupGally data= it.next();
			 listNum= dataCount - (start + n - 1);
			 data.setListNum(listNum);
			 n++;
		}
	    
	
	        
		    String paging = myUtil.paging(current_page, total_page);
		    
		    model.addAttribute("list",list );
		    model.addAttribute("dataCount", dataCount);
		    model.addAttribute("total_page", total_page);
		    model.addAttribute("page", current_page);
		    model.addAttribute("paging", paging);
		    model.addAttribute("searchKey", searchKey);
		    model.addAttribute("searchValue", URLDecoder.decode(searchValue, "utf-8"));
		    
		    return "group/listGally";
	}
	
	
	
	@RequestMapping(value="/group/photo/created", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdSubmit(GroupGally dto, HttpSession session) throws Exception{
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("/");
		String path=root+File.separator+"uploadf"+File.separator+"photo";
		String state="false";

		dto.setUserId(info.getUserId());//아이디저장.	
	
		int result=service.insertPhoto(dto, path);
		
		if(result!=0)
			state="true";
		
		Map<String, Object> model= new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/group/photo/article", method=RequestMethod.GET)
	public String article(@RequestParam(value="gallyNum") int gallyNum,Model model
			) throws Exception{

		GroupGally dto= service.readPhoto(gallyNum);
			dto.setSubject(dto.getSubject().replaceAll("\n", "<br>"));

			
			model.addAttribute("dto", dto);

		return "group/articleGally";
	}
	
	//group/photo/delete  group/listGally
	@RequestMapping(value="/group/photo/delete", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(@RequestParam int gallyNum, HttpSession session) throws Exception{
		
	  	//SessionInfo info=(SessionInfo)session.getAttribute("member");
	  	
		String root=session.getServletContext().getRealPath("/");
		String path=root+File.separator+"uploadf"+File.separator+"photo";
		String state="false";
		
		GroupGally dto = service.readPhoto(gallyNum);//읽어온다.
	/*	if(! dto.getUserId().equals(info.getUserId()) && ! info.getUserId().equals("admin")) {
			
			state="false";
		} else {
			state="true";
		}*/
		Map<String, Object> model= new HashMap<>();
		service.deletePhoto(gallyNum, dto.getImageFilename(), path);
		model.put("state", state);
		
		return model;
	}
	 
	@RequestMapping(value="/group/photo/update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSubmit(GroupGally dto, HttpSession session) throws Exception{
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("/");
		String path=root+File.separator+"uploadf"+File.separator+"photo";
		String state="false";

			
		//dto.setUserId(info.getUserId());//아이디저장.	
		int result=service.updatePhoto(dto, path);
		if(result!=0)
			state="true";
		
		Map<String, Object> model= new HashMap<>();
		model.put("state", state);
		return model;
	}
	///group/photo/createdGReply
	//개시물의 답글 등록하기
	@RequestMapping(value="/group/photo/createdGReply", method=RequestMethod.POST)
	public void createdReply(ReplyGPhoto dto,HttpServletResponse resp, HttpSession session) throws Exception{


		SessionInfo info=(SessionInfo)session.getAttribute("member");
				
		String loginChk="true";
		String state="false";
		System.out.println(dto.getUserId()+"..........................");
		//이부분이 아티클 => GReply를 통해 댓글 인설트하는곳.
			if(info==null) {
				loginChk="false";
			} else {
				int result= service.insertGReply(dto);
				if(result==1)
				state="true";
			}
			//여기서부터			insertGReply
			/*int result= service.insertGReply(dto);
			if(result==1)
				state="true";*/
				////여기까지 else 안에 넣어라
				JSONObject job=new JSONObject();
				job.put("state", state);
				job.put("loginChk", loginChk);
				resp.setContentType("text/html;charset=utf-8");
				PrintWriter out=resp.getWriter();
				out.print(job.toString());
	}
	
	
			@RequestMapping(value="/group/photo/listGReply")
			public String listGReply(
					@RequestParam int gallyNum,
					@RequestParam(value="pageNo", defaultValue="1") int current_page,
					Model model
					) throws Exception{
				
				int numPerPage=1;
				int total_page=0;
				int dataCount=0;
				
				Map<String, Object> map = new HashMap<String, Object>();
				
				dataCount=service.GReplyDataCount(gallyNum);
				
				total_page=myUtil.pageCount(numPerPage, dataCount);
				if(current_page> total_page)
						current_page=total_page;
				//리스트 출력데이터
				int start=(current_page-1)*numPerPage+1;
				int end=current_page*numPerPage;

				map.put("gallyNum", gallyNum);
				map.put("start",start );
				map.put("end", end);
				
				List<ReplyGPhoto> listGReply=service.listGReply(map);

				Iterator<ReplyGPhoto> it= listGReply.iterator();

				while(it.hasNext()){
					ReplyGPhoto dto=it.next();
//					listReplyNum=dataCount-(start+n-1);
//					dto.setListReplyNum(listReplyNum);
					dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
					//n++;
				}

				String paging=myUtil.paging(current_page, total_page);


				model.addAttribute("listGReply",listGReply);
				model.addAttribute("pageNo",current_page);
				model.addAttribute("GReplyCount",dataCount);
				model.addAttribute("total_page",total_page);
				model.addAttribute("paging",paging);
				
				return "group/listGReply";
			}
			
		
			
	@RequestMapping(value="/group/photo/deleteReply", method=RequestMethod.POST)
	public void deletReply(ReplyGPhoto dto,HttpServletResponse resp,HttpSession session)throws Exception{
						
		SessionInfo info=(SessionInfo)session.getAttribute("member");
						
		String loginChk="true";
		String state="false";

		int result=service.deleteReply(dto);
		if(result!=0)
		state="true";
					//여기까지 두번쨰 if문장에 넣기
		JSONObject job=new JSONObject();
		job.put("state", state);
		job.put("loginChk", loginChk);
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.print(job.toString());
	}
	
			
	
	//해당 게시물의 답글에 => 답변을 등록 하는곳
	@RequestMapping(value="/group/photo/insertGReplyAnswer", method=RequestMethod.POST)
	public void insertGReplyAnswer(ReplyGPhoto dto,HttpServletResponse resp)throws Exception{


		String loginChk="true";
		String state="false";

		int result= service.insertGReply(dto);		
		if(result==1)
			state="true";

		JSONObject job=new JSONObject();
		
		job.put("state", state);
		job.put("loginChk", loginChk);
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.print(job.toString());
		
	}

	
	//해당 개시글의 답글에=>> 작성한 답변의 리스트를 뽑아주는곳  
	@RequestMapping(value="/group/photo/listReplyAnswer")
	public String listReplyAnswer(@RequestParam int replyAnswer, Model model)throws Exception{
		
	List<ReplyGPhoto> listAnswer=service.listReplyAnswer(replyAnswer);
	Iterator<ReplyGPhoto> it=listAnswer.iterator();
	while(it.hasNext()){
		ReplyGPhoto dto= it.next();
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
	}
	model.addAttribute("listAnswer",listAnswer);
					
	return "group/groupAnswerList";		
	}
	
	//해당 개시글의 답글에=>> 작성한 답변을 삭제하는곳
	@RequestMapping(value="/group/photo/deleteReplyAnswer", method=RequestMethod.POST)
	public void deleteReplyAnswer(ReplyGPhoto dto, HttpServletResponse resp) throws Exception{
		
		//SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		
		String loginChk="true"; 
		String state="false";
		
		/*if(info==null) {
			loginChk="false";
		} else if(info.getUserId().equals("admin") || info.getUserId().equals(userId)) {
			int result=service.deleteReplyAnswer(dto);
			if(result !=0){
			state="true";
		}
		}*/
		
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
	
	@RequestMapping(value="/group/photo/replyCountAnswer", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyCountAnswer(@RequestParam int replyAnswer)throws  Exception{
		
		int count = 0;
		count = service.replyGroupCountAnswer(replyAnswer);
		System.out.println(count+"       -----------ssssssssssssssssssssssssssss--");
		Map<String, Object> model = new HashMap<>();
		
		model.put("count", count);
		
		return model;
	}

	
	////group/photo/gallryReplyLike
	@RequestMapping(value="/group/photo/gallryReplyLike",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyLike(ReplyGPhoto dto, HttpSession session)throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String state = "true";
		if(info==null){
			state="loginFail";
		}else{
			dto.setUserId(info.getUserId());
			int result= service.insertGallyReplyLike(dto);
			if(result==0)
				state="false";
		}
		
		Map<String, Object>model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}


	@RequestMapping(value="/group/photo/groupCountLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> groupCountLike(@RequestParam int replyNum)throws Exception{
		int likeCount=0, disLikeCount=0;
		Map<String, Object> map = service.groupGeplyCountLike(replyNum);
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