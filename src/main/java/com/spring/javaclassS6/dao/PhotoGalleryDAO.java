package com.spring.javaclassS6.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS6.vo.PhotoGalleryVO;

public interface PhotoGalleryDAO {


	public ArrayList<PhotoGalleryVO> getPhotoGalleryList(@Param("startIndexNo") int startIndexNo, 
      @Param("pageSize") int pageSize, 
      @Param("part") String part, 
      @Param("choice") String choice);

	public int setPhotoGalleryInput(@Param("vo") PhotoGalleryVO vo);

	public int getLastInsertedPhotoGalleryIdx();

	public PhotoGalleryVO getPhotoGalleryIdxSearch(@Param("photoIdx") int photoIdx);

	public ArrayList<PhotoGalleryVO> getPhotoGalleryReply(@Param("photoIdx") int photoIdx);

	public void incrementReadCount(@Param("photoIdx") int photoIdx);

	public PhotoGalleryVO getPhotoGalleryById(@Param("photoIdx") int photoIdx);

	public ArrayList<PhotoGalleryVO> getPhotoGalleryReplies(@Param("photoIdx") int photoIdx);

	public boolean checkIfAlreadyLiked(@Param("idx") int idx,@Param("sMid") String sMid);

	public boolean cancelGood(@Param("idx") int idx,@Param("sMid") String sMid);

	public boolean addGood(@Param("idx")int idx,@Param("sMid") String sMid);

}
