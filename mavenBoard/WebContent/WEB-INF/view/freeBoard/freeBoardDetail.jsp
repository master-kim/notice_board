<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#btnModify").click(function(){
		
		// [1].변수 설정
		var title = $("#title").val().replace(/\s|/gi,'');
		var content =  $("#content").val().replace(/^\s+|\s+$/g,'');
		var num = $("#num").val();
		
		 // [2]. 예외처리 하기
		if(title == ""){
			alert("제목을 입력해주세요.");
			$("#title").focus();
			return;
		} 
		else if(content == ""){
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return;		
		} 
		 
		 //[4.] 컨펌 창
		 if(confirm('수정 하시겠습니까?') == true){
		// [3]. 아작스 비동기 통신
		$.ajax({
			
		    url: "./modifyAjax.ino",
		
		    type: "POST",
		
		    dataType: "json",
		
		    data: {"num":num,"title":title ,"content":content}, 
		
		    success: function(data){
		    	if(data.reusltStr == "success"){
		    		alert("수정이 완료되었습니다.");
		    		// 글 작성 후 보여주기
			    	/* location.href ="redirect:freeBoardDetail.ino?num=" + num; */
			    	location.href ="./main.ino";
		    	}
		    	else{
		    		alert("수정을 취소했습니다.");
		    		return false;
		    	}

		    },
		// ------------------------------------------ 분류 선 -------------------------------------------------
			error: function (request, status, error){     
			alert("새로고침 해주세요");	
			}
		});
		// [4] confirm 창 띄우기
		} 
	});
});

// 글쓰기 삭제 ajax 만들기
$(document).ready(function(){
	   $("#btnDelete").click(function(){
	      var num = $("#num").val();
	      
	  	  if(confirm('정말 삭제하시겠습니까?') == true){
	            $.ajax({
	               url : "./DeleteAjax.ino",
	               
	               type : "POST",
	               
	               datatype : "json",
	               
	               data:{"num":num},
	               
	               success : function(data){
	            	   if(data.reusltStr == "success"){
				    		alert("삭제가 완료되었습니다.");
				    		// 글 작성 후 보여주기
					    	/* location.href ="redirect:freeBoardDetail.ino?num=" + num; */
					    	location.href ="./main.ino";
				    	}
				    	else{
				    		alert("삭제를 취소했습니다.");
				    		return false;
				    	}
	               },
	               error: function (request, status, error){     
	                      alert("에러");
	                   }
	               
	            });
	         // [4] confirm 창 띄우기
			}
	   }); 
	});
</script>

<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width: 650px;" align="right">
		<a href="./main.ino?curPage=${map.curPage}&num=${freeBoardDetail.NUM }">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form name="insertForm">
		<input type="hidden" name="num" id ='num' value="${freeBoardDetail.NUM }" />

		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left">
			<input type="text" name="name" id="name"
				value="${freeBoardDetail.NAME }" readonly />
		</div>

		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left">
			<input type="text" name="title" id="title"
				value="${freeBoardDetail.TITLE }" />
		</div>

		<div style="width: 150px; float: left;">작성날짜</div>
		<div style="width: 500px; float: left;" align="left">
			<input type="text" name="regdate" id="regdate"
				value="${freeBoardDetail.REGDATE }" readonly />
		</div>

		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left">
			<textarea name="content" id="content" rows="25" cols="65">${freeBoardDetail.CONTENT }</textarea>
		</div>
		<div align="right">
			<button type="button" id="btnModify" name="btnModify">수정</button>
			<button type="button" id="btnDelete" name="btnDelete">삭제</button>
			<input type="button" value="취소" onclick="location.href='./main.ino'">
			&nbsp;&nbsp;&nbsp;
		</div>

	</form>

</body>
</html>