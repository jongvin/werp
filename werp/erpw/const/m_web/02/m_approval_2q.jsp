<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
     String arg_seq = req.getParameter("arg_seq");
     String arg_chg_cnt = req.getParameter("arg_chg_cnt");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("approym",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_owner",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("tel_fax",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
    String query = "  SELECT a.DEPT_CODE,   " + 
					    "         to_char(a.APPROYM,'YYYY.MM.DD') APPROYM,   " + 
					    "         a.APPROSEQ,   " + 
					    "         a.CHG_CNT,   " + 
					    "         a.sbcr_code,   " + 
					    "         a.sbcr_owner,   " + 
					    "         a.tel_fax,   " + 
					    "         b.sbcr_name   " + 
					    "    FROM m_approval_sbcr a ,  " + 
					    "         s_sbcr  b " + 
					    "   WHERE ( a.sbcr_code = b.sbcr_code ) and  " + 
					    "         ( a.dept_code =  '" + arg_dept_code + "' ) AND  " + 
					    "         ( a.APPROYM = '" + arg_date + "' )  and " + 
					    "         ( a.approseq = " + arg_seq + " ) and " +
					    "         ( a.chg_cnt = " + arg_chg_cnt + " ) " +
					    " ORDER BY a.sbcr_code       ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>