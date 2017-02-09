package com.sp.friend;

import java.util.List;
import java.util.Map;

public interface FriendService {
	public int insertFriend(Friend dto);
	
	public List<Friend> friendSearchList(Map<String, Object> map);
	public List<Friend> friendList(Map<String, Object> map);
	public List<Friend> friendAskList(String userId);
	public List<Friend> friendAskedList(Map<String, Object> map);
	
	public int updateFriend(Map<String, Object> map);
	public int updateFriendList(Map<String, Object> map);
	
	public int deleteFriend(int num);
	public int deleteFriendList(List<Integer> numList);
}
