package com.sp.note;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("note.noteService")
public class NoteServiceImpl implements NoteService{
	@Autowired
	CommonDAO dao;
	
	@Override
	public List<Note> listFriend(String userId) {
		List<Note> list=null;
		
		try {
			list=dao.getListData("note.listFriend", userId);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int insertNode(Note dto) {
		int result=0;
		
		try {
			result=dao.insertData("note.insertNote", dto);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int dataCountReceive(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("note.dataCountReceive", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Note> listReceive(Map<String, Object> map) {
		List<Note> list=null;
		
		try {
			list=dao.getListData("note.listReceive", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int dataCountSend(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("note.dataCountSend", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Note> listSend(Map<String, Object> map) {
		List<Note> list=null;
		
		try {
			list=dao.getListData("note.listSend", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public Note readReceive(int num) {
		Note dto=null;
		
		try{
			dto=dao.getReadData("note.readReceive", num);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public Note preReadReceive(Map<String, Object> map) {
		Note dto=null;
		
		try{
			dto=dao.getReadData("note.preReadReceive", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public Note nextReadReceive(Map<String, Object> map) {
		Note dto=null;
		
		try{
			dto=dao.getReadData("note.nextReadReceive", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}
	
	@Override
	public Note readSend(int num) {
		Note dto=null;
		
		try{
			dto=dao.getReadData("note.readSend", num);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public Note preReadSend(Map<String, Object> map) {
		Note dto=null;
		
		try{
			dto=dao.getReadData("note.preReadSend", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public Note nextReadSend(Map<String, Object> map) {
		Note dto=null;
		
		try{
			dto=dao.getReadData("note.nextReadSend", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}
	
	@Override
	public Note readReplyReceive(int num) {
		Note dto=null;
		
		try{
			dto=dao.getReadData("note.readReplReceive", num);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public int updateIdentifyDay(int num) {
		int result=0;

		try{
			result=dao.updateData("note.updateIdentifyDay", num);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteNote(Map<String, Object> map) {
		int result=0;

		try{
			    // 삭제(삭제상태로 된경우에는 글을 삭제)
				result=dao.deleteData("note.deleteNote", map);
				
				// 삭제 상태가 아닌 경우는 삭제 상태로 수정
				result=dao.updateData("note.updateDeleteState", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int newNoteCount(String userId) {
		int result=0;
		try {
			result=dao.getIntValue("note.newNoteCount", userId);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

}
