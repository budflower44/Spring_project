package com.myweb.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.myweb.www.domain.BoardDTO;
import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.FileVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.repository.BoardDAO;
import com.myweb.www.repository.FileDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
@Service
public class BoardServiceImpl implements BoardService{
	
	private final BoardDAO bdao;
	private final FileDAO fdao;

	@Override
	public int insert(BoardDTO boardDTO) {
		int isOk = bdao.insert(boardDTO.getBvo());
		
		if(boardDTO.getFlist()== null) {
			return isOk;
		}
		
		//bvo insert 후 파일이 있다면..
		if(isOk > 0 && boardDTO.getFlist().size() > 0) {
			//bno setting
			long bno = bdao.selectOneBno(); //가장 마지막에 등록된 bno
			for(FileVO fvo : boardDTO.getFlist()) {
				fvo.setBno(bno);
				isOk *= fdao.insertFile(fvo);
			}
		}
		return isOk;
	}

	@Override
	public List<BoardVO> selectAll(PagingVO pgvo) {
		bdao.updateCmtQty(pgvo);
		bdao.updateHasFile(pgvo);
		return bdao.selectAll(pgvo);
		
	}

	@Override
	public BoardDTO getDetail(long bno) {
		int isOk = bdao.readCount(bno);
		BoardVO bvo = bdao.getDetail(bno);
		List<FileVO> flist = fdao.getFileList(bno);
		BoardDTO bdto = new BoardDTO(bvo, flist);
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ flist detail >>"+flist);
		return bdto;
	}

	@Override
	public BoardDTO getModify(long bno) {
		BoardVO bvo = bdao.getDetail(bno);
		List<FileVO> flist = fdao.getFileList(bno);
		BoardDTO bdto = new BoardDTO(bvo, flist);
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ flist modify >>"+flist);
		return bdto;
	}
	
	@Override
	public int update(BoardDTO boardDTO) {
		int isOk = bdao.update(boardDTO.getBvo());
		if(boardDTO.getFlist() == null) {
			return isOk;
		}else {
			long bno = boardDTO.getBvo().getBno();
			for(FileVO fvo : boardDTO.getFlist()) {
				fvo.setBno(bno);
				fdao.insertFile(fvo);
			}
		}
		return isOk;
	}

	@Override
	public void delete(long bno) {
		bdao.delete(bno);
	}

	@Override
	public int getTotalCount(PagingVO pgvo) {
		return bdao.getTotalCount(pgvo);
	}

	@Override
	public int deleteFile(String uuid) {
		log.info(">>>>>>>>>>>>>>>>>> deleteFile ServiceImpl");
		return fdao.deleteFile(uuid);
	}

	
	
}