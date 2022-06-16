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
	<title>Overview</title>
</head>
<body>
	<div class="center marg-top-5">
		<h1>Budget Tracker</h1>
		<h2 class="marg-bottom-5">Welcome</h2>
		<a href="/logout/">Logout</a>
	</div>
	<div class="flex just-cent main-size centered al-cent">
		<div class="border-main black minimum">
			<div class="underlined padding-5 dark">
				<h2 class="center padding-5 white">All Accounts</h2>
			</div>
			<div class="padding-5 bar-title">
				<c:forEach items="${allAccounts}" var="acct">
					<a href="/acct/${acct.id}/" class="blank marg-left-5 marg-top-5 flex column"><c:out value="${acct.name}"/></a>
				</c:forEach>
			</div>
		</div>
		<div class="dark border-main four">
			<div class="center white">
				<h2 class="padding-5">Overview</h2>
			</div>
			<div class="padding-5 white">
				<h3>Total Bills: <fmt:formatNumber value="${totalBills}" type="currency" /></h3>
				<h3>Total Income: <fmt:formatNumber value="${totalIncome}" type="currency" /></h3>
			</div>
			<div>
				<div>
					<h3 class="white">All Categories</h3>
				</div>
				<div>
				<table class="center inc-list-t border">
					<thead>
						<tr class="dark-blue">
							<th class="underlined padding-5">Name</th>
							<th class="underlined padding-5"># of Bills</th>
							<th class="underlined padding-5">Total Spent</th>
							<th class="underlined padding-5" colspan="2">Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${allCats}" var="cat">
						<tr class="light-blue">
							<td><c:out value="${cat.name}"/></td>
							<td><c:out value="${cat.getNumBills()}"/></td>
							<td><fmt:formatNumber value="${cat.getAmtSpent()}" type="currency"/></td>
							<td><a href="/edit/cat/${cat.id}/" id="button-edit"><img src="${pageContext.request.contextPath}/images/edit-icon.png" alt="logo" id="icon-sm"></a></td>
							<td>
								<form action="/delete/cat/${cat.id}/" method="post">
				                 	<input type="hidden" name="_method" value="delete">
				                    <button type="submit" id="button-trash-3"><img src="${pageContext.request.contextPath}/images/delete-icon.png" alt="logo" id="icon-sm"></button>
				                </form>
							</td>
						</tr>						
						</c:forEach>
					</tbody>
				</table>
			
				</div>
			</div>
		</div>
		<div class="border-main">
			<div class="dark">
				<h2 class="white center underlined padding-5">Quick Add</h2>
			</div>
			<div class="orange">
				<h3 class="center padding-5">Add Account</h3>
				<h6 class="marg-bottom-10 center">(e.g. "June 2022", "Summer Trip", "Job Earnings", etc.)</h6>
				<form:form action="/new/account/" method="post" modelAttribute="newAccount">
					<p class="marg-bottom-10 marg-left-5">
						<form:label path="name">Name</form:label>
						<form:errors path="name"/>
						<form:input path="name"/>
					</p>
					<p class="center padd-bottom-10">
						<input type="submit" value="Create" id="button"/>
					</p>
				</form:form>
			</div>
			<div class="add-cat underlined">
				<h3 class="marg-bottom-5 center">Add Category</h3>
			    	<form:form action="/new/cat/" method="post" modelAttribute="cat" autocomplete="off">
			        	<h4 class="marg-bottom-10 left">
			            	<form:label path="name">Name</form:label>
			                <form:errors path="name"/>
			                <form:input path="name" id="name"/>
			            </h4>
			            <p class="center">
		                    <input type="submit" value="Create" id="button"/>
		                </p>
		            </form:form>
			</div>
		</div>
	</div>
</body>
</html>