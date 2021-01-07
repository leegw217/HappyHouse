package com.ssafy.happyhouse.model;

public class QnaDTO {
	private int no;
	private String writer;
	private String title;
	private String content;
	private String regtime;
	private boolean secret;
	private String comment;
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
	public boolean getSecret() {
		return secret;
	}
	public void setSecret(boolean secret) {
		this.secret = secret;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	@Override
	public String toString() {
		return "QnaDTO [no=" + no + ", writer=" + writer + ", title=" + title + ", content=" + content + ", regtime="
				+ regtime + ", secret=" + secret + ", comment=" + comment + "]";
	}
}
