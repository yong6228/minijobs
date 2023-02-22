package kr.happyjob.study.info.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.info.dao.PJDao;
import kr.happyjob.study.info.model.PJModel;

@Service
public class PJServiceImpl implements PJService{
	
	// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());
		
		// Get class name for logger
		private final String className = this.getClass().toString();
	
	@Autowired
	PJDao pjdao;

	@Override
	public List<PJModel> pjlist(Map<String, Object> paramMap) throws Exception {
		List<PJModel> pjlist = pjdao.pjlist(paramMap);
		return pjlist;
	}

	@Override
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception {
		int searchlistcnt = pjdao.searchlistcnt(paramMap);
		return searchlistcnt;
	}

	@Override
	public PJModel selectlist(Map<String, Object> paramMap) throws Exception {
		PJModel selectlist = pjdao.selectlist(paramMap);
		return selectlist;
	}

	@Override
	public void insertNotice(Map<String, Object> paramMap) throws Exception {
		pjdao.insertNotice(paramMap);
		
	}

	@Override
	public void updateNotice(Map<String, Object> paramMap) throws Exception {
		pjdao.updateNotice(paramMap);
		
	}

	@Override
	public void deleteNotice(Map<String, Object> paramMap) throws Exception {
		pjdao.deleteNotice(paramMap);
		
	}

	



}
