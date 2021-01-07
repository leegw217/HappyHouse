package com.ssafy.happyhouse.model.mapper;

import java.util.List;

import com.ssafy.happyhouse.model.QnaDTO;

public interface QnaBoardMapper {

	public List<QnaDTO> selectQna() throws Exception;
	public QnaDTO selectQnaByNo(int no) throws Exception;
	public void insertQna(QnaDTO qna) throws Exception;
	public void updateQna(QnaDTO qna) throws Exception;
	public void updateComment(QnaDTO qna) throws Exception;
	public void deleteQna(int no) throws Exception;
	
}
