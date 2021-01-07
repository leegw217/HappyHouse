package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.HouseDTO;
import com.ssafy.happyhouse.model.InterestDTO;
import com.ssafy.util.PageNavigation;

public interface InterestService {

	List<InterestDTO> listInterest(String id) throws Exception;

	int writeInterest(InterestDTO interest) throws Exception;

	int deleteInterest(InterestDTO interest) throws Exception;

	int countInterest(String id) throws Exception;
	
	List<HouseDTO> listHouseByDong(String dongName) throws Exception;
	
	int countHouseByFacility(String dongName, String facility) throws Exception;
	
	PageNavigation makePageNavigation(int pg, int size) throws Exception;

	List<String> listDongWithoutInterest(List<String> dongList) throws Exception;
}