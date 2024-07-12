package com.spring.javaclassS6.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS6.vo.BoardReply2VO;
import com.spring.javaclassS6.vo.BoardVO;

public interface BoardDAO {
	
	public ArrayList<BoardVO> getBoardList();

	public int setBoardInput(@Param("vo") BoardVO vo);

	public BoardVO getBoardContent(@Param("idx") int idx);

	public int totRecCnt(@Param("part") String part);

	public ArrayList<BoardVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	public void setReadNumPlus(@Param("idx") int idx);

	public BoardVO getPreNextSearch(@Param("idx") int idx,@Param("str") String str);

	public int setBoardUpdate(@Param("vo") BoardVO vo);

	public int setBoardDelete(@Param("idx") int idx);

	public BoardReply2VO getBoardParentReplyCheck(@Param("boardIdx") int boardIdx);

	public int setBoardReplyInput(@Param("replyVO") BoardReply2VO replyVO);

	public List<BoardReply2VO> getBoardReply(@Param("idx") int idx);

	public void setReplyOrderUpdate(@Param("boardIdx") int boardIdx,@Param("re_order") int re_order);

	public int totRecCntSearch(@Param("search") String search,@Param("searchString") String searchString);

	public List<BoardVO> getBoardSearchList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);
}

