package com.ssafy.happyhouse.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.MemberDTO;
import com.ssafy.happyhouse.model.mapper.LoginMapper;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	private LoginMapper mapper;
	
	@Override
	public MemberDTO login(Map<String, String> map) throws Exception {
		if(map.get("id") == null || map.get("pw") == null)
			return null;
		return mapper.login(map);
	}
	
}
