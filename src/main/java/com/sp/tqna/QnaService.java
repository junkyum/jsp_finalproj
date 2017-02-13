package com.sp.tqna;

import java.util.List;
import java.util.Map;

public interface QnaService {
  public List<Qna> listQna(Map<String, Object> map);
  public int dataCount(Map<String, Object>map);
  public int insertQna(Qna dto,String mode);
  
   
  public Qna readQna(int qnaNum);
  
  public int updateQna(Qna dto);
  public int deleteQna(int qnaNum);
  
  public Qna preReadBoard(Map<String, Object>map);
  public Qna nextReadBoard(Map<String, Object>map);
  
  public int hitCount(int qnaNum);
  
}
