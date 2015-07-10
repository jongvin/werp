<%-- jsp2.jsp --%>
<%-- 두번째 예제입니다.
 1.  post, get 방식의 데이타를 가져오는 방법입니다.
 2.  내장된 인스턴트를 사용하는 방법
--%>
<html>
<body> <%
if( request.getParameter("name1") != null ) {
%>  당신의 이름은
 <font color=bule><%= request.getParameter("name1") %></font>입니다 <br>
 당신의 email주소는
 <font color=bule><%= request.getParameter("email1") %></font>입니다<br> <%
  String[] fruits;
  fruits = request.getParameterValues("fruit");
  if (fruits != null) {
    out.println("당신의 좋아 하는 과일은 ");
    for (int i = 0; i < fruits.length; i++) {
     out.println ( "<font color = bule>" + fruits[i] + "</font>");
    }
    out.println("입니다.");
  } else {
   out.println ("과일을 좋아 하지 않는 군요<br>");
  }
 } else { %> <form name=form1 method=post action=/examples/jsp/lesson/jsp2.jsp>
당신의 이름은 ?       <input type=text name=name1 ><br>
당신의 email 주소는 ? <input type=text name=email1 ><br>
당신이 좋아하는 과일의 종류를 선택하세요.<br>
 <input TYPE=checkbox name=fruit VALUE=사과> 사과 <BR>
 <input TYPE=checkbox name=fruit VALUE=포도> 포도 <BR>
 <input TYPE=checkbox name=fruit VALUE=오렌지> 오렌지<BR>
 <input TYPE=checkbox name=fruit VALUE=메론> 메론 <BR>
<input type=submit value=확인 ><br>
</form> <%
 }
%>
