<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- script 영역 -->
<script type="text/javascript">
 $( document ).ready(function() {
	 //배열로 넘길시 사용
 	 var tdArr2 = new Array();

 // [1.] 저장 버튼 (수정 , 삭제, 추가 다루기)
 $("#btnSave").click(function(){
    	// input 값을 전부 직렬화 시켜 값을 담는다.
    	var formValue = $("#formAdd,#modifyInputForm,#modifyRadioForm,#deleteForm").serialize();
    	// radioCheck[+count+] 값을 radioCheck 값으로 만들어 공통성을 준다.
    	var formValue = formValue.replace("radioCheck1", "radioCheck");
    	var formValue = formValue.replace("radioCheck2", "radioCheck");
    	var formValue = formValue.replace("radioCheck3", "radioCheck");
 
    	if (confirm("저장 하시겠습니까?") == true) {
    	
    	// 서버와 비동기 통신 데이터를 넘겨준다.
    	$.ajax({

    		url : "./insertCommonCode.ino",
    			
    		type : "POST",

    		dataType : "json",

    		data :formValue, // serialize로 담은 값은 {key : value 불필요}
    		
    		success : function(data) {
    			 if (data.resultStr == "success") {
    				alert("저장 되었습니다.");
    	    		location.href = "./commonCodeDetail.ino?code="+data.masterCode[0]+"";
                  } else if(data.resultStr == "fail"){
                     alert("Detail Code와 같은 값은 불가능합니다.");
                     $("#detailCode").focus();
                     return false;
                  }	 else if(data.resultStr == "length"){
                      alert("DECODE 또는 DECODE이름은 10자 이내로 작성해주세요.");
                      $("#detailCode").focus();
                      location.href = "./commonCodeDetail.ino?code="+data.masterCode[0]+"";
                      return false;
                  }  
    		},
    		error : function(request, status, error) {
    			alert(error);
    		} 
    	}); 
       }
	});
 
 	// [1.]전체 선택, 전체 해제
	$('#checkall').click(function() {
		if ($("#checkall").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} 
		else { 
			$("input[type=checkbox]").prop("checked", false);
		}
	});
	// [2.] 수정하기
	$("#btnModify").click(function() {
		// (1.)선택된 값 가져오기 변수 설정
		var checkbox = $("input[type='checkbox']:checked");
		
		// (2.) 수정 버튼 누르고 인풋박스 , 라디오체크 박스 만들기 및 값 배열에 담기
		checkbox.each(function(i) {
		
		// 각 td에 text 값을 tdArr1 배열에 담기
		var tdArr1 = {};
		// checkbox.parent() : checkbox의 부모는 <td>이다. (결과 : td)
		// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다. (결과 : tr )
		var tr = checkbox.parent().parent().eq(i);
		var td = tr.children();

		tdArr1.CODE = td.eq(1).text();
		tdArr1.DECODE = td.eq(2).text();
		tdArr1.DECODE_NAME = td.eq(3).text();
		tdArr1.USE_YN = td.eq(4).text();
		// 담긴 tdArr1 값을 tdArr2 배열에 다시 담아준다.(값을 배열로 넘길 때 필요)
		tdArr2.push(tdArr1);
		
		var flag = tr.find("#flag").val();

		if (flag == null){

		var addInput = "";
		addInput += "<form id='modifyInputForm' onsubmit='return false'>"
    	addInput += "<input type='text' id='detailCodeName' name='detailCodeName' onkeyup='noSpaceForm(this);' value="+tdArr1.DECODE_NAME+"> ";
    	addInput += "<input type='hidden' id='detailCode' name='detailCode' value="+tdArr1.DECODE+">";  
    	addInput += "<input type='hidden' id='masterCode' name='masterCode' value="+tdArr1.CODE+">";  
    	addInput += "<input type='hidden' id='flag' name='flag' value='M'>";  
    	addInput += "</form>";

	 	var addRadio = "";
   	 	// 라디오 박스를 설정 하기 위해서 (텍스트 값을 받고 그것에 따른 if문을 설정하여 그리는 방법을 달리 하여 적용한다.)
	 	if (tdArr1.USE_YN == "Y"){
			 addRadio += "<form id='modifyRadioForm'><input type='radio' id='radioCheck' name='radioCheck' value='Y' checked>Y&nbsp";
			 addRadio += "<input type='radio' id='radioCheck' name='radioCheck' value='N'>N</form>";
			 addRadio += "</form>";
		 }else if (tdArr1.USE_YN == "N"){
			addRadio += "<form id='modifyRadioForm'><input type='radio' id='radioCheck' name='radioCheck' value='Y'>Y&nbsp";
		 	addRadio += "<input type='radio' id='radioCheck' name='radioCheck' value='N' checked>N</form>";	 
			addRadio += "</form>";
	 	}
	 	
   	 		tr.find("#decodeName").html(addInput);
   	 		tr.find("#UseYN").html(addRadio);
   	 	
		}
		if(flag == "M"){
			
			// 인풋 박스 >> text로 돌릴 때 가져올 값들 (라디오 값 가져오기 참고사이트 https://kimsg.tistory.com/230)
			var detailCodeName = tr.find("#detailCodeName").val();
			var radioCheck = tr.find($("input[type=radio][name=radioCheck]:checked")).val();
		
  			var inputBox = "";
			inputBox += "<form>"+detailCodeName+"</form>";

		    if (radioCheck == "Y"){
		    	var Radio = "";
		    	Radio += "<form>Y<form>";
		 	}else if (radioCheck == "N"){
		 		var Radio = "";
		 		Radio += "<form>N<form>";
		 	}
		    
		    var check1= $("input:checkbox[name='selectCheck']").is(":checked");
		
		    if(check1 == true && flag =="M"){
		    	$("input:checkbox[name='selectCheck']").prop("checked", false);
		   	} 
		    tr.find("#decodeName").html(inputBox);
		    tr.find("#UseYN").html(Radio);
			}
			});	
		});	

	// [3.] 삭제 버튼 (수정과 동일)
	$('#btnDelete').click(function() {
		var checkbox = $("input[name=selectCheck]:checked");
		
		checkbox.each(function(i){
	
			var tdArr1 = {};
			
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();

			tdArr1.CODE = td.eq(1).text();
			tdArr1.DECODE = td.eq(2).text();
			tdArr1.DECODE_NAME = td.eq(3).text();
			tdArr1.USE_YN = td.eq(4).text();
			
			var flag = tr.find("#flag").val();
			
			if(flag == null){
			 var addInput = "";
	         addInput += "<STRIKE><FONT color='red'>"+tdArr1.CODE+"</STRIKE>";
	         
	         var addInput2 = "";
	         addInput2 += "<form id='deleteForm'>"
	       	 addInput2 += "<id='detailCode' name='detailCode' ><STRIKE><FONT color='red'>"+tdArr1.DECODE+"</STRIKE>";
	         addInput2 += "<input type='hidden' id='flag' name='flag' value='D'>";  
	         addInput2 += "<input type='hidden' id='masterCode' name='masterCode' value="+tdArr1.CODE+">";
	         addInput2 += "<input type='hidden' id='detailCodeName' name='detailCodeName' value="+tdArr1.DECODE_NAME+"> ";
	         addInput2 += "<input type='hidden' id='radioCheck' name='radioCheck' value="+tdArr1.USE_YN+"> ";
	         addInput2 += "<input type='hidden' id='detailCode' name='detailCode' value="+tdArr1.DECODE+"> ";
	         addInput2 += "</form>";
		     
		     var addInput3 = "";
		     addInput3 += "<STRIKE><FONT color='red'>"+tdArr1.DECODE_NAME+"</STRIKE>";
		     
		     var addInput4 = "";
		     addInput4 += "<STRIKE><FONT color='red'>"+tdArr1.USE_YN+"</STRIKE>";  
		 
		     tr.find("#Code").html(addInput);
		     tr.find("#Decode").html(addInput2);
		     tr.find("#decodeName").html(addInput3);
		     tr.find("#UseYN").html(addInput4);
			}
			if(flag =="D"){
				var addInput = "";
		        addInput += ""+tdArr1.CODE+"";
		        var addInput2 = "";
		        addInput2 += ""+tdArr1.DECODE+"";
			    var addInput3 = "";
			    addInput3 += ""+tdArr1.DECODE_NAME+"";
			    var addInput4 = "";
			    addInput4 += ""+tdArr1.USE_YN+"";

			    var check1= $("input:checkbox[name='selectCheck']").is(":checked");
				
			    if(check1 == true && flag =="D"){
			    	$("input:checkbox[name='selectCheck']").prop("checked", false);
			   	} 
			    
			    tr.find("#Code").html(addInput);
			    tr.find("#Decode").html(addInput2);
			    tr.find("#decodeName").html(addInput3);
			    tr.find("#UseYN").html(addInput4);
			}	
	    });	
		
	});	
});   
   

// 추가 버튼 눌러서 인풋박스 추가하기
var count = 0;

function addInput(code) { 
     count++;
     var code = code;
     var addTbody = document.getElementById("addTbody");
     var insertRow = addTbody.insertRow(addTbody.rows.length);
     //삽입될 Form Tag
     var addInput = "";
     addInput += "<div id="+count+"><input type='text' style='width:120px; height:20px;' value="+code+" readonly>&nbsp&nbsp";
     addInput += "<input type='text' id='detailCode' name='detailCode' value='' onkeyup='noSpaceForm(this);' style='width:150px; height:20px;' >&nbsp&nbsp";
     addInput += "<input type='text' id='detailCodeName' name='detailCodeName' value='' onkeyup='noSpaceForm(this);' style='width:150px; height:20px;'>&nbsp";
     // 라디오 박스에 name을 다르게 주기 위해 count를 줌으로 중복 가능하게 하기
     addInput += "<input type='radio' id='radioCheck' name='radioCheck"+count+"' checked='checked' value='Y' style='width:50px; height:20px;'>Y&nbsp";
     addInput += "<input type='radio' id='radioCheck' name='radioCheck"+count+"' value='N' style='width:50px; height:20px;'>N&nbsp";
     addInput += "<input type='button' value='삭제' style='margin-left:20px;'onClick='removeRow()'>&nbsp";
     addInput += "<input type='hidden' id='masterCode' name='masterCode' value="+code+"></div>&nbsp";
     addInput += "<input type='hidden' id='flag' name='flag' value='I'></div>&nbsp";

     insertRow.innerHTML = addInput;

     if (count > 3) {
        alert("3개 이상 추가는 불가능 합니다.");
        addTbody.deleteRow(addTbody.rows.length - 1);
        count--;
    }
}

// 인풋박스 삭제하기(인풋 옆에 삭제버튼)
function removeRow() {
    var addTbody = document.getElementById('addTbody');
    addTbody.deleteRow(addTbody.rows.length - 1);
    count--;
}

// 인서트 인풋 박스에 공백 불가
function noSpaceForm(obj) { // 공백사용못하게
	var str_space = /\s/; // 공백체크
	if (str_space.exec(obj.value)) { //공백 체크
		alert("공백 사용불가로 공백은 자동제거됩니다.");
		obj.focus();
		obj.value = obj.value.replace(' ', ''); // 공백제거
		return false;
	}
}

</script>
</head>
<body>
	<div>
		<h1>공통코드 상세보기</h1>
	</div>

	<div style="width: 650px;" align="right">
		<button onclick="addInput('${map.code}');">추가</button>
		<button id="btnModify" name="btnModify">수정</button>
		<button id="btnDelete" name="btnDelete">삭제</button>
		<button id="btnSave" name="btnSave">저장</button>
	</div>
	<hr style="width: 700px">
	<table style="width: 700px; margin-top: 10px;" border="1">
		<thead>
			<tr>
				<th style="width: 30px"><input type="checkbox" id="checkall" name="checkall" /></th>
				<th style="width: 120px;">Master Code</th>
				<th>Detail Code</th>
				<th>Detail Code Name</th>
				<th>USE / UnUse</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="nRow" items="${codeList}">
				<tr style="text-align: center" id="deleteTr" name="deleteTr">
					<td id ='check' style="width: 30px"><input type="checkbox" id='selectCheck' name="selectCheck" value="1"/></td>
					<td id="Code" name="Code" style="width: 120px; padding: 5px;">${nRow.CODE }</td>
					<td id="Decode" name="Decode">${nRow.DECODE }</td>
					<td id="decodeName" name="decodeName">${nRow.DECODE_NAME }</td>
					<td id="UseYN" name="UseYN">${nRow.USE_YN }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<hr style="width: 700px; margin-top: 15px;">

	<form id='formAdd' name='formAdd'>
		<table id='addTbody' name='addTbody'style="width: 700px; margin-top: 100px;">
		</table>
	</form>
</body>
</html>