<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
//    String arg_dept_code = req.getParameter("arg_dept_code");
//---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("estimateyymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("estimateseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("esttitle",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT to_char(a.ESTIMATEYYMM,'YYYY.MM.DD')  ESTIMATEYYMM,  " + 
     					 "         a.ESTIMATESEQ,   " + 
     					 "         a.ESTTITLE   " + 
     					 "    FROM M_ESTIMATION a,   " + 
	  					 "		  ( select max(estimateyymm) estimateyymm, max(estimateseq) estimateseq, count(*) chk " +
	  					 "			   from m_vender_est " +
	  					 "			  where choicetag = 'Y' " +
	  					 "			group by estimateyymm,estimateseq ) b " +
	  					 "  WHERE a.estimateyymm  = b.estimateyymm  " +
	  					 "	 and a.estimateseq   = b.estimateseq  " +
     					 "    and a.requestseq = 0   " + 
     					 " ORDER BY a.ESTIMATEYYMM DESC,   " + 
     					 "         a.ESTIMATESEQ DESC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>