<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 정보 입력 및 결제수단 선택- step2</title>
</head>
<body>
	<!-- stringList(키명) : stringList[] or stringList.get() -->
	<form id="f" method="post" action="./pay3.do">
	<input type="hidden" name="goodcode" value="${stringList[0]}">
	<input type="hidden" name="goodname" value="${stringList[1]}">
	<input type="hidden" name="price" value="${stringList[2]}">
	<input type="hidden" name="goodea" value="${stringList[3]}">
	
	상품코드 : ${stringList[0]}<br>
	상품명 : ${stringList[1]}<br>
	상품 가격 : <span id="total"></span>원<br>
	상품 갯수 : ${stringList[3]} EA<br>
	<p>사용자 정보</p>
	고객명 : <input type="text" name="buyername"><br>
	연락처 : <input type="text" name="buyertel"><br>
	이메일 : <input type="text" name="buyeremail"><br>
	주소 : <input type="text" name="rec_post" value="07285"><br>
	<input type="text" name="rec_addr" value="서울특별시 영등포구 선유로 33 (문래동5가, 문래대림아파트)"><br>
	<input type="text" name="rec_addr_dtc" value="2222동 2222호"><br>
	적립금 & 포인트 : <input type="text" name="point" value="0">
	<p>결제 방식</p>
	<input type="radio" name="gopaymethod" value="Card" checked>신용카드
	<input type="radio" name="gopaymethod" value="DirectBank">계좌이체
	<input type="radio" name="gopaymethod" value="VBank">가상계좌
	<br>
	<input type="button" value="결제 선택 완료" id="btn">
	</form>
</body>
<script>
	var money = Number("${stringList[2]}");
	document.getElementById("total").append(money.toLocaleString());
	
	document.querySelector("#btn").addEventListener("click", function(){
		f.submit();
	});
</script>
</html>