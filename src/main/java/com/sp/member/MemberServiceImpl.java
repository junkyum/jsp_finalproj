package com.sp.member;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private CommonDAO  dao;



	@Override
	public Member readMember(String userId) {
		Member dto=null;
		try {
			dto=dao.getReadData("member.readMember", userId);
			
			if(dto!=null) {
				if(dto.getTel()!=null) {
					String [] s=dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int insertMember(Member dto) {
		int result=0;
		
		try {
			if(dto.getTel1() != null && dto.getTel1().length()!=0 &&
					dto.getTel2() != null && dto.getTel2().length()!=0 &&
							dto.getTel3() != null && dto.getTel3().length()!=0)
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());

			
			
			
			dao.insertData("member.insertMember", dto);
			
			
			dto.setAuthority("ROLE_USER");
			dao.insertData("member.insertAuthority", dto);
	
			
			result=1;
		} catch (Exception e) {
		}
		
		return result;
	}
	
	@Override
	public int updateMember(Member dto) {
		int result=0;
		try {
			if(dto.getTel1() != null && dto.getTel1().length()!=0 &&
					dto.getTel2() != null && dto.getTel2().length()!=0 &&
							dto.getTel3() != null && dto.getTel3().length()!=0)
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			
			result=dao.updateData("member.updateMember", dto);
			
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int updateLastLogin(String userId) {
		int result=0;
		try {
			result=dao.updateData("member.updateLastLogin", userId);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int deleteMember(Member dto) {
		int result=0;
		try {
			
			/*// member1 테이블 수정
			int memberIdx=(Integer)map.get("memberIdx");
			dao.updateData("member.updateMember1", memberIdx);
			*/
			// member2 테이블 삭제
			
			result=dao.deleteData("member.deleteMember", dto);
		} catch (Exception e) {
		}
		return result;
	}
	


	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("member.dataCount", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public List<Member> listMember(Map<String, Object> map) {
		List<Member> list=null;
		try {
			list=dao.getListData("member.listMember", map);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public int insertAuthority(Member member) {
		int result=0;
		try {
			result=dao.insertData("member.insertAuthority", member);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int updateAuthority(Member dto) {
		int result=0;
		try {
			result=dao.updateData("member.updateAuthority", dto);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public Member readAuthority(int num) {
		Member dto=null;
		try {
			dto=dao.getReadData("member.readAuthority", num);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public List<Member> listAuthority(String userId) {
		List<Member> list=null;
		try {
			list=dao.getListData("member.listAuthority", userId);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public int deleteAuthority(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.deleteData("member.deleteAuthority", map);
		} catch (Exception e) {
		}
		return result;
	}
}
