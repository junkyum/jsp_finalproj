package com.sp.group;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("group.groupController")
public class GroupContoller {

	//역할군 - 그룹 생성 및 그룹페이지들간의 연결
	//그룹페이지로 연결
	@RequestMapping(value="/group", method=RequestMethod.GET)
	public String main(HttpSession session) throws Exception {
			return ".group.main";
	}
	//
	
	
	
}
