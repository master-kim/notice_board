package ino.web.freeBoard.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FreeBoardDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	// [4.DAO] 게시판 리스트 = > [5.맵퍼(xml)]
	public List<HashMap<String, Object>> freeBoardList(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectList("freeBoardGetList", map);
	}
	
	// 게시판 글 최대 갯수 가져오기 
	public int getNewNum(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectOne("freeBoardNewNum", map);
	}
	

	// 게시판 리스트 글 상세보기
	public HashMap<String, Object> freeBoardList(int num) {
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}
	
	// 게시판 글 작성 페이지
	public int freeBoardInsertPro(HashMap<String, Object> map) {
		return sqlSessionTemplate.insert("freeBoardInsertPro", map);
	}
	
	// 게시판 글 수정하기
	public int freeBoardModify(HashMap<String, Object> map) {
		return sqlSessionTemplate.update("freeBoardModify", map);
	}
	
	// 글쓰기 글 삭제하기
	public int FreeBoardDelete(HashMap<String, Object> map) {
		return sqlSessionTemplate.delete("freeBoardDelete", map);

	}
	
		

}
