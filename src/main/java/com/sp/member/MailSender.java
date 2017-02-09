package com.sp.member;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.springframework.stereotype.Service;

@Service("mail.myMailSender")
public class MailSender {
	private String mailType; // 메일 타입
	private String encType;
	
	public MailSender() {
		this.encType = "euc-kr";
		this.mailType = "text/html; charset="+encType;
		// this.mailType = "text/plain; charset="+encType;
	}
	
	private class SMTPAuthenticator extends javax.mail.Authenticator {
			  @Override
		      public PasswordAuthentication getPasswordAuthentication() {  
	           // 지메일은 경고메시지 전송 - 전송받은 메일에서 보안 수준을 낮추는 링크를 클릭하고 수준을 낮추면 메일 전송가능
	           // gmail : 내계정 - 로그인 및 보안 => 아래부분 보안수준이 낮은 앱 사용  허용으로 변경
	           // 네이버 : 메일 아래부분 환경설정 클릭후 POP3등을 허용
		    	  
		          String username =  "dhtpdud0052@naver.com"; // 네이버 사용자;  
		          // String username =  "지메일아이디"; // gmail 사용자;  
		          String password = "godwjd2@/"; // 패스워드;  
		          return new PasswordAuthentication(username, password);  
		       }  
	}
	
	public boolean mailSend(Mail vo) {
		boolean b=false;
		
		Properties p = new Properties();   
  
		// SMTP 서버의 계정 설정   
		// Naver와 연결할 경우 네이버 아이디
		// Gmail과 연결할 경우 Gmail 아이디
		p.put("mail.smtp.user", "dhtpdud0052");   
  
		// SMTP 서버 정보 설정   
		p.put("mail.smtp.host", "smtp.naver.com"); // 네이버   
		// p.put("mail.smtp.host", "smtp.gmail.com"); // gmail
		       
		// 네이버와 지메일 동일   
		p.put("mail.smtp.port", "465");   
		p.put("mail.smtp.starttls.enable", "true");   
		p.put("mail.smtp.auth", "true");   
		p.put("mail.smtp.debug", "true");   
		p.put("mail.smtp.socketFactory.port", "465");   
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");   
		p.put("mail.smtp.socketFactory.fallback", "false");  
		
		try {
			Authenticator auth = new SMTPAuthenticator();  
			Session session = Session.getDefaultInstance(p, auth);
			// 메일 전송시 상세 정보 콘솔에 출력 여부
			session.setDebug(true);
			
			Message msg = new MimeMessage(session);

			// 보내는 사람
			if(vo.getSenderName() == null || vo.getSenderName().equals(""))
				msg.setFrom(new InternetAddress(vo.getSenderEmail()));
			else
				msg.setFrom(new InternetAddress(vo.getSenderEmail(), vo.getSenderName(), encType));
			
			// 받는 사람
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(vo.getReceiverEmail()));
			
			// 제목
			msg.setSubject(vo.getSubject());
			
			// HTML 형식인 경우 \r\n을  <br>로 변환
			if(mailType.indexOf("text/html") != -1) {
				vo.setContent(vo.getContent().replaceAll("\n", "<br>"));
			}
			makeMessage(msg, vo);
			msg.setHeader("X-Mailer", vo.getSenderName());
			
			// 메일 보낸 날짜
			msg.setSentDate(new Date());
			
			// 메일 전송
			Transport.send(msg);

			// 메일 전송후 파일 삭제
			if(vo.getPathname() != null) {
				File file = new File(vo.getPathname());
				if(file.exists())
					file.delete();
			}
			
			b=true;
						
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return b;
	}
	
	// 첨부 파일이 있는 경우 MIME을 MultiMime로 파일을 전송 한다.
	private void makeMessage(Message msg, Mail vo) throws MessagingException {
		if(vo.getPathname() == null || vo.getPathname().length()==0) {
			// 파일을 첨부하지 않은 경우
			msg.setText(vo.getContent());
			msg.setHeader("Content-Type", mailType);
		} else {
			// 파일을 첨부하는 경우
			
			// 메일 내용
			MimeBodyPart mbp1 = new MimeBodyPart();
			mbp1.setText(vo.getContent());
			mbp1.setHeader("Content-Type", mailType);
			
			// 첨부 파일
			MimeBodyPart mbp2 = new MimeBodyPart();
			FileDataSource fds = new FileDataSource(vo.getPathname());
			mbp2.setDataHandler(new DataHandler(fds));
			
			try {
				if(vo.getOriginalFilename() == null || vo.getOriginalFilename().length()==0)
					mbp2.setFileName(MimeUtility.encodeWord(fds.getName()));
				else
					mbp2.setFileName(MimeUtility.encodeWord(vo.getOriginalFilename()));
			} catch(UnsupportedEncodingException e) {
				System.out.println(e.toString());
			}
			
			Multipart mp = new MimeMultipart();
			mp.addBodyPart(mbp1);
			mp.addBodyPart(mbp2);
			
			msg.setContent(mp);
		}
	}
}
