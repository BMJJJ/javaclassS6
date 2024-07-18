package com.spring.javaclassS6.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaclassS6.common.JavaclassProvide;
import com.spring.javaclassS6.dao.PhotoGalleryDAO;
import com.spring.javaclassS6.vo.PhotoGalleryVO;

import net.coobird.thumbnailator.Thumbnailator;

@Service
public class PhotoGalleryServiceImpl implements PhotoGalleryService {

	@Autowired
	PhotoGalleryDAO photoGalleryDAO;

	@Autowired
	JavaclassProvide javaclassProvide;

	
	@Override
	public ArrayList<PhotoGalleryVO> getPhotoGalleryList(int startIndexNo, int pageSize, String part, String imsiChoice) {
		return photoGalleryDAO.getPhotoGalleryList(startIndexNo, pageSize, part, imsiChoice);
	}

	@Override
	public int setPhotoGalleryInput(PhotoGalleryVO vo) {
		return photoGalleryDAO.setPhotoGalleryInput(vo);
	}

	@Override
	public int getLastInsertedPhotoGalleryIdx() {
		return photoGalleryDAO.getLastInsertedPhotoGalleryIdx();
	}

	@Override
	public void imgCheck(String content) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 31;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "photoGallery/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 board폴더위치로 복사처리하는 메소드.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	// 파일 복사처리
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] b = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(b)) != -1) {
				fos.write(b, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public String setThumbnail(String content) {
		String res = "";
		try {
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
			// 썸네일 파일이 저장될 경로설정
			File realFileName = new File(realPath + content);
			
			// 썸메일 이미지 생성 저장하기
			realPath = request.getSession().getServletContext().getRealPath("/resources/data/thumbnail/");
			String thumbnailSaveName = "s_" + content;
			File thumbnailFile = new File(realPath + thumbnailSaveName);
			
			int width = 270;
			int height = 200;
			Thumbnailator.createThumbnail(realFileName, thumbnailFile, width, height);
			
			res = thumbnailSaveName;
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	  @Override public void setPhotoGalleryReadNumPlus(int photoIdx) {
	  photoGalleryDAO.incrementReadCount(photoIdx); }
	  
	  @Override public PhotoGalleryVO getPhotoGalleryIdxSearch(int photoIdx) {
		  PhotoGalleryVO vo = photoGalleryDAO.getPhotoGalleryById(photoIdx); 
		  return vo; 
	  }
	  
	  @Override public ArrayList<PhotoGalleryVO> getPhotoGalleryReply(int photoIdx)
	  { return photoGalleryDAO.getPhotoGalleryReplies(photoIdx); }

		@Override
		public boolean checkIfAlreadyLiked(int idx, String sMid) {
			return photoGalleryDAO.checkIfAlreadyLiked(idx,sMid);
		}

		@Override
		public boolean cancelGood(int idx, String sMid) {
			return photoGalleryDAO.cancelGood(idx,sMid);
		}

		@Override
		public boolean addGood(int idx, String sMid) {
			return photoGalleryDAO.addGood(idx,sMid);
		}

	 




}
