package com.lcomputerstudy.example.service;

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

}
