package kr.happyjob.study.myinfo.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.myinfo.dao.MyinfoCDao;
import kr.happyjob.study.myinfo.model.MyinfoCModel;

@Service
public  class MyinfoCServiceImpl implements MyinfoCService {

	@Autowired
	MyinfoCDao myinfoCDao;

	
	public MyinfoCModel fSelectPersCod(Map<String, Object>paramMap) throws Exception{
		
		return myinfoCDao.fSelectPersCod(paramMap);
	}

	

}
