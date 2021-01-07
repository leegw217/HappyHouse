package com.ssafy.happyhouse.model.mapper;

import java.util.List;

import com.ssafy.happyhouse.model.NoticeDTO;

public interface NoticeMapper {
	
	List<NoticeDTO> selectNotice() throws Exception;
	NoticeDTO selectNoticeByNo(int no) throws Exception;
	void insertNotice(NoticeDTO notice) throws Exception;
	void updateNotice(NoticeDTO notice) throws Exception;
	void deleteNotice(int no) throws Exception;
	
}
