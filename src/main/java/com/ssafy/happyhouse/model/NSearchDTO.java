package com.ssafy.happyhouse.model;

public class NSearchDTO {
	private int pageNo;
	private int listSize;
	
	public NSearchDTO() {
		this(1, 10);
	}
	public NSearchDTO(int pageNo) {
		this(pageNo,10);
	}
	public NSearchDTO(int pageNo, int listSize) {
		this.pageNo = pageNo;
		this.listSize = listSize;
	}
	
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getListSize() {
		return listSize;
	}
	public void setListSize(int listSize) {
		this.listSize = listSize;
	}
	
	
}
