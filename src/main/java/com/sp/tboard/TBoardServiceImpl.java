package com.sp.tboard;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("tboard.tboardService")
public class TBoardServiceImpl implements TBoardService {

	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	
	@Override
	public int insertTBoard(TBoard dto, String pathname) {
		int result=0;
		try {
			int maxNum=dao.getIntValue("tboard.maxNum", dto);
			dto.setNum(maxNum+1);
			
			dao.insertData("tboard.insertTBoard", dto);
			
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
						
						dao.insertData("tboard.insertTBoardFile", dto);
						
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
			result=(Integer)dao.getIntValue("tboard.dataCount",map);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		} 
		
		return result;
	}

	@Override
	public List<TBoard> listTBoard(Map<String, Object> map) {
		List<TBoard> list = null;
		
		try {
			list=dao.getListData("tboard.listTBoard",map);
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
			result=dao.updateData("tboard.updateHitCount", num);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public TBoard readTBoard(int num) {
		TBoard dto=null;
		try {
			dto=dao.getReadData("tboard.readTBoard",num);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public TBoard preReadTBoard(Map<String, Object> map) {
		TBoard dto=null;
		try {
			dto=dao.getReadData("tboard.preReadTBoard", map);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public TBoard nextReadTBoard(Map<String, Object> map) {
		TBoard dto=null;
		try {
			dto=dao.getReadData("tboard.nextReadTBoard", map);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int updateTBoard(TBoard dto, String pathname) {
		int result=0;
		
		try {
			result=dao.updateData("tboard.updateTBoard", dto);
			
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
						
						dao.insertData("tboard.insertTBoardFile", dto);
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
	public int deleteTBoard(int num, String pathname) {
		int result=0;
		
		try {
			// 파일 지우기
			List<TBoard> listFile=listFile(num);
			if(listFile!=null) {
				Iterator<TBoard> it=listFile.iterator();
				while(it.hasNext()) {
					TBoard dto=it.next();
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			// 파일 테이블 내용 지우기
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("field", "num");
			map.put("num", num);
			deleteFile(map);
			
			result=dao.deleteData("tboard.deleteTBoard", num);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int insertFile(TBoard dto) {
		int result=0;
		
		return result;
	}

	@Override
	public List<TBoard> listFile(int num) {
		List<TBoard> list = null;
		
		try {
			list=dao.getListData("tboard.listFile",num);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
		
	}

	@Override
	public TBoard readFile(int fileNum) {
		TBoard dto=null;
		try {
			dto=dao.getReadData("tboard.readFile", fileNum);
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
			result=dao.deleteData("tboard.deleteFile", map);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int goodCount(int num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int goodCount_Reple(int repleNum) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertReple(TBoard dto) {
		int result=0;
		try {
			int maxNum=dao.getIntValue("tboard.repleNum", dto);
			dto.setRepleNum(maxNum+1);
			
			dao.insertData("tboard.insertReple", dto);
			
			result=1;
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<TBoard> listReple(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteReple(int num, String pathname) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	
	

}
