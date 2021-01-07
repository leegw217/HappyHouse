package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.MemberDTO;
import com.ssafy.happyhouse.model.mapper.AdminMapper;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminMapper mapper;
	
	@Override
	public List<MemberDTO> userList() {
		return mapper.userList();
	}

	@Override
	public void userModify(MemberDTO memberDto) {
		mapper.userModify(memberDto);
	}

}
