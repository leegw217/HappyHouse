package com.ssafy.happyhouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.CultureDTO;
import com.ssafy.happyhouse.model.DongDTO;
import com.ssafy.happyhouse.model.GugunDTO;
import com.ssafy.happyhouse.model.HouseDTO;
import com.ssafy.happyhouse.model.HouseDealDTO;
import com.ssafy.happyhouse.model.LikeHouseDTO;
import com.ssafy.happyhouse.model.LikeListDTO;
import com.ssafy.happyhouse.model.MetroDTO;
import com.ssafy.happyhouse.model.ParkDTO;
import com.ssafy.happyhouse.model.SchoolDTO;
import com.ssafy.happyhouse.model.SidoDTO;
import com.ssafy.happyhouse.model.StoreDTO;
import com.ssafy.happyhouse.model.service.MapService;

@RestController
@RequestMapping("/map")
public class MapController  {
    
	@Autowired
	private MapService mapService;
	
	@GetMapping(value="/sido")
	public List<SidoDTO> sido() throws Exception {
		System.out.println("sido");
		return mapService.getSido();
	}
	
	@GetMapping(value="/gugun/{sido}")
	public List<GugunDTO> gugun(@PathVariable("sido") String sido) throws Exception {
		return mapService.getGugunInSido(sido);
	}
	
	@GetMapping(value="/dong/{gugun}")
	public List<DongDTO> dong(@PathVariable("gugun") String gugun) throws Exception {
		return mapService.getDongInGugun(gugun);
	}
	
	@GetMapping(value="/searchdong/{dong}")
	public List<HouseDTO> searchdong(@PathVariable("dong") String dong) throws Exception {
		return mapService.getListInDong(dong);
	}
	
	@GetMapping(value="/search/{apt}")
	public HouseDealDTO apt(@PathVariable("apt") String apt) throws Exception {
		return mapService.getApt(apt);
	}
	
	@GetMapping(value="/searchapt/{apt}")
	public List<HouseDealDTO> searchapt(@PathVariable("apt") String apt) throws Exception {
		return mapService.getAptbyName(apt);
	}
	
	@GetMapping(value="/searchall")
	public List<HouseDTO> searchall() throws Exception {
		return mapService.getAll();
	}
	
	@GetMapping(value="/storebigcode/{dong}")
	public List<StoreDTO> storebigcode(@PathVariable("dong") String dong) throws Exception {
		return mapService.getStorebigcode(dong);
	}
	
	@GetMapping(value="/culture/{dong}")
	public List<CultureDTO> culture(@PathVariable("dong") String dong) throws Exception {
		return mapService.getCulture(dong);
	}
	
	@GetMapping(value="/park/{dong}")
	public List<ParkDTO> park(@PathVariable("dong") String dong) throws Exception {
		return mapService.getPark(dong);
	}
	
	@GetMapping(value="/metro/{dong}")
	public List<MetroDTO> metro(@PathVariable("dong") String dong) throws Exception {
		return mapService.getMetro(dong);
	}
	
	@GetMapping(value="/school/{gu}")
	public List<SchoolDTO> school(@PathVariable("gu") String gu) throws Exception {
		return mapService.getSchool(gu);
	}
	
	@RequestMapping(value = "/addLikeList", method = RequestMethod.POST, headers = { "Content-type=application/json" })
	public void addLikeList(@RequestBody LikeListDTO likelistDto) {
		mapService.addLikeList(likelistDto);
	}
	
	@GetMapping(value="/userlikelist/{id}")
	public List<LikeHouseDTO> likelist(@PathVariable("id") String id) throws Exception {
		return mapService.getlikelist(id);
	}
	
	@GetMapping(value="/userlikelist/{id}/{gugun}")
	public List<LikeHouseDTO> likelistbyGugun(@PathVariable("id") String id,@PathVariable("gugun") String gugun) throws Exception {
		return mapService.getlikelistbyGugun(id,gugun);
	}

}