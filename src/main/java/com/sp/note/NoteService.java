package com.sp.note;

import java.util.List;
import java.util.Map;

public interface NoteService {
	public List<Note> listFriend(String userId);
	
	public int insertNode(Note dto);

	public int dataCountReceive(Map<String, Object> map);
	public List<Note> listReceive(Map<String, Object> map);
	
	public int dataCountSend(Map<String, Object> map);
	public List<Note> listSend(Map<String, Object> map);
	
	public Note readReceive(int num);
	public Note preReadReceive(Map<String, Object> map);
	public Note nextReadReceive(Map<String, Object> map);
	public Note readSend(int num);
	public Note preReadSend(Map<String, Object> map);
	public Note nextReadSend(Map<String, Object> map);
	
	public Note readReplyReceive(int num);
	
	public int updateIdentifyDay(int num);
	
	public int deleteNote(Map<String, Object> map);
	
	public int newNoteCount(String userId);
}
