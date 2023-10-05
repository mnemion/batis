<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Javascript Node</title>
<!-- 
DOM :innerHTML innerText
NODE : 객체의 node 번호를 확인해서 출력하는 형태
 -->
</head>
<body>
<ul id="list">
	<li>윤보미</li>
	<li>박초롱</li>
</ul>
<input type="button" value="노드 앞에 추가" onclick="a()">
<input type="button" value="노드 뒤에 추가" onclick="b()">
<input type="button" value="노드 중간에 추가" onclick="c()">
<input type="button" value="노드 삭제" onclick="d()">
<input type="button" value="노드 갯수" onclick="abc()">
<input type="button" value="노드 강제 생성" onclick="f()">
</body>
<script>
var code = document.getElementById("list");
function a(){
	var a  = document.createElement("li"); //태그를 생성
	var text = document.createTextNode("정은지");   //문자만 적용
	a.append(text);  //해당 태그 안에 값을 적용
	code.insertBefore(a,code.childNodes[0]);
}

function b(){
	var a  = document.createElement("li"); 
	var text = document.createTextNode("김남주");
	a.append(text);
	//code.insertBefore(a,code.lastChild);
	code.append(a);
}
/*
 * childNodes : 빈 배열도 포함
   children : 빈 배열 제거 후 실제 태그에 대한 node값만 가져옴
 */

function c(){
	var a  = document.createElement("li"); 
	var text = document.createTextNode("오하영");
	a.append(text);
	//code.insertBefore(a,code.childNodes[1]);
	code.insertBefore(a,code.children[1]);
	
}


function d(){
	code.removeChild(code.children[0]);
}

function abc(){
	console.log(code.children);
	var ea  =code.children.length;
	console.log(ea);
}

function f(){
	var data =["정은지","오하영","김남주"];
	var w = 0;
	do{
		var a  = document.createElement("li"); 
		var text = document.createTextNode(data[w]);
		a.append(text);
		code.append(a);
		w++;
	}while(w<data.length);
}

</script>
</html>