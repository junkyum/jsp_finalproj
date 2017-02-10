package com.sp.group.gboard;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("gboard.groupBoardService")
public class GroupBoardServiceImpl implements GroupBoardService {

	@Autowired private CommonDAO dao;
	@Autowired private FileManager fileManager;

	@Override
	public int insertGroupBoard(GroupBoard dto, String pathname) {
		int res = 0;
		try {
			int maxNum = dao.getIntValue("gboard.maxNum", dto);
			dto.setBoardNum(maxNum + 1);
			res = dao.insertData("gboard.insertGroupBoard", dto);
			
			if (dto.getUpload() != null && !dto.getUpload().isEmpty()) {
				for (MultipartFile mf : dto.getUpload()) {
					if (mf.isEmpty())
						continue;

					String filename = fileManager.doFileUpload(mf, pathname);
					if (filename != null) {
						dto.setSaveFilename(filename);
						dto.setOriginalFilename(mf.getOriginalFilename());
						long fileSize = mf.getSize();
						dto.setFileSize(fileSize);

						dao.insertData("gboard.insertGroupBoardFile", dto);
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
			res = dao.getIntValue("gboard.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

	@Override
	public List<GroupBoard> listGroupBoard(Map<String, Object> map) {
		List<GroupBoard> list = null;
		try {
			list = dao.getListData("gboard.listGroupBoard", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int updateHitCount(int boardNum) {
		int res = 0;
		try {
			res = dao.updateData("gboard.updateHitCount", boardNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

	@Override
	public GroupBoard readGroupBoard(int boardNum) {
		GroupBoard dto = null;
		try {
			dto = dao.getReadData("gboard.readGroupBoard", boardNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public GroupBoard preReadGroupBoard(Map<String, Object> map) {
		GroupBoard dto = null;
		try {
			dto = dao.getReadData("gboard.preReadGroupBoard", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public GroupBoard nextReadGroupBoard(Map<String, Object> map) {
		GroupBoard dto = null;
		try {
			dto = dao.getReadData("gboard.nextReadGroupBoard", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int updateGroupBoard(GroupBoard dto, String pathname) {
		int res = 0;
		try {
			res = dao.updateData("gboard.updateGroupBoard", dto);
			if (!dto.getUpload().isEmpty()) {
				for (MultipartFile mf : dto.getUpload()) {
					if (mf.isEmpty())
						continue;

					String filename = fileManager.doFileUpload(mf, pathname);
					if (filename != null) {
						dto.setSaveFilename(filename);
						dto.setOriginalFilename(mf.getOriginalFilename());
						long fileSize = mf.getSize();
						dto.setFileSize(fileSize);

						dao.updateData("board.updateGroupBoard", dto);
						
						//dao.updateData("gboard.update", dto);
					}
				}
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

	@Override
	public int deleteGroupBoard(int boardNum, String pathname) {
		int res = 0;

		try {
			
			List<GroupBoard> listFile = listFile(boardNum);
			if (listFile != null) {
				Iterator<GroupBoard> it = listFile.iterator();
				while (it.hasNext()) {
					GroupBoard dto = it.next();
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			// 파일 테이블 내용 지우기
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "boardNum");
			map.put("boardNum", boardNum);
			deleteFile(map);

			dao.deleteData("gboard.deleteGroupBoard", boardNum);
			dao.deleteData("gboard.deleteAllReply", boardNum);
			res=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return res;
	}

	@Override
	public int insertFile(GroupBoard dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<GroupBoard> listFile(int boardNum) {
		List<GroupBoard> list = null;

		try {
			list = dao.getListData("gboard.listFile", boardNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public GroupBoard readFile(int fileNum) {
		GroupBoard dto = null;
		try {
			dto = dao.getReadData("gboard.readFile", fileNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int deleteFile(Map<String, Object> map) {
		int res = 0;
		try {
			res = dao.deleteData("gboard.deleteFile", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

	@Override
	public int dataCountLike(int boardNum) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int dataCountReplyLike(int replyNum) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertReply(GroupBoardReply dto) {
		int res=0;
		try {
			int maxReplyNum=dao.getIntValue("gboard.maxReplyNum", dto);
			dto.setReplyNum(maxReplyNum+1);
			
			res = dao.insertData("gboard.insertReply", dto);
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

	@Override
	public List<GroupBoardReply> listReply(Map<String, Object> map) {
		List<GroupBoardReply> list = null;		
		try {
			list = dao.getListData("gboard.listReply", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int deleteReply(GroupBoardReply dto) {
		int res = 0;
		try {
			res = dao.deleteData("gboard.deleteReply", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

/*	@Override
	public int dataCountReply(int boardNum) {
		int res = 0;
		try {
			res = dao.getIntValue("gboard.ReplyDataCount", boardNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}*/

	@Override
	public int insertBoardLike(GroupBoard dto) {
		int result=0;
		try {
			result = dao.insertData("gboard.insertBoardLike", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<GroupBoardReply> listReplyAnswer(int replyAnswer) {
		List<GroupBoardReply> list=null;
		
		try {
			list=dao.getListData("gboard.listReplyAnswer", replyAnswer);
		} catch (Exception e) {
			System.err.println(e.toString());
		}
		return list;
	}

	@Override
	public int deleteReplyAnswer(GroupBoardReply dto) {
		int result=0;
		try {
			result=dao.deleteData("gboard.deleteReplyAnswer", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}		
		return result;
	}

	@Override
	public int replyGroupCountAnswer(int replyAnswer) {
		int result = 0;
		try {
			result = dao.getReadData("gboard.replyGroupCountAnswer",replyAnswer);
			
		} catch (Exception e) {
			System.out.println(e.toString());		
		}			
		return result;
	}

	@Override
	public Map<String, Object> groupBoardLikeCount(int boardNum) {
		Map<String, Object> map = null;
		try {
			map = dao.getReadData("gboard.groupBoardLikeCount",boardNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return map;
	}

	@Override
	public Map<String, Object> groupReplyCountLike(int replyNum) {
		Map<String, Object> map = null;
		try {
			map=dao.getReadData("gboard.groupReplyCountLike",replyNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return map;
	}

	@Override
	public int insertBoardReplyLike(GroupBoardReply dto) {
		int result=0;
		try {	
			result = dao.insertData("gboard.insertGroupReplyLike", dto);				
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int replyDataCount(int boardNum) {
		int result =0;		
		try {
			
			result=dao.getIntValue("gboard.replyDataCount", boardNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

}
