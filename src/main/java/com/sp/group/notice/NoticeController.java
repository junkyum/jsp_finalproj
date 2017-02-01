package com.sp.group.notice;

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

import com.sp.common.FileManager;
import com.sp.common.MyUtil;

import net.sf.json.JSONObject;

@Controller("group.noticeController")
public class NoticeController {
	@Autowired private NoticeService service;
	@Autowired private MyUtil myUtil;
	@Autowired private FileManager fileManager;

	@RequestMapping(value = "/group/notice")
	public void noticeList(
			@RequestParam(value="num", defaultValue = "1") int num,
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value = "searchKey", defaultValue = "subject") String searchKey,
			@RequestParam(value = "searchValue", defaultValue = "") String searchValue, Model model,
			HttpServletRequest req) throws Exception {
		String cp = req.getContextPath();

		int numPerPage = 3; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		searchValue = URLDecoder.decode(searchValue, "utf-8");

		GroupNotice dto = service.readNotice(num);
		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
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
		Iterator<GroupNotice> it = noticeList.iterator();
		while (it.hasNext()) {
			GroupNotice data = (GroupNotice) it.next();
			listNum = dataCount - (start + n - 1);
			data.setListNum(listNum);

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date beginDate = formatter.parse(data.getCreated());
			/*
			 * // 날짜차이(일) gap=(endDate.getTime() - beginDate.getTime()) / (24 *
			 * 60 * 60* 1000); data.setGap(gap);
			 */
			// 날짜차이(시간)
			gap = (endDate.getTime() - beginDate.getTime()) / (60 * 60 * 1000);
			data.setGap(gap);

			data.setCreated(data.getCreated().substring(0, 10));

			n++;
		}
		
		String params = "";
        String urlList = cp+"/group/notice";
        if(searchValue.length()!=0) {
        	params = "searchKey=" +searchKey + 
        	             "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");	
        }
        
        if(params.length()!=0) {
            urlList = cp+"/group/notice?" + params;
        }
        
        String paging = myUtil.paging(current_page, total_page, urlList);
		
        model.addAttribute("dto", dto);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		
	}
	@RequestMapping(value="/group/notice/created",method=RequestMethod.POST)
	public void createdSubmit(
			GroupNotice dto, HttpSession session, Model model, HttpServletResponse resp) throws Exception {

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "notice";
		//dto.setUserId(info.getUserId());
		int res = service.insertNotice(dto, pathname);
		String result="fail";
		if(res>0)
			result="ok";
		JSONObject job = new JSONObject();
		job.put("res", result);
		PrintWriter out = resp.getWriter();
		out.println(job.toString());
		
	}

	
	@RequestMapping(value="/group/notice/update", method=RequestMethod.POST)
	public String updateSubmit(
			@RequestParam int num, HttpServletResponse resp,
			@RequestParam String page,
			HttpSession session ) throws Exception {
		
		/*SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}
		
		if(! info.getUserId().equals("admin"))
			return "redirect:/notice/list?page="+page;*/
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "notice";		
		GroupNotice dto = service.readNotice(num);
		JSONObject job = new JSONObject();		
		job.put("subject", dto.getSubject());
		job.put("content", dto.getContent());
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.print(job.toString());
		
		//dto.setUserId(info.getUserId());
		service.updateNotice(dto, pathname);
		
		return "group/notice";
	}
	@RequestMapping(value="/group/notice/delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "notice";		
		
		/*SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}
		
		if(! info.getUserId().equals("admin"))
			return "redirect:/notice/list?page="+page;*/
		
		// 내용 지우기
		service.deleteNotice(num, pathname);
		
		return "group/notice";
	}

}
