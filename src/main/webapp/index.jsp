<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웹페이지 메인</title>
</head>
<body>
<!-- 
	%를 이용하여 사용하는 형태 include file ; 정적인 파일로드
	jsp 태그를 이용하여 사용하는 include page ; 동적인 파일로드
	flush : 버퍼를 이용하여 출력하는 형태
 -->
	<header><%@ include file="./top.jsp" %></header>
	<nav></nav>
	<main>메인페이지</main>
	<footer><%@ include file="./footer.jsp" %></footer>
</body>
</html>