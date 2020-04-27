package ino.web.commonCode.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommCodeDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	// 공통코드 메인
	public List<HashMap<String, Object>> selectMasterCodeList() {
		return sqlSessionTemplate.selectList("selectMasterCodeList");
	}
	
	// 게시판 공통코드 (searchType 목록)
	public List<HashMap<String, Object>> selectCommonCodeList(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectList("selectCommonCodeList" , map);
	}

	// 공통코드 상세보기
	public List<HashMap<String, Object>> detailCommonCodeList(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectList("detailCommonCodeList" , map);
	}
	
	// 공통코드 중복 체크하기
	public int count(HashMap<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("count", paramMap);
	}

	// 공통코드 추가
	public int insertCommonCodeList(HashMap<String, Object> paramMap) {
		return sqlSessionTemplate.insert("insertCommonCodeList", paramMap);
	}
	
	// 공통코드 수정하기
	public int ModifyCommonCodeList(HashMap<String, Object> paramMap2) {
		return sqlSessionTemplate.update("ModifyCommonCodeList", paramMap2);
	}

	// 공통코드 삭제하기
	public int DeleteCommonCodeList(HashMap<String, Object> paramMap3) {
		return sqlSessionTemplate.update("DeleteCommonCodeList", paramMap3);
	}

}
