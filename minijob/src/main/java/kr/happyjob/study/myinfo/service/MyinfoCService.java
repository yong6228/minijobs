package kr.happyjob.study.myinfo.service;

import java.util.Map;

import kr.happyjob.study.myinfo.model.MyinfoCModel;

public interface MyinfoCService {

	// 마이 인포 한건조회
	
	// 공지사항 목록 카운트 조회
	public MyinfoCModel fSelectPersCod(Map<String, Object>paramMap) throws Exception;

	
}
