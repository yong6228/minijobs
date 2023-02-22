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
import kr.happyjob.study.info.model.ProjectInterview;
import kr.happyjob.study.info.model.Projectlist;
import kr.happyjob.study.info.model.Projectskill;
import kr.happyjob.study.info.service.ProjectlistService;
import kr.happyjob.study.system.model.ComnCodUtilModel;

@Controller
@RequestMapping("/info/")
public class ProjectlistController {

	@Autowired
	ProjectlistService projectlistService;
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("projectlist.do")
	public String projectlist(Model model, @RequestParam Map<String, Object>paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".projectlist");
		logger.info("   - paramMap : " + paramMap);
		
		String usertype = (String) session.getAttribute("userType");
		String loginID = (String) session.getAttribute("loginId");
		String wName = (String) session.getAttribute("wname");

		model.addAttribute("usertype", usertype);
		model.addAttribute("loginID", loginID);
		model.addAttribute("wName", wName);
				
		logger.info("+ End " + className + ".projectlist");
		
		return "info/projectlist";
	}
	
	@RequestMapping("listProjectCod.do")
	public String listProjectCod(Model model, @RequestParam Map<String, Object>paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listProjectCod");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 공통 그룹코드 목록 조회
		List<Projectlist> listProjectCod = projectlistService.listProjectCod(paramMap);
		model.addAttribute("listProjectCod", listProjectCod);
		
		// 공통 그룹코드 목록 카운트 조회
		int totalCount = projectlistService.countListProjectCod(paramMap);
		model.addAttribute("totalCntComnGrpCod", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnGrpCod", currentPage);
		
		logger.info("+ End " + className + ".listProjectCod");
		
		
		return "/info/projectCodList";
	}
	
	@RequestMapping("listProjectAll.do")
	@ResponseBody
	public Map<String, Object> listProjectAll(@RequestParam Map<String, Object> paramMap) throws Exception {
		
		System.out.println("param: " + paramMap);

		Projectlist model = projectlistService.listProjectAll(paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("model", model);
		
		List<Projectskill> skill = projectlistService.listskill(paramMap);
		resultMap.put("skill", skill);
		
		List<ProjectInterview> interviewtype = projectlistService.listInterview(paramMap);
		resultMap.put("interviewtype", interviewtype);
		return resultMap;	
	}
	
	/* 프로젝트 저장*/
	@RequestMapping("saveProjectCod.do")
	@ResponseBody
	public Map<String, Object> saveProjectCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveProjectCod");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		
		if ("I".equals(action)) {
			// 프로젝트 신규 저장
			logger.info("   - action : " + action);
			projectlistService.insertProjectCod(paramMap);
			
			skillinsert(paramMap);
			
			interviewinsert(paramMap);
			
		} else if("U".equals(action)) {
			// 프로젝트 수정 저장
			logger.info("   - action : " + action);
			projectlistService.updateProjectCod(paramMap);
			
			// login id 로 스킬 삭제
			projectlistService.deleteSkillCod(paramMap);
			
			skillinsert(paramMap);
			
			projectlistService.deleteInterviewCod(paramMap);
			
			interviewinsert(paramMap);
			
		} else {
			logger.info("   - action : " + action);
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveProjectCod");
		
		return resultMap;
	}
	
	@RequestMapping("deleteProjectCod.do")
	@ResponseBody
	public Map<String, Object> deleteProjectCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".deleteComnGrpCod");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		projectlistService.deleteSkillCod(paramMap);
		
		projectlistService.deleteInterviewCod(paramMap);
		
		projectlistService.deleteProjectCod(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteComnGrpCod");
		
		return resultMap;
	}
	
	private void skillinsert(Map<String, Object> paramMap) throws Exception {
			
		ComnCodUtil commcod = new ComnCodUtil();
		
		List<ComnCodUtilModel> listlistCod = ComnCodUtil.getComnCod("LanguageCD");
	    List<ComnCodUtilModel> weblistCod = ComnCodUtil.getComnCod("webCD");
	    List<ComnCodUtilModel> dblistCod = ComnCodUtil.getComnCod("DBCD");
	    List<ComnCodUtilModel> wslistCod = ComnCodUtil.getComnCod("WSCD");
	    List<ComnCodUtilModel> oslistCod = ComnCodUtil.getComnCod("OSCD");
	    List<ComnCodUtilModel> networkCod = ComnCodUtil.getComnCod("NTCD");
	    List<ComnCodUtilModel> fwCod = ComnCodUtil.getComnCod("FWCD");
		      
	    String key = "";
	    String groupcode = "";
	    
	    for(ComnCodUtilModel item : listlistCod) {
			key = item.getDtl_cod();
            groupcode = item.getGrp_cod();
			
			if("on".equals(paramMap.get(key))) {
				paramMap.put("group_code", groupcode);
				paramMap.put("detail_code", key);
				
				projectlistService.insertSkillCod(paramMap);
			}
	    }
		
		for(ComnCodUtilModel item : weblistCod) {
			key = item.getDtl_cod();
            groupcode = item.getGrp_cod();
			
            if("on".equals(paramMap.get(key))) {
				paramMap.put("group_code", groupcode);
				paramMap.put("detail_code", key);
				
				projectlistService.insertSkillCod(paramMap);
			}
		}
		
		for(ComnCodUtilModel item : dblistCod) {
			key = item.getDtl_cod();
            groupcode = item.getGrp_cod();
			
            if("on".equals(paramMap.get(key))) {
				paramMap.put("group_code", groupcode);
				paramMap.put("detail_code", key);
				
				projectlistService.insertSkillCod(paramMap);
			}
		}
		
		for(ComnCodUtilModel item : wslistCod) {
			key = item.getDtl_cod();
            groupcode = item.getGrp_cod();
			
            if("on".equals(paramMap.get(key))) {
				paramMap.put("group_code", groupcode);
				paramMap.put("detail_code", key);
				
				projectlistService.insertSkillCod(paramMap);
			}
		}

		for(ComnCodUtilModel item : oslistCod) {
			key = item.getDtl_cod();
            groupcode = item.getGrp_cod();
			
            if("on".equals(paramMap.get(key))) {
				paramMap.put("group_code", groupcode);
				paramMap.put("detail_code", key);
				
				projectlistService.insertSkillCod(paramMap);
			}
		}
		
		for(ComnCodUtilModel item : networkCod) {
			key = item.getDtl_cod();
            groupcode = item.getGrp_cod();
			
            if("on".equals(paramMap.get(key))) {
				paramMap.put("group_code", groupcode);
				paramMap.put("detail_code", key);
				
				projectlistService.insertSkillCod(paramMap);
			}
		}
		
		for(ComnCodUtilModel item : fwCod) {
			key = item.getDtl_cod();
            groupcode = item.getGrp_cod();
			
            if("on".equals(paramMap.get(key))) {
				paramMap.put("group_code", groupcode);
				paramMap.put("detail_code", key);
				
				projectlistService.insertSkillCod(paramMap);
			}
		}
	}
	private void interviewinsert(Map<String, Object> paramMap) throws Exception {
		if("on".equals(paramMap.get("tel"))) {
			paramMap.put("interviewtype", "tel");
			projectlistService.insertInterviewCod(paramMap);
		}
		
		if("on".equals(paramMap.get("join"))) {
			paramMap.put("interviewtype", "join");
			projectlistService.insertInterviewCod(paramMap);
		}
	}
}
