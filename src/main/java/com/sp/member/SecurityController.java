package com.sp.member;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("member.securityController")
public class SecurityController {
	@RequestMapping(value="/member/login")
	public String login(String login_error, Model model, HttpSession session) {
		boolean loginError = login_error != null;
		
		String msg="";
		if(loginError) {
				msg="아이디 또는 패스워드를 잘못 입력 하셨습니다.";
				model.addAttribute("message", msg);
		}
		
		return ".loginLayout";
	}
	
	// 접근 오서라이제이션(Authorization:권한)이 없는 경우
	@RequestMapping(value="/member/noAuthorized")
	public String noAuthorized() {
		
		return ".member.noAuthorized";
	}
}
