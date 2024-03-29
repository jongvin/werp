<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_name = req.getParameter("arg_name");
     arg_name = '%' + arg_name + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("approym",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approtitle",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vatamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("price_class",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.DEPT_CODE,   " + 
     					 "         to_char(a.approym,'YYYY.MM.DD') approym,   " + 
     					 "         a.approseq,   " + 
     					 " 	     a.chg_cnt," + 
     					 "         to_char(a.approdate,'YYYY.MM.DD')  approdate, " + 
     					 "         a.approtitle,   " + 
     					 "         b.sbcr_name,   " + 
     					 "         a.amt," + 
     					 "			  a.vatamt , " + 
     					 "         a.price_class " +
     					 "    FROM m_approval  a," + 
     					 "			  s_sbcr b," + 
     					 "			  (select max(dept_code) dept_code,max(approym) approym,max(approseq) approseq,max(chg_cnt) chg_cnt" + 
     					 "		   	  from m_approval_detail" + 
     					 "		  		 where dept_code = " + "'" + arg_dept_code + "'" + 
     					 "		         and noinput_qty <> 0 " + 
     					 "		    group by dept_code,approym,approseq,chg_cnt) c," + 
     					 "			  (select max(dept_code) dept_code,max(approym) approym,max(approseq) approseq,max(chg_cnt) chg_cnt" + 
     					 "		   	  from m_approval_detail" + 
     					 "		  		 where dept_code = " + "'" + arg_dept_code + "'" + 
     					 "		    group by dept_code,approym,approseq) e," + 
						 "				m_approval_sbcr d            " +
						 "   WHERE d.dept_code = a.dept_code     " +
						 "		 and d.approym   = a.approym       " +
						 "		 and d.approseq  = a.approseq      " +
						 "		 and d.chg_cnt   = a.chg_cnt       " +
						 "		 and a.app_tag   = '3'             " +
						 "		 and a.dept_code  = c.dept_code    " +
						 "     and a.approym    = c.approym      " +
						 "     and a.approseq   = c.approseq     " +
						 "     and a.chg_cnt    = c.chg_cnt      " +
						 "		 and a.dept_code  = e.dept_code    " +
						 "     and a.approym    = e.approym      " +
						 "     and a.approseq   = e.approseq     " +
						 "     and a.chg_cnt    = e.chg_cnt      " +
						 "     and d.sbcr_code = b.sbcr_code     " +
						 "		 and d.dept_code = '" + arg_dept_code + "'" +
						 "		 and d.sbcr_code = '" + arg_sbcr_code + "'" +
     					 " ORDER BY a.DEPT_CODE ASC,   " + 
     					 "          a.approym ASC," + 
     					 "	  		   a.approseq asc       ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>