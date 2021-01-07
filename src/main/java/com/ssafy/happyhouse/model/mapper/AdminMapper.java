package com.ssafy.happyhouse.model.mapper;

import java.util.List;

import com.ssafy.happyhouse.model.MemberDTO;

public interface AdminMapper {

	public List<MemberDTO> userList();
	public void userModify(MemberDTO memberDto);
	
}
