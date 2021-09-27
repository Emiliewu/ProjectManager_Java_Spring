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
<title>project detail</title>
</head>
<body>
	<div class="container mx-auto" style="width:800px;">
	<div class="container-sm my-3 p-3 col-8">
		<div class="d-flex justify-content-between" style="color:#195f9b">
			<h3 class="p-3">Project Details</h3>
			<a href="/dashboard">back to the dashboard</a>
		</div>
		<div class="container-sm my-3 p-3 col-10">
		  <div class="row">
		    <div class="col">
		      <p>Project Title: </p>
		    </div>
		    <div class="col">
		      <p><c:out value="${ projectDetail.title }"/> </p>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col">
		      <p>Project Description: </p>
		    </div>
		    <div class="col">
		      <p><c:out value="${ projectDetail.description }"/> </p>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col">
		      <p>Due Date: </p>
		    </div>
		    <div class="col">
		      <p><fmt:formatDate type="date" value="${ projectDetail.duedate }"/> </p>
		    </div>		  
		  </div>
		  <div class="d-flex justify-content-between" >
		  <div class="col p-3">
		  	<c:if test="${ projectDetail.owner.id==user.id||projectDetail.teammembers.contains(user) }">
		  		<a href="/projects/${projectDetail.id}/tasks">See Tasks</a>
		  	</c:if>
		  </div>
		  <div class="col p-3">
		  	<c:if test="${ projectDetail.owner.id==user.id }">		  	
		  		<a href="/projects/${ projectDetail.id }/delete" class="btn btn-danger">Delete</a>
		  	</c:if>
		  	</div>
		  </div>
		</div>	
	</div>
	</div>
</body>
</html>