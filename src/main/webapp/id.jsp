<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복찾기</title>
<style>
.btn{width:150px; height:30px; display: inline-block; background-color: black; color: white; line-height: 30px; text-align: center; vertical-align: -5px;}
.input{display: inline-block;}
</style>
</head>
<body>
<form id ="f">
아이디 :<input type="text" name="mid" id="mid" class="input">
<span class="btn" onclick="ajax_load()">아이디 중복체크</span>
</form>
</body>
<script type="text/javascript">
function ajax_load(){
	var id = document.getElementById("mid");
	
	if(id.value==""){
		alert("아이디를 입력해 주세요");
	}else{
	var http = new XMLHttpRequest();
	http.onreadystatechange=function(){
		if(http.readyState == XMLHttpRequest.DONE && http.status==200){
			var result = this.response;
			console.log(result);
			//yes:중복, no: 가능 error:오류
			if(result =="no"){
				alert("사용가능한 아이디 입니다.");
				id.readOnly = true;
			}else if(result=="yes"){
				alert("다른 아이디를 입력해 주시길 바랍니다.");
			}
		}
	}
	http.open("post","http://192.168.110.223:8080/batis/idcheck.do",true); //비동기
	http.setRequestHeader("content-type","application/x-www-form-urlencoded");
	http.send("userid="+id.value);
	}
}
</script>
</html>