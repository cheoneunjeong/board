package com.lcomputerstudy.example.request;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class PostRequest {
	
	private int b_id;
	private String title;
	private String content;
	private String writer;
	private String datetime;
	private String hit;
	private int groups;
	private int orders;
	private int depth;
	private List<MultipartFile> files;
	private String filename;
	
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
	public int getGroups() {
		return groups;
	}
	public void setGroups(int groups) {
		this.groups = groups;
	}
	public int getOrders() {
		return orders;
	}
	public void setOrders(int orders) {
		this.orders = orders;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}	
	public List<MultipartFile> getFiles() {
		return files;
	}
	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	@Override
	public String toString() {
		return "PostRequest [b_id=" + b_id + ", title=" + title + ", content=" + content + ", writer=" + writer
				+ ", datetime=" + datetime + ", hit=" + hit + ", groups=" + groups + ", orders=" + orders + ", depth="
				+ depth + ", files=" + files + "]";
	}
	
	
}
