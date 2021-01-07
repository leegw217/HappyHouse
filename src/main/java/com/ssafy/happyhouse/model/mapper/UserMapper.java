package com.ssafy.happyhouse.model.mapper;

import java.util.List;

import com.ssafy.happyhouse.model.MemberDTO;

public interface UserMapper {

	public List<MemberDTO> userList();
	public MemberDTO userInfo(String id);
	public void userRegister(MemberDTO member);
	public void userModify(MemberDTO member);
	public void providerModify(MemberDTO member);
	public void userDelete(String id);
	
}
