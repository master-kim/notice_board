<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#infoDiv
	{margin-top:30px; margin-left:150px; background-color: #F5D08A; 
	border: 1.5px ridge white; width: 450px; height: 50px; padding: 5px;
	text-align: center; line-height: 50px; vertical-align: middle;}
	#btnSearch {
		position:absolute;
		left:815px;
		top:140px;
		height:45px;
	}
	 #startDate {
        text-align:center;
        width:100px;    
    }
    #endDate {
        text-align:center;
        width:105px;    
    }
   
</style>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	// -------------------[1].날짜 자동 완성 하이픈 0000-00-00   --------------------------
 	$(function () {
         $('#startDate').keydown(function (event) {
          var key = event.charCode || event.keyCode || 0;
          $text = $(this); 
          if (key !== 8 && key !== 9) {
              if ($text.val().length === 4) {
                  $text.val($text.val() + '-');
              }
              if ($text.val().length === 7) {
                  $text.val($text.val() + '-');
              }
          }
          return ;
      })
      
      $('#endDate').keydown(function (event) {
          var key = event.charCode || event.keyCode || 0;
          $text = $(this); 
          if (key !== 8 && key !== 9) {
              if ($text.val().length === 4) {
                  $text.val($text.val() + '-');
              }
              if ($text.val().length === 7) {
                  $text.val($text.val() + '-');
              }
          }
          return ;
      })   
	});
	
 	// -------------------[1].날짜 자동 완성 하이픈 0000-00-00 종료지점--------------------------
	$("#btnSearch").click(function(){

		// [1].변수 설정
		var searchType = $("#searchType").val();
		var keyword = $("#keyword").val();

		// ---------------------- <1.>날짜 검색 변수<.1> ----------------------
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		
		var startArrDate = $("#startDate").val().split("-");
		var endArrDate = $("#endDate").val().split("-");
		
		var startYear = Number(startArrDate[0]);
		var startMonth  = Number(startArrDate[1]);
		var startDay  = Number(startArrDate[2]);
		
		var endYear = Number(endArrDate[0]);
		var endMonth  = Number(endArrDate[1]);
		var endDay  = Number(endArrDate[2]);
		
		// [1달 검색 조건 만들기]
		var monthCompare = endMonth > startMonth;
		var dayCompare = endDay > startDay;
		var notNull = startDate != "" && endDate !="";
		var nextYear = ((endYear > startYear) && (startMonth == "12"));
		var nextMonth = ((endMonth <= startMonth) && (endDay > startDay));
		var nextMonth2 = ((endMonth <= startMonth) && (endDay < startDay) && (endMonth !="1"));
		// ---------------------- <1.>날짜 검색 변수 종료 지점<.1> ----------------------
		// [2]. 예외처리 하기
		if((keyword == "" && startDate == "") || (keyword =="" && startDate == "")){
			alert("검색어를 입력하지 않으면 전체 리스트가 조회됩니다.");
			$("#keyword").focus(); 	
		}
		else if(searchType == "DECODE002" && isNaN(keyword)){
			alert("번호를 입력해주세요.");
			$("#keyword").val("");
			$("#keyword").focus();
			return false;
		} 
		
		// ---------------------- <2.>날짜 검색 예외처리<.2> ----------------------
		if ((startDate !="") && ((startYear >= endYear) && (startMonth > endMonth && startDay > endDay))){
			alert("시작일 보다 종료일이 빠를 수 없습니다.");
			$("#endDate").val("");
			$("#endDate").focus();
			return false;
		} 
		
		// [1달 검색 조건 만들기]
		if (((notNull) && (monthCompare && dayCompare)) || ((notNull) && (monthCompare && dayCompare))) {
     		alert("최대 검색 기간은 1달입니다.");
     		$("#endDate").val("");
			$("#endDate").focus();
     		return false;
		} else if ((notNull) && (nextYear && nextMonth)){
			alert("최대 검색 기간은 1달입니다.");
			$("#endDate").val("");
			$("#endDate").focus();
     		return false;
		}else if((notNull) && (nextYear && nextMonth2)){
			alert("최대 검색 기간은 1달입니다.");
			$("#endDate").val("");
			$("#endDate").focus();
     		return false;
			
		}
		
		

		if ((startDate !="") && (startYear < 2000 || startYear > 2050)){ 		// 사용가능 하지 않은 연 체크 (시작일)
			alert("검색 유효 연도에 날짜를 벗어났습니다.");
			$("#startDate").val("");
			$("#startDate").focus();
			return false;
	    }
		else if ((startDate !="") && (endYear < 2000 || endYear > 2050)){ 	// 사용가능 하지 않은 연 체크 (종료일)
			alert("검색 유효 연도에 날짜를 벗어났습니다.");
			$("#endDate").val("");
			$("#endDate").focus();
			return false;
	    }
		
		if ((startDate !="") && (startMonth < 1 || startMonth > 12)){ 		// 사용가능 하지 않은 달 체크 (시작일)
			alert("고객님 월 입력란은 1~12월 까지입니다.");
			$("#startDate").val("");
			$("#startDate").focus();
			return false;
		}
		else if ((startDate !="") && (endMonth < 1 || endMonth > 12)){ 		// 사용가능 하지 않은 달 체크 (종료일)
			alert("고객님 월 입력란은 1~12월 까지입니다.");
			$("#endDate").val("");
			$("#endDate").focus();
			return false;
		}
		
		if ((startDate !="") && ((startMonth == 4 || startMonth == 6 || startMonth == 9 || startMonth == 11 )&& startDay == 31)){
			alert("고객님이 입력하신 당월에는 31일이 없습니다.");
			$("#startDate").val("");
			$("#startDate").focus();
			return false;
		}
		else if ((startDate !="") && ((endMonth == 4 || endMonth == 6 || endMonth == 9 || endMonth == 11 )&& endDay == 31)){
			alert("고객님이 입력하신 당월에는 31일이 없습니다.");
			$("#endDate").val("");
			$("#endDate").focus();
			return false;
		}
		
		if ((startDate !="") && (startMonth == 2)) {		// 윤년 계산 (시작 일)
		    var isleap = (startYear % 4 == 0 && (startYear % 100 != 0 || startYear % 400 == 0));
		    if (startDay > 29 || (startDay == 29 && !isleap)){
		    	alert("검색하신 년도에는 2월29일이 없습니다.");
		    	$("#startDate").val("");
				$("#startDate").focus();
				return false;
		    }
		}
		if ((startDate !="") && (endMonth == 2)) {		// 윤년 계산 (종료 일)
		    var isleap2 = (endYear % 4 == 0 && (endYear % 100 != 0 || endYear % 400 == 0));
		    if (endDay > 29 || (endDay == 29 && !isleap2)){
		    	alert("검색하신 년도에는 2월29일이 없습니다.");
		    	$("#endDate").val("");
				$("#endDate").focus();
				return false;
		    }
		}
		
		if ((startDate !="") && (startDay > 31)){
			alert("일자는 31일을 넘 길수 없습니다.");
	    	$("#startDate").val("");
			$("#startDate").focus();
			return false;
			
		}
		else if ((startDate !="") && (endDay > 31)){
			alert("일자는 31일을 넘 길수 없습니다.");
	    	$("#endDate").val("");
			$("#endDate").focus();
			return false;
			
		}
		
		if ((startDate !="") && (startDay > 31)){
			alert("일자는 31일을 넘 길수 없습니다.");
	    	$("#startDate").val("");
			$("#startDate").focus();
			return false;
			
		} 
		// ---------------------- <2.>날짜 검색 예외처리 종료지점<.2> ----------------------
		
		// [3]. 아작스 비동기 통신
		
		$.ajax({

		    url: "./searchAjax.ino",
		
		    type: "POST",
			
		    dataType: "json",
		
		    data: {"searchType":searchType, "keyword":keyword, "startDate":startDate , "endDate":endDate}, 
		
		    success: function(data){
		    	// 1. 서버에 있는 data.list를 사용하고자 하는 변수에 담는다.
		   		var listArr = data.list;
		    	// 2. 삭제하고자 하는 id를 지운다. $("#id").html("")  = $("#id").remove(); 동일하다
		    	$("#listDiv").html("");
		    	
		    	// 3. list를 빈공간으로 만든다.
		    		var list = "";
		    	// 4. 해당하는 listArr.length 만큼 for문을 돌린다.
		    		for(var i = 0; i < listArr.length; i++){
		    	// 5. 만들고자 하는 부분을 작성 list += 'div' + listArr[i].값 + 
		    			list += '<div style="width: 50px; float: left;">' +listArr[i].NUM+ '</div>';
		    			list += '<div style="width: 300px; float: left;"><a href="./freeBoardDetail.ino?num='+listArr[i].NUM+'&curPage='+data.curPage+'">'+listArr[i].TITLE+ '</a></div>';
		    			list += '<div style="width: 150px; float: left;">' +listArr[i].NAME+ '</div>';
		    			list += '<div style="width: 150px; float: left;">' +listArr[i].REGDATE+ '</div>';
		    			list += '<hr style="width: 600px">';
		    		}	
		    	// 6. list를 다시 채운다. 이때 2번에서 사용한 문과 동일해야한다.
		    		$("#listDiv").html(list);    	
		    		
		    	// 1.(검색 페이징 처리 하기 (데이터를 가지고 함수를 호출))
		    		searchPagination(data.pagination);
		    		infoPagination(data.pagination);
		    	
		    },	    
		   /*  error: function (request, status, error){     
		    	alert("통신 에러 입니다." + error);	
		    } */
		  });
	});
});
// (2. 함수 만들기)  ------------------------------ 페이징 그리기 처리   --------------------------------------
function searchPagination(pagination){
	
	var curPage = pagination.curPage;
	var startText = pagination.startText;
	var endText = pagination.endText;
	var totalPage = pagination.totalPage;
	var totalText = pagination.totalText;
	var curText = pagination.curText;
	var searchType = $("#searchType").val();
	var keyword = $("#keyword").val();
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();

	
	$("#pageDiv").empty();
	
	if (curPage != 1){
		$("#pageDiv").append('<a href="main.ino?curPage=1&searchType='+searchType+'&keyword='+keyword+'">[처음]</a>&nbsp');  //첫페이지로가는버튼 활성화

	}
	if (startText != 1){
		$("#pageDiv").append('<a href="main.ino?curPage='+(startText-1)+'&searchType='+searchType+'&keyword='+keyword+'&startDate='+startDate+'&endDate='+endDate+'">[이전]</a>');
		
	}
	
	for (var i = startText; i <= endText; i ++){
		$("#pageDiv").append('<a href="main.ino?curPage='+i+'&searchType='+searchType+'&keyword='+keyword+'&startDate='+startDate+'&endDate='+endDate+'">'+i+'</a>&nbsp');
	}
	
	
	if (endText < totalPage){	
		$("#pageDiv").append('<a href="main.ino?curPage='+(endText+1)+'&searchType='+searchType+'&keyword='+keyword+'&startDate='+startDate+'&endDate='+endDate+'">[다음]</a>&nbsp');
	} 
	
	if (curPage < totalPage){
		$("#pageDiv").append('<a href="main.ino?curPage='+totalPage+'&searchType='+searchType+'&keyword='+keyword+'&startDate='+startDate+'&endDate='+endDate+'">[끝]</a><br/>');
	}

}

// 아래 화면 ------------- 게시글 수 , 페이지 수 , 현재 페이지 ---------------------
function infoPagination(pagination){
	
	var curPage = pagination.curPage;
	var totalText = pagination.totalText;
	var totalPage = pagination.totalPage;
	
	$("#infoDiv").empty();

	$("#infoDiv").append('<div>총 게시글 수 : '+totalText+' / 총 페이지 수 : '+totalPage+' / 현재 페이지 : '+curPage+'</div>');
}
</script>

</head>
<body>
	
	<div>
		<h1>자유게시판</h1>
	</div>
	
	<!-- --------------------------------  분류 선 -------------------------------- -->
	
	<div>
		<form name ="searchForm" id ='searchForm' onsubmit="return false" >
			<%--  공통 코드 사용 전에 만든 셀렉트 박스
			<select name="searchType" id ="searchType" > 
				<option id ='title' name ='title' value ="title" ${map.searchType eq "title" ? "selected" :""}> 글 제목</option>
				<option id ='num' name ='num' value ="num" ${map.searchType eq "num" ? "selected" :""}> 글 번호</option>
			</select> 
			--%>	
			<!-- <3.> JSP : 컨트롤러에서 사용하는 값을 뿌려준다. -->
			<select name="searchType" id ="searchType" > 
			<c:forEach var="nRow" items="${codeList}">
				<option value="${nRow.DECODE }">${nRow.DECODE_NAME}</option>
			</c:forEach>
			</select>

			<input type="text" name="keyword" id ="keyword" value="${map.keyword}" placeholder =" 검색어를 입력해주세요"/>
			<button type ="button" id="btnSearch" name="btnSearch">검색</button>
			<br/>
			<input type="text" name="startDate" id ="startDate" value="${map.startDate}" maxlength="10" placeholder ="검색 시작일"/>
			&nbsp;~&nbsp;
			<input type="text" name="endDate" id ="endDate" value="${map.endDate}" maxlength="10" placeholder ="검색 종료일"/>
			
		</form>
	</div>

	<!-- --------------------------------  분류 선 -------------------------------- -->
	
	<div style="width:650px;" align="right">
		<a href="./freeBoardInsert.ino">글쓰기</a>
	</div>
	<hr style="width: 600px">
	<div id = "listDiv">
	<c:forEach items="${freeBoardList }" var="dto">
			<div style="width: 50px; float: left;">${dto.NUM }</div>	
			<div style="width: 300px; float: left;"><a href="./freeBoardDetail.ino?num=${dto.NUM }&curPage=${map.pagination.curPage}">${dto.TITLE }</a></div>
			<div style="width: 150px; float: left;">${dto.NAME }</div>
			<div style="width: 150px; float: left;">${dto.REGDATE }</div> 
		<hr style="width: 600px">
	</c:forEach>
	</div>
	
	<!-- [9.]pagination -->
			<div id="pageDiv" style ='margin-top:30px;'>
			<!-- 페이지 네이션 이전 버튼 -->
			<c:if test="${map.pagination.curPage > 1}">
   				 <a href="main.ino?curPage=1&searchType=${map.searchType }&keyword=${map.keyword}&startDate=${map.startDate}&endDate=${endDate}">[처음]</a>
			</c:if>
			<!-- 페이지 네이션 이전 버튼 -->
			<c:if test="${map.pagination.startText > 1}">
				<a href="main.ino?curPage=${map.pagination.startText - 1}&searchType=${map.searchType }&keyword=${map.keyword}&startDate=${map.startDate}&endDate=${endDate}">[이전]</a>
			</c:if>
			<!-- 페이지 네이션 구성 -->
			<c:forEach var="idx" begin="${map.pagination.startText }" end="${map.pagination.endText }">
				<a href="main.ino?curPage=${idx}&searchType=${map.searchType }&keyword=${map.keyword}&startDate=${map.startDate}&endDate=${endDate}">${idx }</a>
			</c:forEach>
			<!-- 페이지 네이션 다음 버튼 -->
			<c:if test="${map.pagination.endText < map.pagination.totalPage}">
				<a href="main.ino?curPage=${map.pagination.endText + 1}&searchType=${map.searchType }&keyword=${map.keyword}&startDate=${map.startDate}&endDate=${endDate}">[다음]</a>
			</c:if>
			<!-- 페이지 네이션 끝 버튼 -->
			<c:if test="${map.pagination.curPage < map.pagination.totalPage}">
  				 <a href="main.ino?curPage=${map.pagination.totalPage}&searchType=${map.searchType }&keyword=${map.keyword}&startDate=${map.startDate}&endDate=${endDate}">[끝]</a>
			</c:if>
			</div>

	<div id ="infoDiv">
      	총 게시글 수 : ${map.pagination.totalText } / 
      	총 페이지 수 : ${map.pagination.totalPage } / 
      	현재 페이지 : ${map.pagination.curPage } 
    </div>  
	
	
</body>
</html>
