package com.lcomputerstudy.example.request;

public class PostRequest {
	
	private int b_id;
	private String title;
	private String content;
	private String writer;
	private String datetime;
	private String hit;
	
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
	
	public int getB_id() {
		return b_id;
	}
	public void setB_id(int b_id) {
		this.b_id = b_id;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}
	public String getHit() {
		return hit;
	}
	public void setHit(String hit) {
		this.hit = hit;
	}
	@Override
	public String toString() {
		return "PostRequest [b_id=" + b_id + ", title=" + title + ", content=" + content + ", writer=" + writer
				+ ", datetime=" + datetime + ", hit=" + hit + "]";
	}
	
}
