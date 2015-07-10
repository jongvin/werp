<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date      = req.getParameter("arg_date");
     String arg_seq       = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chgprice",GauceDataColumn.TB_DECIMAL,18,0));
//     dSet.addDataColumn(new GauceDataColumn("estimatedetailseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("gongamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bugaamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_chgamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_chgamt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("band_tag",GauceDataColumn.TB_STRING,1));
     String query = "  SELECT  " + 
     "	      dept_code," + 
     "	      long_name," + 
     "	      sbcr_code," + 
     "         MTRCODE,   " + 
     "         NAME,   " + 
     "         UNITCODE,   " +
     "         SSIZE,   " + 
     "	      chgprice," + 
     "         sum(gongamt) gongamt,   " +
     "         sum(bugaamt) bugaamt,   " + 
     "         sum(comp_chgamt) comp_chgamt,   " +
     "         sum(comp_chgamt1) comp_chgamt1,   " + 
     "         sum(QTY) QTY,   " + 
     "         sbcr_name,   " + 
     "         band_tag " +
     " from (   SELECT  " + 
     "	    			  b.dept_code," + 
     "	    			  e.long_name," + 
     "	    			  a.sbcr_code," + 
     "	    			  a.chgprice," + 
     "       			  b.ESTIMATEDETAILSEQ,   " + 
     "       			  b.MTRCODE,   " + 
     "       			  b.NAME,   " + 
     "       			  b.SSIZE,   " + 
     "       			  b.UNITCODE,   " + 
     "       			  trunc(a.chgprice * b.qty,0)* 0.1  gongamt,   " +
     "       			  trunc(a.chgprice * b.qty,0)  bugaamt,   " +
     "       			  trunc(a.chgprice * b.qty,0)  comp_chgamt,   " +
     "       			  0  comp_chgamt1,   " + 
     "       			  b.QTY,   " + 
     "       			  c.sbcr_name,   " + 
     "         		  '1' band_tag   " + 
     "     		   FROM m_vender_est_detail  a," + 
     "					  M_EST_DETAIL b," + 
     "           		  s_sbcr  c, " + 
     "           		  m_vender_est d, " +
     "           		  z_code_dept e " +
     "      	  WHERE d.estimateyymm = a.estimateyymm and " +
     "      		     d.estimateseq  = a.estimateseq and " +
     "      		     d.sbcr_code    = a.sbcr_code and " +
     "      		     b.dept_code    = e.dept_code and" + 
     "	   			  a.estimateyymm = b.estimateyymm and" + 
     "					  a.estimateseq  = b.estimateseq and" + 
     "					  a.est_unq_num  = b.est_unq_num and" + 
     "					  a.sbcr_code  = c.sbcr_code and" + 
     "      		     d.ESTIMATEYYMM = " + "'" + arg_date + "'" + " AND  " + 
     "      		     d.ESTIMATESEQ = " + arg_seq +  " and " +
     "      		     d.est_yn = 'Y' " +
     "    UNION ALL " + 
     "        SELECT  " + 
     "	     		   max(b.dept_code)," + 
     "	     		   '    ', " + //  max(e.long_name)," + 
     "	     		   max(a.sbcr_code)," + 
     "	     		   max(0) chgprice," + 
     "        		   max(0)  ESTIMATEDETAILSEQ,   " + 
     "        		   max(' ')    MTRCODE,   " + 
     "        		   max(' 합   계      ')  NAME,   " + 
     "        		   max('    ') SSIZE,   " + 
     "        		   max('     ') unitcode,   " + 
     "        		   0 gongamt,   " +
     "        		   0 bugaamt,   " +
     "        		   SUM(nvl(a.chgprice * b.qty,0)) comp_chgamt,   " +
     "        		   SUM(nvl(a.chgprice * b.qty,0))  comp_chgamt1,   " + 
     "        		   sum(QTY)  QTY,   " + 
     "        		   max(c.sbcr_name),   " + 
     "        		   max('2')  band_tag   " + 
     "     		 FROM m_vender_est_detail  a," + 
     "		 			M_EST_DETAIL b," + 
     "       			s_sbcr  c ," + 
     "           		m_vender_est d, " +
     "          		z_code_dept e " +
     "      	WHERE d.estimateyymm = a.estimateyymm and " +
     "         	   d.estimateseq  = a.estimateseq and " +
     "         	   d.sbcr_code  = a.sbcr_code and " +
     "         	   b.dept_code    = e.dept_code and" + 
     "	   		   a.estimateyymm = b.estimateyymm and" + 
     "		  			a.estimateseq  = b.estimateseq and" + 
     "		  			a.est_unq_num  = b.est_unq_num and" + 
     "		  			a.sbcr_code  = c.sbcr_code and" + 
     "            	d.ESTIMATEYYMM = " + "'" + arg_date + "'" + " AND  " + 
     "            	d.ESTIMATESEQ = " + arg_seq +  " and " +
     "            	d.est_yn = 'Y' " +
     "   	GROUP BY a.sbcr_code,c.sbcr_name) " + 
     "	group by dept_code, long_name, sbcr_code, chgprice, " +
     "				MTRCODE, NAME, SSIZE, UNITCODE, sbcr_name, band_tag " +
     "   ORDER BY dept_code, long_name desc, sbcr_code, MTRCODE, UNITCODE, SSIZE " ; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>