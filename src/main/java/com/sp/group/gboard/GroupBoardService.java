package com.sp.group.gboard;

import java.util.List;
import java.util.Map;

public interface GroupBoardService {
	public int insertGroupBoard(GroupBoard dto, String pathname);
	public int dataCount(Map<String, Object> map);
	public List<GroupBoard> listGroupBoard(Map<String, Object> map);
	public int updateHitCount(int boardNum); 		//쿠키로 막는 방법 있음!! 
	public GroupBoard readGroupBoard(int boardNum);
	public GroupBoard preReadGroupBoard(Map<String, Object> map);
    public GroupBoard nextReadGroupBoard(Map<String, Object> map);	
	public int updateGroupBoard(GroupBoard dto, String pathname);
	public int deleteGroupBoard(int boardNum, String pathname);	
	
	public int insertFile(GroupBoard dto);
	public List<GroupBoard> listFile(int boardNum);
	public GroupBoard readFile(int fileNum);
	public int deleteFile(Map<String, Object>map);
	
	public int insertReply(GroupBoardReply dto);
	public int dataCountReply(int boardNum);
	public List<GroupBoardReply> listReply(Map<String, Object>map);
	public int deleteReply(int replyNum, String pathname);
	
	public int dataCountLike(int boardNum); //게시글 좋아요
	public int dataCountReplyLike(int replyNum); //게시글 리플 좋아요	
}
