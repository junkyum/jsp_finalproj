package com.sp.group.gally;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;


@Service("group.photoService")
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
	public GroupGally readPhoto(int gallyNum) {
		GroupGally dto=null;
		
		try {
			dto=dao.getReadData("groupGally.readPhoto", gallyNum);
		} catch (Exception e) {
			System.err.println(e.toString());
		}
		
		return dto;
	}
	@Override
	public int updatePhoto(GroupGally dto, String path) {
	int result =0;
		
		try {
			
			if(dto.getUpload() !=null && !dto.getUpload().isEmpty()){
				String newFilename= fileManager.doFileUpload(dto.getUpload(), path);
				
				if(newFilename != null){
					//이전 파일 지우기.
					GroupGally vo =readPhoto(dto.getGallyNum());
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
	@Override
	public int deletePhoto(int gallyNum, String imageFilename, String path) {
			int result=0;
					
		try {
			if(imageFilename!=null)
								fileManager.doFileDelete(imageFilename, path);
						
						//게시물 지우기
				result=dao.deleteData("groupGally.deletePhoto", gallyNum);
			} catch (Exception e) {
						System.err.println(e.toString());
		}
			
		return result;
	}
	

	@Override
	public int insertGReply(ReplyGPhoto dto) {
		int result=0;
		
		try {
			result=dao.insertData("groupGally.insertGReply", dto);
		} catch (Exception e) {
			System.err.println(e.toString());
		}
		
		return result;
	}
	@Override
	public int GReplyDataCount(int gallyNum) {
			int result =0;
		
		try {
			
			result=dao.getIntValue("groupGally.GReplyDataCount", gallyNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	@Override
	public List<ReplyGPhoto> listGReply(Map<String, Object> map) {
		List<ReplyGPhoto> list=null;
		
		try {
			list=dao.getListData("groupGally.listGReply", map);
		} catch (Exception e) {
			System.err.println(e.toString());
		}
		
		return list;
	}
	@Override
	public int deleteReply(ReplyGPhoto dto) {
		int result =0;
		try {
			result=dao.deleteData("groupGally.deleteReply", dto);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
	return result;
	}
	
	
	@Override
	public List<ReplyGPhoto> listReplyAnswer(int replyAnswer) {
		List<ReplyGPhoto> list=null;
		
		try {
			list=dao.getListData("groupGally.listReplyAnswer", replyAnswer);
		} catch (Exception e) {
			System.err.println(e.toString());
		}
		return list;
	}
	@Override
	public int deleteReplyAnswer(ReplyGPhoto dto) {
		
		int result=0;
		try {
			result=dao.deleteData("groupGally.deleteReplyAnswer", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	@Override
	public int replyGroupCountAnswer(int replyAnswer) {
		int result = 0;
		try {
			result = dao.getReadData("groupGally.replyGroupCountAnswer",replyAnswer);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		
		}
			
		return result;
	}
	
	
	@Override
	public int insertGallyReplyLike(ReplyGPhoto dto) {
		int result=0;
		try {
	
			result = dao.insertData("groupGally.insertGroupReplyLike", dto);
				
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	@Override
	public Map<String, Object> groupGeplyCountLike(int replyNum) {
		
		Map<String, Object> map = null;
		try {
			map=dao.getReadData("groupGally.groupGeplyCountLike",replyNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return map;
	}
	
	
	


	
}
