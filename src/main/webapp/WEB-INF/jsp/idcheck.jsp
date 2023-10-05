<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	
	response.addHeader("Access-Control-Allow-Origin", "*"); //여긴 도메인명 cors를 해결할 수 있는 response 메소드이며, *는 모든 도메인을 말함
	response.addHeader("Access-Control-Allow-Credentials", "true");   //cors true false (도메인에 대한 인증요청)
%>
${mid}