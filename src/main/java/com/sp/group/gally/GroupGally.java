package com.sp.group.gally;

import org.springframework.web.multipart.MultipartFile;

public class GroupGally {
	private int groupNum, listNum, chkNum;
	private String groupName,groupContent;
	private String groupCreated, groupSubject;
    private String imageFilename,userId;

    private MultipartFile upload;

 

	public int getChkNum() {
		return chkNum;
	}

	public void setChkNum(int chkNum) {
		this.chkNum = chkNum;
	}

	
	
	public int getGroupNum() {
		return groupNum;
	}

	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
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

	public String getGroupContent() {
		return groupContent;
	}

	public void setGroupContent(String groupContent) {
		this.groupContent = groupContent;
	}

	public String getGroupCreated() {
		return groupCreated;
	}

	public void setGroupCreated(String groupCreated) {
		this.groupCreated = groupCreated;
	}

	public String getGroupSubject() {
		return groupSubject;
	}

	public void setGroupSubject(String groupSubject) {
		this.groupSubject = groupSubject;
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
