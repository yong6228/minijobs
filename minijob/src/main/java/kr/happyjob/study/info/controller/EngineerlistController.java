package kr.happyjob.study.info.controller;

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

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.info.model.Engineercategory;
import kr.happyjob.study.info.model.Engineerlist;
import kr.happyjob.study.info.model.Engineerskill;
import kr.happyjob.study.info.service.EngineerlistService;
import kr.happyjob.study.system.model.ComnCodUtilModel;


@Controller
@RequestMapping("/info/")
public class EngineerlistController {
	
	@Autowired
	EngineerlistService engineerlistService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	// 프로젝트 목록 페이지
	@RequestMapping("engineerlist.do")
	public String initEngineerlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".initEngineerlist");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initEngineerlist");
		return "info/engineerlist";
	}
	
	/**
	 * 공통 그룹 코드 목록 조회
	 */
	@RequestMapping("listEngineerCod.do")
	public String listEngineerCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listEngineerCod");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 공통 그룹코드 목록 조회
		List<Engineerlist> listEngineerCod = engineerlistService.listEngineerCod(paramMap);
		model.addAttribute("listEngineerCod", listEngineerCod);
		
		// 공통 그룹코드 목록 카운트 조회
		int totalCount = engineerlistService.countListEngineerCod(paramMap);
		model.addAttribute("totalCntComnGrpCod", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnGrpCod",currentPage);
		
		logger.info("+ End " + className + ".listEngineerCod");
		

		return "/info/engineerCodList";
	}
	
	@RequestMapping("/listEngineerAll.do")
	@ResponseBody
	public Map<String, Object> listEngineerAll(@RequestParam Map<String, Object> paramMap) throws Exception {
		
		System.out.println("param: " + paramMap);

		
		//ComnCodUtil commcod = new ComnCodUtil();
		
		//List<ComnCodUtilModel> listlistCod = ComnCodUtil.getComnCod("LanguageCD");
	    //List<ComnCodUtilModel> weblistCod = ComnCodUtil.getComnCod("webCD");
	    //List<ComnCodUtilModel> dblistCod = ComnCodUtil.getComnCod("DBCD");
	    //List<ComnCodUtilModel> wslistCod = ComnCodUtil.getComnCod("WSCD");
		
		
		Engineerlist model = engineerlistService.listEngineerAll(paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("model", model);
		
		List<Engineerskill> skill = engineerlistService.listskill(paramMap);
		resultMap.put("skill", skill);
		
		List<Engineercategory> category = engineerlistService.listcategory(paramMap);
		resultMap.put("category", category);
		
		
		//resultMap.put("fwcdlist", fwcdlist);
		//resultMap.put("ntcdlist", ntcdlist);
		//resultMap.put("oscdlist", oscdlist);
		
		
		return resultMap;	
	}
	
	
	/**
	 *  공통 상세 코드 저장
	 */
	@RequestMapping("saveEngineerCod.do")
	@ResponseBody
	public Map<String, Object> saveEngineerCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveEngineerCod");
		logger.info("   - paramMap : " + paramMap);

		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		
		
		if ("I".equals(action)) {
			// 상세코드 신규 저장
			engineerlistService.insertEngineerCod(paramMap);
			
			skillinsert(paramMap);
			
			categoryinsert(paramMap);
			
		} else if("U".equals(action)) {
			// 상세코드 수정 저장
			engineerlistService.updateEngineerCod(paramMap);
			
			// login id 로 스킬 삭제
			engineerlistService.deleteSkillCod(paramMap);
			
			skillinsert(paramMap);
			
			engineerlistService.deleteCategoryCod(paramMap);
			
			categoryinsert(paramMap);

		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveEngineerCod");
		
		return resultMap;
	}
	
	private void skillinsert(Map<String, Object> paramMap) throws Exception {
		
		ComnCodUtil commcod = new ComnCodUtil();
		
		List<ComnCodUtilModel> listlistCod = ComnCodUtil.getComnCod("LanguageCD");
	    List<ComnCodUtilModel> weblistCod = ComnCodUtil.getComnCod("webCD");
	    List<ComnCodUtilModel> dblistCod = ComnCodUtil.getComnCod("DBCD");
	    List<ComnCodUtilModel> wslistCod = ComnCodUtil.getComnCod("WSCD");
	    
	    String key = "";
	    String groupcode = "";
	    
	    for(ComnCodUtilModel item : listlistCod) {
			key = item.getDtl_cod();
            groupcode = item.getGrp_cod();
			
			if("on".equals(paramMap.get(key))) {
				paramMap.put("group_code", groupcode);
				paramMap.put("detail_code", key);
				
				engineerlistService.insertSkillCod(paramMap);
			}
		}
		
		for(ComnCodUtilModel item : weblistCod) {
			key = item.getDtl_cod();
            groupcode = item.getGrp_cod();
			
            if("on".equals(paramMap.get(key))) {
				paramMap.put("group_code", groupcode);
				paramMap.put("detail_code", key);
				
				engineerlistService.insertSkillCod(paramMap);
			}
		}
		
		for(ComnCodUtilModel item : dblistCod) {
			key = item.getDtl_cod();
            groupcode = item.getGrp_cod();
			
            if("on".equals(paramMap.get(key))) {
				paramMap.put("group_code", groupcode);
				paramMap.put("detail_code", key);
				
				engineerlistService.insertSkillCod(paramMap);
			}
		}
		
		for(ComnCodUtilModel item : wslistCod) {
			key = item.getDtl_cod();
            groupcode = item.getGrp_cod();
			
            if("on".equals(paramMap.get(key))) {
				paramMap.put("group_code", groupcode);
				paramMap.put("detail_code", key);
				
				engineerlistService.insertSkillCod(paramMap);
			}
		}
	    
	    
		
	}
	
	private void categoryinsert(Map<String, Object> paramMap) throws Exception {
		
		
		if("on".equals(paramMap.get("SI"))) {
			
			paramMap.put("category", "SI");
			
			engineerlistService.insertCategoryCod(paramMap);
			
			
		}
		
		if("on".equals(paramMap.get("SM"))) {
			
			paramMap.put("category", "SM");
			
			engineerlistService.insertCategoryCod(paramMap);
			
			
		}
		
		if("on".equals(paramMap.get("Solution"))) {
			
			paramMap.put("category", "Solution");
			
			engineerlistService.insertCategoryCod(paramMap);
			
			
		}
		
		
	}
	
	
	
}
