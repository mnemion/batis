<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ECMA 전용 - Ajax 사용법</title>
</head>
<body>
	<input type="button" value="클릭" id="btn"><br>
	아이디: <input type="text" name="mid" id="mid"><br>
	전화번호: <input type="text" name="mtel" id="mtel"><br>
	<input type="button" value="클릭2" id="btn2"><br>
	<input type="button" value="배열로 POST통신" id="btn3"><br>
</body>
<script>
	document.querySelector("#btn").addEventListener("click", function(){
		//Ajax get통신
		fetch("./news.json") //fetch라는 함수 (ajax 통신 함수)
		.then(function(aa){ //해당 파일을 통신을 통하여 배열로 변환작업
			return aa.json();
		}).then(function(bb){ //try 데이터 출력파트
			console.log(bb);
		}).catch(function(error){ //예외처리로 데이터 에러발생 파트
			console.log("Data Error!!");
		});
	});
	
	//var, let, const => JS4, ES5
	//ES6 부턴 this변수 => 메모리 권리
	/*	
	POST통신 ECMA ajax 방식
	*/
	//JSON 배열로 넘기는 방식
	document.querySelector("#btn3").addEventListener("click", function(){
		this.mid = document.querySelector("#mid").value;
		this.mtel = document.querySelector("#mtel").value;
		fetch("./ajax2.do", {
			method: "POST",
			cache: "no-cache",
			headers:{
				"Content-Type":"application/json;char-set=utf-8"
			},
			body: JSON.stringify({
				"userid":this.mid
			})
		}).then(function(aa){
			return aa.text();
		}).then(function(bb){
			console.log(bb);
		}).catch(function(error){
			console.log("Data Error!!");
		});
	});
	
	
	//배열값이 아닌 name 형태로 넘기는 방식
	document.querySelector("#btn2").addEventListener("click", function(){
		this.mid = document.querySelector("#mid").value;
		this.mtel = document.querySelector("#mtel").value;
		
		fetch("./ajax.do", {
			method: "POST",
			cache: "no-cache",
			headers: {
				"Content-Type":"application/x-www-form-urlencoded"
			},
			body: "userid="+this.mid + "&usertel="+this.mtel
		}).then(function(aa){
			return aa.text();
		}).then(function(bb){
			console.log(bb);
		}).catch(function(error){
			console.log("Data Error!!");
		});
	});
</script>
</html>