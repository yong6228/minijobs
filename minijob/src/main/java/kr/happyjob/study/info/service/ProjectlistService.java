package kr.happyjob.study.info.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.info.model.ProjectInterview;
import kr.happyjob.study.info.model.Projectlist;
import kr.happyjob.study.info.model.Projectskill;

public interface ProjectlistService {
	
	/* 프로젝트 목록 조회 */
	public List<Projectlist> listProjectCod(Map<String, Object> paramMap) throws Exception;
	
	/* 프로젝트 목록 카운트 조회 */
	public int countListProjectCod(Map<String, Object> paramMap) throws Exception;
	
	/* 프로젝트 목록 전체 조회*/
	public Projectlist listProjectAll (Map<String, Object> paramMap) throws Exception;
	
	/* 프로젝트 스킬 조회 */
	public List<Projectskill> listskill(Map<String, Object> paramMap) throws Exception;
	
	/** 프로젝트 저장 */
	public int insertProjectCod(Map<String, Object> paramMap) throws Exception;
	
	/** 프로젝트 수정 */
	public int updateProjectCod(Map<String, Object> paramMap) throws Exception;
	
	/** 프로젝트 삭제 */
	public int deleteProjectCod(Map<String, Object> paramMap) throws Exception;
	
	/* 프로젝트 스킬 저장 */
	public int insertSkillCod(Map<String, Object> paramMap) throws Exception;
	
	/** 프로젝트 스킬 저장 */
	public int updateSkillCod(Map<String, Object> paramMap) throws Exception;
	
	/* 프로젝트 스킬 삭제 */
	public int deleteSkillCod(Map<String, Object> paramMap) throws Exception;
	
	/* 프로젝트 면접형식 조회 */
	public List<ProjectInterview> listInterview(Map<String, Object> paramMap) throws Exception;
	
	public int insertInterviewCod(Map<String, Object> paramMap) throws Exception;
	
	public int updateInterviewCod(Map<String, Object> paramMap) throws Exception;
	
	public int deleteInterviewCod(Map<String, Object> paramMap) throws Exception;
}
