package com.sp.group.replyBoard;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("group.replyBoardService")
public class ReplyBoardServiceImpl implements  ReplyBoardService{
	@Autowired
	private CommonDAO  dao;
	@Override
	public int insertReplyBoard(ReplyBoard dto, String mode) {
		int result =0;
		try {
			if(mode.equals("created")){
				int maxReplyBoardNum=dao.getIntValue("groupReply.maxReplyBoardNum");
				dto.setReplyBoardNum(maxReplyBoardNum+1);
				dto.setGroupNumber(dto.getReplyBoardNum());
			}
			System.out.println(dto.getGroupName()+"              그룹이름");
			System.out.println(dto.getReplyBoardNum()+"           리플보드넘");
			result=dao.insertData("groupReply.insertReplyBoard", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result =0;
		try {
			result=dao.getIntValue("groupReply.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<ReplyBoard> listReplyBoard(Map<String, Object> map) {
		List<ReplyBoard> list= null;
		try {
			list= dao.getListData("groupReply.listReplyBoard", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	@Override
	public ReplyBoard readReplyBoard(int replyBoardNum) {
		ReplyBoard dto= null;
		try{
			// 게시물 가져오기
			dto=dao.getReadData("groupReply.readReplyBoard", replyBoardNum);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		
		return dto;
	}

	@Override
	public ReplyBoard preReadReplyBoard(Map<String, Object> map) {
		
		return null;
	}

	@Override
	public ReplyBoard nextReadReplyBoard(Map<String, Object> map) {
		
		return null;
	}

	@Override
	public int updateHitCount(int replyBoardNum) {
		int result =0;
		try {
			result=dao.getIntValue("groupReply.updateHitCount", replyBoardNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int updateReplyBoard(ReplyBoard dto) {
		
		return 0;
	}

	@Override
	public int deleteReplyBoard(int replyBoardNum) {
		
		return 0;
	}



}
