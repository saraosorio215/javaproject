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
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" type = "text/css" href="/css/style.css">
<meta charset="ISO-8859-1">
<title>Budget Tracker</title>
</head>
<body>
	<div class="center">
		<h1>Budget Tracker</h1>
	</div>
	<div>
		<h2>Total Due: <fmt:formatNumber value="${totalDue}" type="currency" /></h2>
	</div>
	<div>
		<h2>Total Paid: <fmt:formatNumber value="${totalPaid}" type="currency" /></h2>
	</div>
	<div>
		<h2>Total Income: <fmt:formatNumber value="${totalIncome}" type="currency" /></h2>
	</div>
	<div>
		<h2>Currently Available: <fmt:formatNumber value="${totalIncome - totalPaid}" type="currency" /></h2>
	</div>
	<br />
	<div class="flex sp-btw">
		<div>
			<div>
				<h2>All Bills</h2>
			</div>
			<br />
			<div>
			<c:forEach items="${allcats}" var="oneCat">
				<h3><c:out value="${oneCat.name}"/></h3>
					<table class="table padding-5 center">
						<thead>
							<tr>
								<th>Name</th>
								<th>Amount</th>
								<th>Paid?</th>
								<th>Update</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${oneCat.getBills()}" var="bill">
							<tr>
								<td><c:out value="${bill.getName()}"/></td>
								<td><fmt:formatNumber value="${bill.getAmount()}" type="currency" /></td>
								<c:if test="${bill.getIsPaid() == false}"><td>No</td>
									<td><a href="/paid/${bill.id}/"><button>Paid</button></a></td>
								</c:if>
								<c:if test="${bill.getIsPaid() == true}">
									<td>Yes</td>
									<td><a href="/unpaid/${bill.id}/"><button>Not Paid</button></a></td>
								</c:if>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<br />
			</c:forEach>
			</div>
		</div>
		<div>
			<div>
				<h2>Add Bills</h2>
				<form:form action="/new/bill/" method="post" modelAttribute="bill">
					<p>
						<form:label path="name">Name</form:label>
						<form:errors path="name"/>
						<form:input path="name"/>
					</p>
					<p>
						<form:label path="amount">Amount</form:label>
						<form:errors path="amount"/>
						<form:input path="amount"/>
					</p>
					<p>
						<form:label path="isPaid">Paid?</form:label>
						<form:label path="isPaid">Yes</form:label>
						<form:radiobutton path="isPaid" value="true"/>
						<form:label path="isPaid">No</form:label>
						<form:radiobutton path="isPaid" value="false"/>
					</p>
					<p>
						<form:label path="category">Category</form:label>
						<form:select path="category">
							<c:forEach var="oneCat" items="${allcats}">
								<form:option value="${oneCat.id}" path="category">
									<c:out value="${oneCat.name}"/>
								</form:option>				
							</c:forEach>
						</form:select>
					</p>
					<input type="submit" value="Submit"/>
				</form:form>
			</div>
			<div>
				<h2>Add Income</h2>
					<form:form action="/new/income/" method="post" modelAttribute="income">
					<p>
						<form:label path="name">Name</form:label>
						<form:errors path="name"/>
						<form:input path="name"/>
					</p>
					<p>
						<form:label path="amount">Amount</form:label>
						<form:errors path="amount"/>
						<form:input type="number" path="amount"/>
					</p>
					<input type="submit" value="Add"/>
					</form:form>
			</div>
			<div>
				<h2>Add Category</h2>
				<form:form action="/new/cat/" method="post" modelAttribute="cat">
					<p>
						<form:label path="name">Category Name</form:label>
						<form:errors path="name"/>
						<form:input path="name"/>
					</p>
					<input type="submit" value="Create"/>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>