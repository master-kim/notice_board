package ino.web.commonCode.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import ino.web.commonCode.dao.CommCodeDAO;

@Repository
public class CommCodeServiceImpl implements CommCodeService {

	@Autowired
	private CommCodeDAO CommCodeDao;
	// 공통코드 메인
	@Override
	public List<HashMap<String, Object>> selectMasterCodeList() throws Exception {
		return CommCodeDao.selectMasterCodeList();
	}
	
	// 게시판 공통코드 (searchType 목록)
    @Override
	public List<HashMap<String, Object>> selectCommonCodeList(HashMap<String, Object> map) {
		return CommCodeDao.selectCommonCodeList(map);
	}
    
    // 공통코드 상세보기
    @Override
	public List<HashMap<String, Object>> detailCommonCodeList(HashMap<String, Object> map) {
		return CommCodeDao.detailCommonCodeList(map);
	}
    
	// 공통코드 중복 체크하기
	@Override
	public int count(HashMap<String, Object> paramMap) throws Exception {
		return CommCodeDao.count(paramMap);
	}

    // 공통코드 추가하기
	@Override
	@Transactional
	public int insertCommonCodeList(HashMap<String, Object> paramMap) throws Exception {
		return CommCodeDao.insertCommonCodeList(paramMap);
	}
	
	// 공통코드 수정하기
	@Override
	@Transactional
	public int ModifyCommonCodeList(HashMap<String, Object> paramMap2) throws Exception {
		return CommCodeDao.ModifyCommonCodeList(paramMap2);
	}
	
	// 공통코드 삭제하기
	@Override
	@Transactional
	public int DeleteCommonCodeList(HashMap<String, Object> paramMap3) throws Exception {
		return CommCodeDao.DeleteCommonCodeList(paramMap3);
	}

}
