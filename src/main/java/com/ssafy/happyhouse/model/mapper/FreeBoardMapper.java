package com.ssafy.happyhouse.model.mapper;

import java.util.List;

import com.ssafy.happyhouse.model.FreeCommentDTO;
import com.ssafy.happyhouse.model.FreeDTO;

public interface FreeBoardMapper {
	
	// 게시판
	List<FreeDTO> selectFreeBoard() throws Exception;
	FreeDTO selectFreeBoardByNo(int no) throws Exception;
	void insertFreeBoard(FreeDTO free) throws Exception;
	void updateFreeBoard(FreeDTO free) throws Exception;
	void deleteFreeBoard(int no) throws Exception;
	// 댓글
	int countComment(int bno) throws Exception;
	List<FreeCommentDTO> selectComment(int bno) throws Exception;
	int insertComment(FreeCommentDTO comment) throws Exception;
	int updateComment(FreeCommentDTO comment) throws Exception;
	int deleteComment(int no) throws Exception;
	
}
