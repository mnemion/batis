<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품리스트 선택 출력파트</title>
</head>
<body>
<form id = "f">
<input type="text" name="m" id="m"><br>
<input type="button" value="상품추가" onclick="popup()">
</form>
</body>
<!-- 상대방이 제시하는 웹페이지 값을 iframe으로 가져옴 -->
<script>
function popup(){
	window.open("./load.jsp","","width=500 hegith=500");
	//window.open("http://192.168.110.223:8080/batis/popup.jsp","","width=500 hegith=500");
}
</script>
</html>