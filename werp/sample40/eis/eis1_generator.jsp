<%@ page contentType="text/gdml;charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<c:set var="service" value="${param.dsn}" scope="page"/>
<gdml>		
  <dataset name="tbds_list">    
     <c:choose>
        <c:when test="${service == 'ds3'}">
            <dh>    
              <def name="gubun"        type="string" size="10"/>
              <def name="purpose"      type="int" size="10"/>
              <def name="siljuktoday"  type="int" size="10"/>
              <def name="siljuksum"    type="int" size="10"/>
              <def name="approach"     type="int" size="10"/>
              <def name="achieve"      type="int" size="10"/>
              <def name="beyearcont"   type="int" size="10"/>
              <def name="bemonthcont"  type="int" size="10"/>
              <def name="Color"        type="string" size="10"/>
            </dh>
        </c:when>
        <c:when test="${service eq 'ds3_1'}">
            <dh>    
              <def name="gubun"       type="string" size="30"/>
              <def name="stand"       type="string" size="30"/>
              <def name="achieveper"  type="string" size="30"/>
              <def name="growper"     type="string" size="30"/>
            </dh>
        </c:when>
        <c:when test="${service eq 'ds3_2'}">
            <dh>    
              <def name="gubun"       type="string" size="30"/>
              <def name="stand"       type="string" size="30"/>
              <def name="achieveper"  type="string" size="30"/>
              <def name="growper"     type="string" size="30"/>
            </dh>
        </c:when>
       <c:when test="${service eq 'ds3_3'}">
            <dh>    
              <def name="gubun"       type="string" size="30"/>
              <def name="stand"       type="string" size="30"/>
              <def name="achieveper"  type="string" size="30"/>
              <def name="growper"     type="string" size="30"/>
            </dh>
        </c:when>
       <c:when test="${service eq 'ds3_4'}">
            <dh>    
              <def name="gubun"       type="string" size="30"/>
              <def name="stand"       type="string" size="30"/>
              <def name="achieveper"  type="string" size="30"/>
              <def name="growper"     type="string" size="30"/>
            </dh>
        </c:when>
       <c:when test="${service eq 'ds3_5'}">
            <dh>    
              <def name="gubun"       type="string" size="30"/>
              <def name="stand"       type="string" size="30"/>
              <def name="achieveper"  type="string" size="30"/>
              <def name="growper"     type="string" size="30"/>
            </dh>
        </c:when>
       <c:when test="${service eq 'ds3_6'}">
            <dh>    
              <def name="gubun"       type="string" size="30"/>
              <def name="stand"       type="string" size="30"/>
              <def name="achieveper"  type="string" size="30"/>
              <def name="growper"     type="string" size="30"/>
            </dh>
        </c:when>
       <c:when test="${service eq 'ds3_7'}">
            <dh>    
              <def name="gubun"       type="string" size="30"/>
              <def name="stand"       type="string" size="30"/>
              <def name="achieveper"  type="string" size="30"/>
              <def name="growper"     type="string" size="30"/>
            </dh>
        </c:when>                                
        <c:when test="${service eq 'ds4'}">
            <dh>    
              <def name="gubun"       type="string" size="10"/>
              <def name="selling"     type="int" size="10"/>
              <def name="composeper"  type="int" size="10"/>
              <def name="growper"     type="int" size="10"/>
              <def name="humanper"    type="int" size="10"/>
              <def name="proA"        type="int" size="10"/>
              <def name="proB"        type="int" size="10"/>
              <def name="proC"        type="int" size="10"/>
            </dh>
        </c:when>
        <c:when test="${service eq 'ds4_1'}">
            <dh>    
              <def name="gubun"       type="string" size="30"/>
              <def name="selling"     type="string" size="30"/>
              <def name="composeper"  type="string" size="30"/>
              <def name="growper"     type="string" size="30"/>
              <def name="humanper"    type="string" size="30"/>
            </dh>    
        </c:when>              
        <c:when test="${service eq 'ds4_2'}">
            <dh>    
              <def name="gubun"       type="string" size="30"/>
              <def name="selling"     type="string" size="30"/>
              <def name="composeper"  type="string" size="30"/>
              <def name="growper"     type="string" size="30"/>
              <def name="humanper"    type="string" size="30"/>
            </dh>    
        </c:when>
        <c:when test="${service eq 'ds4_3'}">
            <dh>    
              <def name="gubun"       type="string" size="30"/>
              <def name="selling"     type="string" size="30"/>
              <def name="composeper"  type="string" size="30"/>
              <def name="growper"     type="string" size="30"/>
              <def name="humanper"    type="string" size="30"/>
            </dh>    
        </c:when>
        <c:when test="${service eq 'ds4_4'}">
            <dh>    
              <def name="gubun"       type="string" size="30"/>
              <def name="selling"     type="string" size="30"/>
              <def name="composeper"  type="string" size="30"/>
              <def name="growper"     type="string" size="30"/>
              <def name="humanper"    type="string" size="30"/>
            </dh>    
        </c:when>
        <c:when test="${service eq 'ds4_5'}">
            <dh>    
              <def name="gubun"       type="string" size="30"/>
              <def name="selling"     type="string" size="30"/>
              <def name="composeper"  type="string" size="30"/>
              <def name="growper"     type="string" size="30"/>
              <def name="humanper"    type="string" size="30"/>
            </dh>    
        </c:when>
        <c:when test="${service eq 'ds4_6'}">
            <dh>    
              <def name="gubun"       type="string" size="30"/>
              <def name="selling"     type="string" size="30"/>
              <def name="composeper"  type="string" size="30"/>
              <def name="growper"     type="string" size="30"/>
              <def name="humanper"    type="string" size="30"/>
            </dh>    
        </c:when>
        <c:when test="${service eq 'ds4_7'}">
            <dh>    
              <def name="gubun"       type="string" size="30"/>
              <def name="selling"     type="string" size="30"/>
              <def name="composeper"  type="string" size="30"/>
              <def name="growper"     type="string" size="30"/>
              <def name="humanper"    type="string" size="30"/>
            </dh>    
        </c:when>
        </c:choose><c:forEach var="list" items="${SelectEis}">
        <dr><c:choose>
                <c:when test="${service eq 'ds3'}">
                    <dd><c:out value="${list.gubun}"/></dd>
                    <dd><c:out value="${list.purpose}"/></dd>
                    <dd><c:out value="${list.siljuktoday}"/></dd>
                    <dd><c:out value="${list.siljuksum}"/></dd>
                    <dd><c:out value="${list.approach}"/></dd>
                    <dd><c:out value="${list.achieve}"/></dd>
                    <dd><c:out value="${list.beyearcont}"/></dd>
                    <dd><c:out value="${list.bemonthcont}"/></dd>
                    <dd><c:out value="${list.Color}"/></dd>
                </c:when>
                <c:when test="${service eq 'ds4'}">
                  <dd><c:out value="${list.gubun}"/></dd>
                  <dd><c:out value="${list.selling}"/></dd>
                  <dd><c:out value="${list.composeper}"/></dd>
                  <dd><c:out value="${list.growper}"/></dd>
                  <dd><c:out value="${list.humanper}"/></dd>
                  <dd><c:out value="${list.proA}"/></dd>
                  <dd><c:out value="${list.proB}"/></dd>
                  <dd><c:out value="${list.proC}"/></dd>
                </c:when>
                <c:when test="${service eq 'ds3_1'}">
                  <dd><c:out value="${list.gubun}"/></dd>
                  <dd><c:out value="${list.stand}"/></dd>
                  <dd><c:out value="${list.achieveper}"/></dd>
                  <dd><c:out value="${list.growper}"/></dd>
                </c:when>      
                <c:when test="${service eq 'ds3_2'}">
                  <dd><c:out value="${list.gubun}"/></dd>
                  <dd><c:out value="${list.stand}"/></dd>
                  <dd><c:out value="${list.achieveper}"/></dd>
                  <dd><c:out value="${list.growper}"/></dd>
                </c:when> 
                <c:when test="${service eq 'ds3_3'}">
                  <dd><c:out value="${list.gubun}"/></dd>
                  <dd><c:out value="${list.stand}"/></dd>
                  <dd><c:out value="${list.achieveper}"/></dd>
                  <dd><c:out value="${list.growper}"/></dd>
                </c:when> 
                <c:when test="${service eq 'ds3_4'}">
                  <dd><c:out value="${list.gubun}"/></dd>
                  <dd><c:out value="${list.stand}"/></dd>
                  <dd><c:out value="${list.achieveper}"/></dd>
                  <dd><c:out value="${list.growper}"/></dd>
                </c:when>  
                <c:when test="${service eq 'ds3_5'}">
                  <dd><c:out value="${list.gubun}"/></dd>
                  <dd><c:out value="${list.stand}"/></dd>
                  <dd><c:out value="${list.achieveper}"/></dd>
                  <dd><c:out value="${list.growper}"/></dd>
                </c:when> 
                <c:when test="${service eq 'ds3_6'}">
                  <dd><c:out value="${list.gubun}"/></dd>
                  <dd><c:out value="${list.stand}"/></dd>
                  <dd><c:out value="${list.achieveper}"/></dd>
                  <dd><c:out value="${list.growper}"/></dd>
                </c:when> 
                <c:when test="${service eq 'ds3_7'}">
                  <dd><c:out value="${list.gubun}"/></dd>
                  <dd><c:out value="${list.stand}"/></dd>
                  <dd><c:out value="${list.achieveper}"/></dd>
                  <dd><c:out value="${list.growper}"/></dd>
                </c:when> 
                <c:when test="${service eq 'ds4_1'}">
                  <dd><c:out value="${list.gubun}"/></dd>
                  <dd><c:out value="${list.selling}"/></dd>
                  <dd><c:out value="${list.composeper}"/></dd>
                  <dd><c:out value="${list.growper}"/></dd>
                  <dd><c:out value="${list.humanper}"/></dd>
                </c:when> 
                <c:when test="${service eq 'ds4_2'}">
                  <dd><c:out value="${list.gubun}"/></dd>
                  <dd><c:out value="${list.selling}"/></dd>
                  <dd><c:out value="${list.composeper}"/></dd>
                  <dd><c:out value="${list.growper}"/></dd>
                  <dd><c:out value="${list.humanper}"/></dd>
                </c:when>    
                <c:when test="${service eq 'ds4_3'}">
                  <dd><c:out value="${list.gubun}"/></dd>
                  <dd><c:out value="${list.selling}"/></dd>
                  <dd><c:out value="${list.composeper}"/></dd>
                  <dd><c:out value="${list.growper}"/></dd>
                  <dd><c:out value="${list.humanper}"/></dd>
                </c:when> 
                <c:when test="${service eq 'ds4_4'}">
                  <dd><c:out value="${list.gubun}"/></dd>
                  <dd><c:out value="${list.selling}"/></dd>
                  <dd><c:out value="${list.composeper}"/></dd>
                  <dd><c:out value="${list.growper}"/></dd>
                  <dd><c:out value="${list.humanper}"/></dd>
                </c:when> 
                <c:when test="${service eq 'ds4_5'}">
                  <dd><c:out value="${list.gubun}"/></dd>
                  <dd><c:out value="${list.selling}"/></dd>
                  <dd><c:out value="${list.composeper}"/></dd>
                  <dd><c:out value="${list.growper}"/></dd>
                  <dd><c:out value="${list.humanper}"/></dd>
                </c:when> 
                <c:when test="${service eq 'ds4_6'}">
                  <dd><c:out value="${list.gubun}"/></dd>
                  <dd><c:out value="${list.selling}"/></dd>
                  <dd><c:out value="${list.composeper}"/></dd>
                  <dd><c:out value="${list.growper}"/></dd>
                  <dd><c:out value="${list.humanper}"/></dd>
                </c:when> 
                <c:when test="${service eq 'ds4_7'}">
                  <dd><c:out value="${list.gubun}"/></dd>
                  <dd><c:out value="${list.selling}"/></dd>
                  <dd><c:out value="${list.composeper}"/></dd>
                  <dd><c:out value="${list.growper}"/></dd>
                  <dd><c:out value="${list.humanper}"/></dd>
                </c:when>
        </c:choose></dr>        
    </c:forEach>
  </dataset>
  <message>성공했습니다.</message>
</gdml>