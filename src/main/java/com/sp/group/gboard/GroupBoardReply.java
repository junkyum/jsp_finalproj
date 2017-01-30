package com.sp.group.gboard;

public class GroupBoardReply {
	private int replyNum, gbNum;
	private String userId, userName, gbcontent, gbcreated;
	private int answer;
	public int getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}
	public int getGbNum() {
		return gbNum;
	}
	public void setGbNum(int gbNum) {
		this.gbNum = gbNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getGbcontent() {
		return gbcontent;
	}
	public void setGbcontent(String gbcontent) {
		this.gbcontent = gbcontent;
	}
	public String getGbcreated() {
		return gbcreated;
	}
	public void setGbcreated(String gbcreated) {
		this.gbcreated = gbcreated;
	}
	public int getAnswer() {
		return answer;
	}
	public void setAnswer(int answer) {
		this.answer = answer;
	}
	
	
}
