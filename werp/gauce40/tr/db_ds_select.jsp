<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<sql:query var="user" dataSource="${GauceDB}">
select empno, ename, job, mgr, sal, comm, deptno from emp where empno=?
<sql:param value="${param.empno}"/>
</sql:query>
<gdml>
  <dataset name="tbds_list" buffer="50">
    <dh>
      <def name="empno" type="int" size="5"/>
      <def name="ename" type="string" size="20"/>
      <def name="job" type="string" size="10"/>
      <def name="mgr" type="int" size="5"/>
      <def name="sal" type="decimal" size="5.2"/>
      <def name="comm" type="int" size="5"/>
      <def name="deptno" type="int" size="5"/>
    </dh><c:forEach var="rs_user" items="${user.rows}">
    <dr>
      <dd><c:out value="${rs_user.empno}"/></dd>
      <dd><c:out value="${rs_user.ename}"/></dd>
      <dd><c:out value="${rs_user.job}"/></dd>
      <dd><c:out value="${rs_user.mgr}"/></dd>
      <dd><c:out value="${rs_user.sal}"/></dd>
      <dd><c:out value="${rs_user.comm}"/></dd>
      <dd><c:out value="${rs_user.deptno}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>