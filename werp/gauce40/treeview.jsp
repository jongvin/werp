<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<gdml>
  <dataset name="GAUCE" fragment="50">
    <dh>
      <def name="lev" type="string" size="20"/>
      <def name="root" type="string" size="30"/>
      <def name="text" type="string" size="30"/>
      <def name="type" type="string" size="30"/>
      <def name="seq" type="int" size="5"/>
    </dh><c:forEach var="tree" items="${MenuTree}">
    <dr>
      <dd><c:out value="${tree.lev}"/></dd>
      <dd><c:out value="${tree.root}"/></dd>
      <dd><c:out value="${tree.text}"/></dd>
      <dd><c:out value="${tree.type}"/></dd>
      <dd><c:out value="${tree.seq}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>