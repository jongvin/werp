<%@ page 
    language 	="java" 
    contentType ="text/html;charset=euc-kr" 
    import 		="java.io.*,java.util.*,java.lang.*"
    errorPage 	= "/sys/errorPage.jsp"
%>

<HTML>
    <HEAD>
    	<STYLE>
                TABLE.Line {Background-color: CCCCCC;Border: 0px solid; }
        	TD.GLableL
        	 {Background-color:F9F9FC; Font-family:"����", "����";Color:333333;Font-size:8pt ; Font-weight:normal ; Text-align:left ;Vertical-align:middle;height:10pt}
        	TD.GListL 
        	 {Background-color:FFFFFF; Font-family:"����", "����";Color:333333;Font-size:8pt ; Font-weight:normal ; Text-align:left ;Vertical-align:middle;height:10pt}
        	</STYLE>
    </HEAD>
    <BODY>
<h5> XLog Param Check - build200502 (by sungJo)</h5>   
<FONT COLOR='blue'> ���� <%= request.getServerName() %></FONT><BR>

<%!
  public boolean print(JspWriter out,  String key , String value, String bigo) throws Exception{
  
          out.print ("<TR>");
          out.print ("<TD class='GListL'>" + key + "</TD>");
          out.print ("<TD class='GListL'>" +value + "</TD>");
           out.print ("<TD class='GListL'>" +bigo + "</TD>");
          out.print ("</TR>");
      return true;
  }
  public boolean print2(JspWriter out,  String key , String value) throws Exception{
  
          out.print ("<TR>");
          out.print ("<TD class='GListL'>" + key + "</TD>");
          out.print ("<TD class='GListL'>" +value + "</TD>");
           out.print ("</TR>");
      return true;
  }
%>

<TABLE  class='Line'>
 <TR>
 <TD class='GListL'>�Ķ����</TD>
<TD class='GListL'>��</TD>
<TD class='GListL'>����</TD>
</TR>
  <%
  
    atom.base.env.XConfig conf = atom.base.env.XConfig.getInstance();
  
    print(out, "atom.home", System.getProperty("atom.home"),"ATomȯ�� ��Ʈ, WAS�� startup���� -Datom.home=xxx ���·� ������");
    print(out, "${atom.home}/conf", atom.base.env.Home.get()+"/conf","ATom���� ���� ���丮 ���� atom.home�� ������ �ʵǸ� ${user.home}/atom.home/conf�� ��");
    print(out, "atom.init", conf.get("atom.init"),"XLog�� ATom�� ���� ������Ʈ�� �̰��� Xlog Context�� ��ϵǾ� �־���Ѵ�");
    print(out, "xlog.out.file", conf.get("xlog.out.file"), "���Ϸ� �α��� ������ ����");
    print(out, "xlog.out.file.dir", conf.get("xlog.out.file.dir"),"XLog������ ��ġ");
    print(out, "xlog.out.net", conf.get("xlog.out.net"), "Network���� �α��� ������ ����");
    print(out, "xlog.out.net.host", conf.get("xlog.out.net.host"),"�α׸� �޴� PC�� IP");
    print(out, "xlog.trace", conf.get("xlog.trace"),"�α� ����� ������ NONE�̸� �α׸� ������ ����");
    print(out, "xlog.trace.sql", conf.get("xlog.trace.sql"),"SQL�� �α���( NONE, TIME_ONLY, PARAM_ONLY, SQL_ONLY, SQL_WITH_PARAM)");
    print(out, "xlog.trace.sql_exception", conf.get("xlog.trace.sql_exception"),"SQL Exception�� �α���");
    print(out, "xlog.trace.work_app", conf.get("xlog.trace.work_app"),"TX�� hang�Ǿ����� �Ǵ��ϴ� ����(����ms)(xlog client���� BAD�� ǥ�õ�)");
    print(out, "xprof.enabled", conf.get("xprof.enabled"),"xprof�� ��뿩��, CPU ������ ���ؼ��� XProf�� �ʿ���");
    
 %>

</TABLE>

<TABLE BORDER='1'>
 <TR>
 <TD class='GListL'>�˻��׸�</TD>
<TD class='GListL'>���</TD>
<%
    if(atom.xlog.env.XLogConfigMon.xprof_enabled == true){
	    boolean ok = false;
	    try{
	         atom.xlog.xprof.XProf.getCurrentThreadCpuTime();
	         ok = true;
	    }catch(Exception e){
	    }
	    print2(out, "xprof �� ���� �ε��Ǿ��°�?", ok?"����":"����" );
    }else{
	    print2(out, "xprof �� ���� �ε��Ǿ��°�?", "N/A" );
    }
      print2(out, "java.library.path<br>(xprof�� ��ġ�� ��ġ)", System.getProperty("java.library.path") );
%>
</TR>
</TABLE>
<pre>
�����׵��� ������ ���� �ټ� ���̰� ���� �� ������ 
�⺻������ atom.xxx�Ķ���Ϳ� xlog.trace��  ���������� ��µǸ�
XLog�� ���������� ��ġ�Ǿ����� �ǹ���

                                 sjokim@lgcns.com
</pre>
</body>
</html>