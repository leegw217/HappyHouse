package com.ssafy.happyhouse.model.mapper;

import java.util.List;

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

public interface MapMapper {

	public List<SidoDTO> getSido();
	public List<GugunDTO> getGugunInSido(String sido);
	public List<DongDTO> getDongInGugun(String gugun);
	public HouseDealDTO getApt(String apt);
	public List<HouseDealDTO> getAptbyName(String apt);
	public List<HouseDTO> getListInDong(String dong);
	public List<HouseDTO> getAll();
	public List<StoreDTO> getStorebigcode(String dong);
	public List<CultureDTO> getCulture(String dong);
	public List<ParkDTO> getPark(String dong);
	public void addLikeList(LikeListDTO likelistDto);
	public List<LikeHouseDTO> getlikelist(String id);
	public List<LikeHouseDTO> getlikelistbyGugun(String id,String gugun);
	public List<MetroDTO> getMetro(String dong);
	public List<SchoolDTO> getSchool(String gu);
	
}
