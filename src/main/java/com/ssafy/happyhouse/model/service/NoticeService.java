package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.NoticeDTO;

public interface NoticeService {

	List<NoticeDTO> listNotice() throws Exception;

	NoticeDTO getNotice(int no) throws Exception;

	void writeNotice(NoticeDTO noticeDTO) throws Exception;

	void deleteNotice(int no) throws Exception;

	void modifyNotice(NoticeDTO noticeDTO) throws Exception;

}