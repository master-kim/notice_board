package ino.web.authority.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ino.web.authority.dao.AuthorityDAO;

@Repository
public class AuthorityServiceImpl implements AuthorityService {

	@Autowired
	private AuthorityDAO authorityDAO;
	// 권한설정 (그룹 테이블)
	@Override
	public List<HashMap<String, Object>> selectAuthorityList() throws Exception {
		return authorityDAO.selectAuthorityList();
	}
	
	// 권한설정 (객체 테이블)
	@Override
	public List<HashMap<String, Object>> objectList() throws Exception {
		return authorityDAO.objectList();
	}

	// 권한설정 메인 (매핑 테이블)
	@Override
	public List<HashMap<String, Object>> mappingList(HashMap<String,Object> map) throws Exception {
		return authorityDAO.mappingList(map);
	}

	// 체크박스 선택 등록 
	@Override
	public List<HashMap<String, Object>> insertList(HashMap<String, Object> insertMap) throws Exception {
		return authorityDAO.insertList(insertMap);
	}

	// 체크박스 풀고 삭제 
	@Override
	public List<HashMap<String, Object>> deleteList(HashMap<String, Object> deleteMap) throws Exception {
		return authorityDAO.deleteList(deleteMap);
		}

}
