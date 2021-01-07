package com.ssafy.happyhouse.model.service;

import java.util.Map;

import com.ssafy.happyhouse.model.MemberDTO;

public interface LoginService {

	MemberDTO login(Map<String, String> map) throws Exception;

}