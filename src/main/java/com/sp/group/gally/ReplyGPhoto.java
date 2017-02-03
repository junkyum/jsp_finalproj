package com.sp.group.gally;

public class ReplyGPhoto {

	private int replyNum, gallyNum, listReplyNum;
	private String userId, content, created;
	private String groupName;
	private int replyAnswer, answerCount;
	private int gallryReplyLike;
				
	//private int replyAnswerCount;
	private int gallylike;//좋아싫어?사용하려고만든 변수
	private int likeCount;
	private int disLikeCount;
	
	
	
	
	public int getGallryReplyLike() {
		return gallryReplyLike;
	}
	public void setGallryReplyLike(int gallryReplyLike) {
		this.gallryReplyLike = gallryReplyLike;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public int getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}
	public int getGallyNum() {
		return gallyNum;
	}
	public void setGallyNum(int gallyNum) {
		this.gallyNum = gallyNum;
	}
	public int getListReplyNum() {
		return listReplyNum;
	}
	public void setListReplyNum(int listReplyNum) {
		this.listReplyNum = listReplyNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public int getReplyAnswer() {
		return replyAnswer;
	}
	public void setReplyAnswer(int replyAnswer) {
		this.replyAnswer = replyAnswer;
	}
	public int getAnswerCount() {
		return answerCount;
	}
	public void setAnswerCount(int answerCount) {
		this.answerCount = answerCount;
	}
	public int getGallylike() {
		return gallylike;
	}
	public void setGallylike(int gallylike) {
		this.gallylike = gallylike;
	}

	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public int getDisLikeCount() {
		return disLikeCount;
	}
	public void setDisLikeCount(int disLikeCount) {
		this.disLikeCount = disLikeCount;
	}
	
	
	
}
