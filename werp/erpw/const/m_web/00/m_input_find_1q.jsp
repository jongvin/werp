<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_tag = req.getParameter("arg_tag");
	 String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detailseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vatamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("deliverytag",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("inouttypecode",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("vattag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("vat_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("request_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("est_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approval_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bigo",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("noout_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("input_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("input_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("tmat_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  dept_code ," + 
     					 "          to_char(yymmdd,'yyyy.mm.dd') yymmdd ," + 
     					 "          seq ," + 
     					 "          input_unq_num ," + 
     					 "          detailseq ," + 
     					 "          mtrcode ," + 
     					 "          name ," + 
     					 "          ssize ," + 
     					 "          unitcode ," + 
     					 "          ditag ," + 
     					 "          qty ," + 
     					 "          unitprice ," + 
     					 "          trunc(noout_qty * unitprice,0) amt ," + 
     					 "          vatamt ," + 
     					 "          deliverytag ," + 
     					 "          inouttypecode ," + 
     					 "          sbcr_code ," + 
     					 "          vattag ," + 
     					 "          vat_unq_num ," + 
     					 "          spec_no_seq ," + 
     					 "          spec_unq_num ," + 
     					 "          request_unq_num ," + 
     					 "          est_unq_num ," + 
     					 "          approval_unq_num ," + 
     					 "          bigo ," + 
     					 "          noout_qty, " +
				       "          0       input_qty," +
				       "          0       input_amt," +
				       "          ''           comp_chk, " +
				       "          F_PARENT_DETAIL_NAME(dept_code,spec_unq_num) spec_name,  " + 
				       "          tmat_unq_num " +
     					 "     FROM m_input_detail "  +
     					 "    WHERE DEPT_CODE = '" + arg_dept_code + "'" +
     					 "      and NOOUT_QTY <> 0  " +
						 "      and yymmdd <= '" + arg_date + "' " +
     					 "      and ditag = '" + arg_tag + "'";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>