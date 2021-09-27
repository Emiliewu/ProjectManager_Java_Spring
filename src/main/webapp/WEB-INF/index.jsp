<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta charset="UTF-8" />
<title>Login and Registration</title>
</head>
<body>
<div class="container mx-auto" style="width:800px;">
	<div class="container p-2 my-2">
		<h3 style="color:#195f9b">Project Manager</h3>
		<p>A place for teams to manage projects</p>
	</div>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
	<div  class="container d-flex justfiy-content-around">
	<div class="container p-2 w-40">
	<h3>Registration</h3>
		<form:form action="/register" method="post" modelAttribute="newUser">
	       <div class="form-group">
	           <label>First Name:</label>
	           <form:input path="firstname" class="form-control" />
	           <form:errors path="firstname" class="text-danger" />
	       </div>
	       <div class="form-group">
	           <label>last Name:</label>
	           <form:input path="lastname" class="form-control" />
	           <form:errors path="lastname" class="text-danger" />
	       </div>
	       <div class="form-group">
	           <label>Email:</label>
	           <form:input path="email" class="form-control" />
	           <form:errors path="email" class="text-danger" />
	       </div>
	       <div class="form-group">
	           <label>Password:</label>
	           <form:password path="password" class="form-control" />
	           <form:errors path="password" class="text-danger" />
	       </div>
	       <div class="form-group">
	           <label>Confirm Password:</label>
	           <form:password path="confirm" class="form-control" />
	           <form:errors path="confirm" class="text-danger" />
	       </div>
	       <div class="row my-2">
	        <div class="container">
	       	      <button class="btn btn-primary" type="submit">Register</button>
	         </div>
	     </div>
	    </form:form>
		</div>
	    <div class="container p-3 w-40">
	    <h3>Login</h3>
	    <form:form action="/login" method="post" modelAttribute="newLogin">
	        <div class="form-group">
	            <label>Email:</label>
	            <form:input path="email" class="form-control" />
	            <form:errors path="email" class="text-danger" />
	        </div>
	        <div class="form-group">
	            <label>Password:</label>
	            <form:password path="password" class="form-control" />
	            <form:errors path="password" class="text-danger" />
	        </div>
	        
	        <div class="row my-2">
		        <div class="container">
		       	      <button class="btn btn-success" type="submit">Login</button>
		         </div>
		     </div>
	    </form:form>
	    </div>
	</div>  
	</div>
</body>
</html>