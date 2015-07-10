<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<gdml>
  <dataset name="GAUCE" fragment="300">
    <dh>
      <def name="zip_code" type="string" size="6"/>
      <def name="province" type="string" size="20"/>
      <def name="city" type="string" size="10"/>
      <def name="town" type="string" size="10"/>
      <def name="numtest" type="int" size="5"/>
      <def name="dec" type="decimal" size="15.3"/>
    </dh><c:forEach items="${ds_1}" var="ds">
    <dr>
      <dd><c:out value="${ds.zip_code}"/></dd>
      <dd><c:out value="${ds.province}"/></dd>
      <dd><c:out value="${ds.city}"/></dd> 
      <dd><c:out value="${ds.town}"/></dd>
      <dd><c:out value="${ds.numtest}"/></dd>
      <dd><c:out value="${ds.dec}"/></dd>
    </dr></c:forEach>
  </dataset>
  <message>성공했습니다1</message>
  <!--exception code="7500" type="INTERNAL">실패했습니다.</exception-->
</gdml>
