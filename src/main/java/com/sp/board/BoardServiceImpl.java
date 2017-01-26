package com.sp.board;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("board.boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	
	@Override
	public int insertBoard(Board dto, String pathname) {
		int result=0;
		try {
			int maxNum=dao.getIntValue("board.maxNum", dto);
			dto.setNum(maxNum+1);
			
			dao.insertData("board.insertBoard", dto);
			
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
						
						dao.insertData("board.insertBoardFile", dto);
						
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
			result=(Integer)dao.getIntValue("board.dataCount",map);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		} 
		
		return result;
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list = null;
		
		try {
			list=dao.getListData("board.listBoard",map);
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
			result=dao.updateData("board.updateHitCount", num);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public Board readBoard(int num) {
		Board dto=null;
		try {
			dto=dao.getReadData("board.readBoard",num);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public Board preReadBoard(Map<String, Object> map) {
		Board dto=null;
		try {
			dto=dao.getReadData("Board.preReadBoard", map);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public Board nextReadBoard(Map<String, Object> map) {
		Board dto=null;
		try {
			dto=dao.getReadData("board.nextReadBoard", map);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int updateBoard(Board dto, String pathname) {
		int result=0;
		
		try {
			result=dao.updateData("board.updateBoard", dto);
			
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
						
						dao.insertData("board.insertBoardFile", dto);
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
	public int deleteBoard(int num, String pathname) {
		int result=0;
		
		try {
			// 파일 지우기
			List<Board> listFile=listFile(num);
			if(listFile!=null) {
				Iterator<Board> it=listFile.iterator();
				while(it.hasNext()) {
					Board dto=it.next();
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			// 파일 테이블 내용 지우기
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("field", "num");
			map.put("num", num);
			deleteFile(map);
			
			result=dao.deleteData("board.deleteBoard", num);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int insertFile(Board dto) {
		int result=0;
		
		return result;
	}

	@Override
	public List<Board> listFile(int num) {
		List<Board> list = null;
		
		try {
			list=dao.getListData("board.listFile",num);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
		
	}

	@Override
	public Board readFile(int fileNum) {
		Board dto=null;
		try {
			dto=dao.getReadData("board.readFile", fileNum);
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
			result=dao.deleteData("board.deleteFile", map);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	

}
