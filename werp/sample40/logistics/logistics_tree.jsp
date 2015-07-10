<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<gdml>
  <dataset name="GAUCE" fragment="50">
    <dh>
      <def name="V_level" type="string" size="1"/>
      <def name="V_title" type="string" size="100"/>
      <def name="V_type" type="string" size="1"/>
      <def name="V_index" type="string" size="3"/>
      <def name="ImgC" type="string" size="255"/>
      <def name="ImgD" type="string" size="255"/>
      <def name="ImgO" type="string" size="255"/>
      <def name="A" type="string" size="255"/>
    </dh><c:forEach var="list" items="${SelectLogisticsTree}">
    <dr>
      <dd><c:out value="${list.V_level}"/></dd>
      <dd><c:out value="${list.V_title}"/></dd>
      <dd><c:out value="${list.V_type}"/></dd>
      <dd><c:out value="${list.V_index}"/></dd>
      <dd><c:out value="${list.ImgC}"/></dd>
      <dd><c:out value="${list.ImgD}"/></dd>
      <dd><c:out value="${list.ImgO}"/></dd>
      <dd><c:out value="${list.A}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>