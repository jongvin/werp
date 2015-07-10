<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<gdml>
  <dataset name="GAUCE" fragment="100"> 
    <dh>
      <def name="zip_code" type="string" size="6"/>
      <def name="province" type="string" size="20"/>
      <def name="city" type="string" size="10"/>
      <def name="town" type="string" size="10"/>
      <def name="numtest" type="int" size="5"/>
      <def name="dec" type="decimal" size="15.3"/>
    </dh><c:forEach begin="1" end="100" var="current">
    <dr>
      <dd>10<c:out value="${current}"/></dd>
      <dd>&lt;가우스&gt;</dd>
      <dd>shift</dd> 
      <dd>Town <c:out value="${current}"/></dd>
      <dd><c:out value="${current}"/></dd>
      <dd><c:out value="${current/2}"/></dd>
    </dr></c:forEach>
  </dataset>
  <message>성공입니다...</message>
  <!--exception code="7500" type="internal">오류 메시지</exception-->
</gdml>
