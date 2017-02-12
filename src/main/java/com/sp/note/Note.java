package com.sp.note;

import java.util.List;

public class Note {
	
	private int num;
	private String content;
	private String sendUserId, sendUserName;
	private String receiveUserId, receiveUserName;
	private String sendDay, identifyDay;
	private String sendDelete, receiveDelete;
	private int parent;
	
	private List<String> userIds;
	private List<Integer> nums;
	private String mode;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSendUserId() {
		return sendUserId;
	}
	public void setSendUserId(String sendUserId) {
		this.sendUserId = sendUserId;
	}
	public String getSendUserName() {
		return sendUserName;
	}
	public void setSendUserName(String sendUserName) {
		this.sendUserName = sendUserName;
	}
	public String getReceiveUserId() {
		return receiveUserId;
	}
	public void setReceiveUserId(String receiveUserId) {
		this.receiveUserId = receiveUserId;
	}
	public String getReceiveUserName() {
		return receiveUserName;
	}
	public void setReceiveUserName(String receiveUserName) {
		this.receiveUserName = receiveUserName;
	}
	public String getSendDay() {
		return sendDay;
	}
	public void setSendDay(String sendDay) {
		this.sendDay = sendDay;
	}
	public String getIdentifyDay() {
		return identifyDay;
	}
	public void setIdentifyDay(String identifyDay) {
		this.identifyDay = identifyDay;
	}
	public String getSendDelete() {
		return sendDelete;
	}
	public void setSendDelete(String sendDelete) {
		this.sendDelete = sendDelete;
	}
	public String getReceiveDelete() {
		return receiveDelete;
	}
	public void setReceiveDelete(String receiveDelete) {
		this.receiveDelete = receiveDelete;
	}
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
	public List<String> getUserIds() {
		return userIds;
	}
	public void setUserIds(List<String> userIds) {
		this.userIds = userIds;
	}
	public List<Integer> getNums() {
		return nums;
	}
	public void setNums(List<Integer> nums) {
		this.nums = nums;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
}
