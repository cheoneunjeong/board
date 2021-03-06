package com.lcomputerstudy.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lcomputerstudy.example.domain.Board;
import com.lcomputerstudy.example.domain.Comment;
import com.lcomputerstudy.example.mapper.BoardMapper;
import com.lcomputerstudy.example.request.PostRequest;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper boardmapper;
	
	@Override
	public void insertBoard(Board board) {
		// TODO Auto-generated method stub
		boardmapper.insertBoard1(board);
		boardmapper.insertBoard2(board);
		
	}

	@Override
	public List<Board> getBoardList() {
		// TODO Auto-generated method stub
		return boardmapper.getBoardList();
	}

	@Override
	public Board getBoardDetail(int b_id) {
		// TODO Auto-generated method stub
		return boardmapper.getBoardDetail(b_id);
	}

	@Override
	public void addHit(int b_id) {
		boardmapper.addHit(b_id);
		
	}

	@Override
	public void deletePost(int b_id) {
		boardmapper.deletePost(b_id);
		
	}

	@Override
	public void editPost(Board setBoard) {
		boardmapper.editPost(setBoard);
		
	}

	@Override
	public void insertReply(Board board) {
		// TODO Auto-generated method stub
		boardmapper.insertReply1(board);
		boardmapper.insertReply2(board);
	}

	@Override
	public List<Comment> getCommentList(int b_id) {
		// TODO Auto-generated method stub
		return boardmapper.getCommentList(b_id);
	}

	@Override
	public void createComment(Comment comment) {
		// TODO Auto-generated method stub
		boardmapper.createComment1(comment);
		boardmapper.createComment2(comment);
	}

	@Override
	public void deleteComment(int c_id) {
		// TODO Auto-generated method stub
		boardmapper.deleteComment(c_id);
	}

	@Override
	public Comment getCommentDetail(Comment c_id) {
		// TODO Auto-generated method stub
		return boardmapper.getCommentDetail(c_id);
	}

	@Override
	public void insertReplyComment(Comment reComment) {
		// TODO Auto-generated method stub
		boardmapper.insertReplyComment1(reComment);
		boardmapper.insertReplyComment2(reComment);
	}

	@Override
	public void deleteBoardComments(int b_id) {
		// TODO Auto-generated method stub
		boardmapper.deleteBoardComments(b_id);
	}

}
