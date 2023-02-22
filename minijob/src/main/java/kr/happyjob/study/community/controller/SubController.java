package kr.happyjob.study.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.community.model.SubModel;
import kr.happyjob.study.community.service.SubService;

@Controller
@RequestMapping("/community")
public class SubController {

	@Autowired
	private SubService subservice;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 처음 로딩될 때 자료실 연결
	@RequestMapping("reference.do")
	public String init(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request
			, HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".initNotice");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String)session.getAttribute("loginId");
		model.addAttribute("curloginID", loginID);
		
		return "community/Sub";
	}
	
	// 자료실 리스트
	@RequestMapping("subList.do")
	public String subList(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request
			, HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".subList.do");
		logger.info("   - paramMap : " + paramMap);
		
		int  currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage-1) * pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		//자료실 목록 조회
		List<SubModel> subList = subservice.supListAll(paramMap);
		model.addAttribute("subList",subList);
		
		// 목록 수 추출해서 보내기
		int subCnt = subservice.supTotalCnt(paramMap);
		
		model.addAttribute("subCnt",subCnt);
		model.addAttribute("pageIndex",pageIndex);
		model.addAttribute("currentPage",currentPage);
		
		return "community/SubList";
	}
	
	// 상세 조회
	@RequestMapping("detailSub.do")
	@ResponseBody
public Map<String,Object> detailSub(Model model, @RequestParam Map<String, Object> paramMap,
		HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		//System.out.println("상세정보 보기를 위한 param에서 넘어온 값을 찍어봅시다.: " + paramMap);
		  logger.info("+ Start " + className + ".detailNotice");
		  logger.info("   - paramMap : " + paramMap);
	
		  String resultMsg = "";
		  
		 SubModel detailSub = subservice.supDetail(paramMap);
		 
		 if(detailSub !=null){
			 resultMsg = "SUCCESS";  // 성공시 찍습니다. 
			}else {
				resultMsg = "FAIL / 불러오기에 실패했습니다.";  // null이면 실패입니다.
			}
		 
			Map<String, Object> resultMap = new HashMap<String,Object>();
		  resultMap.put("resultMsg", resultMsg);
		  resultMap.put("detailSub", detailSub);
		  
		  return resultMap;
	}
	
	// 자료실 신규등록, 업데이트
		@RequestMapping("subSave.do")
		@ResponseBody
		public Map<String, Object> subSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".subSave");
			logger.info("   - paramMap : " + paramMap);
			
			   String action = (String)paramMap.get("action");
			   String result = "";
			   String resultMsg = "";
			// 사용자 정보 설정
			
			// 사용자 정보 설정
			paramMap.put("loginID", session.getAttribute("loginId"));
			if ("I".equals(action)) {
				// 그룹코드 신규 저장
				subservice.supCreate(paramMap,request);
				resultMsg = "SUCCESS";
			} else if("U".equals(action)) {
				// 그룹코드 수정 저장
				subservice.supUpdate(paramMap,request);
				resultMsg = "UPDATED";
				System.out.println(paramMap);
			} else {
				resultMsg = "FALSE : 등록에 실패하였습니다.";
			}
			
			//결과 값 전송
			Map<String, Object> resultMap = new HashMap<String, Object>();
			   resultMap.put("result", result);
			   resultMap.put("resultMsg", resultMsg);
		    
		    return resultMap;
		}
	
		// 자료실 삭제
		@RequestMapping("subDelete.do")
		@ResponseBody
		public Map<String,Object> subDelete(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request
				, HttpServletResponse response, HttpSession session) throws Exception{
			
			logger.info("+ Start " + className + ".subDelete");
			logger.info("   - paramMap : " + paramMap);
			
			String resultMsg ="DELETED";
			String result= "삭제 되었습니다.";
			
			subservice.supDelete(paramMap);
			
			Map<String,Object> resultMap = new HashMap<String,Object>();
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			return resultMap;
		}
}
