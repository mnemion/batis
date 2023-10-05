<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Javascript Node2(각종입력사항)</title>
</head>
<body>
<div id="filediv">
파일첨부 : <input type="file" name="mfile">
</div>
<input type="button" value="파일첨부 추가" onclick="plus()">
</body>
<script>
var code = document.getElementById("filediv");
	function plus(){
		var ea = code.children.length;
		if(ea < 4){
			var html = document.createElement("input");
			html.type="file";  //type 설정시 필요
			html.name="mfile";  //name값 설정
			code.append(html);  
		}
	}
</script>
</html>