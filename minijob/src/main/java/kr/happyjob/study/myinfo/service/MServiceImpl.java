package kr.happyjob.study.myinfo.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.myinfo.dao.MDao;
import kr.happyjob.study.myinfo.model.MModel;

@Service
public class MServiceImpl implements MService{

	@Autowired
	MDao mdao;

	// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());
		
		// Get class name for logger
		private final String className = this.getClass().toString();
	
	@Override
	public List<MModel> message1(Map<String, Object> paramMap) throws Exception {
		 List<MModel> message1 = mdao.message1(paramMap);
		return message1;
	}

	@Override
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception {
		 int searchlistcnt = mdao.searchlistcnt(paramMap);
		return searchlistcnt;
	}

	@Override
	public MModel selectj(Map<String, Object> paramMap) throws Exception {
		MModel selectj  = mdao.selectj(paramMap); 
		return selectj;
	}

	@Override
	public void insertNotice(Map<String, Object> paramMap) throws Exception {
		mdao.insertNotice(paramMap);
		
	}

	@Override
	public void updateNotice(Map<String, Object> paramMap) throws Exception {
		mdao.updateNotice(paramMap);
		
	}

	@Override
	public void deleteNotice(Map<String, Object> paramMap) throws Exception {
		mdao.deleteNotice(paramMap);
		
	}

	
	
	
	
	
}
