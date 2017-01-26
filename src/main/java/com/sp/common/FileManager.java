package com.sp.common;

import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Calendar;

import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service("fileManager")
public class FileManager {

	// pathname : 파일을 저장할 경로
	// 리턴 : 서버에 저장된 새로운 파일명
	public String doFileUpload(MultipartFile partFile, String pathname) throws Exception {
		String saveFilename = null;

		if(partFile == null || partFile.isEmpty())
			return null;
		
		// 클라이언트가 업로드한 파일의 이름
		String originalFilename=partFile.getOriginalFilename();
		if(originalFilename==null||originalFilename.length()==0)
			return null;
		
		// 확장자
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if(fileExt == null || fileExt.equals(""))
			return null;
		
		// 서버에 저장할 새로운 파일명을 만든다.
		saveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
				         Calendar.getInstance());
		saveFilename += System.nanoTime();
		saveFilename += fileExt;
		
		String fullpathname = pathname + File.separator + saveFilename;
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File f = new File(fullpathname);
		if(!f.getParentFile().exists())
			f.getParentFile().mkdirs();

		partFile.transferTo(f);

		return saveFilename;
	}

	public String doFileUpload(byte[] bytes, String originalFilename, String pathname) throws Exception {
		String saveFilename = null;

		if(bytes == null)
			return null;
		
		// 클라이언트가 업로드한 파일의 이름
		if(originalFilename==null||originalFilename.length()==0)
			return null;
		
		// 확장자
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if(fileExt == null || fileExt.equals(""))
			return null;
		
		// 서버에 저장할 새로운 파일명을 만든다.
		saveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
				         Calendar.getInstance());
		saveFilename += System.nanoTime();
		saveFilename += fileExt;
		
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File dir = new File(pathname);
		if(!dir.exists())
			dir.mkdirs();
		
		String fullpathname = pathname + File.separator + saveFilename;
		
		FileOutputStream fos = new FileOutputStream(fullpathname);
		fos.write(bytes);
		fos.close();
		
		return saveFilename;
	}

	public String doFileUpload(InputStream is, String originalFilename, String pathname) throws Exception {
		String saveFilename = null;

		// 클라이언트가 업로드한 파일의 이름
		if(originalFilename==null||originalFilename.equals(""))
			return null;
		
		// 확장자
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if(fileExt == null || fileExt.equals(""))
			return null;
		
		// 서버에 저장할 새로운 파일명을 만든다.
		saveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
				         Calendar.getInstance());
		saveFilename += System.nanoTime();
		saveFilename += fileExt;
		
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File dir = new File(pathname);
		if(!dir.exists())
			dir.mkdirs();
		
		String fullpathname = pathname + File.separator + saveFilename;
		
		byte[] b=new byte[1024];
		int size=0;
		FileOutputStream fos = new FileOutputStream(fullpathname);
		
		while((size=is.read(b))!=-1) {
			fos.write(b, 0, size);
		}
		
		fos.close();
		is.close();
		
		return saveFilename;
	}
	
	// 파일 다운로드
	// saveFilename : 서버에 저장된 파일명
	// originalFilename : 클라이언트가 업로드한 파일명
	// pathname : 서버에 저장된 경로
	public boolean doFileDownload(String saveFilename, String originalFilename, String pathname, HttpServletResponse response) {
		String fullpathname = pathname + File.separator + saveFilename;
		
        try {
    		if(originalFilename == null || originalFilename.equals(""))
    			originalFilename = saveFilename;
        	originalFilename = new String(originalFilename.getBytes("euc-kr"),"8859_1");
        } catch (UnsupportedEncodingException e) {
        }

	    try {
	        File file = new File(fullpathname);

	        if (file.exists()){
	            byte readByte[] = new byte[4096];

	            response.setContentType("application/octet-stream");
				response.setHeader(
						"Content-disposition",
						"attachment;filename=" + originalFilename);

	            BufferedInputStream  fin  = new BufferedInputStream(new FileInputStream(file));
	            //javax.servlet.ServletOutputStream outs =	response.getOutputStream();
	            OutputStream outs = response.getOutputStream();
	            
	   			int read;
	    		while ((read = fin.read(readByte, 0, 4096)) != -1)
	    				outs.write(readByte, 0, read);
	    		outs.flush();
	    		outs.close();
	            fin.close();
	            
	            return true;
	        }
	    } catch(Exception e) {
	    }
	    
	    return false;
	}
	
	// 실제 파일 삭제
	public void doFileDelete(String filename, String pathname) 
	        throws Exception {
		String fullpathname = pathname + File.separator + filename;
		File file = new File(fullpathname);
        if (file.exists())
           file.delete();
	}
	
	// 파일 또는 폴더 및 하위 폴더 삭제
	public void removePathname(String pathname) {
		try {
			File f=new File(pathname);
			if (! f.exists())
				return;
			
			if(f.isDirectory())
				removeSubDirectory(pathname);
			
			f.delete();
		} catch (Exception e) {
		}
	}
	private void removeSubDirectory(String pathname) {
		File[] listFile = new File(pathname).listFiles();
		try {
			if (listFile.length > 0) {
				for (int i = 0; i < listFile.length; i++) {
					if (listFile[i].isDirectory()) {
						removeSubDirectory(listFile[i].getPath());
					}
					listFile[i].delete();
				}
			}
		} catch (Exception e) {
		}
	}

	// 파일 길이
	public long getFilesize(String pathname) {
		long size=-1;
		
		File file = new File(pathname);
		if (! file.exists())
			return size;
		
		size=file.length();
		
		return size;
	}
	
	// 파일 타입
	public String getFiletype(String pathname) {
		String type="";
		try {
			URL u = new URL("file:"+pathname);
		    URLConnection uc = u.openConnection();
		    type = uc.getContentType();
		} catch (Exception e) {
		}
		
	    return type;
	}
	
	// 이미지 폭
	public int getImageWidth(String pathname) {
		int width=-1;
		
		File file = new File(pathname);
		if (! file.exists())
			return width;
		
		ParameterBlock pb=new ParameterBlock(); 
        pb.add(pathname); 
        RenderedOp rOp=JAI.create("fileload",pb); 

        BufferedImage bi=rOp.getAsBufferedImage(); 

        width = bi.getWidth(); 		
		
		return width;
	}
	
	// 이미지 높이
	public int getImageHeight(String pathname) {
		int height=-1;
		
		File file = new File(pathname);
		if (! file.exists())
			return height;
		
		ParameterBlock pb=new ParameterBlock(); 
        pb.add(pathname); 
        RenderedOp rOp=JAI.create("fileload",pb); 

        BufferedImage bi=rOp.getAsBufferedImage(); 

        height = bi.getHeight();		
		
		return height;
	}

}
