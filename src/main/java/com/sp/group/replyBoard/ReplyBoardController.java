package com.sp.group.replyBoard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;


import com.sp.common.MyUtil;

@Controller("group.replyBoardController")
public class ReplyBoardController {
	
	@Autowired
	private ReplyBoardService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/group/board")
	public String gally()throws Exception{
		
		return "group/replyBoard";
	}

}
