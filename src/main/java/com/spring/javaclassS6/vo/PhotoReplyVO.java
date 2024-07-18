package com.spring.javaclassS6.vo;

import lombok.Data;

@Data
public class PhotoReplyVO {
//photoReply.sql
	private int idx;
	private String mid;
	private int replyIdx;
	private String replyMid;
	private String content;
	private int replyPhotoIdx;
	private String prDate;
	
	private int replyCnt;	// 댓글 개수
	
	
}
