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

import kr.happyjob.study.myinfo.model.SMModel;
import kr.happyjob.study.myinfo.service.SMService;

@Controller
@RequestMapping("/myinfo/")
public class SMController {
	
	@Autowired
	SMService smservice;

	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("smessage.do")
	public String smessage(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".smessage");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".smessage");

		return "myinfo/smessage";
	}
	
	@RequestMapping("smessage1.do")
	public String smessage1(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".smessage1");
		logger.info("   - paramMap : " + paramMap);			
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		
		List<SMModel> searchlist = smservice.smessage1(paramMap);		
		model.addAttribute("searchlist", searchlist);
		
		int searchlistcnt = smservice.searchlistcnt(paramMap);
		model.addAttribute("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".smessage1");

		return "myinfo/smessage1";
	}
	
	
	// 단건 조회
	@RequestMapping("selectSS.do")
	@ResponseBody
	public Map<String, Object> selectSS(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectSS");
		logger.info("   - paramMap : " + paramMap);			
		int note_id=Integer.parseInt((String)paramMap.get("note_id"));
		paramMap.put("note_id", note_id);
		SMModel searchone = smservice.selectSS(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		returnmap.put("searchone", searchone);
		
		
		logger.info("+ End " + className + ".selectSS");

		return returnmap;
	}	
	
	
	@RequestMapping("savelist0819.do")
	@ResponseBody
	public Map<String, Object> savelist0819(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".savelist0819");
		logger.info("   - paramMap : " + paramMap);			
		
		paramMap.put("loginID",(String) session.getAttribute("loginID"));
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)) {
			smservice.insertNotice0819(paramMap);
		} else if("U".equals(action)) {
			smservice.updateNotice0819(paramMap);
		} else if("D".equals(action)) {
			smservice.deleteNotice0819(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		
		logger.info("+ End " + className + ".savelist0819");

		return returnmap;
	}		
	
	
}
