package kr.happyjob.study.myinfo.controller;

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

import kr.happyjob.study.myinfo.model.MyinfoCModel;
import kr.happyjob.study.myinfo.service.MyinfoCService;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

@Controller
@RequestMapping("/myinfo/")
public class MyinfoController{
	
	@Autowired
	MyinfoCService myinfoCService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 공통코드 관리 초기화면
	 */
	@RequestMapping("myinfo.do")
	public String initComnCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initComnCod");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String)session.getAttribute("loginId");
		model.addAttribute("loginID", loginID);

		String usertype = (String) session.getAttribute("userType");
		String viewname ="";
		
		if("C".equals(usertype)) {
		       viewname = "myinfo/myinfoCg";
		       
		
		} else if("B".equals(usertype)) {
			   viewname = "myinfo/myinfoBg";
			
			   
		}	
		
		logger.info("+ End " + className + ".initComnCod");
		
		
		
		return viewname;
	}
	
	
	@RequestMapping("/fSelectPersCod.do")
	@ResponseBody
	public Map<String, Object> fSelectGrpCod (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".fSelectPersCod");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String)session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		
		// 공통 그룹 코드 단건 조회
		MyinfoCModel modelC = myinfoCService.fSelectPersCod(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("modelC", modelC);
		
		logger.info("+ End " + className + ".fSelectPersCod");
		
		return resultMap;
	}
	
	
	


}
