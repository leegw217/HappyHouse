package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.MemberDTO;
import com.ssafy.happyhouse.model.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserMapper mapper;

	@Override
	public List<MemberDTO> userList() {
		return mapper.userList();
	}

	@Override
	public MemberDTO userInfo(String id) {
		return mapper.userInfo(id);
	}

	@Override
	public void userRegister(MemberDTO member) {
		mapper.userRegister(member);
	}

	@Override
	public void userModify(MemberDTO member) {
		mapper.userModify(member);
	}
	
	@Override
	public void providerModify(MemberDTO member) {
		mapper.providerModify(member);
	}

	@Override
	public void userDelete(String id) {
		mapper.userDelete(id);
	}
}
