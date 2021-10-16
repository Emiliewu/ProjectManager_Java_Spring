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
<title>project dashboard</title>
</head>
<body>
<div class="container mx-auto" style="width:800px; ">
		<div class="d-flex justify-content-between" style="color:#195f9b">
		<h3 class="p-3">Welcome <c:out value="${ user.firstname }" /></h3>
		<a href="/logout">Logout</a>
		</div>
		<div class="d-flex justify-content-around" style="color:#195f9b">
		<h5 class="p-3">All Projects</h5>
		<a href="/projects/new">New Project</a>
		</div>
		<div class="container-sm my-3 p-3 col-8" style="border:1px solid black">
			<table class="table table-striped table-hover">
			<thead>
		    <tr>
		      <th scope="col">Title</th>
		      <th scope="col">Team Lead</th>
		      <th scope="col">Due Date</th>
		      <th scope="col">Action</th>
		    </tr>
			</thead>
			<tbody>
			<c:forEach var="p" items="${ allprojects }">
				<c:if test="${ p.teammembers.contains(user)==false&&p.owner.id!=user.id }">
				<tr>
					<td scope="row"><a href="/projects/${ p.id }"><c:out value="${ p.title }"/></a></td>
					<td scope="row"><c:out value="${ p.description }"/></td>
					<td scope="row"><<fmt:formatDate type="date" value="${ p.duedate }"/></td>
					<td scope="row"><a href="/projects/${ p.id }/join">Join</a></td>
				</tr>
				</c:if>
			</c:forEach>
  			</tbody>
			</table>
		</div>
		<div class="container-sm my-3 p-3 col-8" style="border:1px solid black">
			<h5>Your projects</h5>
			<table class="table table-striped table-hover">
			<thead>
		    <tr>
		      <th scope="col">Title</th>
		      <th scope="col">Team Lead</th>
		      <th scope="col">Due Date</th>
		      <th scope="col">Action</th>
		    </tr>
			</thead>
			<tbody>
			<c:forEach var="p" items="${ allprojects }">
				<c:if test="${ p.teammembers.contains(user)==true||p.owner.id==user.id }">
				<tr>
					<td scope="row"><a href="/projects/${ p.id }"><c:out value="${ p.title }"/></a></td>
					<td scope="row"><c:out value="${ p.description }"/></td>
					<td scope="row"><fmt:formatDate type="date" value="${ p.duedate }"/></td>
					<c:choose>
						<c:when test="${ p.owner.id==user.id }">
						<td scope="row"><a href="/projects/edit/${ p.id }">Edit</a></td>
						</c:when>
						<c:otherwise>
						<td scope="row"><a href="/projects/${ p.id }/leave">Leave Team</a></td>
						</c:otherwise>
					</c:choose>					
				</tr>
				</c:if>
			</c:forEach>
  			</tbody>
			</table>
		</div>
	</div>
</body>
</html>