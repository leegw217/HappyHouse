package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.FreeCommentDTO;
import com.ssafy.happyhouse.model.FreeDTO;

public interface FreeBoardService {
	// 게시판
	List<FreeDTO> listFreeBoard() throws Exception;
	FreeDTO getFreeBoard(int no) throws Exception;
	void writeFreeBoard(FreeDTO free) throws Exception;
	void modifyFreeBoard(FreeDTO free) throws Exception;
	void deleteFreeBoard(int no) throws Exception;
	
	// 댓글
	int countComment(int bno) throws Exception;
	List<FreeCommentDTO> listComment(int bno) throws Exception;
	int writeComment(FreeCommentDTO comment) throws Exception;
	int modifyComment(FreeCommentDTO comment) throws Exception;
	int deleteComment(int no) throws Exception;
	
}