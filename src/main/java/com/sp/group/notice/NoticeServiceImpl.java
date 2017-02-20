package com.sp.group.notice;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("group.noticeService")
public class NoticeServiceImpl implements NoticeService{
	@Autowired private CommonDAO dao;
	@Autowired private FileManager fileManager;
	
	@Override
	public int insertNotice(GroupNotice dto, String pathname) {
		int res =0;
		try {
			int maxNum =dao.getIntValue("groupNotice.maxNum");
			dto.setNum(maxNum+1);
			res = dao.insertData("groupNotice.insertNotice", dto);
			
			if(dto.getUpload() !=null && !dto.getUpload().isEmpty()){
				for(MultipartFile mf : dto.getUpload()){
					if(mf.isEmpty())
						continue;
					String filename = fileManager.doFileUpload(mf, pathname);
					if(filename!=null){
						dto.setSaveFilename(filename);
						dto.setOriginalFilename(mf.getOriginalFilename());
						long fileSize = mf.getSize();
						dto.setFileSize(fileSize);
						
						dao.insertData("groupNotice.insertNoticeFile", dto);
					}
				}
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int res = 0;
		try {
			res = dao.getIntValue("groupNotice.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

	@Override
	public List<GroupNotice> listNotice(Map<String, Object> map) {
		List<GroupNotice>list = null;
		try {
			list = dao.getListData("groupNotice.listNotice", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public GroupNotice readNotice(int num) {
		GroupNotice dto = null;
		try {
			dto = dao.getReadData("groupNotice.readNotice", num);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int insertFile(GroupNotice dto) {
		return 0;
	}


	@Override
	public int updateNotice(GroupNotice dto, String pathname) {
		int result=0;
		
		try {
			result=dao.updateData("groupNotice.updateNotice", dto);
			
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
						
						dao.updateData("groupNotice.updateNotice", dto);
					}
				}
			}
			
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public int deleteNotice(int num, String pathname) {
		int result=0;
		
		try {
			// 파일 지우기
			List<GroupNotice> listFile=listFile(num);
			if(listFile!=null) {
				Iterator<GroupNotice> it=listFile.iterator();
				while(it.hasNext()) {
					GroupNotice dto=it.next();
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			// 파일 테이블 내용 지우기
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("field", "num");
			map.put("num", num);
			deleteFile(map);
			
			result=dao.deleteData("groupNotice.deleteNotice", num);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public List<GroupNotice> listFile(int num) {
		List<GroupNotice> listFile=null;
		
		try {
			listFile=dao.getListData("groupNotice.listFile", num);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return listFile;
	}

	@Override
	public GroupNotice readFile(int fileNum) {
		GroupNotice dto=null;
		
		try {
			dto=dao.getReadData("groupNotice.readFile", fileNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public int deleteFile(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.deleteData("groupNotice.deleteFile", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}


}
