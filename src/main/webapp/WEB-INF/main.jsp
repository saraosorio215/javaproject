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
		<h2 class="marg-bottom-5">June 2022</h2>
	</div>
	<div class="flex border-main centered margin-5">
		<div class="dark">
			<div>
				<div class="flex sp-even marg-top-10">
					<div>
						<div class="flex sp-btw padding-5">
							<div class="marg-right-10">
								<h2 class="center marg-bottom-5 white">Expenses</h2>
								<table class="border bills-t">
									<thead>
										<tr class="underlined dark-yellow">
											<th class="center padding-5"><h3>Due</h3></th>
											<th class="center border-left padding-5"><h3>Paid</h3></th>
										</tr>
									</thead>
									<tbody>
										<tr class="grey">
											<td class="padding-5"><h3><fmt:formatNumber value="${totalDue}" type="currency" /></h3></td>
											<td class="center border-left padding-5"><h3><fmt:formatNumber value="${totalPaid}" type="currency" /></h3></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="marg-left-10">
								<h2 class="center marg-bottom-5 white">Balance</h2>
								<table class="border income-t">
									<thead>
										<tr class="underlined dark-yellow">
											<th class="center padding-5"><h3>Income</h3></th>
											<th class="center border-left padding-5"><h3>Available</h3></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="padding-5 grey"><h3><fmt:formatNumber value="${totalIncome}" type="currency" /></h3></td>
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
						<div class="padding-5 marg-top-10">
							<div>
								<h3 class="center marg-bottom-5 white">Remaining</h3>
							</div>
							<div class="hundred flex green">
								<div style="width: ${(totalPaid / totalIncome) * 100}%" class="red"></div>
								</div>
							</div>
						</div>
						<div class="marg-bottom-5 marg-right-5 half padding-5">
							<div class="marg-bottom-5 center">
								<h2 class="white">Where your money's going</h2>
							</div>
							<div class="marg-left-5 border padding-10 padd-bottom-20 yellow">
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
					</div>
		            <div class="marg-left-5 padding-5 marg-right-5">
		                <div>
		                    <h2 class="center marg-bottom-5 white">All Bills</h2>
		                </div>
		                <div>
		                    <table class="border center bill-list-t">
		                        <thead>
		                            <tr class="grey">
		                                <th class="underlined padding-5">Name</th>
		                                <th class="underlined padding-5">Amount</th>
		                                <th class="underlined padding-5">Category</th>
		                                <th class="underlined padding-5">Paid?</th>
		                                <th class="underlined padding-5">Update</th>
		                                <th class="underlined padding-5">Edit</th>
		                                <th class="underlined padding-5">Delete</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                            <c:forEach items="${allBills}" var="bill">
		                            <tr class="light-grey">
		                                <td class="underlined"><c:out value="${bill.getName()}"/></td>
		                                <td class="underlined"><fmt:formatNumber value="${bill.getAmount()}" type="currency" /></td>
		                                <td class="underlined"><c:out value="${bill.getCategory().getName()}"/></td>
		                                <c:if test="${bill.getIsPaid() == false}"><td class="underlined"><img src="images/x-icon.png" alt="logo" id="icon-sm"></td>
		                                    <td class="underlined"><a href="/paid/${bill.id}/"><button id="button">Paid</button></a></td>
		                                </c:if>
		                                <c:if test="${bill.getIsPaid() == true}">
		                                    <td class="underlined"><img src="images/checkmark-icon.png" alt="logo" id="icon-sm"></td>
		                                    <td class="underlined"><a href="/unpaid/${bill.id}/"><button id="button">Not Paid</button></a></td>
		                                </c:if>
		                                <td class="underlined"><a href="/edit/bill${bill.id}/"><img src="images/edit-icon.png" alt="logo" id="icon-sm"></a></td>
		                                <td class="underlined">
		                                    <form action="/delete/bill/${bill.id}/" method="post">
		                                        <input type="hidden" name="_method" value="delete">
		                                        <button type="submit" id="button"><img src="images/delete-icon.png" alt="logo" id="icon-sm"></button>
		                                    </form>
		                                </td>
		                            </tr>
		                            </c:forEach>
		                        </tbody>
		                    </table>
		                </div>
		                <div class="flex padding-5">
		                    <h4>Total:</h4>
		                    <h4 class="marg-left-5"><fmt:formatNumber value="${totalPaid + totalDue}" type="currency" /></h4>
		                </div>
		            </div>
				</div>
	        </div>
        	<div class="grey full border-left">
			    <div class="center">
				    <div class="marg-bottom-10 dark underlined">
				    	<h2 class="center padding-5 white">Quick Add</h2>
				    </div>	
			        <div class="margin-5 marg-bottom-10">
			            <h3 class="marg-bottom-5 marg-top-5 center">Add Bills</h3>
			            <form:form action="/new/bill/" method="post" modelAttribute="bill" class="left">
			                <h4 class="marg-bottom-5">
			                    <form:label path="name">Name</form:label>
			                    <form:errors path="name"/>
			                    <form:input path="name" id="name"/>
			                </h4>
			                <h4 class="marg-bottom-5">
			                    <form:label path="amount">Amount</form:label>
			                    <form:errors path="amount"/>
			                    <form:input path="amount" id="amount"/>
			                </h4>
			                <h4 class="marg-bottom-5">
			                    <form:label path="category">Category</form:label>
			                    <form:select path="category">
			                        <c:forEach var="oneCat" items="${allcats}">
			                            <form:option value="${oneCat.id}" path="category">
			                                <c:out value="${oneCat.name}"/>
			                            </form:option>				
			                        </c:forEach>
			                    </form:select>
			                </h4>
			                <div class="marg-bottom-5 flex just-left al-cent">
			                    <form:label path="isPaid" class="marg-right-5"><h4>Paid?</h4></form:label>
			                    <form:radiobutton path="isPaid" value="true"/>
			                    <form:label path="isPaid" class="marg-right-10 marg-left-5">Yes</form:label>
			                    <form:radiobutton path="isPaid" value="false"/>
			                    <form:label path="isPaid" class="marg-left-5">No</form:label>
			                </div>
			                <p class="center">
			                    <input type="submit" value="Submit" id="button"/>
			                </p>
			            </form:form>
			        </div>
			        <br />
			        <div class="margin-5 marg-bottom-10">
			            <h3 class="marg-bottom-5 center">Add Income</h3>
			                <form:form action="/new/income/" method="post" modelAttribute="income" class="left">
			                <h4 class="marg-bottom-5">
			                    <form:label path="name">Name</form:label>
			                    <form:errors path="name"/>
			                    <form:input path="name" id="name"/>
			                </h4>
			                <h4 class="marg-bottom-5">
			                    <form:label path="amount">Amount</form:label>
			                    <form:errors path="amount"/>
			                    <form:input path="amount" id="amount"/>
			                </h4>
			                <p class="center">
			                    <input type="submit" value="Add" id="button"/>
			                </p>
			                </form:form>
			        </div>
			        <br />
			        <div class="margin-5">
			            <h3 class="marg-bottom-5 center">Add Category</h3>
			            <form:form action="/new/cat/" method="post" modelAttribute="cat">
			                <h4 class="marg-bottom-5 left">
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
        </div>
</body>
</html>