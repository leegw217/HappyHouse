package com.ssafy.happyhouse.model;

public class FreeCommentDTO {
	private int no;
	private int bno;
	private String content;
	private String writer;
	private String regtime;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getRegtime() {
		return regtime;
	}
	public void setRegtime(String regtime) {
		this.regtime = regtime;
	}
	@Override
	public String toString() {
		return "FreeCommentDTO [no=" + no + ", bno=" + bno + ", content=" + content + ", writer=" + writer
				+ ", regtime=" + regtime + "]";
	}
}
