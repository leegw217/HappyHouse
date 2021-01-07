package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.ClinicDTO;
import com.ssafy.happyhouse.model.HospitalDTO;
import com.ssafy.happyhouse.model.service.CovidService;

@Controller
@RequestMapping("/covid")
public class CovidController {
	
	@Autowired
	private CovidService covidService;
	
	@GetMapping(value="/covid")
	public String covid() {
		return "covid/menu";
	}
	
	@GetMapping(value="/cliniclist")
	public String clinicList(@RequestParam Map<String, String> map, Model model) {
		try {
			List<ClinicDTO> list = covidService.listClinic(map);
			model.addAttribute("cliniclist", list);
			return "covid/clinicList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "목록을 얻어오는 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	
	@GetMapping(value="/clinicdetail")
	public String clinicDetail(@RequestParam("name") String name, Model model) {
		try {
			ClinicDTO clinicDTO = covidService.getClinic(name);
			model.addAttribute("clinic", clinicDTO);
			return "covid/clinicDetail";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "선별진료소 정보를 얻어오는 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	
	@GetMapping(value="/hospitallist")
	public String hospitalList(@RequestParam Map<String, String> map, Model model) {
		try {
			List<HospitalDTO> list = covidService.listHospital(map);
			model.addAttribute("hospitallist", list);
			return "covid/hospitalList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "목록을 얻어오는 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
}
