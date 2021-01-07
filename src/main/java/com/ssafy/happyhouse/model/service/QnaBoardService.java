package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.QnaDTO;

public interface QnaBoardService {

	List<QnaDTO> listQna() throws Exception;

	QnaDTO getQna(int no) throws Exception;

	void writeQna(QnaDTO qna) throws Exception;

	void modifyQna(QnaDTO qna) throws Exception;

	void writeComment(QnaDTO qna) throws Exception;

	void deleteComment() throws Exception;

	void deleteQna(int no) throws Exception;

}