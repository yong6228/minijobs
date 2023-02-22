package kr.happyjob.study.myinfo.dao;

import java.util.Map;

import kr.happyjob.study.myinfo.model.MyinfoCModel;

public interface MyinfoCDao {

	
	
	public MyinfoCModel fSelectPersCod(Map<String, Object>paramMap) throws Exception;
	
}
