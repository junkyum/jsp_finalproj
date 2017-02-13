package com.sp.tqna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;


@Service("tqna.qnaService")
public class QnaServiceImpl implements QnaService {

	@Autowired
	CommonDAO dao;
	
	@Override
	public List<Qna> listQna(Map<String, Object> map) {
		List<Qna> list = null;
		try {
			list= dao.getListData("tqna.listQna", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.getIntValue("tqna.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int insertQna(Qna dto, String mode) {
		int result = 0;

		try {
			if(mode.equals("created")) {
				int maxNum=dao.getIntValue("tqna.maxQnaNum");
				dto.setQnaNum(maxNum+1);
				dto.setGroupNum(dto.getQnaNum());
			} else if(mode.equals("reply")) {
				// orderNo 변경
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("groupNum", dto.getGroupNum());
				map.put("orderNo", dto.getOrderNo());
				dao.updateData("tqna.updateOrderNo", map);

				int maxNum=dao.getIntValue("tqna.maxQnaNum");
				dto.setQnaNum(maxNum+1);
				dto.setDepth(dto.getDepth() + 1);
				dto.setOrderNo(dto.getOrderNo() + 1);
			}
			result=dao.insertData("tqna.insertQna", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public Qna readQna(int qnaNum) {
		Qna dto = null;
		try {
			dto= dao.getReadData("tqna.readQna",qnaNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int updateQna(Qna dto) {
		int result= 0;
		try {
			result= dao.updateData("tqna.updateQna", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int deleteQna(int qnaNum) {
		int result =0;
		try {
			result = dao.deleteData("tqna.deleteQna", qnaNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public Qna preReadBoard(Map<String, Object> map) {
		Qna dto = null;
		try {
			dto = dao.getReadData("tqna.preReadQna",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public Qna nextReadBoard(Map<String, Object> map) {
		Qna dto = null;
		try {
			dto = dao.getReadData("tqna.nextReadQna",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int hitCount(int qnaNum) {
		int result = 0;
		try {
			result= dao.updateData("tqna.updateHitCount",qnaNum);
		} catch (Exception e) {
			System.out.println(e.toString());
			
		} 
				
		return result;
	}

}
