package com.sp.board;

import java.util.List;
import java.util.Map;

public interface BoardService {
	public int insertBoard(Board dto, String pathname);
	// 게시글 생성
	public int dataCount(Map<String, Object> map);
	// 전체 게시글 개수 체크
	public List<Board> listBoard(Map<String, Object> map);
	// 일반 게시글 리스트
	public int updateHitCount(int num);
	// 게시글 조회수 업데이트
	public Board readBoard(int num);
	// 게시글 보기
	public Board preReadBoard(Map<String, Object> map);
	// 이전 글
	public Board nextReadBoard(Map<String, Object> map);
	// 다음 글
	public int updateBoard(Board dto, String pathname);
	// 게시글 수정
	public int deleteBoard(int num, String pathname);
	// 게시글 삭제
	public int insertFile(Board dto);
	// 공지 내 파일 입력
	public List<Board> listFile(int num);
	// 게시글 내 파일 리스트
	public Board readFile(int fileNum);
	// 게시글 내 파일 리딩
	public int deleteFile(Map<String, Object> map);
	// 게시글 내 파일 삭제
	
	
	
	

}
