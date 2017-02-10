package com.sp.tfaq;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;


@Service("category.faqBoardService")
public class FaqServiceImpl implements FaqService {

	@Autowired
	private CommonDAO dao;
	
	
	@Override
	public int insertFaq(Faq dto) {
			int result = 0;
			try {
				result= dao.insertData("tfaq.insertFaq",dto);
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result= dao.getIntValue("tfaq.dataCountFaq", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int updateFaq(Faq dto) {
		int result = 0;
		try {
			result = dao.updateData("tfaq.updateFaq", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int deleteFaq(int num) {
		int result =0;
		try {
			result = dao.deleteData("tfaq.deleteFaq", num);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Faq> FaqList(Map<String, Object> map) {
			List<Faq> list = null;
			try {
				list = dao.getListData("tfaq.listFaq", map);
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		
		return list;
	}

	@Override
	public List<Faq> FaqCategory() {
			List<Faq> list = null;
			try {
				list = dao.getListData("tfaq.listFaqCategory");
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		
		return list;
	}

	@Override
	public Faq readFaq(int num) {
		
		Faq faq = null;
		try {
			faq = dao.getReadData("tfaq.readFaq",num);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
				
		
		return faq;
	}

	@Override
	public int insertCategroy(Faq dto) {

		int result = 0;
		try {
			result = dao.insertData("tfaq.insertCategory", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Faq> ListCategroy() {
		List<Faq> list= null;
		try {
			list= dao.getListData("tfaq.listCategory");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	@Override
	public int dataCountCategroy() {
		int result =0;
		try {
			result = dao.getIntValue("tfaq.dataCountCategory");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int deleteCategroy(int categoryNum) {
			int result = 0;
			
			try {
				result = dao.deleteData("tfaq.deleteCategory", categoryNum);
			} catch (Exception e) {
				System.out.println(e.toString());
			
			}
			
		return result;
	}

}
