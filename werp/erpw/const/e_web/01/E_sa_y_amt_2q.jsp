<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%>
<%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymmdd = req.getParameter("arg_yymmdd");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("prgs_degree",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,18,0));
	 dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,10,0));
	 dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.dept_code,									  " + 
				   "         to_char(a.yymm,'yyyy.mm.dd') yymm,				  " + 
				   "         a.seq,											     " + 
				   "         a.order_number,								     " + 
				   "         a.prgs_degree ,								  		" + 
				   "         b.sbc_name	,									 		 " + 
				   "         c.sbcr_name ,									  		" + 
				   "         to_char(a.yymm,'yyyy-mm-dd') yymmdd,			  " + 
				   "         nvl(d.amt,0) amt 										" +
				   "  FROM  s_pay a , s_cn_list b , s_sbcr c,				  " + 
				   "        (select a.dept_code, 									" +
				   "                a.order_number,								 " +
				   "                a.yymm,										" +
				   "                sum(a.tm_prgs_amt) amt							 " +
				   "           from s_prgs_detail a, 										" +
				   "                s_cn_detail b 								" +
				   "          where a.dept_code=b.dept_code and 			" +
				   "                a.order_number=b.order_number and 		" +
				 	"                a.spec_no_seq=b.spec_no_seq and	" +
				 	"                a.detail_unq_num=b.detail_unq_num and	" +
				   "                b.res_class='X' 							" +
				   "       group by a.dept_code, a.yymm, a.order_number) d 		" +
				   "  WHERE													  			" +
				   "          ( a.dept_code = '" + arg_dept_code + "' ) AND   " + 
				   "          ( a.yymm = '" + arg_yymmdd + "') AND			  " + 
				   "          ( a.seq = " + arg_seq + " ) AND				  " + 
				   "	        ( a.dept_code =   b.dept_code   ) AND		      " + 
				   "          ( a.order_number = b.order_number ) AND         " +
				   "          ( b.sbcr_code = c.sbcr_code ) AND					  " +
				   "          ( a.dept_code = d.dept_code(+)) AND 			" +
				   "          ( a.order_number = d.order_number(+)) AND		 " +
				   "          ( a.yymm = d.yymm(+))	and							" +
					"          ( nvl(d.amt,0) > 0	)								" +
				   "  ORDER BY a.dept_code ASC,								  " + 
				   "         a.yymm ASC,									  " + 
				   "         a.seq ASC,										  " + 
				   "		    a.order_number DESC,							  " + 
				   "         a.prgs_degree ASC								  " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>