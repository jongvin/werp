<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<gdml>
  <dataset name="GAUCE" fragment="50">
    <dh>
      <def name="emp_name" type="string" size="20"/>
      <def name="emp_id" type="int" size="5"/>
      <def name="emp_code" type="int" size="5"/>
      <def name="emp_hiredate" type="string" size="20"/>
      <def name="emp_age" type="int" size="5"/>
      <def name="emp_pay" type="decimal" size="10.3"/>
    </dh><c:forEach var="list" items="${TRSelectList}">
    <dr>
      <dd><c:out value="${list.emp_name}"/></dd>
      <dd><c:out value="${list.emp_id}"/></dd>
      <dd><c:out value="${list.emp_code}"/></dd>
      <dd><c:out value="${list.emp_hiredate}"/></dd>
      <dd><c:out value="${list.emp_age}"/></dd>
      <dd><c:out value="${list.emp_pay}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>
