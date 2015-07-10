<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<gdml>
  <dataset name="GAUCE" fragment="50">
    <dh>
      <def name="gubun" type="string" size="20"/>
      <def name="data" type="int" size="5"/>
    </dh><c:forEach var="list" items="${Chart1List}">
    <dr>
      <dd><c:out value="${list.gubun}"/></dd>
      <dd><c:out value="${list.data}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>