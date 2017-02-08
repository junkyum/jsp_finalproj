package com.sp.group.replyBoard;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service("group.replyBoardService")
public class ReplyBoardServiceImpl implements  ReplyBoardService{

	@Override
	public int insertResponse(ReplyBoard dto, String mode) {
		
		return 0;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		
		return 0;
	}

	@Override
	public List<ReplyBoard> listResponse(Map<String, Object> map) {
		
		return null;
	}

	@Override
	public ReplyBoard readResponse(int boardNum) {
		
		return null;
	}

	@Override
	public ReplyBoard preReadResponse(Map<String, Object> map) {
		
		return null;
	}

	@Override
	public ReplyBoard nextReadResponse(Map<String, Object> map) {
		
		return null;
	}

	@Override
	public int updateHitCount(int responseNum) {
		
		return 0;
	}

	@Override
	public int updateResponse(ReplyBoard dto) {
	
		return 0;
	}

	@Override
	public int deleteResponse(int responseNum) {
		
		return 0;
	}

}
