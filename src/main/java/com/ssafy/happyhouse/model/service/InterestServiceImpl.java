package com.ssafy.happyhouse.model.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.HouseDTO;
import com.ssafy.happyhouse.model.InterestDTO;
import com.ssafy.happyhouse.model.mapper.InterestMapper;
import com.ssafy.util.PageNavigation;

@Service
public class InterestServiceImpl implements InterestService {
	
	@Autowired
	private InterestMapper mapper; 
	
	@Override
	public List<InterestDTO> listInterest(String id) throws Exception {
		return mapper.selectInterest(id);
	}
	
	@Override
	public int writeInterest(InterestDTO interest) throws Exception {
		return mapper.insertInterest(interest);
	}
	
	@Override
	public int deleteInterest(InterestDTO interest) throws Exception {
		return mapper.deleteInterest(interest);
	}
	
	@Override
	public int countInterest(String id) throws Exception {
		return mapper.countInterest(id);
	}
	
	@Override
	public List<HouseDTO> listHouseByDong(String dongName) throws Exception {
		return mapper.selectHouseByDongName(dongName);
	}
	
	@Override
	public int countHouseByFacility(String dongName, String facility) throws Exception {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("dongName", dongName);
		map.put("facility", facility);
		return mapper.countHouseByFacility(map);
	}
	
	@Override
	public List<String> listDongWithoutInterest(List<String> dongList) throws Exception {
		return mapper.selectDongWithoutInterest(dongList);
	}
	
	@Override
	public PageNavigation makePageNavigation(int pg, int size) throws Exception {
		int naviSize = 7;
		int currentPage = pg;
		//int sizePerPage = 6;
		PageNavigation pageNavigation = new PageNavigation();
		pageNavigation.setCurrentPage(currentPage);
		pageNavigation.setNaviSize(naviSize);
		int totalCount = size;
		pageNavigation.setTotalCount(totalCount);
		int totalPageCount = (totalCount - 1) / naviSize + 1;
		pageNavigation.setTotalPageCount(totalPageCount);
		boolean startRange = currentPage <= naviSize;
		pageNavigation.setStartRange(startRange);
		boolean endRange = (totalPageCount - 1) / naviSize * naviSize < currentPage;
		pageNavigation.setEndRange(endRange);
		pageNavigation.makeNavigator();
		return pageNavigation;
	}
}
