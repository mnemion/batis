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
				<th>파일 리스트</th>
			</tr>
		</thead>
		<tbody id="datalist">
			
		</tbody>
	</table>
</body>
	<%-- var data = "${data.get(0).getFidx()}";	//자동 증가값
	var data = "${data.get(0).getFname()}";	//파일 이름 --%>
<script>
	//표현식 코드는 자바스크립트 주석으로 사용하더라도 작동됨
	//JSTL이 먼저 작동을 하며, JAVASCRIPT가 이후에 작동하게 됨
	//Java -> JSP(표현식) -> javascript -> HTML
	
	var data = Number("${data.size()}");
	var ea0 = ("${list.get(0).getFname()}")
	var ea1 = ("${list.get(1).getFname()}")
	
	var w = 0;
	var html = document.getElementById("datalist");
	
	while(w < data) {
		var filenm = eval("ea" + w);
		var spnm = filenm.split(",");

		var aa = document.createElement("tr");
		var bb = document.createElement("td");
		
		for(var f = 0; f < spnm.length; f++) {
			bb.innerHTML += "<a href='"+spnm[f]+"'>"+spnm[f]+"</a>\n";
		}
		
		aa.append(bb);
		html.append(aa);
		
		w++;
	}
</script>
</html>