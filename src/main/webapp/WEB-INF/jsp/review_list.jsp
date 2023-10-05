<%@page import="batis.datavo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 
    	1.db -> dto -> Array1차원 -> return -> Array2차원
    	현재 방식 db-> vo -> Array1차언 ->viewpage
     -->
 <%
 	List<datavo> rv = (List<datavo>)request.getAttribute("data");
 	int total = Integer.parseInt((String)request.getAttribute("ct"));
 	String search = (String)request.getAttribute("search");
 	if(search=="null" ||search == null || search==""){
 		search="";
 	}
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록 리스트</title>
</head>
<body>
<table border="1">
	<thead>
		<tr>
			<th>고객명</th>
			<th>리뷰내용</th>
			<th>등록일</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
	</thead>
	<tbody>
	<%
		if(rv.size()==0){  //검새된 데이커가 없을 경우
	%>
	<tr><td colspan="5">검색하신 내용이 존재하지 않습니다.</td></tr>
	<%
		}else{ //검색된 데이토 또는 전체리스트
			int w = 0;
			do{
	%>
		<tr>
			<td><%= rv.get(w).getRname() %></td>
			<td><%= rv.get(w).getRtext() %></td>
			<td><%= rv.get(w).getRindate().substring(0,10) %></td>
			<td><input type="button" value="수정" onclick="modify_review(<%=rv.get(w).getRidx()%>)"></td>
			<td><input type="button" value="삭제" onclick="delete_review(<%=rv.get(w).getRidx()%>)"></td>
		</tr>
	<%
			w++;
			}while(w < rv.size());
		}
	%>
	</tbody>
</table>

<table border ="1">
	<tr>
	<%
		int pg = (int)Math.ceil(total/2f);
		int i =1;
		while(i < pg){
			
		
	%>
		<td><a href="./review_list.do?ridx=<%=i %>"><%=i %></a></td>
	<%
		i++;
		}
	%>
	</tr>
</table>
<form id="f" method="get" action="./review_list.do">
검색 : <input type="text" name="search" value="<%=search%>">
<input type="submit" value="검색" id="btn"> 
</form>
</body>
<script>
document.querySelector("#f").addEventListener("submit",function(){
	a.preventDefault();
	if(f.search.value==""){
		location.href='./review_list.do';
	}else{
		f.submit();
	}
});

	function modify_review(no){
		location.href="./review_modify.do?ridx="+no;
	}
	function delete_review(no){
		if(confirm("해당 내용 삭제시 데이터 복구가 되지 않습니다.")){
			location.href="./review_delete.do?ridx="+no;
		}
	}
</script>
</html>	