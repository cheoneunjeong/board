package com.lcomputerstudy.example.service;

import java.util.List;

import com.lcomputerstudy.example.domain.Board;
import com.lcomputerstudy.example.domain.Comment;
import com.lcomputerstudy.example.request.PostRequest;

public interface BoardService {
	
	public void insertBoard (Board board);

	public List<Board> getBoardList();

	public Board getBoardDetail(int b_id);

	public void addHit(int b_id);

	public void deletePost(int b_id);

	public void editPost(Board setBoard);

	public void insertReply(Board board);

	public List<Comment> getCommentList(int b_id);

	public void createComment(Comment comment);

	public void deleteComment(int c_id);

	public Comment getCommentDetail(Comment c_id);

	public void insertReplyComment(Comment reComment);

	public void deleteBoardComments(int b_id);
}
