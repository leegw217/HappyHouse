package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.QnaDTO;
import com.ssafy.happyhouse.model.mapper.QnaBoardMapper;

@Service
public class QnaBoardServiceImpl implements QnaBoardService {
	
	@Autowired
	private QnaBoardMapper mapper;
	
	@Override
	public List<QnaDTO> listQna() throws Exception {
		return mapper.selectQna();
	}
	@Override
	public QnaDTO getQna(int no) throws Exception {
		return mapper.selectQnaByNo(no);
	}
	@Override
	public void writeQna(QnaDTO qna) throws Exception {
		mapper.insertQna(qna);
	}
	@Override
	public void modifyQna(QnaDTO qna) throws Exception {
		mapper.updateQna(qna);
	}
	@Override
	public void writeComment(QnaDTO qna) throws Exception {
		mapper.updateComment(qna);
	}
	@Override
	public void deleteComment() throws Exception {
		mapper.updateComment(null);
	}
	@Override
	public void deleteQna(int no) throws Exception {
		mapper.deleteQna(no);
	}
}
