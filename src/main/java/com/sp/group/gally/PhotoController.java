package com.sp.group.gally;


import java.io.File;
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


@Controller("group.groupGallyController")
public class PhotoController {
	
	@Autowired
	private PhotoService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/groupGally/list")
	public String list(Model model,HttpServletRequest req,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="groupSubject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue
			)throws Exception{
		
		String cp= req.getContextPath();
		
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
	    
//	    System.out.println(searchKey+"-------------------");
//	    System.out.println(searchValue+"------------------");
//	    //잘들어옴
	    dataCount= service.dataCount(map);
	    total_page= myUtil.pageCount(numPerPage, dataCount);
	    
	    if(total_page < current_page)
	    	current_page= total_page;
	    
	    int start = (current_page-1) * numPerPage+1;
	    int end = current_page* numPerPage;
	    
	    map.put("start", start);
	    map.put("end", end);
	    
	    List<GroupGally> list =service.listPhoto(map);
	    
	    //글번호 만들기.
	    int listNum, n=0;
	    //int chkNum;
	   // int a=0;
	    Iterator<GroupGally> it= list.iterator();
	    while(it.hasNext()){
	    	GroupGally data= it.next();
	    	listNum= dataCount - (start + n - 1);
	    	//chkNum= dataCount - (start + n - 1);
	    	data.setListNum(listNum);
	    	//data.setChkNum(chkNum);
	    	n++;
	    }
	   

	    String params="";
	    String urlList=cp+"/groupGally/list";
	    String urlArticle = cp+"/photo/article?page=" + current_page;
	    
	    if(searchValue.length()!=0) {
        	params = "searchKey=" +searchKey + 
        	             "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");	
        }
	    
	    if(params.length() !=0){
	    	 urlList = cp+"/groupGally/list?" + params;
	         urlArticle = cp+"/groupGally/article?page=" + current_page + "&"+ params;
	    }

        
	    String paging = myUtil.paging(current_page, total_page, urlList);
	    
	    model.addAttribute("list",list );
	    model.addAttribute("dataCount", dataCount);
	    model.addAttribute("total_page", total_page);
	    model.addAttribute("page", current_page);
	    model.addAttribute("paging", paging);
	    model.addAttribute("urlArticle", urlArticle);

	   
		return "groupGally/list";
	}
	

	
	@RequestMapping(value="/photo/created", method=RequestMethod.POST)
	public String createdSubmit(GroupGally dto, HttpSession session) throws Exception{
		
		String root=session.getServletContext().getRealPath("/");
		String path=root+File.separator+"uploadf"+File.separator+"photo";
		
		service.insertPhoto(dto, path);
		
		return "redirect:/groupGally/list";
	}
	
	
	
	//article 만듬
//	 System.out.println(searchKey+"-------------------");
//	    System.out.println(searchValue+"------------------");
	@RequestMapping(value="/groupGally/article", method=RequestMethod.GET)
	public String article(
			@RequestParam(value="groupNum") int groupNum,
			Model model
			) throws Exception{
		
			GroupGally dto= service.readPhoto(groupNum);
	
			
			dto.setGroupSubject(dto.getGroupSubject().replaceAll("\n", "<br>"));

			model.addAttribute("mode","article");
			model.addAttribute("dto", dto);

		return "groupGally/article";
	}
	
	@RequestMapping(value="/photo/delete", method=RequestMethod.GET)
	public String delete(@RequestParam int groupNum, HttpSession session) throws Exception{
		
		String root=session.getServletContext().getRealPath("/");
		String path=root+File.separator+"uploadf"+File.separator+"photo";

		GroupGally dto = service.readPhoto(groupNum);
		if(dto==null)
				return "redirect:/photo/list";
		
		service.deletePhoto(groupNum, dto.getImageFilename(), path);
		
		
		return "redirect:/groupGally/list";
	}
	
	
	//  /photo/update
	@RequestMapping(value="/photo/update", method=RequestMethod.POST)
	public String updateSubmit(GroupGally dto, HttpSession session) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String path=root+File.separator+"uploadf"+File.separator+"photo";
		

		service.updatePhoto(dto, path);
		

		return "redirect:/groupGally/list";
	}
}