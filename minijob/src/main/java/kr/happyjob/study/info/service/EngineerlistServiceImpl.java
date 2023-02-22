package kr.happyjob.study.info.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.info.dao.EngineerlistDao;
import kr.happyjob.study.info.model.Engineercategory;
import kr.happyjob.study.info.model.Engineerlist;
import kr.happyjob.study.info.model.Engineerskill;

@Service
public class EngineerlistServiceImpl implements EngineerlistService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	EngineerlistDao engineerlistDao;
	
	/** 그룹코드 목록 조회 */
	public List<Engineerlist> listEngineerCod(Map<String, Object> paramMap) throws Exception {
		
		List<Engineerlist> listEngineerCod = engineerlistDao.listEngineerCod(paramMap);
		
		return listEngineerCod;
	}
	
	/** 그룹코드 목록 카운트 조회 */
	public int countListEngineerCod(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = engineerlistDao.countListEngineerCod(paramMap);
		
		return totalCount;
	}

	@Override
	public Engineerlist listEngineerAll(Map<String, Object> paramMap) throws Exception {
	
		return engineerlistDao.listEngineerAll(paramMap);
	}

	@Override
	public List<Engineerskill> listskill(Map<String, Object> paramMap) throws Exception {
		
		List<Engineerskill> listskill = engineerlistDao.listskill(paramMap);
		
		return listskill;
	}

	@Override
	public int insertEngineerCod(Map<String, Object> paramMap) throws Exception {

		int ret = engineerlistDao.insertEngineerCod(paramMap);
		
		return ret;
	}

	@Override
	public int updateEngineerCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = engineerlistDao.updateEngineerCod(paramMap);
		
		return ret;
	}

	@Override
	public int insertSkillCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = engineerlistDao.insertSkillCod(paramMap);
		
		return ret;
	}

	@Override
	public int updateSkillCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = engineerlistDao.updateSkillCod(paramMap);
		
		return ret;
	}

	@Override
	public int deleteSkillCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = engineerlistDao.deleteSkillCod(paramMap);
		
		return ret;
	}

	@Override
	public List<Engineercategory> listcategory(Map<String, Object> paramMap) throws Exception {
		
		List<Engineercategory> listcategory = engineerlistDao.listcategory(paramMap);
		
		return listcategory;
	}

	@Override
	public int insertCategoryCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = engineerlistDao.insertCategoryCod(paramMap);
		
		return ret;
	}

	@Override
	public int updateCategoryCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = engineerlistDao.updateCategoryCod(paramMap);
		
		return ret;
	}

	@Override
	public int deleteCategoryCod(Map<String, Object> paramMap) throws Exception {

		int ret = engineerlistDao.deleteCategoryCod(paramMap);
		
		return ret
		;
	}

	
	
}
