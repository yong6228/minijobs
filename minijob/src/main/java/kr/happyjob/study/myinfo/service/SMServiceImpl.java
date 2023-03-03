package kr.happyjob.study.myinfo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.myinfo.dao.SMDao;
import kr.happyjob.study.myinfo.model.SMModel;

@Service
public class SMServiceImpl implements SMService{
	
	@Autowired
	SMDao smdao;
	

	@Override
	public List<SMModel> smessage1(Map<String, Object> paramMap) throws Exception {
		 List<SMModel> smessage1 = smdao.smessage1(paramMap);
		return smessage1;
	}

	@Override
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception {
		int searchlistcnt = smdao.searchlistcnt(paramMap);
		return searchlistcnt;
	}

	@Override
	public SMModel selectSS(Map<String, Object> paramMap) throws Exception {
		SMModel selectSS = smdao.selectSS(paramMap);
		return selectSS;
	}

	@Override
	public void insertNotice0819(Map<String, Object> paramMap) throws Exception {
		smdao.insertNotice0819(paramMap);
		
	}

	@Override
	public void updateNotice0819(Map<String, Object> paramMap) throws Exception {
		smdao.updateNotice0819(paramMap);
		
	}

	@Override
	public void deleteNotice0819(Map<String, Object> paramMap) throws Exception {
		smdao.deleteNotice0819(paramMap);
		
	}

}
