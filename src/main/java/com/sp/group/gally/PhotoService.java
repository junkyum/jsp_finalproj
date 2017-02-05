package com.sp.group.gally;

import java.util.List;
import java.util.Map;



public interface PhotoService {
	
	public int insertPhoto(GroupGally dto, String path);
	public int dataCount(Map<String, Object> map);
	public List<GroupGally> listPhoto(Map<String, Object> map);
	public GroupGally readPhoto(int gallyNum);
	public int updatePhoto(GroupGally dto, String path);
	public int deletePhoto(int gallyNum, String imageFilename, String path);
	
	//게시물 좋아요 하는곳
	public int insertGallyLike(GroupGally dto);
	public Map<String, Object> groupGallyLikeCount(int gallyNum);
	
	//리플 메소드  GReply
	public int insertGReply(ReplyGPhoto dto);
	public int GReplyDataCount(int gallyNum);//리플 갯수 새려고 만ㄷ
	public List<ReplyGPhoto> listGReply(Map<String, Object>map);//댓글의 리스트를 뽑기위해서.
	public int deleteReply(ReplyGPhoto dto);//댓글 삭제할꺼야
	
	//개시물 답글=>답변 관련된것들
	public List<ReplyGPhoto> listReplyAnswer(int replyAnswer);
	public int deleteReplyAnswer(ReplyGPhoto dto);
	
	public int replyGroupCountAnswer(int replyAnswer);//대댓글 갯수 세는곳
	
	public int insertGallyReplyLike(ReplyGPhoto dto);//댓글 좋아@싫어 추가하는거
	public Map<String, Object> groupGeplyCountLike(int replyNum);
	

}
