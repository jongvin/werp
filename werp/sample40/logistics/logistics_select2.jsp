<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<sql:query var="user" dataSource="${GauceDB$sampledb}">    
    SELECT gubun, ToSite, FromSite, SC, Category, January, Feburary, March, April, May, June, July, August, September, October, November, December FROM T_HM3000 WHERE YYYY = '<c:out value="${param.year}"/>' order by ToSite asc, Category asc
</sql:query>
<gdml>
  <dataset name="tbds_list">
    <dh>    
      <def name="gubun"       type="string" size="20"/>
      <def name="ToSite"      type="string" size="20" constraint="key"/>
      <def name="FromSite"    type="string" size="20"/>
      <def name="SC"          type="string" size="20"/>
      <def name="Category"    type="string" size="20" constraint="key"/>
      <def name="January"     type="decimal" size="10.0"/>
      <def name="Feburary"    type="decimal" size="10.0"/>
      <def name="March"       type="decimal" size="10.0"/>
      <def name="April"       type="decimal" size="10.0"/>
      <def name="May"         type="decimal" size="10.0"/>
      <def name="June"        type="decimal" size="10.0"/>
      <def name="July"        type="decimal" size="10.0"/>
      <def name="August"      type="decimal" size="10.0"/>
      <def name="September"   type="decimal" size="10.0"/>
      <def name="October"     type="decimal" size="10.0"/>
      <def name="November"    type="decimal" size="10.0"/>
      <def name="December"    type="decimal" size="10.0"/>
    </dh><c:forEach var="rs_user" items="${user.rows}">
    <dr>
      <dd><c:out value="${rs_user.gubun}"/></dd>
      <dd><c:out value="${rs_user.ToSite}"/></dd>
      <dd><c:out value="${rs_user.FromSite}"/></dd>
      <dd><c:out value="${rs_user.SC}"/></dd>
      <dd><c:out value="${rs_user.Category}"/></dd>
      <dd><c:out value="${rs_user.January}"/></dd>
      <dd><c:out value="${rs_user.Feburary}"/></dd>
      <dd><c:out value="${rs_user.March}"/></dd>
      <dd><c:out value="${rs_user.April}"/></dd>
      <dd><c:out value="${rs_user.May}"/></dd>
      <dd><c:out value="${rs_user.June}"/></dd>
      <dd><c:out value="${rs_user.July}"/></dd>
      <dd><c:out value="${rs_user.August}"/></dd>
      <dd><c:out value="${rs_user.September}"/></dd>
      <dd><c:out value="${rs_user.October}"/></dd>
      <dd><c:out value="${rs_user.November}"/></dd>
      <dd><c:out value="${rs_user.December}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>