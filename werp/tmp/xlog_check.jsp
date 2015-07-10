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
        	 {Background-color:F9F9FC; Font-family:"돋움", "굴림";Color:333333;Font-size:8pt ; Font-weight:normal ; Text-align:left ;Vertical-align:middle;height:10pt}
        	TD.GListL 
        	 {Background-color:FFFFFF; Font-family:"돋움", "굴림";Color:333333;Font-size:8pt ; Font-weight:normal ; Text-align:left ;Vertical-align:middle;height:10pt}
        	</STYLE>
    </HEAD>
    <BODY>
<h5> XLog Param Check - build200502 (by sungJo)</h5>   
<FONT COLOR='blue'> 서버 <%= request.getServerName() %></FONT><BR>

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
 <TD class='GListL'>파라미터</TD>
<TD class='GListL'>값</TD>
<TD class='GListL'>설명</TD>
</TR>
  <%
  
    atom.base.env.XConfig conf = atom.base.env.XConfig.getInstance();
  
    print(out, "atom.home", System.getProperty("atom.home"),"ATom환경 루트, WAS의 startup쉘에 -Datom.home=xxx 형태로 설정됨");
    print(out, "${atom.home}/conf", atom.base.env.Home.get()+"/conf","ATom설정 파일 디렉토리 만약 atom.home이 지정이 않되면 ${user.home}/atom.home/conf가 됨");
    print(out, "atom.init", conf.get("atom.init"),"XLog는 ATom의 서브 컴포넌트로 이값에 Xlog Context가 등록되어 있어야한다");
    print(out, "xlog.out.file", conf.get("xlog.out.file"), "파일로 로깅할 것인지 여부");
    print(out, "xlog.out.file.dir", conf.get("xlog.out.file.dir"),"XLog파일의 위치");
    print(out, "xlog.out.net", conf.get("xlog.out.net"), "Network으로 로깅할 것인지 여부");
    print(out, "xlog.out.net.host", conf.get("xlog.out.net.host"),"로그를 받는 PC의 IP");
    print(out, "xlog.trace", conf.get("xlog.trace"),"로깅 방법을 지정함 NONE이면 로그를 남기지 않음");
    print(out, "xlog.trace.sql", conf.get("xlog.trace.sql"),"SQL문 로깅방법( NONE, TIME_ONLY, PARAM_ONLY, SQL_ONLY, SQL_WITH_PARAM)");
    print(out, "xlog.trace.sql_exception", conf.get("xlog.trace.sql_exception"),"SQL Exception을 로깅함");
    print(out, "xlog.trace.work_app", conf.get("xlog.trace.work_app"),"TX가 hang되었음을 판단하는 기준(단위ms)(xlog client에서 BAD로 표시됨)");
    print(out, "xprof.enabled", conf.get("xprof.enabled"),"xprof의 사용여부, CPU 추적을 위해서는 XProf가 필요함");
    
 %>

</TABLE>

<TABLE BORDER='1'>
 <TR>
 <TD class='GListL'>검사항목</TD>
<TD class='GListL'>결과</TD>
<%
    if(atom.xlog.env.XLogConfigMon.xprof_enabled == true){
	    boolean ok = false;
	    try{
	         atom.xlog.xprof.XProf.getCurrentThreadCpuTime();
	         ok = true;
	    }catch(Exception e){
	    }
	    print2(out, "xprof 가 정상 로딩되었는가?", ok?"정상":"에러" );
    }else{
	    print2(out, "xprof 가 정상 로딩되었는가?", "N/A" );
    }
      print2(out, "java.library.path<br>(xprof을 설치할 위치)", System.getProperty("java.library.path") );
%>
</TR>
</TABLE>
<pre>
위사항들은 버전에 따라 다소 차이가 있을 수 있으나 
기본적으로 atom.xxx파라미터와 xlog.trace가  정상적으로 출력되면
XLog가 정상적으로 설치되었음을 의미함

                                 sjokim@lgcns.com
</pre>
</body>
</html>