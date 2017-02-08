package com.sp.group.replyBoard;

import java.util.List;
import java.util.Map;

public interface ReplyBoardService {
	
	public int insertReplyBoard(ReplyBoard dto, String mode);
	public int dataCount(Map<String, Object> map);
	public List<ReplyBoard> listReplyBoard(Map<String, Object> map);
	
	// 게시물 보기
	public ReplyBoard readReplyBoard(int replyBoardNum);
	
	public ReplyBoard preReadReplyBoard(Map<String, Object> map);
	public ReplyBoard nextReadReplyBoard(Map<String, Object> map);
	
	public int updateHitCount(int replyBoardNum);
	
	public int updateReplyBoard(ReplyBoard dto);
	public int deleteReplyBoard(int replyBoardNum);
}
