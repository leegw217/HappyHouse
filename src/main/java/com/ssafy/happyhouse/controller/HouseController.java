package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.HouseDTO;
import com.ssafy.happyhouse.model.HouseDealDTO;
import com.ssafy.happyhouse.model.HouseInfoDTO;
import com.ssafy.happyhouse.model.LikeListDTO;
import com.ssafy.happyhouse.model.MemberDTO;
import com.ssafy.happyhouse.model.service.HouseService;
import com.ssafy.util.PageNavigation;

@Controller
@RequestMapping("/house")
public class HouseController {

	@Autowired
	private HouseService houseService;
	
	@GetMapping(value="/houselist")
	public String houseList(@RequestParam Map<String, String> map, Model model) {
		String spp = map.get("spp");
		String key = map.get("key");
		String word = map.get("word");
		String dongName = map.get("dongName");

		map.put("spp", spp != null ? spp : "10");
		try {
			List<HouseDTO> list = houseService.listHouse(map);
			PageNavigation pageNavigation = houseService.makePageNavigation(map);
			model.addAttribute("houselist", list);
			model.addAttribute("navigation", pageNavigation);
			model.addAttribute("word", word);
			model.addAttribute("key", key);
			model.addAttribute("dongName", dongName);
			return "house/houseList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "목록을 얻어오는 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	
	@ResponseBody
	@GetMapping(value="/houselistjson")
	public List<HouseDTO> houseListJson(@RequestParam Map<String, String> map, Model model) throws Exception {
		return houseService.listHouseJson(map);
	}
	
	@GetMapping(value="/housedetail")
	public String houseDetail(@RequestParam("aptName") String aptName, Model model) {
		try {
			HouseInfoDTO houseInfoDTO = houseService.getHouse(aptName);
			model.addAttribute("house", houseInfoDTO);
			return "house/houseDetail";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "집 정보를 얻어오는 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	
	@ResponseBody
	@GetMapping(value="/search/{apt}")
	public HouseDealDTO apt(@PathVariable("apt") String apt) throws Exception {
		return houseService.getApt(apt);
	}
	
	@GetMapping(value="/interest")
	public String interestArea() {
		return "house/interestArea";
	}
}
