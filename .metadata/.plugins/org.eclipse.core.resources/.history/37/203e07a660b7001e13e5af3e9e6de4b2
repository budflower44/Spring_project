package com.myweb.www.repository;

import java.util.List;

import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.PagingVO;

public interface BoardDAO {

	int insert(BoardVO bvo);

	List<BoardVO> selectAll(PagingVO pgvo);

	BoardVO getDetail(long bno);

	int readCount(long bno);

	int update(BoardVO bvo);

	void delete(long bno);

	int getTotalCount(PagingVO pgvo);

	void updateCmtQty(PagingVO pgvo);

	long selectOneBno();

	void updateHasFile(PagingVO pgvo);


}
