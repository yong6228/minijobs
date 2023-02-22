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

import kr.happyjob.study.community.model.FreeBoardModel;
import kr.happyjob.study.community.service.FreeBoardService;

@Controller
@RequestMapping("/community")
public class FreeBoardController {

	@Autowired
	private FreeBoardService freeboardservice;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	// 자유게시판 메인페이지
	@RequestMapping("board.do")
	public String freeboard(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request
			, HttpServletResponse response, HttpSession session) throws Exception{

		logger.info("+ Start " + className + ".freeboard");
		logger.info("   - paramMap : " + paramMap);

		String loginID =  (String)session.getAttribute("loginId");
		//paramMap.put("loginID", loginID);

		model.addAttribute("curloginID", loginID);

		return "community/FreeBoard";
	}

	// 자유게시판 리스트 호출
	@RequestMapping("FreeBoardList.do")
	public String  FreeBoardList(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request
			, HttpServletResponse response, HttpSession session) throws Exception{

		logger.info("   - paramMap : " + paramMap);
		String title = (String)paramMap.get("title");

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("title", title);

		// 자유게시판 목록 조회
		List<FreeBoardModel> freeList = freeboardservice.boardList(paramMap);
		model.addAttribute("freeList",freeList);

		// 목록 수 추출해서 보내기
		int freeCnt = freeboardservice.boardCnt(paramMap);
		model.addAttribute("freeCnt",freeCnt);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("currentPage",currentPage);

		return "community/FreeBoardList";
	}

	// 자유게시판 상세 조회
	@RequestMapping("detailBoard.do")
	@ResponseBody
	public Map<String,Object> detailBoard(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request
			, HttpServletResponse response, HttpSession session) throws Exception{

		logger.info("+ Start " + className + ".detailBoard");
		logger.info("   - paramMap : " + paramMap);

		String result = "";
		String resultMsg = "";
		
		// 선택된 게시판 1건 조회
		FreeBoardModel detailBoard = freeboardservice.boradDetail(paramMap);
		System.out.println("====================" + detailBoard);
		
		if(detailBoard != null) {
			result = "SUCCESS";  // 성공시 찍습니다. 
			resultMsg = "조회 되었습니다";
		}else {
			resultMsg = "FAIL / 불러오기에 실패했습니다.";  // null이면 실패입니다.
			
		}

		Map<String,Object> resutlMap = new HashMap<String, Object>();
		resutlMap.put("result",result );
		resutlMap.put("resultMsg",resultMsg );
		resutlMap.put("detailBoard", detailBoard);

		logger.info("+ End " + className + ".detailBoard");
		return resutlMap;		

	}
	
	// 자유게시판 신규등록, 업데이트
	@RequestMapping("boradSave.do")
	@ResponseBody
	public Map<String,Object> boradSave(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request
			, HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".boradSave");
		logger.info("   - paramMap : " + paramMap);
		
	   String action = (String)paramMap.get("action");
	   String result = "";
	   String resultMsg = "";
	// 사용자 정보 설정
	   

	   paramMap.put("loginID", session.getAttribute("longinId"));
	   
	   if("I".equals(action)){
			// 그룹코드 신규 저장
		   freeboardservice.createBorad(paramMap);
		   result = "SUCCESS";
		   resultMsg = "신규 등록 되었습니다";
	   }
	   else if("U".equals(action)){
			// 그룹코드 수정 저장
		   freeboardservice.updateBorad(paramMap);
		   result = "UPDATED";
		   resultMsg = "수정 되었습니다";
	   }else {
		   resultMsg = "FALSE: 등록에 실패하였습니다.";
	   }
	   
		//결과 값 전송
	   Map<String,Object> resultMap = new HashMap<String,Object>();
	   resultMap.put("result", result);
	   resultMap.put("resultMsg", resultMsg);
	   
	   return resultMap;
	}
	
	// 자유게시판 삭제
	@RequestMapping("boardDelete.do")
	@ResponseBody
	public Map<String,Object> boardDelete(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request
			, HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".boradSave");
		logger.info("   - paramMap : " + paramMap);
		
		String result ="DELETED";
		String resultMsg = "삭제 되었습니다.";
		
		freeboardservice.deleteBoard(paramMap);
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		return resultMap;
	}
}
