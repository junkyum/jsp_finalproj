package com.sp.main;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.member.SessionInfo;

@Controller("mainController")
public class MainController {
	
	
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String main(HttpSession session) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null){
			return "/member/login";
		}
		else
			return ".mainLayout";
	}

}
