<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<gdml>
  <dataset name="GAUCE" fragment="50">
    <dh>
      <def name="deptnm" type="string" size="20"/>
      <def name="year" type="string" size="20"/>
      <def name="amt1" type="int" size="5"/>
      <def name="amt2" type="int" size="5"/>
    </dh><c:forEach var="list" items="${SelectList}">
    <dr>
      <dd><c:out value="${list.deptnm}"/></dd>
      <dd><c:out value="${list.year}"/></dd>
      <dd><c:out value="${list.amt1}"/></dd>
      <dd><c:out value="${list.amt2}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>