package com.lcomputerstudy.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.lcomputerstudy.example.domain.Board;

@Mapper
public interface BoardMapper {

	void insertBoard(Board board);

	List<Board> getBoardList();

	Board getBoardDetail(int b_id);

	void addHit(int b_id);

}
