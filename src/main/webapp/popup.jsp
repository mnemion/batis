<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝업창</title>
</head>
<body>
데이터 출력 리스트<br>
<span onclick="datacall('java')">java</span>
<span onclick="datacall('css')">css</span>
<span onclick="datacall('html')">html</span>
</body>
<script>
	function datacall(pname){
		//자신의 임의 파일을 이용하여 팝업을 띄움
		parent.window.postMessage({msg:pname},"*"); //postMessage: 서로다른 도메인에 한하여 배열 형태로 데이터를 보내는 함수 postMessage(배열값,"상대방 ip주소 또는 도메인") 
		//postMessage (배열값,"*") 모든 사이트 접속에 대해서 허용함
		
		
		//parent 자신을 로드한 페이지를 말함
	}
</script>
</html>