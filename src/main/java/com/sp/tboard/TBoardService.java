package com.sp.tboard;

import java.util.List;
import java.util.Map;


public interface TBoardService {
	// 게시글 생성11
	public int insertTBoard(TBoard dto, String pathname);
	// 전체 게시글 개수 체크
	public int dataCount(Map<String, Object> map);
	// 일반 게시글 리스트
	public List<TBoard> listTBoard(Map<String, Object> map);
	// 게시글 조회수 업데이트
	public int updateHitCount(int num);
	// 게시글 보기1
	public TBoard readTBoard(int num);
	// 이전 글
	public TBoard preReadTBoard(Map<String, Object> map);
	// 다음 글
	public TBoard nextReadTBoard(Map<String, Object> map);
	// 게시글 수정
	public int updateTBoard(TBoard dto, String pathname);
	// 게시글 삭제
	public int deleteTBoard(int num, String pathname);
	// 공지 내 파일 입력
	public int insertFile(TBoard dto);
	// 게시글 내 파일 리스트
	public List<TBoard> listFile(int num);
	// 게시글 내 파일 리딩
	public TBoard readFile(int fileNum);
	// 게시글 내 파일 삭제
	public int deleteFile(Map<String, Object> map);

	
	
    public int insertBoardLike(TBoard dto);
    public Map<String, Object> countLike(int num);
    
    public int insertReply(Reply dto);
    public List<Reply> listReply(Map<String, Object>map);
    public List<Reply> listReplyAnswer(int answer);
    public int deleteReply(Map<String, Object>map);
    public int replyCountAnswer(int answer);
    public int replyDataCount(Map<String, Object>map);
    
    public int insertReplyLike(Reply dto);
    public Map<String, Object> replyCountLike(int replyNum);
    
    
	

}
