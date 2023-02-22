package kr.happyjob.study.myinfo.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.myinfo.model.MModel;

public interface MService {

	public List<MModel> message1(Map<String, Object> paramMap)throws Exception;

	public int searchlistcnt(Map<String, Object> paramMap)throws Exception;

	public MModel selectj(Map<String, Object> paramMap)throws Exception;

	public void insertNotice(Map<String, Object> paramMap)throws Exception;

	public void updateNotice(Map<String, Object> paramMap)throws Exception;

	public void deleteNotice(Map<String, Object> paramMap)throws Exception;



	
}