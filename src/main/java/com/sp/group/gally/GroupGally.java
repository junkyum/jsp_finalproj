package com.sp.group.gally;

import org.springframework.web.multipart.MultipartFile;

public class GroupGally {
	private int gallyNum, listNum, chkNum;
	private String groupName,content ;
	private String created , subject;
    private String imageFilename,userId;

    private MultipartFile upload;

 

	public int getGallyNum() {
		return gallyNum;
	}

	public void setGallyNum(int gallyNum) {
		this.gallyNum = gallyNum;
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

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public int getChkNum() {
		return chkNum;
	}

	public void setChkNum(int chkNum) {
		this.chkNum = chkNum;
	}

	
	
	public int getListNum() {
		return listNum;
	}

	public void setListNum(int listNum) {
		this.listNum = listNum;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getImageFilename() {
		return imageFilename;
	}

	public void setImageFilename(String imageFilename) {
		this.imageFilename = imageFilename;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public MultipartFile getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
}
