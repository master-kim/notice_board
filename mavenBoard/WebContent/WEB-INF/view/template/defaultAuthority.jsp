<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="bodyAll" align="center" style="width: 800px;margin-left:200px;" >

		<header>
			<div style="width: 800px; margin: 0;">
				<tiles:insertAttribute name="header" />
			</div>
		</header>
		<div class="contents" style="width: 800px; margin: 0;">
			<aside>
			<div style="float: left;  width: 150px; height:700px; border: 2px; solid: #b6b8bb; background-color: #aaaaaa;">
				<tiles:insertAttribute name="menu" />
			</div>
			</aside>
			 <section>
                <div style="background-color:#dedede; height:700px; width:1000px;">
				<tiles:insertAttribute name="content" />
			 </div>
        </section>
		</div>
	</div>
</body>
</html>