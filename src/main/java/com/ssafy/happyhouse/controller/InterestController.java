package com.ssafy.happyhouse.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.HouseDTO;
import com.ssafy.happyhouse.model.InterestDTO;
import com.ssafy.happyhouse.model.service.InterestService;
import com.ssafy.util.PageNavigation;

@Controller
@RequestMapping("/interest")
public class InterestController {
	
	@Autowired
	private InterestService interestService;
	
	@GetMapping("/listinterest")
	@ResponseBody
	public List<InterestDTO> listInterest(@RequestParam("id") String id) {
		List<InterestDTO> list = null;
		try {
			list = interestService.listInterest(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@GetMapping("/writeinterest")
	@ResponseBody
	public int writeInterest(@RequestParam("id") String id, @RequestParam("dong") String dong) {
		int cnt = 0;
		try {
			cnt = interestService.countInterest(id);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		int result = -1;
		if(cnt < 3) {
			InterestDTO interest = new InterestDTO();
			interest.setId(id);
			interest.setDong(dong);
			try {
				result = interestService.writeInterest(interest);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else return 0;
		return result;
	}
	
	@GetMapping("/deleteinterest")
	@ResponseBody
	public int deleteInterest(@RequestParam("id") String id, @RequestParam("dong") String dong) {
		InterestDTO interest = new InterestDTO();
		interest.setId(id);
		interest.setDong(dong);
		int result = -1;
		try {
			result = interestService.deleteInterest(interest);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping("/listhouse")
	@ResponseBody
	public Map<String, Object> listHouse(@RequestParam("id") String id, @RequestParam("pg") String pg) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<HouseDTO> houseList = null;
		List<InterestDTO> interestList = null;
		try {
			interestList = interestService.listInterest(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(interestList != null) {
			houseList = new ArrayList<>();
			for(int i=0; i<interestList.size(); i++) {
				List<HouseDTO> temp = null;
				try {
					temp = interestService.listHouseByDong(interestList.get(i).getDong());
					houseList.addAll(temp);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		int size = houseList.size();
		int start = (Integer.parseInt(pg) - 1) * 6;
		List<HouseDTO> pList = houseList.subList(start, start+6>size?size:start+6);
		try {
			PageNavigation pageNavigation = interestService.makePageNavigation(Integer.parseInt(pg), size);
			map.put("navigator", pageNavigation.getNavigator());
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("list", pList);
		
		return map;
	}
	
	@GetMapping("/search")
	@ResponseBody
	public Map<String, Object> searchHouse(@RequestParam("id") String id, @RequestParam("divideList[]") List<String> divideList, 
			@RequestParam("pg") String pg, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<HouseDTO> houseList = null;
		List<InterestDTO> interestList = null;
		try {
			interestList = interestService.listInterest(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(interestList != null) {
			houseList = new ArrayList<>();
			for(int i=0; i<interestList.size(); i++) {
				List<HouseDTO> temp = null;
				String dongName = interestList.get(i).getDong();
				try {
					boolean flag = false;
					for(int j=0; j<divideList.size(); j++) {
						int cnt = interestService.countHouseByFacility(dongName, divideList.get(j));
						if(cnt == 0) {
							flag = true;
							break;
						}
					}
					if(!flag) {
						temp = interestService.listHouseByDong(dongName);
						houseList.addAll(temp);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		int size = houseList.size();
		int start = (Integer.parseInt(pg) - 1) * 6;
		List<HouseDTO> pList = houseList.subList(start, start+6>size?size:start+6);
		try {
			PageNavigation pageNavigation = interestService.makePageNavigation(Integer.parseInt(pg), size);
			map.put("navigator", pageNavigation.getNavigator());
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("list", pList);
		return map;
	}
	
	@GetMapping("/recommend")
	@ResponseBody
	public List<HouseDTO> recommendHouse(@RequestParam("id") String id, @RequestParam("divideList[]") List<String> divideList) {
		List<HouseDTO> houseList = null;
		List<InterestDTO> interestList = null;
		try {
			interestList = interestService.listInterest(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		houseList = new ArrayList<>();
		List<String> list = new ArrayList<String>();
		for(int i=0; i<interestList.size(); i++) 
			list.add(interestList.get(i).getDong());
		List<String> dongList = null;
		try {
			dongList = interestService.listDongWithoutInterest(list);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		for(int i=0; i<dongList.size(); i++) {
			List<HouseDTO> temp = null;
			String dongName = dongList.get(i);
			try {
				boolean flag = false;
				for(int j=0; j<divideList.size(); j++) {
					int cnt = interestService.countHouseByFacility(dongName, divideList.get(j));
					System.out.println(cnt);
					if(cnt == 0) {
						flag = true;
						break;
					}
				}
				if(!flag) {
					temp = interestService.listHouseByDong(dongName);
					houseList.addAll(temp);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		Collections.sort(houseList, new Comparator<HouseDTO>() {
			@Override
			public int compare(HouseDTO h1, HouseDTO h2) {
				return h1.getDealAmount().compareTo(h2.getDealAmount());
			}			
		});
		
		List<HouseDTO> pList = houseList.subList(0, 4);
		return pList;
	}
}
