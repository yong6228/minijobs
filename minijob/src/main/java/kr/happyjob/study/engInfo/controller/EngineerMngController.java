package kr.happyjob.study.engInfo.controller;

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

import kr.happyjob.study.engInfo.model.EngineerMngModel;
import kr.happyjob.study.engInfo.service.EngineerMngService;


@Controller
@RequestMapping("/enginfo/")
public class EngineerMngController {
	
	@Autowired
	EngineerMngService engineerMngService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	private final String className = this.getClass().toString();
	
	@RequestMapping("engineerlist.do")
	public String initEngineerList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start" + className + ".initEngineerList");
		logger.info("  - paramMap : " + paramMap);
		
		logger.info(" + End " + className + ".initEngineerList");
		return "enginfo/engineerMng";
	}
	@RequestMapping("listEngineerCod.do")
	public String listEngineerCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".listEngineerCod");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage-1)*pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<EngineerMngModel> listEngineerCod = engineerMngService.listEngineerCod(paramMap);
		model.addAttribute("listEngineerCod", listEngineerCod);
		
		int totalCount = engineerMngService.countListEngineerCod(paramMap);
		model.addAttribute("totalCount", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnGrpCod", currentPage);
		
		logger.info(" + End" + className + ".listEngineerCod");
		
		return "/enginfo/engineerCodList";
		
	}

	
}
