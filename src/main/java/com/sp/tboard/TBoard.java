package com.sp.tboard;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class TBoard {

	// 게시글 관련
	private int num, listNum;
	private String userId, userName;
	private String subject, content, created;
	private int hitCount;
	
	// 게시판 좋아요
	private int goodCount;
	
	// 게시판 리플
	private int repleNum, answer;
	private String repleContent;
	
	// 게시판 리플 좋아요
	private int goodCount_Reple;
	
	
	// file 관련
	private int fileNum;
	private String saveFilename, originalFilename;
	private long fileSize;
	
	private List<MultipartFile> upload;
	// private MultipartFile upload;
	
	private long gap;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getListNum() {
		return listNum;
	}

	public void setListNum(int listNum) {
		this.listNum = listNum;
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

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
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

	public int getHitCount() {
		return hitCount;
	}

	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}

	public int getFileNum() {
		return fileNum;
	}

	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
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

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
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

	public int getGoodCount() {
		return goodCount;
	}

	public void setGoodCount(int goodCount) {
		this.goodCount = goodCount;
	}

	public int getRepleNum() {
		return repleNum;
	}

	public void setRepleNum(int repleNum) {
		this.repleNum = repleNum;
	}

	public int getAnswer() {
		return answer;
	}

	public void setAnswer(int answer) {
		this.answer = answer;
	}

	public String getRepleContent() {
		return repleContent;
	}

	public void setRepleContent(String repleContent) {
		this.repleContent = repleContent;
	}

	public int getGoodCount_Reple() {
		return goodCount_Reple;
	}

	public void setGoodCount_Reple(int goodCount_Reple) {
		this.goodCount_Reple = goodCount_Reple;
	}
	
	
	
	
}
