<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<gdml>
  <dataset name="USER" fragment="50">
    <dh>
      <def name="empno" type="int" size="5"/>
      <def name="ename" type="string" size="30"/>
      <def name="job" type="string" size="20"/>
      <def name="mgr" type="int" size="5"/>
      <def name="sal" type="int" size="5"/>
      <def name="comm" type="int" size="5"/>
      <def name="deptno" type="int" size="5"/>
    </dh><c:forEach var="user" items="${UserList}">
    <dr>
      <dd><c:out value="${user.empno}"/></dd>
      <dd><c:out value="${user.ename}"/></dd>
      <dd><c:out value="${user.job}"/></dd>
      <dd><c:out value="${user.mgr}"/></dd>
      <dd><c:out value="${user.sal}"/></dd>
      <dd><c:out value="${user.comm}"/></dd>
      <dd><c:out value="${user.deptno}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>