<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- script 영역 -->
<script type="text/javascript">

var mappingList = new Array();
var insertList = new Array();
var deleteList = new Array();
var groupId = 0;

// 객체 권한 테이블 등록
$(document).ready(function() {
	
	$("#insert").click(function(){
		
		// 배열을 비우기 위한 변수 (1개 선택 후 다른거 추가 선택  사항 고려)
		var insertList = [];
		var deleteList = [];
		var mappingList = [];
		
		var checkbox = $("input[type='checkbox']:checked");
		
		var notCheck = $("input[type='checkbox']:not(:checked)");
		
		// 언체크박스 데이터 가져오기
		notCheck.each(function(i) {
			
			var tdArr1 = {};
			var tr = notCheck.parent().parent().eq(i);
			var td = tr.children();
			
			tdArr1.OBJECT_ID = td.eq(2).text();
			tdArr1.OBJECT_NAME = td.eq(3).text();
			tdArr1.OBJECT_SEQ = td.eq(4).text();
			tdArr1.flag = td.eq(5).val();
			tdArr1.GROUP_ID = td.eq(6).val();
			
			// 체크 되지 않은 테이블 리스트를 가져온다.
			var check = td.eq(0).find('input[type=checkbox]:not(:checked)');
			
			if(check){
				if(tdArr1.flag == 'E'){
					tdArr1.flag = tdArr1.flag.replace("E" , "D");
					
					deleteList.push(tdArr1);
				}
			}
			
		});

		// 체크박스 데이터 가져오기
		checkbox.each(function(i) {
			
			var tdArr1 = {};
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();
		
			tdArr1.OBJECT_ID = td.eq(2).text();
			tdArr1.OBJECT_NAME = td.eq(3).text();
			tdArr1.OBJECT_SEQ = td.eq(4).text();
			tdArr1.flag = td.eq(5).val();
			tdArr1.GROUP_ID = td.eq(6).val();
			
			if(tdArr1.flag == 'A'){
				insertList.push(tdArr1);
			}
			
		});
		
		
		// 체크박스 데이터 와 언체크박스 데이터를 params에 담고 ajax로 보낸다.
		var params = {
			"insertList" : insertList,
			"deleteList" : deleteList,
			"groupId" : groupId
			
		}
		
		$.ajax({

			url : "./authorityInsert.ino",
				
			type : "POST",

			dataType : "json",

			data : JSON.stringify(params),
			
			contentType:'application/json; charset=utf-8',
			
			success : function(data) {
			
				alert("등록되었습니다.");
				// 지역변수
				var objectList = data.objectList;
				
				// 전역변수 (objId와 mappingId를 비교 위함)
				var mappingList = data.mappingList;
				
				$("#tableTbody").html("");
	        	
	        	var list = "";
	        	
	        		for(var i = 0; i < objectList.length; i++){
	        			
	        			use = "미사용";
						check = "<input type='checkbox' id='selectCheck' name='selectCheck' value='N'>";
						flag = "<input type='hidden' name='flag' id='flag' value='A'>";
	            		GROUP_ID = "<input type='hidden' name='GROUP_ID' id='GROUP_ID' value="+groupId+">";
						
	        			for(var j=0; j < mappingList.length; j++){
	        				
	                    	if(mappingList[j].OBJECT_ID == objectList[i].OBJECT_ID){
	                    		
	                    		use = "사용중";
	                    		check = "<input type='checkbox' id='selectCheck' name='selectCheck' checked value='Y'>";
	                    		flag = "<input type='hidden' name='flag' id='flag' value='E'>";
	                    		GROUP_ID = "<input type='hidden' name='GROUP_ID' id='GROUP_ID' value="+groupId+">";

	                    	}
	        			}	
	        			
	                    list += "<tr style='text-align:center'>";
	                    list += "<td >"+check+"</td>";
	                    list += "<td id='useYn' name='useYn'>"+use+"</td>";
	                    list += "<td >"+objectList[i].OBJECT_ID+"</td>" ;
	                    list += "<td >"+objectList[i].OBJECT_NAME+"</td>";
	                    list += "<td >"+objectList[i].OBJECT_SEQ+"</td>";
	                    list += ""+flag+"";
	                    list += ""+GROUP_ID+"";
	                    list += "</tr>";
	        		}
	        		
	        	$("#tableTbody").html(list);
			},
			error : function(request, status, error) {
				alert(error);
			} 
		}); 
	});
});


//그룹 리스트
function ObjectTable(e) { 
	
	groupId = $(e).attr('value');
	
	$.ajax({

		url : "./authorityDetail.ino",
			
		type : "POST",

		dataType : "json",

		data : {"groupId" : groupId},
		
		success : function(data) {
			
			// 지역변수
			var objectList = data.objectList;
			
			// 전역변수 (objId와 mappingId를 비교 위함)
			var mappingList = data.mappingList;
			
			$("#tableTbody").html("");
        	
        	var list = "";
        	
        		for(var i = 0; i < objectList.length; i++){
        			
        			use = "미사용";
					check = "<input type='checkbox' id='selectCheck' name='selectCheck' value='N'>";
					flag = "<input type='hidden' name='flag' id='flag' value='A'>";
            		GROUP_ID = "<input type='hidden' name='GROUP_ID' id='GROUP_ID' value="+groupId+">";
					
        			for(var j=0; j < mappingList.length; j++){
        				
                    	if(mappingList[j].OBJECT_ID == objectList[i].OBJECT_ID){
                    		
                    		use = "사용중";
                    		check = "<input type='checkbox' id='selectCheck' name='selectCheck' checked value='Y'>";
                    		flag = "<input type='hidden' name='flag' id='flag' value='E'>";
                    		GROUP_ID = "<input type='hidden' name='GROUP_ID' id='GROUP_ID' value="+groupId+">";

                    	}
        			}	
        			
                    list += "<tr style='text-align:center'>";
                    list += "<td >"+check+"</td>";
                    list += "<td id='useYn' name='useYn'>"+use+"</td>";
                    list += "<td >"+objectList[i].OBJECT_ID+"</td>" ;
                    list += "<td >"+objectList[i].OBJECT_NAME+"</td>";
                    list += "<td >"+objectList[i].OBJECT_SEQ+"</td>";
                    list += ""+flag+"";
                    list += ""+GROUP_ID+"";
                    list += "</tr>";
        		}
        		
        	$("#tableTbody").html(list);
        		
		},
		error : function(request, status, error) {
			alert(error);
		} 
	}); 
}

</script>
</head>
<body>
	<div>
		<h1>권한설정 Main</h1>
	</div>
		<hr style="width: 800px">
		<h3>그룹 테이블</h3>
	
	<table style="width:400px;" border="1">
		<thead style="text-align:center">
			<tr>
				<th>그룹 코드</th>
				<th>그룹 코드 이름</th>
				<th>사용 유무</th>
			</tr>
		<thead>
		<tbody>
			<c:forEach var="nRow" items="${authorityList}">
				<tr style="text-align: center">
					<td ><a href="javascript:void(0);"  onclick="ObjectTable(this);" value="${nRow.GROUP_ID }">${nRow.GROUP_ID }</a></td>
					<td ><a href="javascript:void(0);"  onclick="ObjectTable(this);" value="${nRow.GROUP_ID }">${nRow.GROUP_NAME }</a></td>
					<td >${nRow.USE_YN }</td>
				</tr>
			</c:forEach>		
		</tbody>
	</table>
	<br/>
	<hr style="width:800px;">
	<h3 style="margin-top:20px;"align="center"> 객체 권한 ${map.GROUP_ID } 테이블</h3>
	<hr style="width: 800px" align="center">
	<button type='button' style="margin-left:450px;" id='insert' name='insert'>등록</button>
	
	<hr style="width: 800px">
	
	<form id='objectForm' name='objectForm'>
	<table style="width: 600px" border="1">
	
	<thead>
		<tr style='text-align:center'>
			<th >선택</th>
			<th >사용여부</th>
			<th >권한 객체 아이디</th>
			<th >권한 객체 이름</th>			
			<th >권한 객체 시퀀스</th>			
		</tr>
	</thead>
	
	<tbody id="tableTbody">
	</tbody>
	</table>
	</form>
</body>
</html>

