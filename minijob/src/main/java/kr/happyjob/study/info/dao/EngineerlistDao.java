package kr.happyjob.study.info.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.info.model.Engineercategory;
import kr.happyjob.study.info.model.Engineerlist;
import kr.happyjob.study.info.model.Engineerskill;

public interface EngineerlistDao {

	/** 개발자 조회 */
	public List<Engineerlist> listEngineerCod(Map<String, Object> paramMap);
	
	/** 개발자 목록 카운트 조회 */
	public int countListEngineerCod(Map<String, Object> paramMap);
	
	
	public Engineerlist listEngineerAll(Map<String, Object> paramMap) throws Exception;
	
	public List<Engineerskill> listskill(Map<String, Object> paramMap) throws Exception;
	
	public List<Engineercategory> listcategory(Map<String, Object> paramMap) throws Exception;
	
	/** 그룹코드 저장 */
	public int insertEngineerCod(Map<String, Object> paramMap);
	
	/** 그룹코드 수정 */
	public int updateEngineerCod(Map<String, Object> paramMap);
	
	/** 그룹코드 저장 */
	public int insertSkillCod(Map<String, Object> paramMap);
	
	/** 그룹코드 수정 */
	public int updateSkillCod(Map<String, Object> paramMap);
	
	/** 그룹코드 삭제 */
	public int deleteSkillCod(Map<String, Object> paramMap);
	
	/** 그룹코드 저장 */
	public int insertCategoryCod(Map<String, Object> paramMap);
	
	/** 그룹코드 수정 */
	public int updateCategoryCod(Map<String, Object> paramMap);
	
	/** 그룹코드 삭제 */
	public int deleteCategoryCod(Map<String, Object> paramMap);
	
}
