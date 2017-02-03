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
	public int insertPhotoLike(GroupGally dto);
	public int groupPhotoLikeCount(GroupGally dto);
	//위에 3개까지만.  insertPhotoLike  groupPhotoLikeCount
	
	//리플 메소드  GReply
	public int insertGReply(ReplyGPhoto dto);
	//개시물 답글=>답변삭제
	public int GReplyDataCount(int gallyNum);//리플 갯수 새려고 만ㄷ
	public List<ReplyGPhoto> listGReply(Map<String, Object>map);//댓글의 리스트를 뽑기위해서.
	public int deleteReply(ReplyGPhoto dto);//댓글 삭제할꺼야
	
	//개시물 답글=>답변 관련된것들
	public int replyGroupCountAnswer(int replyAnswer);
	public List<ReplyGPhoto> listReplyAnswer(int replyAnswer);
	public int dataReplyAnswerCount(ReplyGPhoto dto);
	public int deleteReplyAnswer(ReplyGPhoto dto);
	
	
	/*

	public int insertPhotoLike(GroupGally dto);
	public int groupPhotoLikeCount(GroupGally dto);
	//위에 3개까지만.  insertPhotoLike  groupPhotoLikeCount
	
	//리플 메소드  GReply
	public int insertGReply(ReplyGPhoto dto);
	//개시물 답글=>답변삭제
	public int GReplyDataCount(int num);//리플 갯수 새려고 만ㄷ
	public List<ReplyGPhoto> listGReply(Map<String, Object>map);//댓글의 리스트를 뽑기위해서.
	public int deleteReply(ReplyGPhoto dto);//댓글 삭제할꺼야
	
	//개시물 답글=>답변 관련된것들
	public List<ReplyGPhoto> listReplyAnswer(int replyAnswer);
	public int dataReplyAnswerCount(ReplyGPhoto dto);
	public int deleteReplyAnswer(ReplyGPhoto dto);
	
	
	
	
	public int insertGReplyLike(ReplyGPhoto dto);//좋아싫어
	public int replyLikeCount(ReplyGPhoto dto);//좋아싫어?
	 * 
	 * 
	 * 
	 * 
	 */
	
}
