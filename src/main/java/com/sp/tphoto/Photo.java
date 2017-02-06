package com.sp.tphoto;

import org.springframework.web.multipart.MultipartFile;

public class Photo {
	private int listNum, num;
	private String userId, userName;
	private String subject, imageFilename, content;
	private String created, hitCount;
	
	private MultipartFile upload;


	private int tPhotoLike;
	private int tlikeCount;
	private int tdisLikeCount;
	
	
	public int getTphotoLike() {
		return tPhotoLike;
	}

	public void setTphotoLike(int tphotoLike) {
		this.tPhotoLike = tphotoLike;
	}

	public int getTlikeCount() {
		return tlikeCount;
	}

	public void setTlikeCount(int tlikeCount) {
		this.tlikeCount = tlikeCount;
	}

	public int getTdisLikeCount() {
		return tdisLikeCount;
	}

	public void setTdisLikeCount(int tdisLikeCount) {
		this.tdisLikeCount = tdisLikeCount;
	}

	public int getListNum() {
		return listNum;
	}

	public void setListNum(int listNum) {
		this.listNum = listNum;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
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

	public String getImageFilename() {
		return imageFilename;
	}

	public void setImageFilename(String imageFilename) {
		this.imageFilename = imageFilename;
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

	public String getHitCount() {
		return hitCount;
	}

	public void setHitCount(String hitCount) {
		this.hitCount = hitCount;
	}

	public MultipartFile getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	
}
