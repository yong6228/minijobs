package kr.happyjob.study.engInfo.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.engInfo.model.EngineerMngModel;

public interface EngineerMngService {

	public List<EngineerMngModel> listEngineerCod(Map<String, Object> paramMap);
	
	public int countListEngineerCod(Map<String, Object> paramMap);
	
}
