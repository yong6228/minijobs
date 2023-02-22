package kr.happyjob.study.community.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.community.model.FreeBoardModel;

public interface FreeBoardService {

	//자유게시판 전체조회
	public List<FreeBoardModel> boardList(Map<String, Object> paramMap) throws Exception;
	// 자유게시판 총 건수 조회
	public int boardCnt(Map<String, Object> paramMap) throws Exception;
	// 자유게시판 단건 조회
	public FreeBoardModel boradDetail(Map<String, Object> paramMap) throws Exception;
	// 자유게시판 신규 등록
	public int createBorad(Map<String,Object>paramMap) throws Exception;
	// 자유게시판 수정
	public int updateBorad(Map<String,Object>paramMap) throws Exception;
	// 자유게시판 삭제
	public int deleteBoard(Map<String,Object>paramMap) throws Exception;
	
}
