package com.sp.tnotice;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("notice.noticeService")
public class TNoticeServiceImpl implements TNoticeService {

	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	
	@Override
	public int insertTNotice(TNotice dto, String pathname) {
		int result=0;
		try {
			int maxNum=dao.getIntValue("notice.maxNum", dto);
			dto.setNum(maxNum+1);
			
			dao.insertData("notice.insertNotice", dto);
			
			if(dto.getUpload()!=null && ! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					if(mf.isEmpty())
						continue;
					
					String filename=fileManager.doFileUpload(mf, pathname);
					insertFile(dto);
					if(filename!=null) {
						dto.setSaveFilename(filename);
						dto.setOriginalFilename(mf.getOriginalFilename());
						long fileSize=mf.getSize();
						dto.setFileSize(fileSize);
						
						dao.insertData("notice.insertNoticeFile", dto);
						
					}
				}
			}
			result=1; // 굳이 리턴 할 필요는 없다.
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
	int result=0;
		
		try {
			result=(Integer)dao.getIntValue("tnotice.dataCount",map);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		} 
		
		return result;
	}

	@Override
	public List<TNotice> listTNotice(Map<String, Object> map) {
		List<TNotice> list = null;
		
		try {
			list=dao.getListData("tnotice.listTNotice",map);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		
		
		return list;
	}

	@Override
	public List<TNotice> listTNoticeTop() {
		List<TNotice> list = null;
		
		try {
			list=dao.getListData("tnotice.listTNoticeTop");
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		
		
		return list;
	}

	@Override
	public int updateHitCount(int num) {
		int result =0;
		
		try {
			result=dao.updateData("notice.updateHitCount", num);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public TNotice readTNotice(int num) {
		TNotice dto=null;
		try {
			dto=dao.getReadData("notice.readNotice",num);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public TNotice preReadTNotice(Map<String, Object> map) {
		TNotice dto=null;
		try {
			dto=dao.getReadData("notice.preReadNotice", map);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public TNotice nextReadTNotice(Map<String, Object> map) {
		TNotice dto=null;
		try {
			dto=dao.getReadData("notice.nextReadNotice", map);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int updateTNotice(TNotice dto, String pathname) {
		int result=0;
		
		try {
			result=dao.updateData("notice.updateNotice", dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					if(mf.isEmpty())
						continue;
					
					String filename=fileManager.doFileUpload(mf, pathname);
					if(filename!=null) {
						dto.setSaveFilename(filename);
						dto.setOriginalFilename(mf.getOriginalFilename());
						long fileSize=mf.getSize();
						dto.setFileSize(fileSize);
						
						dao.insertData("notice.insertNoticeFile", dto);
					}
				}
			}
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteTNotice(int num, String pathname) {
		int result=0;
		
		try {
			// 파일 지우기
			List<TNotice> listFile=listFile(num);
			if(listFile!=null) {
				Iterator<TNotice> it=listFile.iterator();
				while(it.hasNext()) {
					TNotice dto=it.next();
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			// 파일 테이블 내용 지우기
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("field", "num");
			map.put("num", num);
			deleteFile(map);
			
			result=dao.deleteData("tnotice.deleteTNotice", num);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int insertFile(TNotice dto) {
		int result=0;
		
		return result;
	}

	@Override
	public List<TNotice> listFile(int num) {
		List<TNotice> list = null;
		
		try {
			list=dao.getListData("tnotice.listFile",num);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
		
	}

	@Override
	public TNotice readFile(int fileNum) {
		TNotice dto=null;
		try {
			dto=dao.getReadData("tnotice.readFile", fileNum);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int deleteFile(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.deleteData("tnotice.deleteFile", map);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	

}
