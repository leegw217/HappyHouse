package com.ssafy.happyhouse.model;

public class SearchDTO {

	private String searchWord;
	private String searchType;
	private String searchDong;
	
	private int pageNo;
	private int listSize;
	
	public SearchDTO() {
	    this.pageNo = 1;
	    this.listSize = 10;
	}
	public SearchDTO(int pageNo) { 
	    this.pageNo = 10;
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
	public String getSearchWord() {
	    return searchWord;
	}
	public void setSearchWord(String searchWord) {
	    this.searchWord = searchWord;
	}
	public String getSearchDong() {
	    return searchDong;
	}
	public void setSearchDong(String searchDong) {
	    this.searchDong = searchDong;
	}
	public String getSearchType() {
	    return searchType;
	}
	public void setSearchType(String searchType) {
	    this.searchType = searchType;
	}
}