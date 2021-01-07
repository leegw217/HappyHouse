package com.ssafy.happyhouse.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.ClinicDTO;
import com.ssafy.happyhouse.model.HospitalDTO;
import com.ssafy.happyhouse.model.mapper.CovidMapper;

@Service
public class CovidServiceImpl implements CovidService {
	
	@Autowired
	private CovidMapper mapper;
	
	@Override
	public List<ClinicDTO> listClinic(Map<String, String> map) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("key", map.get("key") == null ? "" : map.get("key"));
		param.put("word", map.get("word") == null ? "" : map.get("word"));
		return mapper.selectClinic(param);
	}
	
	@Override
	public ClinicDTO getClinic(String name) throws Exception {
		return mapper.selectClinicByName(name);
	}
	
	@Override
	public List<HospitalDTO> listHospital(Map<String, String> map) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("key", map.get("key") == null ? "" : map.get("key"));
		param.put("word", map.get("word") == null ? "" : map.get("word"));
		return mapper.selectHospital(param);
	}
	
}
