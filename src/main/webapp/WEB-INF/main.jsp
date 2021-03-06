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
	<div class="center marg-top-5 marg-bottom-5">
		<h1>Budget Tracker</h1>
		<h2 class="marg-bottom-5"><c:out value="${currAcct.name}"/></h2>
		<a href="/overview/">Overview</a>
		<br />
		<a href="/logout/">Logout</a>
	</div>
	<div class="flex just-cent main-size centered al-cent">
		<div class="border-main black minimum">
			<div class="underlined padding-5 dark">
				<h3 class="center padding-5 white">All Accounts</h3>
			</div>
			<div class="padding-5 bar-title scroll">
				<c:forEach items="${allAccounts}" var="acct">
						<a href="/acct/${acct.id}/" class="blank marg-left-5 marg-top-5 flex column">
						<c:out value="${acct.name}"/>
						</a>
				</c:forEach>
			</div>
		</div>
		<div class="dark main-acct four">
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
										<tr>
											<c:if test="${totalDue > 0}">
												<td class="padding-5 red">
													<h3><fmt:formatNumber value="${totalDue}" type="currency" /></h3>
												</td>
											</c:if>
											<c:if test="${totalDue == 0}">
												<td class="padding-5 light-grey">
													<h3><fmt:formatNumber value="${totalDue}" type="currency" /></h3>
												</td>
											</c:if>
											<td class="center border-left padding-5 light-grey"><h3><fmt:formatNumber value="${totalPaid}" type="currency" /></h3></td>
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
										<tr class="center">
											<td class="padding-5 light-grey"><h3><fmt:formatNumber value="${totalIncome}" type="currency" /></h3></td>
											<c:if test="${(totalIncome-totalPaid) > 0}">
												<td class="center border-left padding-5 green"><h3><fmt:formatNumber value="${totalIncome - totalPaid}" type="currency" /></h3></td>
											</c:if>
											<c:if test="${(totalIncome-totalPaid) < 0}">
												<td class="center border-left padding-5 red"><h3><fmt:formatNumber value="${totalIncome - totalPaid}" type="currency" /></h3></td>
											</c:if>
											<c:if test="${totalIncome == 0}">
												<td class="light-grey border-left"><h3>$0.00</h3></td>
											</c:if>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="padding-5 marg-top-10">
							<div>
							</div>
							<div class="hundred flex green">
								<div style="width: ${(totalPaid / totalIncome) * 100}%" class="red"></div>
								<h5 class="marg-left-5 padd-top-5 padd-right-5">Remaining</h5>
								</div>
							</div>
						</div>
						<div class="marg-bottom-5 marg-right-5 half padding-5">
							<div class="marg-bottom-5 center">
								<h3 class="white">Money Distribution</h3>
							</div>
							<div class="marg-left-5 border padding-10 padd-bottom-20 black bar-title">
								<c:forEach items="${currPercent}" var="entry">
								<c:if test="${entry.value > 0.0}">
								<div class="flex marg-bottom-5">
									<h4><c:out value="${entry.key}"/>:</h4>
									<h4 class="marg-left-5"><c:out value="${entry.value}"/>%</h4>				
								</div>
								</c:if>
								</c:forEach>
								<div class="hundred flex al-cent bar light-grey">
									<c:forEach items="${currPercent}" var="entry">
									<c:if test="${entry.value > 0.0}">
										<div style="width: ${entry.value}%" class="overflow-h padding-5"><span class="marg-left-3 black-text"><c:out value="${entry.key}"/></span></div>
									</c:if>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
		            <div class="margin-5 padding-5 flex sp-btw">
		            	<div class="four">
			                <div class="flex al-cent marg-bottom-5 marg-left-10 white left">
			                    <h3>All Bills -- </h3>
			                    <h4 class="marg-left-5">Total: <fmt:formatNumber value="${totalPaid + totalDue}" type="currency" /></h4>
			                </div>
		                	<div class="margin-5 scroll">
			                    <table class="border bill-list-t center">
			                        <thead>
			                            <tr class="dark-red">
			                                <th class="underlined padding-5">Name</th>
			                                <th class="underlined padding-5">Amount</th>
			                                <th class="underlined padding-5">Paid?</th>
			                                <th class="underlined padding-5">Category</th>
			                                <th class="underlined padding-5" colspan="2">Actions</th>
			                            </tr>
			                        </thead>
			                        <tbody>
			                            <c:forEach items="${allBills}" var="bill">
			                            <tr class="light-red">
			                                <td class="underlined padding-3"><c:out value="${bill.getName()}"/></td>
			                                <td class="underlined padding-3"><fmt:formatNumber value="${bill.getAmount()}" type="currency" /></td>
			                                <c:if test="${bill.getIsPaid() == false}"><td class="underlined center"><img src="${pageContext.request.contextPath}/images/x-icon.png" alt="logo" id="icon-sm"></td>
				                                <td class="underlined"><c:out value="${bill.getCategory().getName()}"/></td>
			                                    <td class="underlined"><a href="/paid/${bill.id}/"><button id="button">Paid</button></a></td>
			                                </c:if>
			                                <c:if test="${bill.getIsPaid() == true}">
			                                    <td class="underlined"><img src="${pageContext.request.contextPath}/images/checkmark-icon.png" alt="logo" id="icon-sm"></td>
				                                <td class="underlined no-wrap"><c:out value="${bill.getCategory().getName()}"/></td>
			                                    <td class="underlined"><a href="/unpaid/${bill.id}/"><button id="button">Not Paid</button></a></td>
			                                </c:if>
			                                <td class="underlined">
			                                    <form action="/delete/bill/${bill.id}/" method="post">
			                                        <input type="hidden" name="_method" value="delete">
			                                        <button type="submit" id="button-trash"><img src="${pageContext.request.contextPath}/images/delete-icon.png" alt="logo" id="icon-sm"></button>
			                                    </form>
			                                </td>
			                            </tr>
			                            </c:forEach>
			                        </tbody>
			                    </table>
		                	</div>
		                </div>
		            	<div class="double marg-left-10 marg-right-5">
					    	<div class="white marg-left-10 marg-bottom-5 flex al-cent left">
					        	<h3>All Income -- </h3>
					          	<h4 class="marg-left-5">Total: <fmt:formatNumber value="${totalIncome}" type="currency" /></h4>
				    	    </div>
				    	    <div class="margin-5 scroll">
				    	        <table class="border inc-list-t center">
				    	        	<thead>
				    	        		<tr class="dark-green">
				    	       				<th class="underlined padding-5">Name</th>
				    	       				<th class="underlined padding-5">Amount</th>
				    	       				<th class="underlined padding-5">Actions</th>
				    	       			</tr>
				    	       		</thead>
				    	       		<tbody>
				    	       			<c:forEach items="${allIncome}" var="inc">
				    	       			<tr class="light-green">
				    	       				<td class="underlined padding-5 no-wrap"><c:out value="${inc.name}"/></td>
				            				<td class="underlined padding-5"><fmt:formatNumber value="${inc.amount}" type="currency" /></td>
				            				<td class="underlined">
				            					<form action="/delete/inc/${inc.id}/" method="post">
			                                        <input type="hidden" name="_method" value="delete">
			                                        <button type="submit" id="button-trash-2"><img src="${pageContext.request.contextPath}/images/delete-icon.png" alt="logo" id="icon-sm"></button>
			                                    </form>
				            				</td>
				   	        			</tr>
				   	        			</c:forEach>
				   	        		</tbody>
				   	        	</table>
			   	        	</div>
			           	</div>
		           	</div>
				</div>
	       	</div>
	       	<div class="add-form border-main single">
				<div class="center">
				    <div class="dark underlined padding-5">
				    	<h3 class="center padding-5 white">Quick Add</h3>
				    </div>
			        <div class="add-income underlined">
				    	<h3 class="marg-bottom-5 center">Add Income</h3>
				        <form:form action="/new/income/" method="post" modelAttribute="income" class="left" autocomplete="off">
							<h4 class="marg-bottom-5 flex">
						        <form:label path="name">Name</form:label>
					            <form:errors path="name"/>
					            <form:input path="name" id="name"/>
				            </h4>
				            <h4 class="marg-bottom-10 flex">
				                <form:label path="amount">Amount</form:label>
			                    <form:errors path="amount"/>
			                    <form:input path="amount" id="amount"/>
				            </h4>
				            <form:hidden path="account" value="${currAcct.id}"/>
				            <p class="center">
				                <input type="submit" value="Add" id="button"/>
				            </p>
			                </form:form>
				    </div>
			        <div class="add-bill underlined">
			            <h3 class="marg-bottom-5 marg-top-5 center">Add Bill</h3>
			            <form:form action="/new/bill/" method="post" modelAttribute="bill" class="left" autocomplete="off">
			                <h4 class="marg-bottom-5 flex">
			                    <form:label path="name">Name</form:label>
			                    <form:errors path="name"/>
			                    <form:input path="name" id="name"/>
			                </h4>
			                <h4 class="marg-bottom-5 flex">
			                    <form:label path="amount">Amount</form:label>
			                    <form:errors path="amount"/>
			                    <form:input path="amount" id="amount"/>
			                </h4>
			                <h4 class="marg-bottom-5 flex">
			                    <form:label path="category">Category</form:label>
			                    <form:select path="category" id="category">
			                        <c:forEach var="oneCat" items="${allcats}">
			                            <form:option value="${oneCat.id}" path="category" id="cat-name">
			                                <c:out value="${oneCat.name}"/>
			                            </form:option>				
			                        </c:forEach>
			                    </form:select>
			                </h4>
			                <div class="marg-bottom-10 flex just-left al-cent">
			                    <form:label path="isPaid" class="marg-right-5"><h4>Paid?</h4></form:label>
			                    <form:radiobutton path="isPaid" value="true" id="radio"/>
			                    <form:label path="isPaid" class="marg-right-10 marg-left-5">Yes</form:label>
			                    <form:radiobutton path="isPaid" value="false" id="radio"/>
			                    <form:label path="isPaid" class="marg-left-5">No</form:label>
			                </div>
			                <form:hidden path="account" value="${currAcct.id}"/>
			                <p class="center">
			                    <input type="submit" value="Add" id="button"/>
			                </p>
			            </form:form>
			        </div>
			        <div class="add-cat underlined">
					<h3 class="marg-bottom-5 center">Add Category</h3>
				    	<form:form action="/new/cat/${currAcct.id}" method="post" modelAttribute="cat" autocomplete="off">
				        	<h4 class="marg-bottom-10 left flex">
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