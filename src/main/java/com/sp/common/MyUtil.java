package com.sp.common;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;

@Service("myUtil")
public class MyUtil {
    //********************************************
	// 총페이지 수 구하기
	public int pageCount(int numPerPage, int dataCount) {
		int pageCount=0;
		
		if(dataCount > 0) {
			if(dataCount % numPerPage == 0)
				pageCount=dataCount/numPerPage;
			else
				pageCount=dataCount/numPerPage+1;
		}
		
		return pageCount;
	}
	
    //********************************************
	// 페이징(paging) 처리(GET 방식) : 부트스트랩
	public String paging(int current_page, int total_page, String list_url) {
		StringBuffer sb=new StringBuffer();
		
		int numPerBlock=10;
		int currentPageSetup;
		int n, page;
		
		if(current_page<1 || total_page < 1)
			return "";
		
		if(list_url.indexOf("?")!=-1)
			list_url+="&";
		else
			list_url+="?";
		
		// currentPageSetup : 표시할첫페이지-1
		currentPageSetup=(current_page/numPerBlock)*numPerBlock;
		if(current_page%numPerBlock==0)
			currentPageSetup=currentPageSetup-numPerBlock;

		sb.append("<ul class='pagination pagination-sm'>");
		// 처음페이지
		if(current_page > 1) {
			sb.append("<li><a href='"+list_url+"page=1' aria-label='First'><span aria-hidden='true' class='glyphicon glyphicon-step-backward'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='First'><span aria-hidden='true' class='glyphicon glyphicon-step-backward'></span></a></li>");
		}
		// 이전(10페이지 전)
		n=current_page-numPerBlock;
		if(total_page > numPerBlock && currentPageSetup > 0) {
			sb.append("<li><a href='"+list_url+"page="+n+"' aria-label='Previous'><span aria-hidden='true' class='glyphicon glyphicon-triangle-left'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Previous'><span aria-hidden='true' class='glyphicon glyphicon-triangle-left'></span></a></li>");
		}
		
		// 바로가기
		page=currentPageSetup+1;
		while(page<=total_page && page <=(currentPageSetup+numPerBlock)) {
			if(page==current_page) {
				sb.append("<li class='active'><a href='#'>"+page+" <span class='sr-only'>(current)</span></a></li>");
			} else {
				sb.append("<li><a href='"+list_url+"page="+page+"'>"+page+"</a></li>");
			}
			page++;
		}
		
		// 다음(10페이지 후)
		n=current_page+numPerBlock;
		if(n>total_page) n=total_page;
		if(total_page-currentPageSetup>numPerBlock) {
			sb.append("<li><a href='"+list_url+"page="+n+"' aria-label='Next'><span aria-hidden='true' class='glyphicon glyphicon-triangle-right'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Next'><span aria-hidden='true' class='glyphicon glyphicon-triangle-right'></span></a></li>");
		}
		// 마지막페이지
		if(current_page<total_page) {
			sb.append("<li><a href='"+list_url+"page="+total_page+"' aria-label='Last'><span aria-hidden='true' class='glyphicon glyphicon-step-forward'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Last'><span aria-hidden='true' class='glyphicon glyphicon-step-forward'></span></a></li>");
		}
		
		sb.append("</ul>");
	
		return sb.toString();
	}

    //********************************************
	// javascript 페이지 처리(javascript listPage() 함수 호출) : 부트스트랩
    public String paging(int current_page, int total_page) {
		if(current_page < 1 || total_page < 1)
			return "";

        int numPerBlock = 10;   // 리스트에 나타낼 페이지 수
        int currentPageSetup;
        int n;
        int page;
        StringBuffer sb=new StringBuffer();
        
        // 표시할 첫 페이지
        currentPageSetup = (current_page / numPerBlock) * numPerBlock;
        if (current_page % numPerBlock == 0)
        	currentPageSetup = currentPageSetup - numPerBlock;

		sb.append("<ul class='pagination pagination-sm'>");
        
        // 처음페이지
		if(current_page > 1) {
			sb.append("<li><a onclick='listPage(1);' aria-label='First'><span aria-hidden='true' class='glyphicon glyphicon-step-backward'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='First'><span aria-hidden='true' class='glyphicon glyphicon-step-backward'></span></a></li>");
		}
        // 이전(10페이지 전)
        n = current_page - numPerBlock;
		if(total_page > numPerBlock && currentPageSetup > 0) {
			sb.append("<li><a onclick='listPage("+n+");' aria-label='Previous'><span aria-hidden='true' class='glyphicon glyphicon-triangle-left'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Previous'><span aria-hidden='true' class='glyphicon glyphicon-triangle-left'></span></a></li>");
		}

        // 바로가기 페이지 구현
		page=currentPageSetup+1;
		while(page<=total_page && page <=(currentPageSetup+numPerBlock)) {
			if(page==current_page) {
				sb.append("<li class='active'><a href='#'>"+page+" <span class='sr-only'>(current)</span></a></li>");
			} else {
				sb.append("<li><a onclick='listPage("+page+");'>"+page+"</a></li>");
			}
			page++;
		}
        
        // 다음(10페이지 후)
        n = current_page + numPerBlock;
		if(n>total_page) n=total_page;
		if(total_page-currentPageSetup>numPerBlock) {
			sb.append("<li><a onclick='listPage("+n+"); aria-label='Next'><span aria-hidden='true' class='glyphicon glyphicon-triangle-right'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Next'><span aria-hidden='true' class='glyphicon glyphicon-triangle-right'></span></a></li>");
		}
        // 마지막 페이지
		if(current_page<total_page) {
			sb.append("<li><a onclick='listPage("+total_page+");' aria-label='Last'><span aria-hidden='true' class='glyphicon glyphicon-step-forward'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Last'><span aria-hidden='true' class='glyphicon glyphicon-step-forward'></span></a></li>");
		}
        
        sb.append("</ul>");

        return sb.toString();
    }

    //********************************************
	// javascript 페이지 처리(javascript 지정 함수 호출, methodName:호출할 스크립트 함수명) : 부트스트랩
    public String pagingMethod(int current_page, int total_page, String methodName) {
		if(current_page < 1 || total_page < 1)
			return "";

        int numPerBlock = 10;   // 리스트에 나타낼 페이지 수
        int currentPageSetup;
        int n;
        int page;
        StringBuffer sb=new StringBuffer();
        
        // 표시할 첫 페이지
        currentPageSetup = (current_page / numPerBlock) * numPerBlock;
        if (current_page % numPerBlock == 0)
        	currentPageSetup = currentPageSetup - numPerBlock;

		sb.append("<ul class='pagination pagination-sm'>");
        
        // 처음페이지
		if(current_page > 1) {
			sb.append("<li><a onclick='"+methodName+"(1);' aria-label='First'><span aria-hidden='true' class='glyphicon glyphicon-step-backward'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='First'><span aria-hidden='true' class='glyphicon glyphicon-step-backward'></span></a></li>");
		}
        // 이전(10페이지 전)
        n = current_page - numPerBlock;
		if(total_page > numPerBlock && currentPageSetup > 0) {
			sb.append("<li><a onclick='"+methodName+"("+n+");' aria-label='Previous'><span aria-hidden='true' class='glyphicon glyphicon-triangle-left'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Previous'><span aria-hidden='true' class='glyphicon glyphicon-triangle-left'></span></a></li>");
		}

        // 바로가기 페이지 구현
		page=currentPageSetup+1;
		while(page<=total_page && page <=(currentPageSetup+numPerBlock)) {
			if(page==current_page) {
				sb.append("<li class='active'><a href='#'>"+page+" <span class='sr-only'>(current)</span></a></li>");
			} else {
				sb.append("<li><a onclick='"+methodName+"("+page+");'>"+page+"</a></li>");
			}
			page++;
		}
        
        // 다음(10페이지 후)
        n = current_page + numPerBlock;
		if(n>total_page) n=total_page;
		if(total_page-currentPageSetup>numPerBlock) {
			sb.append("<li><a onclick='"+methodName+"("+n+"); aria-label='Next'><span aria-hidden='true' class='glyphicon glyphicon-triangle-right'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Next'><span aria-hidden='true' class='glyphicon glyphicon-triangle-right'></span></a></li>");
		}
        // 마지막 페이지
		if(current_page<total_page) {
			sb.append("<li><a onclick='"+methodName+"("+total_page+");' aria-label='Last'><span aria-hidden='true' class='glyphicon glyphicon-step-forward'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Last'><span aria-hidden='true' class='glyphicon glyphicon-step-forward'></span></a></li>");
		}
        
        sb.append("</ul>");

        return sb.toString();
    }
    
    //********************************************
    // HTML 태그 제거
    public String removeHtmlTag(String str) {
		if(str==null||str.length()==0)
			return "";

		String regex="<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>";
		String result=str.replaceAll(regex, "");
		return result;
    }

    //********************************************
    // HTML 문서의 img 태그 src 속성값 추출 
    public List<String> getImgSrc(String html) {
		List<String> result = new ArrayList<String>();
		
		if(html==null||html.length()==0)
			return result;

		String regex="<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>";
		Pattern nonValidPattern = Pattern.compile(regex);

		Matcher matcher = nonValidPattern.matcher(html);
		while (matcher.find()) {
			result.add(matcher.group(1));
		}
		return result;
    }
    
    //********************************************
    // 특수문자를 HTML 문자로 변경
	public String escape(String str) {
		if(str==null||str.length()==0)
			return "";
		
		StringBuilder builder = new StringBuilder((int)(str.length() * 1.2f));

		for (int i = 0; i < str.length(); i++) {
			char c = str.charAt(i);
			switch (c) {
			case '<':
				builder.append("&lt;");
				break;
			case '>':
				builder.append("&gt;");
				break;
			case '&':
				builder.append("&amp;");
				break;
			case '\"':
				builder.append("&quot;");
				break;
			default:
				builder.append(c);
			}
		}
		return builder.toString();
	}

    //********************************************
    // 특수문자를 HTML 문자로 변경 및 엔터를 <br>로 변경 
     public String htmlSymbols(String str) {
		if(str==null||str.length()==0)
			return "";

    	 str=str.replaceAll("&", "&amp;");
    	 str=str.replaceAll("\"", "&quot;");
    	 str=str.replaceAll(">", "&gt;");
    	 str=str.replaceAll("<", "&lt;");
    	 
    	 str=str.replaceAll(" ", "&nbsp;");
    	 str=str.replaceAll("\n", "<br>");
    	 
    	 return str;
     }

    //********************************************
 	// 문자열의 내용중 원하는 문자열을 다른 문자열로 변환
 	// String str = replaceAll(str, "\n", "<br>"); // 엔터를 <br>로 변환
 	public String replaceAll(String str, String oldStr, String newStr) throws Exception {
 		if(str == null)
 			return "";

         Pattern p = Pattern.compile(oldStr);
         
         // 입력 문자열과 함께 매쳐 클래스 생성
         Matcher m = p.matcher(str);

         StringBuffer sb = new StringBuffer();
         // 패턴과 일치하는 문자열을 newStr 로 교체해가며 새로운 문자열을 만든다.
         while(m.find()) {
             m.appendReplacement(sb, newStr);
         }

         // 나머지 부분을 새로운 문자열 끝에 덫 붙인다.
         m.appendTail(sb);

 		return sb.toString();
 	}

    //********************************************
 	// E-Mail 검사
     public boolean isValidEmail(String email) {
         if (email==null) return false;
         boolean b = Pattern.matches(
        	 "[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+", 
             email.trim());
         return b;
     }

    //********************************************
 	// NULL 인 경우 ""로 
     public String checkNull(String str) {
         String strTmp;
         if (str == null)
             strTmp = "";
         else
             strTmp = str;
         return strTmp;
     }
}
