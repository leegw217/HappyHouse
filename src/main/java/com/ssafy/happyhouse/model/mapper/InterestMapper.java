package com.ssafy.happyhouse.model.mapper;

import java.util.HashMap;
import java.util.List;

import com.ssafy.happyhouse.model.HouseDTO;
import com.ssafy.happyhouse.model.InterestDTO;

public interface InterestMapper {

		List<InterestDTO> selectInterest(String id) throws Exception;
		
		int insertInterest(InterestDTO interest) throws Exception;
		
		int deleteInterest(InterestDTO interest) throws Exception;
		
		int countInterest(String id) throws Exception;
		
		List<HouseDTO> selectHouseByDongName(String dongName) throws Exception;
		
		int countHouseByFacility(HashMap<String, String> map) throws Exception;
		
		List<String> selectDongWithoutInterest(List<String> dongList) throws Exception;
}
