package com.ssafy.happyhouse.model;

public class CultureDTO {

	private int id;
	private int genreCode;
	private String genreName;
	private String name;
	private String address;
	private String lat;
	private String lng;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getGenreCode() {
		return genreCode;
	}
	public void setGenreCode(int genreCode) {
		this.genreCode = genreCode;
	}
	public String getGenreName() {
		return genreName;
	}
	public void setGenreName(String genreName) {
		this.genreName = genreName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	
}
