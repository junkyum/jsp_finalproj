package com.sp.member;

import java.io.File;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sp.common.FileManager;
import com.sp.common.MyUtil;

@Controller("mail.mailSenderController")
public class MailSenderController {
	@Autowired
	private MailSender mailSender;
	
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private MemberService service;

	@Autowired
	private FileManager fileManager;
	
	
	
	
	
	@RequestMapping(value="/mail/mail")
	public ModelAndView mailSubmit(HttpSession session,
			@RequestParam String email,String mode) throws Exception {
		System.out.println(mode);
			Mail dto = new Mail();
	 String userId = service.findId(email); 
			
			
			
		if(mode!=null && mode.equals("id")){
			dto.setSubject(" ========= 메일 확인 해라 ======= : ㅎㅎ!");
			dto.setContent("회원님의 id는  "+userId+" 입니다.");
			dto.setSenderEmail("dhtpdud0052@naver.com");
			dto.setSenderName("관리자");
			dto.setReceiverEmail(email);
		}
			
		// 첨부파일이 존재하는 경우
		String root = session.getServletContext().getRealPath("/");
		String path = root + File.separator + "uploads" + File.separator + "mail";		
		String newFileName;
		String pathname;
		if(dto.getUpload()!=null &&!dto.getUpload().isEmpty()) {
			newFileName = fileManager.doFileUpload(dto.getUpload(), path);
			
			dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			pathname=path+File.separator+newFileName;
			dto.setPathname(pathname);
		}
		
		// dto.setSubject(myUtil.escape(dto.getSubject()));
		// dto.setContent(myUtil.escape(dto.getContent()));
		
		boolean b=mailSender.mailSend(dto);
		
		String msg="<span style='color:blue;'>"+dto.getReceiverEmail()+"</span> 님에게<br>";
		if(b) {
			msg+="메일을 성공적으로 전송 했습니다.";
		} else {
			msg+="메일을 전송하는데 실패했습니다.";
		}

		ModelAndView mav=new ModelAndView("redirect:/");
		mav.addObject("message", msg);
		return mav;
	}


	@RequestMapping(value="/mail/mail2")
	public ModelAndView mailSubmit2(HttpSession session,
			@RequestParam String email,String mode, Member mb) throws Exception {
	  		Mail dto = new Mail();
	  		
	  		
	        if(mode!=null && mode.equals("pw")){
	        	
	        	
	        	 ShaPasswordEncoder passwordEncoder=new ShaPasswordEncoder(256);
	        	 int ran = new Random().nextInt(100000) + 10000; 
		   	      String hashed = String.valueOf(ran);
		   	      String hashed2=passwordEncoder.encodePassword(hashed, null);
		   	      mb.setUserPW(hashed2);
		   	      mb.setEmail(email);

		
			      service.updatePW(mb);
			dto.setSubject(" ========= 메일 확인 해라 ======= : ㅎㅎ!");
			dto.setContent("회원님의 임시 패스워드는   "+hashed+" 입니다.");
			dto.setSenderEmail("dhtpdud0052@naver.com");
			dto.setSenderName("관리자");
			dto.setReceiverEmail(email);
		}
			
		String root = session.getServletContext().getRealPath("/");
		String path = root + File.separator + "uploads" + File.separator + "mail";		
		String newFileName;
		String pathname;
		if(dto.getUpload()!=null &&!dto.getUpload().isEmpty()) {
			newFileName = fileManager.doFileUpload(dto.getUpload(), path);
			
			dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			pathname=path+File.separator+newFileName;
			dto.setPathname(pathname);
		}
		
		// dto.setSubject(myUtil.escape(dto.getSubject()));
		// dto.setContent(myUtil.escape(dto.getContent()));
		
		boolean b=mailSender.mailSend(dto);
		
		String msg="<span style='color:blue;'>"+dto.getReceiverEmail()+"</span> 님에게<br>";
		if(b) {
			msg+="메일을 성공적으로 전송 했습니다.";
		} else {
			msg+="메일을 전송하는데 실패했습니다.";
		}

		ModelAndView mav=new ModelAndView("redirect:/");
		mav.addObject("message", msg);
		return mav;
	}

}
