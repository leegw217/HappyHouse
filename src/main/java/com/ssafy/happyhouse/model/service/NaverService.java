package com.ssafy.happyhouse.model.service;

import com.ssafy.happyhouse.model.NaverProfile;
import com.ssafy.happyhouse.model.NaverToken;

public interface NaverService {

	NaverToken getToken(String code) throws Exception;

	NaverProfile getProfile(NaverToken naverToken) throws Exception;

	NaverToken refreshToken(String token) throws Exception;
	
	String deleteToken(String token) throws Exception;
	
}