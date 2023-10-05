<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드 기능 적용</title>
</head>
<body>
<!-- 
	1.font에서 같은 이름으로 첨부파일을 여려개 사용하여 보내는 경우
	2. 
 -->
<form id ="f" method="post" action="./flieupok.do" enctype="multipart/form-data">
파일 업로드 : <input type="file" name="mfile" multiple="multiple"><br>
<input type="button" value="전송" onclick="abc()">
</form>
</body>
<script>
function abc(){
	f.submit();
}
</script>
</html>