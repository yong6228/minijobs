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

import kr.happyjob.study.info.model.PJModel;
import kr.happyjob.study.info.service.PJservice;

@Controller
@RequestMapping("/info/")
public class PJController {
	
	@Autowired
	PJservice pjservice;

	// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		private final String className = this.getClass().toString();
	
		@RequestMapping("projectlist2.do")
		public String projectlist2(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".projectlist2");
			logger.info("   - paramMap : " + paramMap);
			
			
			logger.info("+ End " + className + ".projectlist2");
			
			
			

			return "info/projectlist2";
		}
		
		@RequestMapping("pjlist.do")
		public String pjlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".pjlist");
			logger.info("   - paramMap : " + paramMap);			
			
			int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
			int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
			int startnum = (clickpagenum - 1) * pagesize;
			
			paramMap.put("startnum", startnum);
			paramMap.put("pagesize", pagesize);
			
			
			List<PJModel> searchlist = pjservice.pjlist(paramMap);		
			model.addAttribute("searchlist", searchlist);
			
			int searchlistcnt = pjservice.searchlistcnt(paramMap);
			model.addAttribute("searchlistcnt", searchlistcnt);
			
			logger.info("+ End " + className + ".pjlist");

			return "info/pjlist";
		}
		
		
		// 단건 조회
		@RequestMapping("selectpjlist.do")
		@ResponseBody
		public Map<String, Object> selectpjlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".selectpjlist");
			logger.info("   - paramMap : " + paramMap);			
			int projectID=Integer.parseInt((String)paramMap.get("projectID"));
			paramMap.put("projectID", projectID);
			PJModel searchone = pjservice.selectpjlist(paramMap);
		
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			returnmap.put("result", "SUCESS");
			returnmap.put("searchone", searchone);
			
			
			logger.info("+ End " + className + ".selectpjlist");

			return returnmap;
		}	
		
}
