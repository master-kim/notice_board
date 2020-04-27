<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#btnInsert").click(function(){
		
		// [1].변수 설정
		var name = $("#name").val().replace(/\s|/gi,'');
		var title = $("#title").val().replace(/\s|/gi,'');
		var content =  $("#content").val().replace(/^\s+|\s+$/g,'');
		
		 // [2]. 예외처리 하기
		if(name == ""){
			alert("이름을 입력해주세요");
			$("#name").focus();
			return false;
		}
		else if(title ==""){
			alert("제목을 입력해주세요.");
			$("#title").focus();
			return false;
		} 
		else if(content == ""){
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return false;
		}
		 
		 // [4] confirm 창 띄우기
		 if(confirm("글 작성을 완료하시겠습니까?") == true){
			// [3]. 아작스 비동기 통신
			 $.ajax({
					
				    url: "./insertProAjax.ino",
				
				    type: "POST",
				
				    dataType: "json",
				
				    data: {"title" : title , "content" : content , "name" : name}, 
					success: function(data){
				    	if(data.reusltStr == "success"){
				    		alert("작성이 완료되었습니다.");
				    		// 글 작성 후 보여주기
					    	location.href ="./main.ino";
					    	/* location.href ="redirect:freeBoardDetail.ino?num=" + num; */
				    	}
				    	else{
				    		alert("작성이 실패했습니다.");
				    		return false;
				    	}
				    },
				// ------------------------------------------ 분류 선 -------------------------------------------------
					error: function (request, status, error){     
					alert("통신 에러");
					}
				
			});
		// [4] confirm 창 끝지점
		} 
	});
	
});

</script>
</head>
<body>
	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width: 650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form action='./freeBoardInsertPro.ino' name='addcontent' method='post'>
		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left">
			<input type="text" name="name" id= "name"/>
		</div>

		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left">
			<input type="text" name="title" id ="title"/>
		</div>

		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left">
			<textarea name="content" id ="content"rows="25" cols="65"></textarea>
		</div>
		<div align="right">
			<button type="button" id="btnInsert" name="btnInsert">글쓰기</button>
			<input type="button" value="다시쓰기" onclick="reset()"> 
			<input type="button" value="취소" onclick=""> &nbsp;&nbsp;&nbsp;
		</div>

	</form>

</body>
</html>