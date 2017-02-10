package com.sp.group.replyBoard;

import java.util.HashMap;
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

			} else if (mode.equals("reply")){
				Map<String, Object> map=new HashMap<>();
				map.put("groupNumber", dto.getGroupNumber());
				map.put("orderNo", dto.getOrderNo());
				dao.updateData("groupReply.updateOrderNo", map);
				
				
				int maxReplyBoardNum= dao.getIntValue("groupReply.maxReplyBoardNum");
				
				dto.setReplyBoardNum(maxReplyBoardNum+1);
				dto.setDepth(dto.getDepth()+1);
				dto.setOrderNo(dto.getOrderNo()+1);	

			}

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
		ReplyBoard dto= null;
		try{
			dto=dao.getReadData("groupReply.preReadReplyBoard", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	@Override
	public ReplyBoard nextReadReplyBoard(Map<String, Object> map) {
		ReplyBoard dto= null;
		try{
			dto=dao.getReadData("groupReply.nextReadReplyBoard", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
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
		int result=0;
		try {
			System.out.println(dto.getReplyBoardNum()+"  ??????????????");
			result=dao.updateData("groupReply.updateReplyBoard", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteReplyBoard(int replyBoardNum) {
		int result=0;

		try{
			
			result=dao.deleteData("groupReply.deleteReplyBoard", replyBoardNum);
		} catch(Exception e) {
		}
		return result;
	}



}
