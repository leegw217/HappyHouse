package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.NoticeDTO;
import com.ssafy.happyhouse.model.mapper.NoticeMapper;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeMapper mapper;
	
	@Override
	public List<NoticeDTO> listNotice() throws Exception {
		return mapper.selectNotice();
	}
	
	@Override
	public NoticeDTO getNotice(int no) throws Exception {
		return mapper.selectNoticeByNo(no);
	}

	@Override
	public void writeNotice(NoticeDTO noticeDTO) throws Exception {
		mapper.insertNotice(noticeDTO);
	}

	@Override
	public void deleteNotice(int no) throws Exception {
		mapper.deleteNotice(no);
	}

	@Override
	public void modifyNotice(NoticeDTO noticeDTO) throws Exception {
		mapper.updateNotice(noticeDTO);
	}
}
