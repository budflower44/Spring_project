package com.myweb.www.handler;

import java.util.List;

import com.myweb.www.domain.CommentVO;
import com.myweb.www.domain.PagingVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class PagingHandler {
	
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int totalCount;
	private PagingVO pgvo;
	
	private List<CommentVO> cmtList;
	
	public PagingHandler(PagingVO pgvo, int totalCount) {
		this.pgvo = pgvo;
		this.totalCount = totalCount;
		
		//1~5, 6~10, 11~15
		this.endPage = (int)Math.ceil((double)pgvo.getPageNo()/10)*10;
		this.startPage = endPage-9;
		
		int realEngPage = (int)(Math.ceil(totalCount / (double)pgvo.getQty()));
		
		if(realEngPage < endPage) {
			this.endPage = realEngPage;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEngPage;
		
	}
	
	//댓글 더보기 버튼 생성자
	public PagingHandler(PagingVO pgvo, int totalCount, List<CommentVO> cmtList) {
		this(pgvo, totalCount);
		this.cmtList = cmtList;
	}
	
	
	
}