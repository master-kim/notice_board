package ino.web.freeBoard.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public interface FreeBoardService {
	
	// [2. 서비스] = > [3. 서비스 임플]
	public List<HashMap<String, Object>> freeBoardList(HashMap<String, Object> map);

	// 게시판 글 갯수 가져오기
	public int getNewNum(HashMap<String, Object> map);

	// 게시판 리스트 글 상세보기
	public HashMap<String, Object> getDetailByNum(int num);

	// 게시판 글쓰기 버튼 후 글 작성 페이지로 넘어가기
	public HashMap<String, Object> freeBoardInsertPro(HashMap<String, Object> map);
	
	// 게시판 글쓰기 수정하기
	public HashMap<String, Object> freeBoardModify(HashMap<String, Object> map);
	
	// 게시판 글쓰기 삭제
	public HashMap<String, Object> FreeBoardDelete(HashMap<String, Object> map);
	
}