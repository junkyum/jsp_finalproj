package com.sp.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("member.memberController")
public class MemberController {
	@Autowired
	private MemberService service;
	// 회원가입 및 회원정보 수정 -----------------------
	@RequestMapping(value="/member/member", method=RequestMethod.GET)
	public String memberForm(Model model) {
		model.addAttribute("mode", "created");
		
		return ".single.member.member";
	}
	
	@RequestMapping(value="/member/member", method=RequestMethod.POST)
	public String memberSubmit(Member dto , Model model,HttpSession session) {
	   ShaPasswordEncoder passwordEncoder=new ShaPasswordEncoder(256);
	      String hashed=passwordEncoder.encodePassword(dto.getUserPW(), null);
	      dto.setUserPW(hashed);
		int result=service.insertMember(dto);
		if(result==1) {
			StringBuffer sb=new StringBuffer();
			sb.append(dto.getUserName()+ "님의 회원 가입이 정상적으로 처리되었습니다.<br>");
			sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");
		model.addAttribute("title", "회원 가입")	;
		model.addAttribute("message", sb.toString());
			return ".member.complete";
		} else {
			
			model.addAttribute("message", "아이디 / 이메일 중복으로 회원가입이 실패했습니다.");
			model.addAttribute("mode", "created");
		

			return ".single.member.member";
		}
	}

	@RequestMapping(value="/member/info")
	public String info(
			HttpSession session,
			Model model
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		
		Member dto=service.readMember(info.getUserId());
			
		System.out.println(info.getUserId()+"a------");
		model.addAttribute("dto", dto);
		return ".member.info";
	}
	
	
	
	@RequestMapping(value="/member/pwd", method=RequestMethod.GET)
	public String pwdForm(
			HttpServletRequest req,
			HttpSession session,
			Model model) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		if(info==null) {
			return"redirect:/member/login";
		}
		
		String dropout=req.getParameter("dropout");
		
		if(dropout==null) {
			model.addAttribute("mode", "update");
		
		} else {
			model.addAttribute("mode", "dropout");
		}
		return ".member.pwd";
	}
	
	@RequestMapping(value="/member/pwd", method=RequestMethod.POST)
	public String pwdSubmit(HttpSession session,
			@RequestParam(value="userPW") String userPW
			,@RequestParam(value="mode") String mode
			,Model model
	     ) {
		      
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}
		Member dto=service.readMember(info.getUserId());
		
		
		
		if(dto==null) {
			session.invalidate();
			return "redirect:/";
		}
		
		  ShaPasswordEncoder passwordEncoder=new ShaPasswordEncoder(256);
		  userPW=passwordEncoder.encodePassword(userPW, null);
	   
	      
	      
		if(! dto.getUserPW().equals(userPW)) {
			if(mode.equals("update")) {
				model.addAttribute("mode", "update");
			
			} else {
				model.addAttribute("mode", "dropout");
			}
			
			
			model.addAttribute("message", "패스워드가 일치하지 않습니다.");
			return ".member.pwd";
		}
		
		if(mode.equals("dropout")){
			// 회원탈퇴 
			
			
			session.removeAttribute("member");
			
			session.invalidate();
			
			service.deleteMember(dto);

		
			StringBuffer sb=new StringBuffer();
			sb.append(dto.getUserName()+ "님의 회원 탈퇴 처리가 정상적으로 처리되었습니다.<br>");
			sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
			
			model.addAttribute("title", "회원 탈퇴");
			model.addAttribute("message", sb.toString());
			
			return ".member.complete";
		}

		// 회원정보수정폼
		//ModelAndView mav=new ModelAndView(".member.member");
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		return ".member.member";
	}

	@RequestMapping(value="/member/update",	method=RequestMethod.POST)
	public String updateSubmit(
			HttpSession session,
			Member dto,
			Model model) {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}

		System.out.println(dto.getUserId()+"아이디"+"비밀번호!.."+dto.getUserPW());
		service.updateMember(dto);
		
	
		StringBuffer sb=new StringBuffer();
		sb.append(dto.getUserName()+ "님의 회원정보가 정상적으로 변경되었습니다.<br>");
		sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
		
		model.addAttribute("title", "회원 정보 수정");
		model.addAttribute("message", sb.toString());
		return ".member.complete";
	}
	
	@RequestMapping(value="/member/userIdCheck")
	@ResponseBody
	public Map<String, Object> userIdCheck(@RequestParam String userId) throws Exception {
		String passed="false";
		Member dto=service.readMember(userId);
		if(dto==null)
			passed="true";
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("passed", passed);
		return model;
	}
	
	@RequestMapping(value="/member/emailCheck")
	@ResponseBody
	public Map<String, Object> emailCheck(@RequestParam String email) throws Exception{
		
		String passed="false";
		Member dto = service.readEmail(email);
		
		if(dto==null)
			passed="true";
		Map<String, Object>	model = new HashMap<>();
		model.put("passed", passed);
		return model;
	}
	
}
