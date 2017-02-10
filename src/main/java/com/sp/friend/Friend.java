package com.sp.friend;

import java.util.List;

public class Friend {
	private int num;
	private String userId, userName, friendUserId, friendUserName;
	private String state;
	
	private List<Integer> numList;
	private List<String> userIdList;
	private String mode;
	
/*
  -- state
    -- '0' : 요청(userId->friendUserId)
    -- '1' : 수락(자신은 친구 추가, 친구의 상태는 수락으로 변경)
    -- '2' : 거절(요청받은것을 거절)
    -- '3' : 차단(수락후 거절)
*/
	
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
	public String getFriendUserId() {
		return friendUserId;
	}
	public void setFriendUserId(String friendUserId) {
		this.friendUserId = friendUserId;
	}
	public String getFriendUserName() {
		return friendUserName;
	}
	public void setFriendUserName(String friendUserName) {
		this.friendUserName = friendUserName;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public List<Integer> getNumList() {
		return numList;
	}
	public void setNumList(List<Integer> numList) {
		this.numList = numList;
	}
	public List<String> getUserIdList() {
		return userIdList;
	}
	public void setUserIdList(List<String> userIdList) {
		this.userIdList = userIdList;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
}
