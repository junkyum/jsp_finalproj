package com.sp.friend;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("friend.friendService")
public class FriendServiceImpl implements FriendService {
	@Autowired
	CommonDAO dao;
	
	@Override
	public int insertFriend(Friend dto) {
		int result=0;
		
		try {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("userId", dto.getUserId());
			map.put("friendUserId", dto.getFriendUserId());
			int cnt=dao.getIntValue("friend.friendCount", map);
			
			if(cnt==0)
				dto.setState("0"); // 요청중
			else
				dto.setState("1"); // 추가할 친구가 나를 친구로 등록한 경우(또는 삭제후 다시 추가한경우)

			result=dao.insertData("friend.insertFriend", dto);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public List<Friend> friendSearchList(Map<String, Object> map) {
		List<Friend> list=null;
		
		try {
			list=dao.getListData("friend.friendSearchList", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<Friend> friendList(Map<String, Object> map) {
		List<Friend> list=null;
		
		try {
			list=dao.getListData("friend.friendList", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<Friend> friendAskList(String userId) {
		List<Friend> list=null;
		
		try {
			list=dao.getListData("friend.friendAskList", userId);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	@Override
	public List<Friend> friendAskedList(Map<String, Object> map) {
		List<Friend> list=null;
		
		try {
			list=dao.getListData("friend.friendAskedList", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	@Override
	public int updateFriend(Map<String, Object> map) {
		int result=0;

		try{
			result=dao.updateData("friend.updateFriend", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int updateFriendList(Map<String, Object> map) {
		int result=0;

		try{
			result=dao.updateData("friend.updateFriendList", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteFriend(int num) {
		int result=0;

		try{
			result=dao.deleteData("friend.deleteFriend", num);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteFriendList(List<Integer> numList) {
		int result=0;

		try{
			result=dao.deleteData("friend.deleteFriendList", numList);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
}
