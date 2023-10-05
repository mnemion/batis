<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<iframe frameborder="0" src="http://192.168.110.223:8080/batis/popup.jsp">

</iframe>
</body>
<script>
//addEventListener : 실시간으로 정복밧을 가져옴
//("message",받을 함수묭, 동기 ,비동기로 선택가능)
//message : postMessage에 대한 정보값
	window.addEventListener("message",product_code,false);
	function product_code(a){
		//해당 iframe에서 받은 데이터 값을 부모창으로 전달
		window.opener.f.m.value=a.data.msg; //a; 이벤트 출력, data : 배열값을 가지고 있는 속성, msg:배열키(랜덤)
		self.close();
	}
</script>
</html>