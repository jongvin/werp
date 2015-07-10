<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<gdml>
  <dataset name="USER" buffer="50">
    <sql:query var="user" dataSource="${GauceDB}">  
      select empno, ename, job, mgr, sal, comm, deptno from emp
    </sql:query>
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

  <dataset name="GROUP" buffer="50">
    <sql:query var="group" dataSource="${GauceDB}">
      select deptno, dname, loc from dept order by deptno
    </sql:query>
    <dh>
      <def name="deptno" type="int" size="5"/>
      <def name="dname" type="string" size="20"/>
      <def name="loc" type="string" size="10"/>
    </dh><c:forEach var="rs_group" items="${group.rows}">
    <dr>
      <dd><c:out value="${rs_group.deptno}"/></dd>
      <dd><c:out value="${rs_group.dname}"/></dd>
      <dd><c:out value="${rs_group.loc}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>
