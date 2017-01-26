package com.sp.tnotice;

import java.util.List;
import java.util.Map;

public interface TNoticeService {
	public int insertTNotice(TNotice dto, String pathname);
	// 게시글 생성
	public int dataCount(Map<String, Object> map);
	// 전체 게시글 개수 체크
	public List<TNotice> listTNotice(Map<String, Object> map);
	// 일반 게시글 리스트
	public List<TNotice> listTNoticeTop();
	// 공지 위에 올리는 리스트
	public int updateHitCount(int num);
	// 게시글 조회수 업데이트
	public TNotice readTNotice(int num);
	// 게시글 보기
	public TNotice preReadTNotice(Map<String, Object> map);
	// 이전 글
	public TNotice nextReadTNotice(Map<String, Object> map);
	// 다음 글
	public int updateTNotice(TNotice dto, String pathname);
	// 게시글 수정
	public int deleteTNotice(int num, String pathname);
	// 게시글 삭제
	public int insertFile(TNotice dto);
	// 공지 내 파일 입력
	public List<TNotice> listFile(int num);
	// 게시글 내 파일 리스트
	public TNotice readFile(int fileNum);
	// 게시글 내 파일 리딩
	public int deleteFile(Map<String, Object> map);
	// 게시글 내 파일 삭제
	
	
	
	

}
