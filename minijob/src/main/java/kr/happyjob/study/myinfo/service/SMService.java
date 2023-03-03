package kr.happyjob.study.myinfo.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.myinfo.model.SMModel;

public interface SMService {

	public List<SMModel> smessage1(Map<String, Object> paramMap)throws Exception;

	public int searchlistcnt(Map<String, Object> paramMap)throws Exception;

	public SMModel selectSS(Map<String, Object> paramMap)throws Exception;

	public void insertNotice0819(Map<String, Object> paramMap)throws Exception;

	public void updateNotice0819(Map<String, Object> paramMap)throws Exception;

	public void deleteNotice0819(Map<String, Object> paramMap)throws Exception;

}
