package com.sp.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller("mypage.myPageController")
public class MyPageController {
	@RequestMapping(value="/mypage/info")
	public ModelAndView info() throws Exception {
		ModelAndView mav=new ModelAndView(".four.menu5.mypage.info");
		mav.addObject("subMenu", "1");
		return mav;
	}
}
