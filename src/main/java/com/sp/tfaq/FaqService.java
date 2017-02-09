package com.sp.tfaq;

import java.util.List;
import java.util.Map;

public interface FaqService {
	public int insertFaq(Faq dto);
	public int dataCount(Map<String, Object>map);
	public int updateFaq(Faq dto);
	public int deleteFaq(int num);
	public List<Faq> FaqList(Map<String, Object>map);
	public List<Faq> FaqCategory();
	public Faq readFaq(int num);
	
	
	
	////////////////////
	
	public int insertCategroy(Faq dto);
	public List<Faq> ListCategroy();
	public int dataCountCategroy();
	public int deleteCategroy(int categoryNum);
	
	
}
