package kr.happyjob.study.info.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.info.dao.ProjectlistDao;
import kr.happyjob.study.info.model.ProjectInterview;
import kr.happyjob.study.info.model.Projectlist;
import kr.happyjob.study.info.model.Projectskill;

@Service
public class ProjectlistServicelmpl implements ProjectlistService{

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ProjectlistDao projectlistDao;
	
	/** 그룹코드 목록 조회 */
	public List<Projectlist> listProjectCod(Map<String, Object> paramMap) throws Exception {
		
		List<Projectlist> listProjectCod = projectlistDao.listProjectCod(paramMap);
		
		return listProjectCod;
	}
		
	/** 그룹코드 목록 카운트 조회 */
	public int countListProjectCod(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = projectlistDao.countListProjectCod(paramMap);
		
		return totalCount;
	}

	@Override
	public Projectlist listProjectAll(Map<String, Object> paramMap) throws Exception {
	
		return projectlistDao.listProjectAll(paramMap);
	}
	
	@Override
	public List<Projectskill> listskill(Map<String, Object> paramMap) throws Exception {
		
		List<Projectskill> listskill = projectlistDao.listskill(paramMap);
		
		return listskill;
	}
	
	@Override
	public int insertProjectCod(Map<String, Object> paramMap) throws Exception {

		int ret = projectlistDao.insertProjectCod(paramMap);
		
		return ret;
	}

	@Override
	public int updateProjectCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = projectlistDao.updateProjectCod(paramMap);
		
		return ret;
	}
	
	@Override
	public int deleteProjectCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = projectlistDao.deleteProjectCod(paramMap);
		
		return ret;
	}
	
	@Override
	public int insertSkillCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = projectlistDao.insertSkillCod(paramMap);
		
		return ret;
	}
	
	@Override
	public int updateSkillCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = projectlistDao.updateSkillCod(paramMap);
		
		return ret;
	}
	
	@Override
	public int deleteSkillCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = projectlistDao.deleteSkillCod(paramMap);
		
		return ret;
	}
	
	@Override
	public List<ProjectInterview> listInterview(Map<String, Object> paramMap) throws Exception {
		
		List<ProjectInterview> listInterview = projectlistDao.listInterview(paramMap);
		
		return listInterview;
	}
	
	@Override
	public int insertInterviewCod(Map<String, Object> paramMap) throws Exception{
		
		int ret = projectlistDao.insertInterviewCod(paramMap);
		
		return ret;
	}
	
	@Override
	public int updateInterviewCod(Map<String, Object> paramMap) throws Exception{
		int ret = projectlistDao.updateInterviewCod(paramMap);
		
		return ret;
	}
	
	@Override
	public int deleteInterviewCod(Map<String, Object> paramMap) throws Exception{
		int ret = projectlistDao.deleteInterviewCod(paramMap);
		
		return ret;
	}
}
