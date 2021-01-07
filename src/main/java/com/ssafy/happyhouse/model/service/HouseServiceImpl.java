package com.ssafy.happyhouse.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.HouseDTO;
import com.ssafy.happyhouse.model.HouseDealDTO;
import com.ssafy.happyhouse.model.HouseInfoDTO;
import com.ssafy.happyhouse.model.LikeListDTO;
import com.ssafy.happyhouse.model.mapper.HouseMapper;
import com.ssafy.util.PageNavigation;

@Service
public class HouseServiceImpl implements HouseService {

	@Autowired
	private HouseMapper mapper;
	
	@Override
	public List<HouseDTO> listHouse(Map<String, String> map) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		System.out.println("리스트 "+map.get("word"));
		param.put("key", map.get("key") == null ? "" : map.get("key"));
		param.put("word", map.get("word") == null ? "" : map.get("word"));
		param.put("dongName", map.get("dongName") == null ? "" : map.get("dongName"));
		int currentPage = Integer.parseInt(map.get("pg"));
		int sizePerPage = 10;
		int start = (currentPage - 1) * sizePerPage;
		param.put("start", start);
		return mapper.selectHouse(param);
	}

	@Override
	public PageNavigation makePageNavigation(Map<String, String> map) throws Exception {
		int naviSize = 10;
		int currentPage = Integer.parseInt(map.get("pg"));
		PageNavigation pageNavigation = new PageNavigation();
		pageNavigation.setCurrentPage(currentPage);
		pageNavigation.setNaviSize(naviSize);
		int totalCount = mapper.selectTotalCount(map);
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

	@Override
	public HouseInfoDTO getHouse(String name) throws Exception {
		return mapper.selectHouseByName(name);
	}

	@Override
	public List<HouseDTO> listHouseJson(Map<String, String> map) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		System.out.println("지도  "+map.get("word"));
		param.put("key", map.get("key") == null ? "" : map.get("key"));
		param.put("word", map.get("word") == null ? "" : map.get("word"));
		param.put("dongName", map.get("dongName") == null ? "" : map.get("dongName"));
		return mapper.selectHouseJson(param);
	}

	@Override
	public HouseDealDTO getApt(String apt) throws Exception {
		return mapper.getApt(apt);
	}

}
