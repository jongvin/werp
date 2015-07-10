<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<gdml>
  <dataset name="GAUCE" buffer="50">
    <dh>
      <def name="zip_code" type="string" size="6"/> 
      <def name="province" type="string" size="2"/>
      <def name="city" type="string" size="10"/>
      <def name="town" type="string" size="10"/>
      <def name="numtest" type="int" size="5"/>
      <def name="dec" type="decimal" size="15.3"/>
    </dh><c:forEach begin="1" end="100" var="current">
    <dr>
      <dd>10<c:out value="${current}"/></dd>
      <dd><![CDATA[°¡¿ì½º]]></dd>
      <dd>shift</dd> 
      <dd>Town <c:out value="${current}"/></dd>
      <dd><c:out value="${current}"/></dd>
      <dd><c:out value="${current/2}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>
