package com.sp.group.gboard;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class GroupBoard {
	private int listNum, gbnum;
	private String userId, userName;
	private String gbsubject, gbcontent, gbcreated;
	private int hitCount;
	
	private int countLike;
	private int gbreplyNum, answer;
	private String replyContent;
	private int countReplyLike;	
	
	private int gbfileNum;
	private String saveFilename, originalFilename;
	private long gbfileSize;
	
	private List<MultipartFile> upload;
	// private MultipartFile upload;
	
	private long gap;

	public int getListNum() {
		return listNum;
	}

	public void setListNum(int listNum) {
		this.listNum = listNum;
	}

	public int getGbnum() {
		return gbnum;
	}

	public void setGbnum(int gbnum) {
		this.gbnum = gbnum;
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

	public String getGbsubject() {
		return gbsubject;
	}

	public void setGbsubject(String gbsubject) {
		this.gbsubject = gbsubject;
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

	public int getHitCount() {
		return hitCount;
	}

	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}

	public int getCountLike() {
		return countLike;
	}

	public void setCountLike(int countLike) {
		this.countLike = countLike;
	}

	public int getGbreplyNum() {
		return gbreplyNum;
	}

	public void setGbreplyNum(int gbreplyNum) {
		this.gbreplyNum = gbreplyNum;
	}

	public int getAnswer() {
		return answer;
	}

	public void setAnswer(int answer) {
		this.answer = answer;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public int getCountReplyLike() {
		return countReplyLike;
	}

	public void setCountReplyLike(int countReplyLike) {
		this.countReplyLike = countReplyLike;
	}

	public int getGbfileNum() {
		return gbfileNum;
	}

	public void setGbfileNum(int gbfileNum) {
		this.gbfileNum = gbfileNum;
	}

	public String getSaveFilename() {
		return saveFilename;
	}

	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}

	public String getOriginalFilename() {
		return originalFilename;
	}

	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}

	public long getGbfileSize() {
		return gbfileSize;
	}

	public void setGbfileSize(long gbfileSize) {
		this.gbfileSize = gbfileSize;
	}

	public List<MultipartFile> getUpload() {
		return upload;
	}

	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}

	public long getGap() {
		return gap;
	}

	public void setGap(long gap) {
		this.gap = gap;
	}
	
	
}
