package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.ClinicDTO;
import com.ssafy.happyhouse.model.HospitalDTO;

public interface CovidService {

	List<ClinicDTO> listClinic(Map<String, String> map) throws Exception;

	ClinicDTO getClinic(String name) throws Exception;

	List<HospitalDTO> listHospital(Map<String, String> map) throws Exception;

}