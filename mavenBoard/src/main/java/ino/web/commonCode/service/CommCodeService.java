package ino.web.commonCode.service;

import java.util.HashMap;
import java.util.List;
import org.springframework.stereotype.Service;


@Service
public interface CommCodeService {
	// 공통코드 메인
	public List<HashMap<String, Object>> selectMasterCodeList() throws Exception; 
	
	// 게시판 공통코드 (searchType 목록)
	public List<HashMap<String, Object>> selectCommonCodeList(HashMap<String, Object> map);
	
	// 공통코드 상세보기
	public List<HashMap<String, Object>> detailCommonCodeList(HashMap<String, Object> map);

	// 공통코드 중복 체크하기
	public int count(HashMap<String, Object> paramMap) throws Exception;
	
	// 공통코드 추가
	public int insertCommonCodeList(HashMap<String, Object> paramMap) throws Exception;
	
	// 공통코드 수정하기
	public int ModifyCommonCodeList(HashMap<String, Object> paramMap2)throws Exception;

	// 공통코드 삭제하기
	public int DeleteCommonCodeList(HashMap<String, Object> paramMap3)throws Exception;

	
}

