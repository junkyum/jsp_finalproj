package com.sp.group.notice;

import java.util.List;
import java.util.Map;

public interface NoticeService {
	public int insertNotice(GroupNotice dto, String pathname);
	public int dataCount(Map<String, Object> map);
	public List <GroupNotice> listNotice(Map<String, Object> map);
	//public int updateHitCount(int num);
	public GroupNotice readNotice(int num);
	/*public Notice preReadNotice(Map<String, Object> map);
	public Notice nextReadNotice(Map<String, Object> map);*/
	public int updateNotice(GroupNotice dto, String pathname);
	public int deleteNotice(int num, String pathname);
	public int insertFile(GroupNotice dto);
	public List<GroupNotice> listFile(int num);
	public GroupNotice readFile(int fileNum); //파일정보 가져오기 
	public int deleteFile(Map<String, Object> map);
}
