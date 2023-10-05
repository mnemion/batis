<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	Random rd = new Random();
	int number = 0;
	String pdcode = "";
	for(int a = 1; a < 7; a++) {
		number = rd.nextInt(9);
		pdcode += number;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 선택 및 장바구니 - step1</title>
<!-- 
	상품 상세 페이지에서 > 장바구니 > 사용자 정보(이름, 이메일, 전화번호...) > 결제수단을 선택 > PG API > return.jsp(결제 승인 및 결제 미승인 결과)
	Close.jsp (결제 진행 시 취소 버튼 클릭하게 되면 레이어 팝업 사라짐)
-->
</head>
<body>
	<form id="f" method="post" action="./pay2.do">
	상품코드 : <input type="text" name="product_code" value="<%=pdcode%>" readonly="readonly"><br>
	상품명 : <input type="text" name="product_name" value=""><br>
	결제 금액 : <input type="text" name="product_money" value="" placeholder="3000원 이상 입력해주세요."><br> <!-- 숫자만 -->
	상품 수량 : <input type="text" name="product_ea" value=""><br>
	<input type="button" value="상품구매 확정" id="btn">
	</form>
</body>
<script>
	document.querySelector("#btn").addEventListener("click", function(){
		f.submit();
	});
</script>
</html>