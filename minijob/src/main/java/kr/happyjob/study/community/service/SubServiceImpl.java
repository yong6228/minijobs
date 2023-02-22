package kr.happyjob.study.community.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.community.dao.SubDao;
import kr.happyjob.study.community.model.SubModel;

@Service
public class SubServiceImpl implements SubService {

	@Autowired
	private SubDao subdao;
	@Value("${fileUpload.rootPath}")     
	private String rootPath;	   
	@Value("${fileUpload.lectiredirPath}")  
	private String lectiredirPath;

	//자료실 전체 목록 조회 
	@Override
	public List<SubModel> supListAll(Map<String, Object> paramMap) throws Exception {
		List<SubModel> supListAll = subdao.supListAll(paramMap);
		return supListAll;
	}

	//자료실 총 갯수 조회
	@Override
	public int supTotalCnt(Map<String, Object> paramMap) throws Exception {
		int supTotalCnt = subdao.supTotalCnt(paramMap);
		return supTotalCnt;
	}

	// 자료실 상세 조회
	@Override
	public SubModel supDetail(Map<String, Object> paramMap) throws Exception {
		SubModel supDetail = subdao.supDetail(paramMap);
		return supDetail;
	}

	// 자료실 신규 등록
	
	@Override
	public int supCreate(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		  String action = (String) paramMap.get("action");
	      int maxlecno = 0;
	      maxlecno = subdao.supCreate(paramMap);
	      paramMap.put("lecno", maxlecno);
	      
	      MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;       
	      //MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
	      
	      //파일저장
	      String itemFilePath = lectiredirPath + File.separator + paramMap.get("lecno") + File.separator ; // 업로드 실제 경로 조립 (문자열생성)    *****  중요   실제 저장 경로 : rootPath, + itemFilePath       ********
	      FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
	      Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리    ********    fileInfo 에는 파일명, 사이즈, 위치정보  아래 참조 

	      fileInfo.put("file_lloc", "/lecfile/"+fileInfo.get("file_nm"));
	      paramMap.put("file", fileInfo);    
	      
		int supCreate = subdao.supCreate(paramMap);
		return supCreate;
	}

	// 자료실 목록 수정
	@Override
	public int supUpdate(Map<String, Object> paramMap,HttpServletRequest request) throws Exception {
		int supUpdate = subdao.supUpdate(paramMap);
		return supUpdate;
	}

	// 자료실 목록 삭제
	@Override
	public int supDelete(Map<String, Object> paramMap) throws Exception {
		int supDelete = subdao.supDelete(paramMap);
		return supDelete;
	}

}
