<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<gdml>
  <dataset name="GAUCE" fragment="50">
    <dh>
      <def name="month" type="string" size="20"/>
      <def name="seoul" type="int" size="5"/>
      <def name="busan" type="int" size="5"/>
      <def name="daegu" type="int" size="5"/>
      <def name="incheon" type="int" size="5"/>
    </dh><c:forEach var="list" items="${Chart2List}">
    <dr>
      <dd><c:out value="${list.month}"/></dd>
      <dd><c:out value="${list.seoul}"/></dd>
      <dd><c:out value="${list.busan}"/></dd>
      <dd><c:out value="${list.daegu}"/></dd>
      <dd><c:out value="${list.incheon}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>