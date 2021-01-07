package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.Map;

import com.ssafy.happyhouse.model.MemberDTO;

public interface LoginMapper {
	
	public MemberDTO login(Map<String, String> map) throws SQLException;
	
}
