package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.FreeCommentDTO;
import com.ssafy.happyhouse.model.FreeDTO;
import com.ssafy.happyhouse.model.mapper.FreeBoardMapper;

@Service
public class FreeBoardServiceImpl implements FreeBoardService {
	
	@Autowired
	private FreeBoardMapper mapper;
	// 게시판
	@Override
	public List<FreeDTO> listFreeBoard() throws Exception {
		return mapper.selectFreeBoard();
	}
	@Override
	public FreeDTO getFreeBoard(int no) throws Exception {
		return mapper.selectFreeBoardByNo(no);
	}
	@Override
	public void writeFreeBoard(FreeDTO free) throws Exception {
		mapper.insertFreeBoard(free);
	}
	@Override
	public void modifyFreeBoard(FreeDTO free) throws Exception {
		mapper.updateFreeBoard(free);
	}
	@Override
	public void deleteFreeBoard(int no) throws Exception {
		mapper.deleteFreeBoard(no);
	}
	
	// 댓글
	@Override
	public int countComment(int bno) throws Exception {
		return mapper.countComment(bno);
	}
	@Override
	public List<FreeCommentDTO> listComment(int bno) throws Exception {
		return mapper.selectComment(bno);
	}
	@Override
	public int writeComment(FreeCommentDTO comment) throws Exception {
		return mapper.insertComment(comment);
	}
	@Override
	public int modifyComment(FreeCommentDTO comment) throws Exception {
		return mapper.updateComment(comment);
	}
	@Override
	public int deleteComment(int no) throws Exception {
		return mapper.deleteComment(no);
	}
}
