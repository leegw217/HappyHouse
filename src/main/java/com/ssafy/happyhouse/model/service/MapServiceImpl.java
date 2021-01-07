package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
import com.ssafy.happyhouse.model.mapper.MapMapper;

@Service
public class MapServiceImpl implements MapService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<SidoDTO> getSido(){
	    return sqlSession.getMapper(MapMapper.class).getSido();
	}
	
	@Override
	public List<GugunDTO> getGugunInSido(String sido){
	    return sqlSession.getMapper(MapMapper.class).getGugunInSido(sido);
	}
	
	@Override
	public List<DongDTO> getDongInGugun(String gugun){
	    return sqlSession.getMapper(MapMapper.class).getDongInGugun(gugun);
	}
	
	@Override
	public HouseDealDTO getApt(String apt) {
	    return sqlSession.getMapper(MapMapper.class).getApt(apt);
	}

	@Override
	public List<HouseDTO> getAll() {
		return sqlSession.getMapper(MapMapper.class).getAll();
	}

	@Override
	public List<StoreDTO> getStorebigcode(String dong) {
		return sqlSession.getMapper(MapMapper.class).getStorebigcode(dong);
	}

	@Override
	public List<HouseDTO> getListInDong(String dong) {
		return sqlSession.getMapper(MapMapper.class).getListInDong(dong);
	}

	@Override
	public List<CultureDTO> getCulture(String dong) {
		return sqlSession.getMapper(MapMapper.class).getCulture(dong);
	}

	@Override
	public List<ParkDTO> getPark(String dong) {
		return sqlSession.getMapper(MapMapper.class).getPark(dong);
	}

	@Override
	public void addLikeList(LikeListDTO likelistDto) {
		sqlSession.getMapper(MapMapper.class).addLikeList(likelistDto);
	}

	@Override
	public List<LikeHouseDTO> getlikelist(String id) {
		return sqlSession.getMapper(MapMapper.class).getlikelist(id);
	}

	@Override
	public List<LikeHouseDTO> getlikelistbyGugun(String id, String gugun) {
		return sqlSession.getMapper(MapMapper.class).getlikelistbyGugun(id,gugun);
	}

	@Override
	public List<MetroDTO> getMetro(String dong) {
		return sqlSession.getMapper(MapMapper.class).getMetro(dong);
	}

	@Override
	public List<SchoolDTO> getSchool(String gu) {
		return sqlSession.getMapper(MapMapper.class).getSchool(gu);
	}

	@Override
	public List<HouseDealDTO> getAptbyName(String apt) {
		return sqlSession.getMapper(MapMapper.class).getAptbyName(apt);
	}

}