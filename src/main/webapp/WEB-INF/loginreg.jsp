<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!-- c:out ; c:forEach etc. --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (dates) --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<link rel = "stylesheet" type = "text/css" href="/css/style.css">
	<script type="text/javascript" src="/js/script.js"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Kaushan+Script&family=Montserrat:wght@100;400&display=swap" rel="stylesheet">
	<title>Login & Register</title>
</head>
<body>
	<div class="flex just-cent al-cent">
		<div class="dark border-main margin-5 white">
			<h3 class="padding-5 underlined center">Login</h3>
			<form:form action="/login/" method="post" modelAttribute="newLogin">
				<p class="marg-top-10 marg-bottom-5 padding-5">
					<form:label path="email"><span>Email</span></form:label>
					<form:errors path="email"/>
					<form:input path="email" id="email"/>
				</p>
				<p class="marg-bottom-10 padding-5">
					<form:label path="password">Password</form:label>
					<form:errors path="password"/>
					<form:input type="password" path="password" id="password"/>
				</p>
				<p class="center marg-bottom-10">
					<input type="submit" value="Login" id="button"/>
				</p>
			</form:form>
		</div>
		<div class="light-grey border-main margin-5">
			<h3 class="padding-5 underlined center">Register</h3>
			<form:form action="/register/" method="post" modelAttribute="newUser">
				<p class="marg-top-10 marg-bottom-5 padding-5">
					<form:label path="email">Email</form:label>
					<form:errors path="email"/>
					<form:input path="email" id="email"/>
				</p>
				<p class="marg-bottom-5 padding-5">
					<form:label path="password">Password</form:label>
					<form:errors path="password"/>
					<form:input type="password" path="password" id="password"/>
				</p>
				<p class="marg-bottom-10 padding-5">
					<form:label path="confirm">Confirm Password</form:label>
					<form:errors path="confirm"/>
					<form:input path="confirm" type="password" id="confirm"/>
				</p>
				<p class="center marg-bottom-10">
					<input type="submit" value="Register" id="button"/>
				</p>
			</form:form>
		</div>
	</div>
</body>
</html>