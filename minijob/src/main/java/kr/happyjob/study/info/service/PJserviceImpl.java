package kr.happyjob.study.info.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.info.dao.PJDao;
import kr.happyjob.study.info.model.PJModel;

@Service
public class PJserviceImpl implements PJservice{
	
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
	public PJModel selectpjlist(Map<String, Object> paramMap) throws Exception {
		PJModel selectpjlist = pjdao.selectpjlist(paramMap);
		return selectpjlist;
	}

}
