package com.sp.member;

import java.util.List;
import java.util.Map;

public interface MemberService {
	public Member readMember(String userId);
	
	public int insertMember(Member dto);
	
	public int updateMember(Member dto);
	public int updateLastLogin(String userId);
	
	public int updatePW(Member mb);
	public String findId(String email); 
	public String findPW(String email);
	public int deleteMember(Member dto);
	
	public int dataCount(Map<String, Object> map);
	public List<Member> listMember(Map<String, Object> map);
	
	public int insertAuthority(Member dto);
	public int updateAuthority(Member dto);
	public Member readAuthority(int num);
	public List<Member> listAuthority(String userId);
	public int deleteAuthority(Map<String, Object> map);

	public Member readEmail(String email);
}
