<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<sql:query var="list" dataSource="${GauceDB}">
select empno, ename, job, mgr, sal, comm, deptno from emp
</sql:query>
<gdml>
  <dataset name="USERLIST" buffer="50">
    <dh>
      <def name="empno" type="int" size="5"/>
      <def name="ename" type="string" size="20"/>
      <def name="job" type="string" size="10"/>
      <def name="mgr" type="int" size="5"/>
      <def name="sal" type="decimal" size="5.2"/>
      <def name="comm" type="int" size="5"/>
      <def name="deptno" type="int" size="5"/>
    </dh><c:forEach var="rs_list" items="${list.rows}">
    <dr>
      <dd><c:out value="${rs_list.empno}"/></dd>
      <dd><c:out value="${rs_list.ename}"/></dd>
      <dd><c:out value="${rs_list.job}"/></dd>
      <dd><c:out value="${rs_list.mgr}"/></dd>
      <dd><c:out value="${rs_list.sal}"/></dd>
      <dd><c:out value="${rs_list.comm}"/></dd>
      <dd><c:out value="${rs_list.deptno}"/></dd>
    </dr></c:forEach>
  </dataset>
  <message>성공입니다.</message>
</gdml>
