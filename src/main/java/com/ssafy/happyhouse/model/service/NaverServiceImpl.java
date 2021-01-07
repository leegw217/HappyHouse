package com.ssafy.happyhouse.model.service;

import java.math.BigInteger;
import java.security.SecureRandom;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.happyhouse.model.NaverProfile;
import com.ssafy.happyhouse.model.NaverToken;

@Service
public class NaverServiceImpl implements NaverService {
	
	@Override
	public NaverToken getToken(String code) throws Exception {
		RestTemplate rt = new RestTemplate();
		SecureRandom random = new SecureRandom();
	    String status = new BigInteger(130, random).toString(32);
	    HttpHeaders headers = new HttpHeaders();
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("client_id", "MPvkgO4ohChxb_eiLLvU");
		params.add("client_secret", "hDNrIXK91f");
		params.add("grant_type", "authorization_code");
		params.add("status", status);
		params.add("code", code);
		HttpEntity<MultiValueMap<String, String>> naverTokenRequest = new HttpEntity<>(params, headers);
		ResponseEntity<String> response = rt.exchange(
			"https://nid.naver.com/oauth2.0/token",
			HttpMethod.POST,
			naverTokenRequest,
			String.class
		);
		ObjectMapper objectMapper = new ObjectMapper();
		return objectMapper.readValue(response.getBody(), NaverToken.class);
	}
	
	@Override
	public NaverProfile getProfile(NaverToken naverToken) throws Exception {
		RestTemplate rt = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer "+naverToken.getAccess_token());
		HttpEntity<MultiValueMap<String, String>> naverProfileRequest = new HttpEntity<>(headers);
		ResponseEntity<String> response = rt.exchange(
			"https://openapi.naver.com/v1/nid/me",
			HttpMethod.POST,
			naverProfileRequest,
			String.class
		);
		ObjectMapper objectMapper = new ObjectMapper();
		return objectMapper.readValue(response.getBody(), NaverProfile.class);
	}
	
	@Override
	public NaverToken refreshToken(String token) throws Exception {
		RestTemplate rt = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("client_id", "MPvkgO4ohChxb_eiLLvU");
		params.add("client_secret", "hDNrIXK91f");
		params.add("grant_type", "refresh_token");
		params.add("refresh_token", token);
		HttpEntity<MultiValueMap<String, String>> naverTokenRequest = new HttpEntity<>(params, headers);
		ResponseEntity<String> response = rt.exchange(
			"https://nid.naver.com/oauth2.0/token",
			HttpMethod.POST,
			naverTokenRequest,
			String.class
		);
		ObjectMapper objectMapper = new ObjectMapper();
		return objectMapper.readValue(response.getBody(), NaverToken.class);
	}
	
	@Override
	public String deleteToken(String token) throws Exception {
		RestTemplate rt = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("client_id", "MPvkgO4ohChxb_eiLLvU");
		params.add("client_secret", "hDNrIXK91f");
		params.add("grant_type", "delete");
		params.add("access_token", token);
		params.add("service_provider", "NAVER");
		HttpEntity<MultiValueMap<String, String>> naverTokenRequest = new HttpEntity<>(params, headers);
		ResponseEntity<String> response = rt.exchange(
			"https://nid.naver.com/oauth2.0/token",
			HttpMethod.POST,
			naverTokenRequest,
			String.class
		);
		if(response.getBody().indexOf("success") > 0) return "success";
		else return "fail";
	}
}
