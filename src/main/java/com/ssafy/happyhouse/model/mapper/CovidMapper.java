package com.ssafy.happyhouse.model.mapper;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.ClinicDTO;
import com.ssafy.happyhouse.model.HospitalDTO;

public interface CovidMapper {
	
	List<ClinicDTO> selectClinic(Map<String, Object> map);
	ClinicDTO selectClinicByName(String name);
	List<HospitalDTO> selectHospital(Map<String, Object> map);
	
}
