package com.sp.group.gally;

import java.util.List;
import java.util.Map;

public interface PhotoService {
	
	public int insertPhoto(GroupGally dto, String path);
	public int dataCount(Map<String, Object> map);
	public List<GroupGally> listPhoto(Map<String, Object> map);
	public GroupGally readPhoto(int groupNum);
	public int updatePhoto(GroupGally dto, String path);
	public int deletePhoto(int groupNum, String imageFilename, String path);
}
