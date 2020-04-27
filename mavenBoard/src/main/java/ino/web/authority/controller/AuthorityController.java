package ino.web.authority.controller;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.authority.service.AuthorityService;

@Repository
@Controller
public class AuthorityController {
	@Autowired 
	private AuthorityService authorityService;
	
	// 그룹 테이블 조회 권한설정 메인 화면
	@RequestMapping("/authorityMain.ino")
	@ResponseBody
	public ModelAndView authorityMain(HttpServletRequest req ,
		@RequestParam(value = "groupId", defaultValue = "") String groupId)throws Exception{
		
		ModelAndView mav = new ModelAndView();
		List<HashMap<String,Object>> authorityList = authorityService.selectAuthorityList();
		
		mav.addObject("authorityList" , authorityList);
		mav.setViewName("authorityMain");
		
		return mav;
	}
	
	// 객체 권한 테이블 조회
	@RequestMapping("/authorityDetail.ino")
	@ResponseBody
	public HashMap<String, Object> authorityDetail(HttpServletRequest req ,
		@RequestParam(value = "groupId", defaultValue = "") String groupId)throws Exception{
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("groupId", groupId);

		List<HashMap<String, Object>> mappingList = authorityService.mappingList(map);
		
		map.put("mappingList", mappingList);
		
		List<HashMap<String, Object>> objectList = authorityService.objectList();
		
		map.put("objectList", objectList);
		
		return map;
	}
	
	// 객체 권한 테이블 인서트
	@SuppressWarnings("unchecked")
	// 아래의 if문 중 배열의 크기를 통해 if문 비교함의 용도 이므로 안정하다.
	@RequestMapping("/authorityInsert.ino")
	@ResponseBody
	public HashMap<String, Object> authorityInsert(HttpServletRequest req,
		@RequestBody HashMap<String, Object> params) throws Exception {
		
		Object deleteList = params.get("deleteList");
		Object insertList = params.get("insertList");
		Object groupId = params.get("groupId");
		
		HashMap<String,Object> deleteMap = new HashMap<String,Object>();
		deleteMap.put("deleteList", deleteList);
		
		HashMap<String,Object> insertMap = new HashMap<String,Object>();
		
		insertMap.put("insertList", insertList);
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("deleteList", deleteList);
		map.put("insertList", insertList);
		
		map.put("groupId", groupId);
		if(((List<HashMap<String, Object>>) insertList).size() != 0){
			authorityService.insertList(insertMap);
		}
		if(((List<HashMap<String, Object>>) deleteList).size() != 0){
			authorityService.deleteList(deleteMap);
		}
			
		List<HashMap<String, Object>> mappingList = authorityService.mappingList(map);
		
		map.put("mappingList", mappingList);
		
		List<HashMap<String, Object>> objectList = authorityService.objectList();
		
		map.put("objectList", objectList);
		
		
		return map;
	}
		
}
