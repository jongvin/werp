<%-- jsp2.jsp --%>
<%-- �ι�° �����Դϴ�.
 1.  post, get ����� ����Ÿ�� �������� ����Դϴ�.
 2.  ����� �ν���Ʈ�� ����ϴ� ���
--%>
<html>
<body> <%
if( request.getParameter("name1") != null ) {
%>  ����� �̸���
 <font color=bule><%= request.getParameter("name1") %></font>�Դϴ� <br>
 ����� email�ּҴ�
 <font color=bule><%= request.getParameter("email1") %></font>�Դϴ�<br> <%
  String[] fruits;
  fruits = request.getParameterValues("fruit");
  if (fruits != null) {
    out.println("����� ���� �ϴ� ������ ");
    for (int i = 0; i < fruits.length; i++) {
     out.println ( "<font color = bule>" + fruits[i] + "</font>");
    }
    out.println("�Դϴ�.");
  } else {
   out.println ("������ ���� ���� �ʴ� ����<br>");
  }
 } else { %> <form name=form1 method=post action=/examples/jsp/lesson/jsp2.jsp>
����� �̸��� ?       <input type=text name=name1 ><br>
����� email �ּҴ� ? <input type=text name=email1 ><br>
����� �����ϴ� ������ ������ �����ϼ���.<br>
 <input TYPE=checkbox name=fruit VALUE=���> ��� <BR>
 <input TYPE=checkbox name=fruit VALUE=����> ���� <BR>
 <input TYPE=checkbox name=fruit VALUE=������> ������<BR>
 <input TYPE=checkbox name=fruit VALUE=�޷�> �޷� <BR>
<input type=submit value=Ȯ�� ><br>
</form> <%
 }
%>
