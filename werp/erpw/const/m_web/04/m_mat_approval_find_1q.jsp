<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("approym",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approtitle",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("vattag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("paymentmethod",GauceDataColumn.TB_STRING,200));
    String query = " select max(b.sbcr_name) sbcr_name, " +
						 "		  max(b.sbcr_code) sbcr_code," +
						 "		  to_char(max(a.approym),'YYYY.MM.DD') approym, " +
						 "		  nvl(max(a.approseq),0) approseq, " +
						 "		  nvl(max(a.chg_cnt),0) chg_cnt, " +
						 "		  max(a.approtitle) approtitle, " +
						 "		  max(a.vattag) vattag, " +
						 "		  max(a.paymentmethod) paymentmethod " +
						 "	from  ( select a.dept_code,a.approym,a.approseq,a.chg_cnt,a.approtitle,a.vattag,b.approval_unq_num,a.paymentmethod " +
						 "				from m_approval_detail b, " +
						 "			     	  m_approval a " +
						 "			  where b.dept_code = a.dept_code " +
						 "				 and b.approym = a.approym " +
						 "				 and b.approseq = a.approseq " +
						 "				 and b.chg_cnt = a.chg_cnt " +
						 "				 and b.dept_code = '" + arg_dept_code + "') a, " +
						 "			( select b.sbcr_name,b.sbcr_code,a.approval_unq_num " +
						 "				 from m_input_detail a, " +
						 "						s_sbcr b " +
						 "				where a.sbcr_code = b.sbcr_code " +
						 "				  and a.dept_code = '" + arg_dept_code + "' " +
					    "   and a.inouttypecode <> '8' " +
						 "				  and a.vat_unq_num = 0 and a.SEQ > 0 ) b " +
						 "  where b.approval_unq_num  = a.approval_unq_num (+) " +
						 " group by a.dept_code,a.approym,a.approseq,b.sbcr_code " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>