package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.HouseDTO;
import com.ssafy.happyhouse.model.HouseDealDTO;
import com.ssafy.happyhouse.model.HouseInfoDTO;
import com.ssafy.happyhouse.model.LikeListDTO;

public interface HouseMapper {

	public List<HouseDTO> selectHouse(Map<String, Object> map) throws SQLException;
	public HouseInfoDTO selectHouseByName(String name) throws SQLException;
	public int selectTotalCount(Map<String, String> map) throws SQLException;
	public List<HouseDTO> selectHouseJson(Map<String, Object> map) throws SQLException;
	public HouseDealDTO getApt(String apt) throws SQLException;
	
}
