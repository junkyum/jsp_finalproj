//*************************************
// 유틸리티
// 내용의 값의 빈공백을 trim(앞/뒤)
String.prototype.trim = function(){
		var TRIM_PATTERN = /(^\s*)|(\s*$)/g;
		return this.replace(TRIM_PATTERN, "");
};

// 이메일 형식 검사
function isValidEmail(data){
	var format = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	
	if(! format.test(data))
        return false; 
    
    return true;//올바른 포맷 형식
}

// 한글 필터링
function isValidKorean(data){
     // UTF-8 코드 중 AC00부터 D7A3 값이지 검사
	var format = /^[\uac00-\ud7a3]*$/g;

    if(! format.test(data))
        return false; 
    
    return true; //올바른 포맷 형식
}


// 이미지 파일인지 검사
function isImageFile(filename){
	var format = /(\.gif|\.jpg|\.jpeg|\.png)$/i;

	if(! format.test(filename)) {
        return false;
     }
	
	  return true;
}

// 숫자인지 검사
function isValidNumber(data){
	// var format=/^[0-9]*$/g;
	var format=/^(\d+)$/;
	
    if(! format.test(data))
	        return false; 
    
	return true;
}

//*************************************
// 날짜 관련 함수
// 날짜 형식 검사 정규표현식
function isValidDateFormat(data){
	var regexp=/(\.)|(\-)|(\/)/g;
	data=data.replace(regexp, "");
	
	if(data.length!=8)
		return false;

	var format = /[12][0-9]{3}[0-9]{2}[0-9]{2}/;
	if(! format.test(data))
		return false;
		
	var year = data.substr(0,4);
	var month= data.substr(4,2);
	var day = data.substr(6,2);
	
	return isValidDate(year, month, day);		
}

// 날짜가 정확한지 검사(문자)
function isValidDate(y, m, d){
	var year, month, day;
	var days = new Array (31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

	y = y.trim();
	m = m.trim();
	d = d.trim();
    if(y.length != 4 || m.length!=2 || d.length!=2)
		return false;

    year = parseInt(y);

    if(m.charAt(0) == '0')
        m = m.charAt(1);
    month = parseInt(m);

    if(d.charAt(0) == '0')
        d = d.charAt(1);
    day = parseInt(d);

    // 날짜 검사
	if(year%4==0 && year%100 !=0 || year%400==0)
		days[1]=29;
	else
		days[1]=28;

	if(month < 1 || month > 12)
		return false;

	if(day < 1 || day > days[month-1])
		return false;

	return true;
}

// 기준일부터 몇일후(기준일 포함)
function getDaysLater(sDate, days) {
	var y, m, d, s;
	
	var date=new Date();
	
	var regexp=/(\.)|(\-)|(\/)/g;
	sDate=sDate.replace(regexp, "");
	if(sDate.length!=8)
		return "";
	
	y = parseInt(sDate.substr(0, 4));
	m = parseInt(sDate.substr(4, 2));
	// d = parseInt(sDate.substr(6, 2))+parseInt(days);
	d = parseInt(sDate.substr(6, 2))+parseInt(days)-1;

	date.setFullYear(y, m-1, d);

	y=date.getFullYear();
	m=date.getMonth()+1;
	if(m<10) m="0"+m;
	d=date.getDate();
	if(d<10) d='0'+d;
	
	s=y+"-"+m+"-"+d;

	return s;
}

// 두 날짜간의 간격 계산
function getDiffDays(sDate, eDate) {
	var regexp=/(\.)|(\-)|(\/)/g;
	sDate=sDate.replace(regexp, "");
	eDate=eDate.replace(regexp, "");
	
	if(sDate.length!=8)
		return "";
	if(eDate.length!=8)
		return "";
	
	var sy = parseInt(sDate.substr(0, 4));
	var sm = parseInt(sDate.substr(4, 2));
	var sd = parseInt(sDate.substr(6, 2));
	
	var ey = parseInt(eDate.substr(0, 4));
	var em = parseInt(eDate.substr(4, 2));
	var ed = parseInt(eDate.substr(6, 2));

	var date1=new Date(sy, sm-1, sd);
	var date2=new Date(ey, em-1, ed);
	
	var sn=date1.getTime();
	var en=date2.getTime();
	var count=en-sn;
	var day=Math.floor(count/(24*3600*1000));
	
	// return day;
	return day+1;
}

// 나이 계산
function getAge(data) {
	var regexp=/(\.)|(\-)|(\/)/g;
	data=data.replace(regexp, "");
	
	if(data.length!=8)
		return "";
	
	var by = parseInt(data.substr(0, 4));
	var bm = parseInt(data.substr(4, 2));
	var bd = parseInt(data.substr(6, 2));
	var bdate=new Date(by, bm-1, bd);
	var now = new Date();
	
	var age=now.getFullYear() - bdate.getFullYear();
	if((bdate.getMonth() > now.getMonth()) ||
			((bdate.getMonth() == now.getMonth()) && 
					bdate.getDate() > now.getDate())) {
		age--;
	}
	
	return age;
}

//*************************************
// 쿠키 설정
// expiredays : 쿠키유지시간(일단위, 설정하지 않으면 브라우저가 종료되기 전까지)
function setCookie(name, value, expiredays){
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate() + expiredays);

     var s="; path=/"+((expiredays==null) ? "" : "; expires=" + todayDate.toUTCString());

	// document.cookie = name + "=" + encodeURIComponent(value) + "; path=/; expires=" + todayDate.toGMTString + ";";
	document.cookie = name + "=" + encodeURIComponent(value) + s;
}

// 쿠키값 반환
function getCookie(name) {
	var found = false;
	var start, end=0;
	var i=0;

	// 쿠키 문자열 전체를 검색
	while(i <= document.cookie.length) {
		start = i;
		end = start + name.length;

		// name과 동일한 문자가 있다면
		if(document.cookie.substring(start, end) == name) {
			found = true;
			break;
		}
		i++;
	}

	// name 문자열을 cookie에서 찾은 경우
	if(found == true) {
		start = end + 1;
		end = document.cookie.indexOf(";", start);

		// 마지막 부분이라는 것을 의미(마지막에는 ';'가 없다)
		if(end < start)
			end = document.cookie.length;

		return decodeURIComponent(document.cookie.substring(start, end));
	}

	return "";
}

//*************************************
// 주민등록 번호 검사
function isValidResidentNO(ssn1, ssn2) {
		var days = new Array (31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

		var check = new Array (2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5);
		var ssn = new Array(13);
		var temp, year, month, day, tot, chkNum, i;

		if((ssn1.length != 6) || (ssn2.length != 7))
			return false;

		for(i = 0; i< 13; i++) {
			if(i < 6)
				ssn[i] = parseInt(ssn1.charAt(i));
			else
				ssn[i] = parseInt(ssn2.charAt(i-6));
		}

		temp = ssn1.substr(0, 2);
		if(temp.charAt(0) == '0')
			temp = temp.charAt(1);
		year = parseInt(temp);

		if(ssn[6] == 1 || ssn[6] == 2)
			year = year + 1900;
		else
			year = year + 2000;

		temp = ssn1.substr(2, 2);
		if(temp.charAt(0) == '0')
			temp = temp.charAt(1);
		month = parseInt(temp);

		if(ssn[6] < 1 || ssn[6] > 4)
			return false;
   
		temp = ssn1.substr(4, 2);
		if(temp.charAt(0) == '0')
			temp = temp.charAt(1);
		day = parseInt(temp);

		if(year%4==0 && year%100!=0 || year%400==0)
			days[1]=29;
		else
			days[1]=28;

		if(month < 1 || month > 12)
			return false;

		if(day > days[month-1] || day < 1)
			return false;

		tot=0;
		for(i=0; i<12; i++)
			tot = tot + ssn[i] * check[i];
		chkNum = 11 - tot % 11;
		chkNum = chkNum % 10;
  
		if(chkNum != ssn[12])
			return false;
		return true;
}

//*************************************
// 입력 허용
// 숫자와 영문자만 입력 허용
function onlyAlpNum() {
     if((event.keyCode < 48) || 
         ((event.keyCode > 57) && (event.keyCode < 65)) || 
         ((event.keyCode > 90) && (event.keyCode < 97)) || 
         (event.keyCode > 122)) {
          try {
            event.preventDefault(); //이벤트 취소
          } catch (e) {
            event.returnValue=false; //IE 8 이하
          }
	 }
}

// 숫자만 입력 허용
function onlyNum() {
     if((event.keyCode < 48) || (event.keyCode > 57)) {
            try {
                event.preventDefault(); //이벤트 취소
            } catch (e) {
                event.returnValue=false; //IE 8 이하
            }
	 }
}

// 한글만 입력 허용
function onlyHangul() {
		if((event.keyCode < 12592) || (event.keyCode > 12687)) {
            try {
                event.preventDefault(); //이벤트 취소
            } catch (e) {
                event.returnValue=false; //IE 8 이하
            }
		}
}

//*************************************
//팝업 윈도우즈
function winOpen(theURL, winName) {
	var flag;
	flag = "left=10, ";
	flag += "top=10, ";
	flag += "width=372, ";
	flag += "height=466, ";
	flag += "toolbar=no, ";
	flag += "menubar=no, ";
	flag += "status=no, ";
	flag += "scrollbars=no, ";
	flag += "resizable=no";
    // features = "scrollbars=no,resizable=no,width=220,height=230";

     window.open(theURL, winName, flag);

     return;
}

//*************************************
// 기타 형식 검사
// 영문, 숫자 인지 확인
 function isValidEngNum(str) {
	for(var i=0;i<str.length;i++) {
		achar = str.charCodeAt(i);                 
		if( achar > 255 )
			return false;
	}
	return true; 
}

// 전화번호 형식(숫자-숫자-숫자)인지 체크
function isValidPhone(data) {
	// var format = /^(\d+)-(\d+)-(\d+)$/;
	var format=/^(01[016789])-[0-9]{3,4}-[0-9]{4}$/g;
    return format.test(data);
}

// 문자열에 특수문자(",  ',  <,  > ) 검사
function isValidSpecialChar(str) {
    if(str.value.search(/[\",\',<,>]/g) >= 0)
		return true; // 존재 하면
	return false;
}
