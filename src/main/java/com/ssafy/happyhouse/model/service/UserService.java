package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.MemberDTO;

public interface UserService {

	List<MemberDTO> userList();

	MemberDTO userInfo(String id);

	void userRegister(MemberDTO member);

	void userModify(MemberDTO member);

	void providerModify(MemberDTO member);
	
	void userDelete(String id);

}