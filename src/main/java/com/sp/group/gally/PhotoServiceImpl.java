package com.sp.group.gally;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("Gphoto.photoServiceImpl")
public class PhotoServiceImpl implements PhotoService{

	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	
	@Override
	public int insertPhoto(GroupGally dto, String path) {
		int result=0;
		
		try {
			if(dto.getUpload()!=null && !dto.getUpload().isEmpty()){
				//파일 업로드 할것이바
				String newFilename= fileManager.doFileUpload(dto.getUpload(), path);
				dto.setImageFilename(newFilename);
				
				result=dao.insertData("groupGally.insertPhoto", dto);
			}
			
			
		} catch (Exception e) {
			System.err.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
			try {
				result=dao.getIntValue("groupGally.dataCount",map);
			} catch (Exception e) {
				System.err.println(e.toString());
			}
		return result;
	}

	@Override
	public List<GroupGally> listPhoto(Map<String, Object> map) {
		List<GroupGally> list= null;
		try {
			list=dao.getListData("groupGally.listPhoto", map);
		} catch (Exception e) {
			System.err.println(e.toString());
		}
		return list;
	}

	@Override
	public GroupGally readPhoto(int groupNum) {
		GroupGally dto=null;
		
		try {
			dto=dao.getReadData("groupGally.readPhoto", groupNum);
		} catch (Exception e) {
			System.err.println(e.toString());
		}
		
		return dto;
	}


	@Override
	public int deletePhoto(int groupNum, String imageFilename, String path) {
		int result=0;
		
		try {
			if(imageFilename!=null)
					fileManager.doFileDelete(imageFilename, path);
			
			//게시물 지우기
			result=dao.deleteData("groupGally.deletePhoto", groupNum);
		} catch (Exception e) {
			System.err.println(e.toString());
		}

		return result;
	}
	
	

	//삭제?
	@Override
	public int updatePhoto(GroupGally dto, String path) {
		int result =0;
		
		try {
			
			if(dto.getUpload() !=null && !dto.getUpload().isEmpty()){
				String newFilename= fileManager.doFileUpload(dto.getUpload(), path);
				
				if(newFilename != null){
					//이전 파일 지우기.
					GroupGally vo =readPhoto(dto.getGroupNum());
					if(vo != null && vo.getImageFilename()!= null){
							fileManager.doFileDelete(vo.getImageFilename(),path);
					}
					dto.setImageFilename(newFilename);
				}
			}
				
			result= dao.updateData("groupGally.updatePhoto", dto);
			
		} catch (Exception e) {
			System.err.println(e.toString());
		}
		
		
		return result;
	}
	
}
