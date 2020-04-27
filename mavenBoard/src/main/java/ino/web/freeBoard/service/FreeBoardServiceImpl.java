package ino.web.freeBoard.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ino.web.freeBoard.common.util.Pagination;
import ino.web.freeBoard.dao.FreeBoardDAO;

@Repository
public class FreeBoardServiceImpl implements FreeBoardService {

	@Autowired
	private FreeBoardDAO freeBoardDao;
	//[3. 서비스 임플] = > [4. DAO]
	@Override
	public List<HashMap<String, Object>> freeBoardList(HashMap<String, Object> map) {
		// (컨트롤러에서 key 값 = > 서비스에서 받기)
		
		int count = freeBoardDao.getNewNum(map);
		int curPage = (int) map.get("curPage");
		
		Pagination pagination = new Pagination(count, curPage);
		map.put("start", pagination.getStartPage());
		map.put("end", pagination.getEndPage());	
		map.put("pagination", pagination);
		
		return freeBoardDao.freeBoardList(map);
	}
	// 게시판 글 갯수 가져오기
	@Override
	public int getNewNum(HashMap<String, Object> map) {
		return freeBoardDao.getNewNum(map);
	}
	
	// 게시판 상세보기
	@Override
	public HashMap<String, Object> getDetailByNum(int num) {
		return freeBoardDao.freeBoardList(num);	
	}
	
	// 게시판 글쓰기
	@Override
	public HashMap<String, Object> freeBoardInsertPro(HashMap<String, Object>map) {
		
	      try {

	         int cnt = freeBoardDao.freeBoardInsertPro(map);

	         if (cnt == 1) {
	            map.put("reusltStr", "success");
	         } else {
	            map.put("reusltStr", "fail");
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      }

		return map;
		
	}
	
	// 게시판 글쓰기 수정하기
	@Override
	public HashMap<String, Object> freeBoardModify(HashMap<String, Object> map) {
		  	  
	      try {

	         int cnt = freeBoardDao.freeBoardModify(map);

	         if (cnt == 1) {
	            map.put("reusltStr", "success");
	         } else {
	            map.put("reusltStr", "fail");
	         }

	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      
	      return map;

	   }
	
	// 글쓰기 글 삭제하기
	@Override
	public HashMap<String, Object> FreeBoardDelete(HashMap<String, Object> map){

	      try {
	         String result = "";
	         int cnt = freeBoardDao.FreeBoardDelete(map);

	         if (cnt == 1) {
	            map.put("result", "success");
	         } else {
	            map.put("result", "fail");
	         }

	      } catch (Exception e) {
	         e.printStackTrace();
	      }

	      return map;
	}

}
