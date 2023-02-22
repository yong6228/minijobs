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

import kr.happyjob.study.myinfo.model.MModel;
import kr.happyjob.study.myinfo.service.MService;

@Controller
@RequestMapping("/myinfo/")
public class MController {
	
	@Autowired
	MService mservice;
	
	// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		private final String className = this.getClass().toString();

	@RequestMapping("message.do")
	public String message(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".message");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".message");

		return "myinfo/message";
	}
	
	@RequestMapping("message1.do")
	public String message1(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".message1");
		logger.info("   - paramMap : " + paramMap);			
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		
		List<MModel> searchlist = mservice.message1(paramMap);		
		model.addAttribute("searchlist", searchlist);
		
		int searchlistcnt = mservice.searchlistcnt(paramMap);
		model.addAttribute("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".message1");

		return "myinfo/message1";
	}
	
	// 단건 조회
@RequestMapping("selectj.do")
@ResponseBody
public Map<String, Object> selectj(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		HttpServletResponse response, HttpSession session) throws Exception {
	
	logger.info("+ Start " + className + ".selectj");
	logger.info("   - paramMap : " + paramMap);			
	int note_id=Integer.parseInt((String)paramMap.get("note_id"));
	paramMap.put("note_id", note_id);
	MModel searchone = mservice.selectj(paramMap);
	
	Map<String, Object> returnmap = new HashMap<String, Object>();
	
	returnmap.put("result", "SUCESS");
	returnmap.put("searchone", searchone);
	
	
	logger.info("+ End " + className + ".selectj");

	return returnmap;
}	

@RequestMapping("savenote.do")
@ResponseBody
public Map<String, Object> savenote(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		HttpServletResponse response, HttpSession session) throws Exception {
	
	logger.info("+ Start " + className + ".savenote");
	logger.info("   - paramMap : " + paramMap);			
	
	paramMap.put("note_id",(String) session.getAttribute("note_id"));
	
	String action = String.valueOf(paramMap.get("action"));
	
	if("I".equals(action)) {
		mservice.insertNotice(paramMap);
	} else if("U".equals(action)) {
		mservice.updateNotice(paramMap);
	} else if("D".equals(action)) {
		mservice.deleteNotice(paramMap);
	}
	
	Map<String, Object> returnmap = new HashMap<String, Object>();
	
	returnmap.put("result", "SUCESS");
	
	logger.info("+ End " + className + ".savenote");

	return returnmap;
}		


}
