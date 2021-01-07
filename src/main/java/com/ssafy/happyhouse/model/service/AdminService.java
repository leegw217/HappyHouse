package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.MemberDTO;

public interface AdminService {

	public List<MemberDTO> userList();
	public void userModify(MemberDTO memberDto);
	
	
}
