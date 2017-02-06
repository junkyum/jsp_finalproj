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
	public String gally(Model model,@RequestParam String groupName)throws Exception{
		model.addAttribute("groupName",groupName);
		return "group/gally";
	}
	
	@RequestMapping(value="/groupGally/list")
	public String list(Model model,HttpServletRequest req,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(value="searchKeyK", defaultValue="subject") String searchKeyK,
			@RequestParam(value="searchValueK", defaultValue="") String searchValueK
			)throws Exception{

		int numPerPage = 6;
		int total_page;
		int dataCount;
		
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			searchValueK = URLDecoder.decode(searchValueK, "utf-8");
		}

		//전체 페이지수.
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("searchKeyK", searchKeyK);
		map.put("searchValueK", searchValueK);
			    
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
		  //////////////////////////////////


		    String paging = myUtil.paging(current_page, total_page);

		    model.addAttribute("list",list );
		    model.addAttribute("dataCount", dataCount);
		    model.addAttribute("total_page", total_page);
		    model.addAttribute("page", current_page);
		    model.addAttribute("paging", paging);
		    model.addAttribute("searchKeyK", searchKeyK);
		    model.addAttribute("searchValueK", searchValueK);
		    
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
		System.out.println(dto.getGroupName()+"  sssssssssssssssss");
	/*	System.out.println(dto.getUserId()+"  ----------------------등록할떄");
		System.out.println(dto.getGroupName()+"  ---------------------등록할떄");
		System.out.println(dto.getSubject()+"  ----------------------등록할떄");
		System.out.println(dto.getContent()+"  ----------------------등록할때");*/

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
		
		String root=session.getServletContext().getRealPath("/");
		String path=root+File.separator+"uploadf"+File.separator+"photo";
		String state="false";

		GroupGally dto = service.readPhoto(gallyNum);//읽어온다.
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

		int result=service.updatePhoto(dto, path);
		if(result!=0)
			state="true";
		
		Map<String, Object> model= new HashMap<>();
		model.put("state", state);
		return model;
	}

	//개시물의 답글 등록하기
	@RequestMapping(value="/group/photo/createdGReply", method=RequestMethod.POST)
	public void createdReply(ReplyGPhoto dto,HttpServletResponse resp, HttpSession session) throws Exception{


		SessionInfo info=(SessionInfo)session.getAttribute("member");
				
		String loginChk="true";
		String state="false";
		
		System.out.println(dto.getGallyNum()+"   사진 번호");
		System.out.println(dto.getContent()+"    리플내용");
		System.out.println(dto.getReplyAnswer()+"   리플의 답글");
		System.out.println(dto.getUserId()+"   유저 ID");
			if(info==null) {
				loginChk="false";
			} else {
				int result= service.insertGReply(dto);
				if(result==1)
				state="true";
			}
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
				
				//pagingMethod => 내가 원하는 페이징 메소드를 따로 만들고 싶을떄 사용합니다.
				String paging=myUtil.pagingMethod(current_page, total_page, "listPageAnswer");
				//System.out.println(paging+"                     ");

				model.addAttribute("listGReply",listGReply);
				System.out.println();
				model.addAttribute("pageNo",current_page);
				model.addAttribute("GReplyCount",dataCount);
				model.addAttribute("total_page",total_page);
				model.addAttribute("paging",paging);
				
				return "group/listGReply";//위에서 받아온 정보를   listGReply.jsp에 뿌린다.
			}
			
		
			
	@RequestMapping(value="/group/photo/deletePhotoReply", method=RequestMethod.POST)
	public void deletReply(ReplyGPhoto dto,HttpServletResponse resp,HttpSession session)throws Exception{
						
		SessionInfo info=(SessionInfo)session.getAttribute("member");
						
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
					
	return "group/gallyAnswerList";		
	}
	
	//해당 개시글의 답글에=>> 작성한 답변을 삭제하는곳
	@RequestMapping(value="/group/photo/deleteReplyAnswer", method=RequestMethod.POST)
	public void deleteReplyAnswer(ReplyGPhoto dto, HttpServletResponse resp) throws Exception{
		
		//SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		
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
	
	//게시물 밑에 답글 밑에 답글의 갯수를 새는곳 
	@RequestMapping(value="/group/photo/replyCountAnswer", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyCountAnswer(@RequestParam int replyAnswer)throws  Exception{
		
		int count = 0;
		count = service.replyGroupCountAnswer(replyAnswer);
		Map<String, Object> model = new HashMap<>();
		
		model.put("count", count);
		
		return model;
	}

	
	//게시물밑에 답글 좋아요@싫어요 저장하는곳
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

	//게시물 밑에 답글 좋아 싫어요 갯수를 세는곳
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

	
	//게시물 좋아요 하는곳
	@RequestMapping(value="/group/photo/gallyLike",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertGallyLike(GroupGally dto , HttpSession session)throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String state = "true";
		
		if(info==null){
			state="false";
		}else{ dto.setUserId(info.getUserId());
			int result = service.insertGallyLike(dto);
			if(result==0)
				state="false";
		}
		Map<String, Object> model =new HashMap<>();
		model.put("state", state);	
		return model;
	}

	
	//게시물 좋아요 갯수 세는곳
	///group/photo/groupGallyLikeCount
	@RequestMapping(value="/group/photo/groupGallyLikeCount", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> groupGallyLikeCount(@RequestParam int gallyNum)throws Exception{
		int gallyLikeCount=0;
		Map<String, Object> map = service.groupGallyLikeCount(gallyNum);
		if(map!=null){
			gallyLikeCount=((BigDecimal)map.get("GALLYLIKECOUNT")).intValue();
			}
		//gallyLikeCount   gallyLikeCountG
		Map<String, Object> model = new HashMap<>();
		model.put("gallyLikeCount", gallyLikeCount);
		
		return model;
	}
	
	
	
	
}