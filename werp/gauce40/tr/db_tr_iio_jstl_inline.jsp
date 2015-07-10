<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql_rt" %>
 
<%-- USER TR 처리 --%>
<c:forEach items="${dataset.USER}" var="user">
  <c:if test="${user.op == 'I'}">
    <sql:update var="i_cnt" dataSource="${GauceDB}">
      insert into emp(empno, ename, job, mgr, sal, comm, deptno) values(?, ?, ?, ?, ?, ?, ?)
      <sql:param value="${user.empno}"/>
      <sql:param value="${user.ename}"/>
      <sql:param value="${user.job}"/>
      <sql:param value="${user.mgr}"/>
      <sql:param value="${user.sal}"/>
      <sql:param value="${user.comm}"/>
      <sql:param value="${user.deptno}"/>
    </sql:update>
  </c:if>
  <c:if test="${user.op == 'U'}">
    <sql:update var="u_cnt" dataSource="${GauceDB}">
      update emp set empno=?, ename=?, job=?, mgr=?, sal=?, comm=?, deptno=? where empno=?
      <sql:param value="${user.empno}"/>
      <sql:param value="${user.ename}"/>
      <sql:param value="${user.job}"/>
      <sql:param value="${user.mgr}"/>
      <sql:param value="${user.sal}"/>
      <sql:param value="${user.comm}"/>
      <sql:param value="${user.deptno}"/>
      <sql:param value="${user.empno}"/>
    </sql:update>
  </c:if>
  <c:if test="${user.op == 'D'}">
    <sql:update var="d_cnt" dataSource="${GauceDB}">
      delete from emp where empno=?
      <sql:param value="${user.empno}"/>
    </sql:update>
  </c:if>
</c:forEach>

<%-- GROUP TR 처리 --%>
<c:forEach items="${dataset.GROUP}" var="group">
  <c:if test="${group.op == 'I'}">
    <sql:update var="i_cnt" dataSource="${GauceDB}">
      insert into dept(deptno, dname, loc) values(?, ?, ?)
      <sql:param value="${group.deptno}"/>
      <sql:param value="${group.dname}"/>
      <sql:param value="${group.loc}"/>
    </sql:update>
  </c:if>
  <c:if test="${group.op == 'U'}">
    <sql:update var="u_cnt" dataSource="${GauceDB}">
      update dept set deptno=?, dname=?, loc=? where deptno=?
      <sql:param value="${group.deptno}"/>
      <sql:param value="${group.dname}"/>
      <sql:param value="${group.loc}"/>
      <sql:param value="${group.deptno}"/>
    </sql:update>
  </c:if>
  <c:if test="${group.op == 'D'}">
    <sql:update var="d_cnt" dataSource="${GauceDB}">
      delete from dept where deptno=?
      <sql:param value="${group.deptno}"/>
    </sql:update>
  </c:if>
</c:forEach>

<%--USERLIST 출력 --%>
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
