package ino.web.freeBoard.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.commonCode.service.CommCodeService;
import ino.web.freeBoard.common.util.Pagination;
import ino.web.freeBoard.service.FreeBoardService;
import ino.web.freeBoard.service.FreeBoardServiceImpl;

@Repository
@Controller
public class FreeBoardController {

	@Autowired	// Autowired는 부르는 곳 1곳에 1개이다.
	private FreeBoardService freeBoardService;
	@Autowired	// Autowired는 부르는 곳 1곳에 1개이다.
	private CommCodeService commCodeService;
	
	// [1. 게시판 메인 리스트] = > [2. 서비스]
	@RequestMapping(value = "/main.ino")
	public ModelAndView main(HttpServletRequest request,
			@RequestParam(value = "searchType", defaultValue = "") String searchType,
			@RequestParam(value = "keyword", defaultValue = "") String keyword,
			@RequestParam(defaultValue = "1") int curPage
			) {

		ModelAndView mav = new ModelAndView();

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("searchType", searchType);
		map.put("keyword", keyword);
		map.put("curPage", curPage);
		map.put("startDate", request.getParameter("startDate"));
		map.put("endDate", request.getParameter("endDate"));
		
		List<HashMap<String, Object>> list = freeBoardService.freeBoardList(map);
		
		map.put("code", "COM001");
		List<HashMap<String, Object>> codeList = commCodeService.selectCommonCodeList(map);
		mav.addObject("codeList", codeList);
		
		mav.setViewName("boardMain");
		mav.addObject("freeBoardList", list);
		mav.addObject("map", map);

		return mav;
	}
	
	// 게시판 검색 후 메인화면 리스트
	@RequestMapping(value = "/searchAjax.ino")
	@ResponseBody
	public HashMap<String, Object> searchAjax(HttpServletRequest request,
		@RequestParam(value = "searchType", defaultValue = "") String searchType,
		@RequestParam(value = "keyword", defaultValue = "") String keyword,
		@RequestParam(value = "startDate", defaultValue = "") String startDate,
		@RequestParam(value = "endDate", defaultValue = "") String endDate,
		@RequestParam(defaultValue = "1") int curPage
			) throws Exception {

		HashMap<String, Object> map = new HashMap<String, Object>();
		// (1.) 키워드와 검색 조건을 먼저 가져오기
		map.put("keyword", keyword);
		map.put("searchType", searchType);
		map.put("curPage", curPage);
		// 날짜 검색 (0000-00-00 하이픈을 없애준다.)
		map.put("startDate", startDate.replaceAll("-", ""));
		map.put("endDate", endDate.replaceAll("-", ""));

		List<HashMap<String, Object>> list = freeBoardService.freeBoardList(map);
		// (6.) pagination 에 다시 리턴 해주고 적용시킨다. = > (7.) JSP 적용한다.
		map.put("list", list);

		return map;
	}
	
	// 게시판 리스트 글 상세보기
	@RequestMapping("/freeBoardDetail.ino")
	@ResponseBody
	public ModelAndView freeBoardDetail(HttpServletRequest request,
		@RequestParam(value = "curPage", defaultValue = "") int curPage,
		@RequestParam(value = "num", defaultValue = "") int num) {
		
		ModelAndView mav = new ModelAndView();

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("curPage", curPage);
		// 글번호에 해당하는 이름, 제목 , 내용을 가져 온다.
		HashMap<String, Object> detail = freeBoardService.getDetailByNum(num);
		mav.addObject("freeBoardDetail", detail);
		mav.addObject("map", map);

		return mav;
	}
	
	// 게시판 글 작성 페이지로 넘겨주는 컨트롤러
	@RequestMapping("/freeBoardInsert.ino")
	public String freeBoardInsert() {

		return "freeBoardInsert";
	}
	
	// 글쓰기 작성하기 (ajax)
	@RequestMapping(value = "/insertProAjax.ino")
	@ResponseBody
	public HashMap<String, Object> insertProAjax(HttpServletRequest request
		/* [리퀘스트](리퀘스트 파람 해서 데이터를 가져와두 된다.)
		@RequestParam(value = "title", defaultValue = "") String title,
		@RequestParam(value = "content", defaultValue = "") String content*/ ){
		HashMap<String, Object> map = new HashMap<String, Object>();
		// [리퀘스트](필수 입력하는 내용은 requestParam 위에 두지 말고 request에서 자체적으로 가져오는 것도 좋다.)
		map.put("title", request.getParameter("title"));
		map.put("name", request.getParameter("name"));
		map.put("content", request.getParameter("content"));


		freeBoardService.freeBoardInsertPro(map);
		
		return map;
	}
	
	// 글쓰기 수정하기 (ajax)
	@RequestMapping(value = "/modifyAjax.ino", method = RequestMethod.POST)
	@ResponseBody // json 방식은 붙여주어야한다.
	public HashMap<String, Object> modifyAjax(HttpServletRequest request,
		
		@RequestParam(value = "num", defaultValue = "") String num,
		@RequestParam(value = "title", defaultValue = "") String title,
		@RequestParam(value = "content", defaultValue = "") String content) throws Exception {

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("title", title);
		map.put("content", content);

		freeBoardService.freeBoardModify(map);
		
		return map;
	}
	
	// 글쓰기 삭제하기 (Ajax)
	@RequestMapping(value = "/DeleteAjax.ino", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> DeleteAjax(HttpServletRequest request,
		@RequestParam(value = "num", defaultValue = "") String num) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("num", num);

		freeBoardService.FreeBoardDelete(map);
		
		return map;
	}	
		
}
