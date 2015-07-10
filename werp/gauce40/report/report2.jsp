<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<gdml>
  <dataset name="GAUCE" fragment="50">
    <dh>
      <def name="sabun" type="string" size="20"/>
      <def name="name" type="string" size="20"/>
    </dh><c:forEach var="list" items="${SelectTRList}">
    <dr>
      <dd><c:out value="${list.sabun}"/></dd>
      <dd><c:out value="${list.name}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>