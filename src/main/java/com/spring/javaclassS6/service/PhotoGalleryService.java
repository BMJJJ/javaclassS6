package com.spring.javaclassS6.service;

import java.util.ArrayList;

import com.spring.javaclassS6.vo.PhotoGalleryVO;

public interface PhotoGalleryService {

	public ArrayList<PhotoGalleryVO> getPhotoGalleryList(int startIndexNo, int pageSize, String part, String imsiChoice);

	public int setPhotoGalleryInput(PhotoGalleryVO vo);

	public int getLastInsertedPhotoGalleryIdx();

	public void imgCheck(String content);

	public String setThumbnail(String content);


	public void setPhotoGalleryReadNumPlus(int photoIdx);
	  
	public PhotoGalleryVO getPhotoGalleryIdxSearch(int photoIdx);
	  
	public ArrayList<PhotoGalleryVO> getPhotoGalleryReply(int photoIdx);

	public boolean checkIfAlreadyLiked(int idx, String sMid);

	public boolean cancelGood(int idx, String sMid);

	public boolean addGood(int idx, String sMid);





}
