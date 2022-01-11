package com.lcomputerstudy.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lcomputerstudy.example.domain.Board;
import com.lcomputerstudy.example.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper boardmapper;
	
	@Override
	public void insertBoard(Board board) {
		// TODO Auto-generated method stub
		boardmapper.insertBoard(board);
		
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

}
