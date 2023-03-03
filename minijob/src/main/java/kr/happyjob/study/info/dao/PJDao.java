package kr.happyjob.study.info.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.info.model.PJModel;

public interface PJDao {

	public List<PJModel> pjlist(Map<String, Object> paramMap)throws Exception;

	public int searchlistcnt(Map<String, Object> paramMap)throws Exception;

	public PJModel selectpjlist(Map<String, Object> paramMap)throws Exception;
}
