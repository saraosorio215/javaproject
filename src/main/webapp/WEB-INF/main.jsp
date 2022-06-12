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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<link rel = "stylesheet" type = "text/css" href="/css/style.css">
	<script type="text/javascript" src="/js/script.js"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Kaushan+Script&family=Montserrat:wght@100;400&display=swap" rel="stylesheet">
	<meta charset="ISO-8859-1">
	<title>Budget Tracker</title>
</head>
<body>
	<div class="center marg-top-5">
		<h1>Budget Tracker</h1>
		<h2>June 2022</h2>
	</div>
	<br />
	<div class="eighty border-main centered padding-5 dark">
		<div class="flex sp-even padding-5">
			<div class="fit-cont">
				<h2 class="center marg-bottom-5">Expenses</h2>
				<table class="border bills-t">
					<thead>
						<tr class="underlined">
							<th class="center padding-5"><h3>Due</h3></th>
							<th class="center border-left padding-5"><h3>Paid</h3></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="padding-5"><h3><fmt:formatNumber value="${totalDue}" type="currency" /></h3></td>
							<td class="center border-left padding-5"><h3><fmt:formatNumber value="${totalPaid}" type="currency" /></h3></td>
						</tr>
					</tbody>
				</table>
			</div>
			<br />
			<div class="fit-cont">
				<h2 class="center marg-bottom-5">Balance</h2>
				<table class="border income-t">
					<thead>
						<tr class="underlined">
							<th class="center padding-5"><h3>Income</h3></th>
							<th class="center border-left padding-5"><h3>Available</h3></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="padding-5"><h3><fmt:formatNumber value="${totalIncome}" type="currency" /></h3></td>
							<c:if test="${(totalIncome-totalPaid) > 0}">
								<td class="center border-left padding-5 green"><h3><fmt:formatNumber value="${totalIncome - totalPaid}" type="currency" /></h3></td>
							</c:if>
							<c:if test="${(totalIncome-totalPaid) < 0}">
								<td class="center border-left padding-5 red"><h3><fmt:formatNumber value="${totalIncome - totalPaid}" type="currency" /></h3></td>
							</c:if>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<br />
		<br />
		<div class="flex sp-even">
			<div class="marg-bottom-5 marg-right-5 half padding-5">
				<div class="marg-bottom-5 center">
					<h2>Where your money's going</h2>
				</div>
				<div class="marg-left-5 border padding-10 padd-bottom-20">
					<c:forEach items="${currPercent}" var="entry">
					<div class="flex marg-bottom-5">
						<h3><c:out value="${entry.key}"/>:</h3>
						<h3 class="marg-left-5"><c:out value="${entry.value}"/>%</h3>				
					</div>
					</c:forEach>
					<div class="hundred flex al-cent bar">
						<c:forEach items="${currPercent}" var="entry">
							<div style="width: ${entry.value}%" class="color overflow-h padding-5"><span class="marg-left-3 white"><c:out value="${entry.key}"/></span></div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="half marg-left-5 padding-5">
				<div>
					<h2 class="center marg-bottom-5">Money Left</h2>
				</div>
				<div class="border box-shadow padding-5">
					<div class="hundred flex green">
						<div style="width: ${(totalPaid / totalIncome) * 100}%" class="red"></div>
						<span class="marg-left-5"><fmt:formatNumber value="${totalIncome - totalPaid}" type="currency"/></span>
					</div>
				</div>
			</div>
		</div>
		<br />
		<div class="flex sp-even">
			<div class="marg-left-5 padding-5 seventy marg-right-5">
				<div>
					<h2 class="center marg-bottom-5">All Bills</h2>
				</div>
				<div>
					<table class="border center bill-list-t">
						<thead>
							<tr>
								<th class="underlined padding-5">Name</th>
								<th class="underlined padding-5">Amount</th>
								<th class="underlined padding-5">Category</th>
								<th class="underlined padding-5">Paid?</th>
								<th class="underlined padding-5">Update</th>
								<th class="underlined padding-5">Delete</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${allBills}" var="bill">
							<tr>
								<td class="underlined padding-5"><c:out value="${bill.getName()}"/></td>
								<td class="underlined padding-5"><fmt:formatNumber value="${bill.getAmount()}" type="currency" /></td>
								<td class="underlined padding-5"><c:out value="${bill.getCategory().getName()}"/></td>
								<c:if test="${bill.getIsPaid() == false}"><td class="underlined padding-5"><img src="images/x-icon.png" alt="logo" id="icon-sm"></td>
									<td class="underlined padding-5"><a href="/paid/${bill.id}/"><button id="button">Paid</button></a></td>
								</c:if>
								<c:if test="${bill.getIsPaid() == true}">
									<td class="underlined padding-5"><img src="images/checkmark-icon.png" alt="logo" id="icon-sm"></td>
									<td class="underlined padding-5"><a href="/unpaid/${bill.id}/"><button id="button">Not Paid</button></a></td>
								</c:if>
								<td class="underlined padding-5">
									<form action="/delete/bill/${bill.id}/" method="post">
										<input type="hidden" name="_method" value="delete">
										<input type="submit" value="Delete" id="button">
									</form>
								</td>
							</tr>
							</c:forEach>
							<tr>
								<td class="padding-5"><h4>Total:</h4></td>
								<td class="padding-5"><h4><fmt:formatNumber value="${totalPaid + totalDue}" type="currency" /></h4></td>
							</tr>
						</tbody>
					</table>
					<br />
				</div>
			</div>
			<div class="border box-shadow padding-5 thirty center margin-5">
				<div class="margin-5">
					<h2 class="marg-bottom-5 marg-top-5 center">Add Bills</h2>
					<form:form action="/new/bill/" method="post" modelAttribute="bill">
						<p class="marg-bottom-5">
							<form:label path="name">Name</form:label>
							<form:errors path="name"/>
							<form:input path="name" id="name"/>
						</p>
						<p class="marg-bottom-5">
							<form:label path="amount">Amount</form:label>
							<form:errors path="amount"/>
							<form:input path="amount" id="amount"/>
						</p>
						<p class="marg-bottom-5">
							<form:label path="category">Category</form:label>
							<form:select path="category">
								<c:forEach var="oneCat" items="${allcats}">
									<form:option value="${oneCat.id}" path="category">
										<c:out value="${oneCat.name}"/>
									</form:option>				
								</c:forEach>
							</form:select>
						</p>
						<p class="marg-bottom-5">
							<form:label path="isPaid">Paid?</form:label>
							<form:label path="isPaid">Yes</form:label>
							<form:radiobutton path="isPaid" value="true"/>
							<form:label path="isPaid">No</form:label>
							<form:radiobutton path="isPaid" value="false"/>
						</p>
						<p class="center">
							<input type="submit" value="Submit" id="button"/>
						</p>
					</form:form>
				</div>
				<div class="marg-bottom-5">
					<h2 class="marg-bottom-5 center">Add Income</h2>
						<form:form action="/new/income/" method="post" modelAttribute="income">
						<p class="marg-bottom-5">
							<form:label path="name">Name</form:label>
							<form:errors path="name"/>
							<form:input path="name" id="name"/>
						</p>
						<p class="marg-bottom-5">
							<form:label path="amount">Amount</form:label>
							<form:errors path="amount"/>
							<form:input path="amount" id="amount"/>
						</p>
						<p class="center">
							<input type="submit" value="Add" id="button"/>
						</p>
						</form:form>
				</div>
				<div>
					<h2 class="marg-bottom-5 center">Add Category</h2>
					<form:form action="/new/cat/" method="post" modelAttribute="cat">
						<p class="marg-bottom-5">
							<form:label path="name">Name</form:label>
							<form:errors path="name"/>
							<form:input path="name" id="name"/>
						</p>
						<p class="center">
							<input type="submit" value="Create" id="button"/>
						</p>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	

</body>
</html>