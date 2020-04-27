package ino.web.freeBoard.common.util;

public class Pagination {
	
	// [1]. 페이지 네이션 각 변수이름을 지정해준다.
	public static final int PaginationCnt = 10;  // 페이지 네이션 갯수
	public static final int BlockCnt = 10; 		 // 한 페이지 당 글의 갯수
	
	private int curPage;			// 현재 페이지 번호
	private int startPage;			// 페이지 네이션 시작 값
	private int endPage;			// 페이지 네이션 마지막 값
	private int pageRange;			// 페이지 네이션 범위 값
	private int totalPage;			// 페이지 네이션 전체 갯수 값
	private int startText;			// 현재 페이지 글의 시작 번호
	private int endText;			// 현재 페이지 글의 끝 번호
	private int curText;			// 현재 글의 번호 값
	private int TextRange;			// 현재 글의 범위 값
	private int totalText;			// 전체 글의 갯수 값
	private int prevPage;  			// 이전 페이지
	private int nextPage;   		// 다음 페이지
	
	
	//[3.] 생성자를 생성해준다. (계산식 하기 위함) = > [4.]컨트롤러 고고
	
	public Pagination(int count, int curPage){
		
		// [6. 계산식을 작성한다.] = > 간단한건 여기서 계산 (복잡한건 따로 계산 실행[코드 보기 편하기 위해])
		startText = 1; 				 // 글의 시작 번호를 1로 초기화 해준다.
		this.curPage = curPage;		 // 현재 페이지 번호를 지정 해준다.
		this.totalText = count;		 // 전체 글 개수를 변수에 담아준다.
		settotalPage(count);		 // [7.1] 전체 페이지 갯수 함수 호출
		setPageRange();				 // [7.2] 페이지 범위를 호출
		setTextRange();				 // [7.3] 텍스트 범위 호출
		
	}
	//[7. 생성자 길어지므로 복잡한거 따로 계산 후 불러오기]
	// [7.1] 전체 페이지 갯수 = 전체 글의 갯수 / 페이지당 글의 갯수
	public void settotalPage(int count){
		totalPage = this.totalText / BlockCnt;	// 전체 페이지 갯수 = 전체 글의 갯수 / 페이지당 글의 갯수
		if (this.totalText % BlockCnt > 0) {	// 나눈 값이 0으로 딱 떨어지지 않으면 1페이지를 추가한다.
			totalPage++;
		}
		if (this.curPage > this.totalPage) {	// 전체 페이지 갯수보다 현재 페이지가 크면 전체 페이지로 변경한다.
			this.curPage = this.totalPage;
		}
	}
	// [7.2] 글의 범위 만들기
		public void setTextRange() {
			// 현재 페이지가 몇번째 페이지 블록에 속하는지 계산
	        curText = (int)Math.ceil((curPage-1) / BlockCnt)+1;
	        // 현재 페이지 블록의 시작, 끝 번호 계산
	        startText = (curText-1)*BlockCnt+1;
	        // 페이지 블록의 끝번호
	        endText = startText+BlockCnt-1;
	        // 마지막 블록이 범위를 초과하지 않도록 계산
	        if(endText > totalPage) endText = totalPage;
	        // 이전을 눌렀을 때 이동할 페이지 번호
	        prevPage = curPage-1;
	        // 다음을 눌렀을 때 이동할 페이지 번호
	        nextPage = curPage+1;
	        // 마지막 페이지가 범위를 초과하지 않도록 처리
	        if(nextPage >= totalPage) nextPage = totalPage;
	    }
		
		
		// [7.3] 페이지 네이션 범위 만들기  = > [8.]컨트롤러 고고
		public void setPageRange() {	// WHERE rnum BETWEEN #{start} AND #{end} 맵퍼에서 사용 위함
			// 시작번호 = (현재페이지-1)*페이지당 게시물수 +1
			this.startPage = (this.curPage - 1) * PaginationCnt + 1;  
			// 끝번호 = 시작번호+페이지당 게시물수 -1
			this.endPage = (this.startPage + PaginationCnt) - 1;	 
	    }
		
		
		// [2.] final을 제외 getter and setter을 해준다.
		public int getCurPage() {
			return curPage;
		}
		public void setCurPage(int curPage) {
			this.curPage = curPage;
		}
		public int getStartPage() {
			return startPage;
		}
		public void setStartPage(int startPage) {
			this.startPage = startPage;
		}
		public int getEndPage() {
			return endPage;
		}
		public void setEndPage(int endPage) {
			this.endPage = endPage;
		}
		public int getPageRange() {
			return pageRange;
		}
		public void setPageRange(int pageRange) {
			this.pageRange = pageRange;
		}
		public int getTotalPage() {
			return totalPage;
		}
		public void setTotalPage(int totalPage) {
			this.totalPage = totalPage;
		}
		public int getStartText() {
			return startText;
		}
		public void setStartText(int startText) {
			this.startText = startText;
		}
		public int getEndText() {
			return endText;
		}
		public void setEndText(int endText) {
			this.endText = endText;
		}
		public int getCurText() {
			return curText;
		}
		public void setCurText(int curText) {
			this.curText = curText;
		}
		public int getTextRange() {
			return TextRange;
		}
		public void setTextRange(int textRange) {
			TextRange = textRange;
		}
		public int getTotalText() {
			return totalText;
		}
		public void setTotalText(int totalText) {
			this.totalText = totalText;
		}
		public int getPrevPage() {
			return prevPage;
		}
		public void setPrevPage(int prevPage) {
			this.prevPage = prevPage;
		}
		public int getNextPage() {
			return nextPage;
		}
		public void setNextPage(int nextPage) {
			this.nextPage = nextPage;
		}
}
