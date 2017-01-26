package com.sp.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MemberController {
	@Autowired
	private MemberService service;
	
	// 로그인 및 로그아웃 -----------------------
	@RequestMapping(value="/member/login", method=RequestMethod.GET)
	public ModelAndView loginForm() throws Exception {
		return new ModelAndView(".member.login");
	}
	
	@RequestMapping(value="/member/login", method=RequestMethod.POST)
	public ModelAndView loginSubmit(
			HttpSession session,
			@RequestParam("userId") String userId,
			@RequestParam("userPW") String userPW
			) throws Exception {
		
		Member dto = service.readMember(userId);
		
	

		if(dto==null || (!dto.getUserPW().equals(userPW))) {
			ModelAndView mav=new ModelAndView(".member.login");
			mav.addObject("message", "아이디 또는 패스워드가 일치하지 않습니다.");
			return mav;
		}
		
		// 로그인 날짜 변경
		service.updateLastLogin(dto.getUserId());

		// 로그인 정보를 세션에 저장
		SessionInfo info = new SessionInfo();
		//info.setMemberIdx(dto.getMemberIdx());
		info.setUserId(dto.getUserId());
		info.setUserName(dto.getUserName());
		session.setAttribute("member", info);
		
		return new ModelAndView("redirect:/");
	}	

	@RequestMapping(value="/member/logout")
	public String logout(HttpSession session) throws Exception {
		// 로그인 정보를 세션에서 삭제 한다.
		session.removeAttribute("member");
		session.invalidate();
		
		return "redirect:/";
	}
	
	// 회원가입 및 회원정보 수정 -----------------------
	@RequestMapping(value="/member/member", method=RequestMethod.GET)
	public ModelAndView memberForm() {
		ModelAndView mav=new ModelAndView(".member.member");
		mav.addObject("mode", "created");
		return mav;
	}
	
	@RequestMapping(value="/member/member", method=RequestMethod.POST)
	public ModelAndView memberSubmit(Member dto) {
		
		int result=service.insertMember(dto);
		
		ModelAndView mav=new ModelAndView();
		
		if(result==1) {
			StringBuffer sb=new StringBuffer();
			sb.append(dto.getUserName()+ "님의 회원 가입이 정상적으로 처리되었습니다.<br>");
			sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");
			
			mav.setViewName(".member.complete");
			mav.addObject("message", sb.toString());
			mav.addObject("title", "회원 가입");
		} else {
			mav.setViewName(".member.member");
			mav.addObject("mode", "created");
			mav.addObject("message", "아이디 중복으로 회원가입이 실패했습니다.");
		}
		return mav;
	}
	
	@RequestMapping(value="/member/pwd", method=RequestMethod.GET)
	public ModelAndView pwdForm(
			HttpServletRequest req,
			HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return new ModelAndView("redirect:/member/login");
		}
		
		String dropout=req.getParameter("dropout");
		
		ModelAndView mav=new ModelAndView(".member.pwd");
		if(dropout==null) {
			mav.addObject("mode", "update");
		} else {
			mav.addObject("mode", "dropout");
		}
		return mav;
	}
	
	@RequestMapping(value="/member/pwd", method=RequestMethod.POST)
	public ModelAndView pwdSubmit(HttpSession session,
			@RequestParam(value="userPW") String userPW
			,@RequestParam(value="mode") String mode
	     ) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return new ModelAndView("redirect:/member/login");
		}
		
		Member dto=service.readMember(info.getUserId());
		if(dto==null) {
			session.invalidate();
			return new ModelAndView("redirect:/");
		}
		
		if(! dto.getUserPW().equals(userPW)) {
			ModelAndView mav=new ModelAndView(".member.pwd");
			if(mode.equals("update")) {
				mav.addObject("mode", "update");
			} else {
				mav.addObject("mode", "dropout");
			}
			mav.addObject("message", "패스워드가 일치하지 않습니다.");
			return mav;
		}
		
		if(mode.equals("dropout")){
			// 회원탈퇴 처리
			
			
			session.removeAttribute("member");
			session.invalidate();

			ModelAndView mav=new ModelAndView(".member.complete");
			
			StringBuffer sb=new StringBuffer();
			sb.append(dto.getUserName()+ "님의 회원 탈퇴 처리가 정상적으로 처리되었습니다.<br>");
			sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
			
			mav.addObject("title", "회원 탈퇴");
			mav.addObject("message", sb.toString());
			
			return mav;
		}

		// 회원정보수정폼
		ModelAndView mav=new ModelAndView(".member.member");
		mav.addObject("dto", dto);
		mav.addObject("mode", "update");
		return mav;
	}

	@RequestMapping(value="/member/update",
			method=RequestMethod.POST)
	public ModelAndView updateSubmit(
			HttpSession session,
			Member dto) {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return new ModelAndView("redirect:/member/login");
		}

		service.updateMember(dto);
		
		ModelAndView mav=new ModelAndView(".member.complete");
		
		StringBuffer sb=new StringBuffer();
		sb.append(dto.getUserName()+ "님의 회원정보가 정상적으로 변경되었습니다.<br>");
		sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
		
		mav.addObject("title", "회원 정보 수정");
		mav.addObject("message", sb.toString());
		return mav;
	}
	
	@RequestMapping(value="/member/userIdCheck")
	@ResponseBody
	public Map<String, Object> userIdCheck(
			@RequestParam String userId
			) throws Exception {
		String passed="false";
		Member dto=service.readMember(userId);
		if(dto==null)
			passed="true";
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("passed", passed);
		return model;
	}
}
