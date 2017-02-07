package com.sp.group;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("group.groupServiceImpl")
public class GroupServiceImpl implements GroupService {
	@Autowired 
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	@Override
	public int insertGroup(Group dto,String path) {
		int result = 0;

		try {
			if(dto.getUpload()!=null && ! dto.getUpload().isEmpty()) {
				// 파일 업로드
				String newFilename=fileManager.doFileUpload(dto.getUpload(), path);
				dto.setProfile(newFilename);
			result = dao.insertData("group.insertGroup", dto);
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public Group readGroup(String groupName){
		Group dto = null;
		try {
			dto = dao.getReadData("group.readGroup",groupName);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int deleteGroup(String groupName) {
		int result = 0;
		try {
			result = dao.deleteData("group.deleteGroup", groupName);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.getIntValue("group.dataCountGroup", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Group> listGroup(Map<String, Object> map) {
		List<Group> list=null;
		try {
			list = dao.getListData("group.listGroup", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int updateGroup(Group dto,String path) {
		int res = 0;
		try {
			if(dto.getUpload()!=null && !dto.getUpload().isEmpty()) {
				String newFilename = fileManager.doFileUpload(dto.getUpload(), path);
		
				if (newFilename != null) {
					// 이전 파일 지우기
					Group vo = readGroup(dto.getGroupName());
					if(vo!=null && vo.getProfile()!=null) {
						fileManager.doFileDelete(vo.getProfile(), path);
					}
					
					dto.setProfile(newFilename);
				}
			}
			res = dao.updateData("group.updateGroup", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

	@Override
	public int insertGroupMember(Group dto) {
		int res = 0;
		try {
			res=dao.insertData("group.insertGroupMember",dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

	@Override
	public int dataCountMember(Map<String, Object> map) {
		int res = 0;
		try {
			res=dao.getIntValue("group.dataCountMember", map);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return res;
	}

	@Override
	public List<Group> listGroupMemer(String groupName) {
		List<Group> list=null;
		try {
			list = dao.getListData("group.listGroupMember", groupName);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int deleteGroupMember(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.deleteData("group.deleteGroupMember", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Group> listMyGroup(String userId) {
		List<Group> list=null;
		try {
			list = dao.getListData("group.listMyGroup", userId);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

}
