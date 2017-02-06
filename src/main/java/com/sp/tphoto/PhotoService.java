package com.sp.tphoto;

import java.util.List;
import java.util.Map;

public interface PhotoService {
    public int insertPhoto(Photo dto, String path);
    public int dataCount(Map<String, Object> map);
    public List<Photo> listPhoto(Map<String, Object> map);
    public int updatePhoto(Photo dto, String path);
    public int deletePhoto(int num, String imageFilename, String path);
    public Photo readPhoto(int num);
    public Photo preReadPhoto(Map<String, Object>map);
    public Photo nextReadPhoto(Map<String, Object>map);
    public int updateHitCount(int num);
    
    
    public int insertPhotoLike(Photo dto);
    public Map<String, Object> countLike(int num);
    
    //
    public int deletePhotoId(String userId, String root);
    
    //
    
    public int insertReply(Reply dto);
    public List<Reply> listReply(Map<String, Object>map);
    public List<Reply> listReplyAnswer(int answer);
    public int deleteReply(Map<String, Object>map);
    public int replyCountAnswer(int answer);
    public int replyDataCount(Map<String, Object>map);
    
    public int insertReplyLike(Reply dto);
    public Map<String, Object> replyCountLike(int replyNum);
    
    
    
    
}
