package com.sp.tphoto;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;


@Service("tphoto.photoServiceImpl")
public class PhotoServiceImpl implements PhotoService{

	@Autowired
	private CommonDAO dao;
	
	
	
	@Autowired
	private FileManager filemanager;
	
	
	
	@Override
	public int insertPhoto(Photo dto, String path) {

		int result=0;
		try {
			
			if(dto.getUpload()!=null && !dto.getUpload().isEmpty()){
				
				String newFilename= filemanager.doFileUpload(dto.getUpload(), path);
				dto.setImageFilename(newFilename);
				
				result=dao.insertData("tphoto.insertPhoto", dto);
					
			}
			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		
		int result=0;
		try {
			
			result= dao.getIntValue("tphoto.dataCount",map);
			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Photo> listPhoto(Map<String, Object> map) {

		List<Photo> list= null;
		
		try {
			list= dao.getListData("tphoto.listPhoto",map);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	@Override
	public int updatePhoto(Photo dto, String path) {

			int result= 0;
			try {
				if(dto.getUpload()!=null && !dto.getUpload().isEmpty()){
					String newFilename =filemanager.doFileUpload(dto.getUpload(), path);
					
					
					if(newFilename !=null){
					Photo po = readPhoto(dto.getNum());
					if(po!=null && po.getImageFilename()!=null){
						filemanager.doFileDelete(newFilename, path);
					}
					dto.setImageFilename(newFilename);
				}
				}
				result = dao.updateData("tphoto.updatePhoto", dto);
				
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		return result;
	}

	@Override
	public int deletePhoto(int num, String imageFilename, String path) {
		int result=0;
		try {
			if(imageFilename!=null)
				filemanager.doFileDelete(imageFilename, path);
			
		result= dao.deleteData("tphoto.deletePhoto", num);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public Photo readPhoto(int num) {

		Photo dto = null;
		
		try {
			
			dto= dao.getReadData("tphoto.readPhoto",num);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public Photo preReadPhoto(Map<String, Object> map) {
		
		Photo dto = null;
		try {
			dto = dao.getReadData("tphoto.preReadPhoto",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public Photo nextReadPhoto(Map<String, Object> map) {
		
		
		System.out.println(map);
		
		Photo dto = null;
		try {
			dto = dao.getReadData("tphoto.nextReadPhoto",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int deletePhotoId(String userId, String root) {
		
		
		return 0;
	}

	@Override
	public int insertReply(Reply dto) {
		int result = 0;
		try {
			
			result = dao.insertData("tphoto.insertReply", dto);
		} catch (Exception e) {
	
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		try {
			list = dao.getListData("tphoto.listReply", map);
		} catch (Exception e) {

			System.out.println(e.toString());
		}
		
		return list;
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {

		List<Reply> list = null;
		try {
			list= dao.getListData("tphoto.listReplyAnswer",answer);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int deleteReply(Map<String, Object> map) {

		int result=0;
		try {
			result= dao.deleteData("tphoto.deleteReply", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int insertReplyLike(Reply dto) {
		int result=0;
		try {
	
			result = dao.insertData("tphoto.insertReplyLike", dto);
				
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public Map<String, Object> replyCountLike(int replyNum) {

		Map<String, Object> map = null;
		try {
			map=dao.getReadData("tphoto.replyCountLike",replyNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return map;
	}

	@Override
	public int insertPhotoLike(Photo dto) {
		int result=0;
		try {
			result = dao.insertData("tphoto.insertPhotoLike", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public Map<String, Object> countLike(int num) {
		Map<String, Object> map = null;
		try {
			map = dao.getReadData("tphoto.countLike",num);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return map;
	}

	@Override
	public int replyCountAnswer(int answer) {
		int result = 0;
		try {
			result = dao.getReadData("tphoto.replyCountAnswer",answer);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		
		}
			
		return result;
	}

	@Override
	public int replyDataCount(Map<String, Object> map) {

		int result = 0;
		
		try {
			result = dao.getIntValue("tphoto.replyDataCount",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int updateHitCount(int num) {

		int result= 0;
		try {
			result=dao.getIntValue("tphoto.updateHitCount",num);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

}
