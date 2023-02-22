package kr.happyjob.study.community.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.community.model.SubModel;

public interface SubService {

	//자료실 전체 목록 조회 
	public List<SubModel> supListAll(Map<String,Object> paramMap) throws Exception;
	//자료실 총 갯수 조회
	public int supTotalCnt(Map<String,Object> paramMap) throws Exception;
	// 자료실 상세 조회
	public SubModel supDetail(Map<String,Object> paramMap) throws Exception;
	// 자료실 신규 등록
	public int supCreate(Map<String,Object> paramMap, HttpServletRequest request) throws Exception;
	// 자료실 목록 수정
	public int supUpdate(Map<String,Object> paramMap,HttpServletRequest request) throws Exception;
	// 자료실 목록 삭제
	public int supDelete(Map<String,Object> paramMap) throws Exception;
	
}
