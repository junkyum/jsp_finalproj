package com.sp.tfaq;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("faq.faqController")
public class FaqController {
	
	
	@Autowired
	private FaqService service;
	
	@Autowired
	private MyUtil util;
	
	
    @RequestMapping(value="/tfaq/faq")
	public String faq(@RequestParam(value="category",defaultValue="0") int categoryNum,
			          @RequestParam(value="pageNo",defaultValue="1") int current_page,
			          Model model)throws Exception{
		List<Faq> listFaqCategory= service.FaqCategory();
		
		model.addAttribute("category",categoryNum);
		model.addAttribute("pageNo",current_page);
		model.addAttribute("listFaqCategory", listFaqCategory);
		
		return ".tfaq.faq";
	} 
    
    
    @RequestMapping(value="/tfaq/list")
    public String list(@RequestParam(value="category",defaultValue="0") int categoryNum,
    		          @RequestParam(value="pageNo",defaultValue="1")int current_page,
    		          @RequestParam(value="searchValue", defaultValue="") String searchValue,
    		          Model model, HttpServletRequest req
    		)throws Exception {
    	
    	int numPerPage = 5;
    	int total_page=0;
    	int dataCount=0;
    	
    	if(req.getMethod().equalsIgnoreCase("GET")){
    		searchValue=URLDecoder.decode(searchValue,"utf-8");
    	}
    	
    	Map<String, Object> map = new HashMap<String,Object>();
    	map.put("categoryNum", categoryNum);
    	map.put("searchValue", searchValue);
    	
    	
    	dataCount = service.dataCount(map);
    	if(dataCount !=0)
    		total_page= util.pageCount(numPerPage, dataCount);
    	
    	if(total_page < current_page)
    		current_page = total_page;
    	
    	int start = (current_page -1) * numPerPage+1;
    	int end = current_page * numPerPage;
    	map.put("start", start);
    	map.put("end", end);
    	
    	List<Faq> list= service.FaqList(map);
    	Iterator<Faq> it = list.iterator();
    	while(it.hasNext()){
    		Faq dto = it.next();
    		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
    	}
    	
    	
    	model.addAttribute("list",list);
    	model.addAttribute("pageNo",current_page);
    	model.addAttribute("searchValue",searchValue);
    	model.addAttribute("category",categoryNum);
    	model.addAttribute("paging", util.paging(current_page, total_page));
    	
    	    	
    	return ".single.tfaq.list";
    }
    
    @RequestMapping(value="/tfaq/created",method=RequestMethod.GET)
    public String createdForm(@RequestParam(value="category", defaultValue="0") int categoryNum,
    		 Model model, HttpSession session)throws Exception {
    	
    	SessionInfo info = (SessionInfo)session.getAttribute("member");
    	if(info==null)
    		return "redirect:/";
    	
    	if(! info.getUserId().equals("admin"))
    		return "redirect:/tfaq/faq?category="+categoryNum;
    	
    	List<Faq> listCategory= service.ListCategroy();
    	List<Faq> listFaqCategory =service.FaqCategory();
    	
    	model.addAttribute("category", categoryNum);
    	model.addAttribute("listCategory",listCategory);
    	model.addAttribute("listFaqCategory", listFaqCategory);
    	model.addAttribute("mode", "created");
    	
    	return ".tfaq.created";
    }
    
    
    @RequestMapping(value="/tfaq/created",method=RequestMethod.POST)
    public String createdSubmit(@RequestParam(value="category",defaultValue="0") int categoryNum,
    		 HttpSession session,  Faq dto)throws Exception{
    	
    	SessionInfo info = (SessionInfo)session.getAttribute("member");
    	
    	if(info==null)
    		return "redirect:/";
    	
    	if(! info.getUserId().equals("admin"))
    		return "redirect:/tfaq/faq?category="+categoryNum;
    				
    	dto.setUserId(info.getUserId());
    	service.insertFaq(dto);
    return "redirect:/tfaq/faq?category="+dto.getCategoryNum();
    }
    
    
    @RequestMapping(value="/tfaq/delete")
    public String deleteFaq ( @RequestParam(value="num") int num,
    		                 @RequestParam(value="category", defaultValue="0") int categoryNum,
    		                 @RequestParam(value="pageNo",defaultValue="1")int pageNo,
    		                 HttpSession session)throws Exception{
    	
    	
    	SessionInfo info =(SessionInfo)session.getAttribute("member");
    	
    	if(info==null)
    		return "redirect:/";
    	
    	if(! info.getUserId().equals("admin"))
    		return "redirect:/tfaq/faq?category="+categoryNum;
    	
    	service.deleteFaq(num);
    	
    	return "redirect:/tfaq/faq?category="+categoryNum+"&pageNo"+pageNo;
    }
    
    @RequestMapping(value="/tfaq/update",method=RequestMethod.GET)
    public String updateForm (
    						@RequestParam int num ,
    						@RequestParam String pageNo,
    						@RequestParam(value="category",defaultValue="0") int categoryNum,
    		              HttpSession session,Model model) throws Exception {
    	SessionInfo info =(SessionInfo)session.getAttribute("member");
    	
    	if(info==null)
    		return "redirect:/";
    	if(! info.getUserId().equals("admin"))
    		return "redirect:/tfaq/faq?category="+categoryNum;
    	
    	Faq dto = service.readFaq(num);
    	
    	if(dto==null){
    		return "redirect:/tfaq/faq?category="+categoryNum;
    	}
    	List<Faq> listCategory = service.ListCategroy();
    	List<Faq> listFaqCategory = service.FaqCategory();
    	
    	model.addAttribute("pageNo", pageNo);
    	model.addAttribute("category",categoryNum);
    	model.addAttribute("listCategory", listCategory);
    	model.addAttribute("listFaqCategory", listFaqCategory);
    	model.addAttribute("mode","update");
    	model.addAttribute("dto",dto);
    	return ".tfaq.created";
    }
    
    @RequestMapping(value="/tfaq/update",method=RequestMethod.POST)
    public String updateSubmit(Faq dto, 
    		@RequestParam String pageNo,	
    		@RequestParam(value="category",defaultValue="0")int categoryNum,
    		     HttpSession session)throws Exception{
    	
    	SessionInfo info =(SessionInfo)session.getAttribute("member");
    	if(info==null)
    		return "redirect:/";
    	
    	if(! info.getUserId().equals("admin"))
    		return "redirect:/tfaq/faq?category="+categoryNum;
    				
    	
    	service.updateFaq(dto);
    	
    	return "redirect:/tfaq/faq?category="+categoryNum+"&pageNo"+pageNo;
    }
    ////////////////////
    
    @RequestMapping(value="/tfaq/categoryCreated",method=RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> categoryCreated(@RequestParam(value="classify") String classify,
    		                                   HttpServletRequest req)throws Exception {
    	
    	int categoryNum = 0, dataCount=0;
    	
    	String state ="false";
    	
    	dataCount=service.dataCountCategroy();
    	if(dataCount<10){
    	 Faq faq = new Faq();
    	 faq.setCategoryNum(categoryNum);
    	 faq.setClassify(classify);
    	 
    	 int result= service.insertCategroy(faq);
    	 if(result ==1)
    		 state="true";
    	}
    	req.setAttribute("state", state);
    	return categoryList(req);
  
    }
    
    @RequestMapping(value="/tfaq/categoryList")
    @ResponseBody
    public Map<String,Object> categoryList(HttpServletRequest req)throws Exception{
    	List<Faq> list = service.ListCategroy();
    	
    	String state=(String) req.getAttribute("state");
    	
    	Map<String, Object> model = new HashMap<>();
    	model.put("state", state);
    	model.put("list", list);
    	return model;
    }
    
    @RequestMapping(value="/tfaq/deleteCategory")
    @ResponseBody
    public Map<String, Object> deleteCategory(@RequestParam(value="categoryNum") int categoryNum, HttpServletRequest req)throws Exception{
    	
    	String state ="true";
    	int result = service.deleteCategroy(categoryNum);
    	if(result ==0)
    		state="false";
    	req.setAttribute("state", state);
    	return categoryList(req);
    }

}
