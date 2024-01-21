package com.myweb.www.service;

import java.util.List;

import com.myweb.www.domain.BoardDTO;
import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.PagingVO;

public interface BoardService {

	int insert(BoardDTO boardDTO);

	List<BoardVO> selectAll(PagingVO pgvo);

	BoardDTO getDetail(long bno);

	BoardDTO getModify(long bno);
	
	int update(BoardDTO boardDTO);

	void delete(long bno);
	
	int getTotalCount(PagingVO pgvo);

	int deleteFile(String uuid);



}
