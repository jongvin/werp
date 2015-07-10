<%@ page import="java.io.*,com.gauce.common.*" contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<gdml>	
  <dataset name="tbds_list">    
    <dh>    
      <def name="Gubn"             type="string" size="20"/>
      <def name="Py10"             type="string" size="8"/>
      <def name="Py11"             type="string" size="8"/>
      <def name="Py"               type="string" size="8"/>
      <def name="Amt1"             type="string" size="8"/>
      <def name="Amt2"             type="string" size="8"/>
      <def name="Amt3"             type="string" size="8"/>
      <def name="Amt4"             type="string" size="8"/>
      <def name="Amt5"             type="string" size="8"/>
      <def name="Amt6"             type="string" size="8"/>
      <def name="Amt7"             type="string" size="8"/>
      <def name="Amt8"             type="string" size="8"/>
      <def name="Amt9"             type="string" size="8"/>    
      <def name="Amt10"            type="string" size="8"/>
      <def name="Amt11"            type="string" size="8"/>
      <def name="Amt12"            type="string" size="8"/>
      <def name="Color"            type="string" size="8"/>
      <def name="Branch"           type="string" size="2"/>
      <def name="Yyyy"             type="string" size="4"/>  
      <def name="Flag"             type="string" size="1"/>
      <def name="Toinb_client_ip"  type="string" size="40"/>                 
    </dh><c:forEach var="list" items="${Public2Main}">
    <dr>      
      <dd><c:out value="${list.Gubn}"/></dd>
      <dd><c:out value="${list.Py10}"/></dd> 
      <dd><c:out value="${list.Py11}"/></dd> 
      <dd><c:out value="${list.Py}"/></dd>
      <dd><c:out value="${list.Amt1}"/></dd>
      <dd><c:out value="${list.Amt2}"/></dd>
      <dd><c:out value="${list.Amt3}"/></dd>    
      <dd><c:out value="${list.Amt4}"/></dd>
      <dd><c:out value="${list.Amt5}"/></dd> 
      <dd><c:out value="${list.Amt6}"/></dd> 
      <dd><c:out value="${list.Amt7}"/></dd>
      <dd><c:out value="${list.Amt8}"/></dd>
      <dd><c:out value="${list.Amt9}"/></dd>        
      <dd><c:out value="${list.Amt10}"/></dd>
      <dd><c:out value="${list.Amt11}"/></dd> 
      <dd><c:out value="${list.Amt12}"/></dd> 
      <dd><c:out value="${list.Color}"/></dd>
      <dd><c:out value="${list.Branch}"/></dd>
      <dd><c:out value="${list.Yyyy}"/></dd>
      <dd><c:out value="${list.Flag}"/></dd>    
      <dd><c:out value="${list.Toinb_client_ip}"/></dd>            
    </dr></c:forEach>
  </dataset>
  <message>성공했습니다.</message>
</gdml>  