package ino.web.authority.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AuthorityDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	// 권한설정 메인 (그테이블)
	public List<HashMap<String, Object>> selectAuthorityList() {
		return sqlSessionTemplate.selectList("selectAuthorityList");
	}
	
	// 권한설정 메인 (객체테이블)
	public List<HashMap<String, Object>> objectList() {
		return sqlSessionTemplate.selectList("objectList");
	}
	
	// 권한설정 메인 (매핑 테이블)
	public List<HashMap<String, Object>> mappingList(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectList("mappingList" , map);
	}
	
	// 체크박스 선택 등록
	public List<HashMap<String, Object>> insertList(HashMap<String, Object> insertMap) {
		return sqlSessionTemplate.selectList("insertList" , insertMap);
	}

	// 체크박스 풀고 삭제 
	public List<HashMap<String, Object>> deleteList(HashMap<String, Object> deleteMap) {
		return sqlSessionTemplate.selectList("deleteList" , deleteMap);
	}
}
