<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@include file ="../common/randomGenerate.jsp"%>
<% 
	String[] accountMake  = {"�����ܰ�","��������","��ȯ����","�������","��������","��Ƽ����"};
	String[] transferKind = {"���������","������ ��","��ȭ, ����","����������","�����ι�����"};
%>
<c:set var="gubunCode" value="${param.gbn}" scope="page"/>
<gdml>
  <dataset name="tbds_list">
    <dh>    
      <def name="accountMake"       type="string" size="25"/>
      <def name="transferKind"      type="string" size="25"/>
      <def name="X1"                type="int" size="15"/>
      <def name="Y1"                type="int" size="15"/>
      <def name="X2"                type="int" size="15"/>
      <def name="Y2"                type="int" size="15"/>
      <def name="X3"                type="int" size="15"/>
      <def name="Y3"                type="int" size="15"/>
      <def name="X4"                type="int" size="15"/>
      <def name="Y4"                type="int" size="15"/>
      <def name="X5"                type="int" size="15"/>
      <def name="Y5"                type="int" size="15"/>                  
    </dh><% int j = 0;int k = 0; %><c:forEach begin="1" end="5" var="current">
    <dr>
      <%
          if(j >= 5) {
              j=0;k++;
			  if(k >=5) k=0;
		  }
	  %>
      <dd><%=accountMake[j] + request.getParameter("gbn") %></dd>
      <dd><%=transferKind[k]%></dd>
      <dd><c:out value="${gubunCode}"/></dd>
      <dd><%=getRandomInt(10000)%></dd>
      <dd><c:out value="${gubunCode}"/></dd>
      <dd><%=getRandomInt(5000)%></dd>
      <dd><c:out value="${gubunCode}"/></dd>
      <dd><%=getRandomInt(3500)%></dd>
      <dd><c:out value="${gubunCode}"/></dd>
      <dd><%=getRandomInt(2000)%></dd>
      <dd><c:out value="${gubunCode}"/></dd>
      <dd><%=getRandomInt(800)%></dd>
    </dr><% j++; %></c:forEach>
  </dataset>
</gdml>