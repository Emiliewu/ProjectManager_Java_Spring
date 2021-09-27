<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta charset="UTF-8" />
<title>edit project</title>
</head>
<body>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
		<div class="container-sm my-3 p-3 col-8">
			<div class="d-flex justify-content-between" style="color:#195f9b">
			<h3 class="p-3">Edit Project </h3>
			<a href="/dashboard">back to the dashboard</a>
			</div>
			<form:form action="/projects/update/${editproject.id}" method="POST" modelAttribute="editproject">
			<input type="hidden" name="_method" value="PUT">
			<form:hidden path="owner" />	
			<form:hidden path="teammembers" />
			<form:hidden path="tickets" />				
		    <div class="mb-3 row">
		        <form:label path="title" class="col-sm-2 col-form-label">Title</form:label>
		        <div class="col-sm-10">
		        <form:errors path="title" style="color:red;"/>
		        <form:input path="title" class="form-control"/>
		        </div>
		    </div>
		    <div class="mb-3 row">
		        <form:label path="description" class="col-sm-2 col-form-label">Description</form:label>
		        <div class="col-sm-10">
		        <form:errors path="description" style="color:red;"/>
		        <form:input path="description" class="form-control"/>
		        </div>
		    </div>
		    <div class="mb-3 row">
		        <form:label path="duedate" class="col-sm-3 col-form-label">Due Date </form:label>
		        <div class="col-sm-9">
		        <form:errors path="duedate" style="color:red;"/>
		        <p style="color:red;"><c:out value="${ duedateerror }" /></p>
		        <form:input path="duedate" type="date" class="form-control" min="${todaydate}"/>
		        </div>
		    </div>
		    <div class="row my-2">
	         	<div class="container">
	         	  <a href="/dashboard" class="btn btn-primary">Cancel</a>
	       	      <button class="btn btn-primary" type="submit">Submit</button>
	         	</div>
	         </div>
		</form:form>  
		
	</div>
</body>
</html>