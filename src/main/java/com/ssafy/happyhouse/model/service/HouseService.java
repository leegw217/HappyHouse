package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.HouseDTO;
import com.ssafy.happyhouse.model.HouseDealDTO;
import com.ssafy.happyhouse.model.HouseInfoDTO;
import com.ssafy.happyhouse.model.LikeListDTO;
import com.ssafy.util.PageNavigation;

public interface HouseService {

	public List<HouseDTO> listHouse(Map<String, String> map) throws Exception;
	public PageNavigation makePageNavigation(Map<String, String> map) throws Exception;
	public HouseInfoDTO getHouse(String name) throws Exception;
	public List<HouseDTO> listHouseJson(Map<String, String> map) throws Exception;
	public HouseDealDTO getApt(String apt) throws Exception;
	
}
