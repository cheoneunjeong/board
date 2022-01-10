package com.lcomputerstudy.example.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.lcomputerstudy.example.domain.Board;

@Mapper
public interface BoardMapper {

	void insertBoard(Board board);

}
