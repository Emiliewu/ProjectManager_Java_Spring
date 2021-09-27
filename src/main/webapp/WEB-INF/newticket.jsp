<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<meta charset="UTF-8" />
<title>project tasks</title>
</head>
<body>
	<div class="container mx-auto" style="width:800px;">
		<div class="container-sm my-3 p-3 col-10">
			<div class="d-flex justify-content-between" style="color:#195f9b">
				<h3 class="p-2">Project: <c:out value="${ projectDetail.title }" /></h3>
				<a href="/dashboard">back to the dashboard</a>
			</div>
			<div class="container-sm my-3">
			<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
			<p class="p-2">Project Lead: <c:out value="${ projectDetail.owner.firstname }" /></p>
			<c:if test="${ projectDetail.owner.id==user.id||projectDetail.teammembers.contains(user) }">
			<form:form action="/projects/${projectDetail.id}/tasks/new" method="POST" modelAttribute="newticket">			
			    <div class="mb-3 row">
			        <form:label path="tickettask" class="col-sm-4 col-form-label">Add a task ticket for this team:</form:label>
			        <div class="col-sm-6">
			        <form:errors path="tickettask" style="color:red;"/>
			        <form:input path="tickettask" class="form-control"/>
			        </div>
			    </div>
			   
			    <div class="row my-2">
		         	<div class="container">
		       	      <button class="btn btn-primary" type="submit">Submit</button>
		         	</div>
		         </div>
			</form:form>  
			</c:if>
			</div>
			<div class="container-sm my-3">
				<c:forEach items="${ tickets }" var="t">
				<p style="color:#195f9b">Added by <c:out value="${ t.ticketowner.firstname }" /> at <fmt:formatDate pattern="hh:mma MM dd" value="${ t.getCreatedAt()}"/></p>
				<p class="d-flex justify-content-between"><c:out value="${ t.tickettask }" /> <span><a href="/projects/${ projectDetail.id }/tasks/${ t.id }/delete" class="btn btn-sm btn-primary">Delete</a></span></p>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>