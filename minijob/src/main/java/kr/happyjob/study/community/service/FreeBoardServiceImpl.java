package kr.happyjob.study.community.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.community.dao.FreeBoardDao;
import kr.happyjob.study.community.model.FreeBoardModel;

@Service
public class FreeBoardServiceImpl implements FreeBoardService {

	@Autowired
	private FreeBoardDao freeboarddao;
	
	//자유게시판 전체조회
	@Override
	public List<FreeBoardModel> boardList(Map<String, Object> paramMap) throws Exception {
		List<FreeBoardModel> boardList = freeboarddao.boardList(paramMap);
		return boardList;
	}

	// 자유게시판 총 건수 조회
	@Override
		public int boardCnt(Map<String, Object> paramMap) throws Exception {
		int boardCnt = freeboarddao.boardCnt(paramMap);
		return boardCnt;
	}

	// 자유게시판 단건 조회
	@Override
	public FreeBoardModel boradDetail(Map<String, Object> paramMap) throws Exception {
		FreeBoardModel boradDetail = freeboarddao.boradDetail(paramMap);
		return boradDetail;
	}

	// 자유게시판 신규 등록
	@Override
	public int createBorad(Map<String, Object> paramMap) throws Exception {
		int createBorad = freeboarddao.createBorad(paramMap);
		return createBorad;
	}

	// 자유게시판 수정
	@Override
	public int updateBorad(Map<String, Object> paramMap) throws Exception {
		int updateBorad = freeboarddao.updateBorad(paramMap);
		return updateBorad;
	}
	// 자유게시판 삭제
	@Override
	public int deleteBoard(Map<String, Object> paramMap) throws Exception {
		int deleteBoard = freeboarddao.deleteBoard(paramMap);
		return deleteBoard;
	}
}
