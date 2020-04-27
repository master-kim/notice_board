package ino.web.authority.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public interface AuthorityService {
	
	// 권한설정 메인(그룹 테이블)
	public List<HashMap<String, Object>> selectAuthorityList() throws Exception;

	// 권한설정 메인 (객체 테이블)
	public List<HashMap<String, Object>> objectList() throws Exception; 
	
	// 권한설정 메인 (매핑 테이블)
	public List<HashMap<String, Object>> mappingList(HashMap<String,Object> map) throws Exception;

	// 체크박스 선택 등록 
	public List<HashMap<String, Object>> insertList(HashMap<String, Object> insertMap) throws Exception;

	// 체크박스풀고 삭제
	public List<HashMap<String, Object>> deleteList(HashMap<String, Object> deleteMap) throws Exception;

	
		


}

