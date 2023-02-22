package kr.happyjob.study.engInfo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.engInfo.dao.EngineerMngDao;
import kr.happyjob.study.engInfo.model.EngineerMngModel;

@Service
public class EngineerMngServiceImpl implements EngineerMngService {
	
	@Autowired
	EngineerMngDao engineerMngDao;
	
	@Override
	public List<EngineerMngModel> listEngineerCod(Map<String, Object> paramMap) {
		
		List<EngineerMngModel> listEngineerCod = engineerMngDao.listEngineerCod(paramMap);
		return listEngineerCod;
	}

	@Override
	public int countListEngineerCod(Map<String, Object> paramMap) {
		int totalCount = engineerMngDao.countListEngineerCod(paramMap);
		return totalCount;
	}
	
	
	
}
