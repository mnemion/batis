<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>저장된 파일리스트</title>
</head>
<body>
<table border="1">
<thead>
<tr>
<th>파일리스트</th>
</tr>
</thead>
<tbody id ="datalist">

</tbody>
</table>
</body>
<script>
// 표현식 코드는 자바스크립트 주석으로 사용하더라도 작동됨
//JSTL 먼저 작동을 하며, 이후에 javascript 이후에 작동 하게 됩니다.
var html = document.getElementById("datalist");
var data = Number("${data.size()}");

var w =0;
var ea0 = "${data.get(0).getFname()}";
var ea1 = "${data.get(1).getFname()}";
while(w < 2){
	var filenm = eval("ea"+w);
	var spnm = filenm.split(",");
	console.log(spnm);
	var aa = document.createElement("tr");
	var bb = document.createElement("td");
	//var cc = document.createTextNode(filenm);
	for(var i = 0; i < spnm.length; i++){
		bb.innerHTML += "<a href='"+spnm[i]+"'>"+spnm[i]+"</a>\n"
	}
	//bb.append(cc);
	aa.append(bb);
	html.append(aa);
	w++;
}

</script>
</html>