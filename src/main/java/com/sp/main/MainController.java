package com.sp.main;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("mainController")
public class MainController {
	
	
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String main(Model model) throws Exception {
		
		// 사용자 로그인 확인
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String username = null;
		boolean isAnonymous = true;
		if (principal instanceof UserDetails) {
			username = ((UserDetails) principal).getUsername();
			isAnonymous = false;
		} else {
			username = principal.toString(); // anonymousUser
			isAnonymous = true;
		}
		
		model.addAttribute("username", username);
		model.addAttribute("isAnonymous", isAnonymous);
		return ".mainLayout";
		
	}
	
}
