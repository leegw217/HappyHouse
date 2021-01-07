package com.ssafy.happyhouse.model;

public class FreeDTO {
	private int no;
	private String writer;
	private String title;
	private String content;
	private String regtime;
	private int view;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegtime() {
		return regtime;
	}
	public void setRegtime(String regtime) {
		this.regtime = regtime;
	}
	public int getView() {
		return view;
	}
	public void setView(int view) {
		this.view = view;
	}
	@Override
	public String toString() {
		return "FreeDTO [no=" + no + ", writer=" + writer + ", title=" + title + ", content=" + content + ", regtime="
				+ regtime + ", view=" + view + "]";
	}
}
