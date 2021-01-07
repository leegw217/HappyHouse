package com.ssafy.happyhouse.model;

public class StoreDTO {

	private String storename;
	private String lat;
	private String lng;
	private String bigCode;
	private String typename;
	
	public String getStorename() {
		return storename;
	}
	public void setStorename(String storename) {
		this.storename = storename;
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
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	public String getBigCode() {
		return bigCode;
	}
	public void setBigCode(String bigCode) {
		this.bigCode = bigCode;
	}
	
}
