package com.sp.group.replyBoard;

import java.util.List;
import java.util.Map;

public interface ReplyBoardService {
	
	public int insertResponse(ReplyBoard dto, String mode);
	public int dataCount(Map<String, Object> map);
	public List<ReplyBoard> listResponse(Map<String, Object> map);
	
	// 게시물 보기
	public ReplyBoard readResponse(int boardNum);
	
	public ReplyBoard preReadResponse(Map<String, Object> map);
	public ReplyBoard nextReadResponse(Map<String, Object> map);
	
	public int updateHitCount(int responseNum);
	
	public int updateResponse(ReplyBoard dto);
	public int deleteResponse(int responseNum);
}
