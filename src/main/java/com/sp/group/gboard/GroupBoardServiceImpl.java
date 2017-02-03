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
			res = dao.insertData("gboard.insertGorupBoard", dto);
			
			if (dto.getUpload() != null && !dto.getUpload().isEmpty()) {
				for (MultipartFile mf : dto.getUpload()) {
					if (mf.isEmpty())
						continue;

					String filename = fileManager.doFileUpload(mf, pathname);
					insertFile(dto);
					if (filename != null) {
						dto.setSaveFilename(filename);
						dto.setOriginalFilename(mf.getOriginalFilename());
						long gbfileSize = mf.getSize();
						dto.setFileSize(gbfileSize);

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
						long gbfileSize = mf.getSize();
						dto.setFileSize(gbfileSize);

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
			int maxNum=dao.getIntValue("gboard.replyNum", dto);
			dto.setReplyNum(maxNum+1);
			
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
	public int deleteReply(int replyNum, String pathname) {
		int res = 0;
		try {
			res = dao.deleteData("gboard.deleteReply", replyNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

	@Override
	public int dataCountReply(int boardNum) {
		int res = 0;
		try {
			res = dao.getIntValue("gboard.dataCountReply", boardNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

}
