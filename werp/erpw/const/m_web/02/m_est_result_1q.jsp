<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_estimateyymm = req.getParameter("arg_estimateyymm");
     String arg_estimateseq = req.getParameter("arg_estimateseq");
     String arg_chasu = req.getParameter("arg_chasu");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("open_dt",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("band_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("unit_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = " " + 
                   " select a.sbcr_code,                                              " + 
                   "        a.sbcr_name,                                              " + 
                   "        a.open_dt,                                              " + 
                   "        a.band_tag,                                               " + 
                   "        a.unit_amt                                                " + 
                   "   from                                                           " + 
                   "        (      SELECT                                             " + 
                   "      	     		   a.sbcr_code sbcr_code,                    " + 
                   "              		c.sbcr_name sbcr_name,                    " + 
     					 "          to_char(d.open_dt,'yyyy.mm.dd hh24:mi') open_dt," + 
                   "              		'1차 견적'  band_tag,                          " + 
                   "              		a.amt unit_amt       " + 
                   "           		 FROM m_vender_est  a,                     " + 
                   "             			s_sbcr  c ,                                 " + 
                   "                 		m_estimation d                              " + 
                   "            	WHERE d.estimateyymm = a.estimateyymm and            " + 
                   "               	   d.estimateseq  = a.estimateseq and             " + 
                   "      		  			a.sbcr_code  = c.sbcr_code and                 " + 
                   "                  	a.ESTIMATEYYMM =  '" + arg_estimateyymm + "' AND             " + 
                   "                  	a.ESTIMATESEQ =  " + arg_estimateseq + " and                        " + 
                   "                  	a.est_yn = 'Y'                                 " ;
              if (arg_chasu.equals("2")) {  
              	    query = query +                  
                   "         	union all                                               " + 
                   "              SELECT                                              " + 
                   "      	     		   a.sbcr_code sbcr_code,                    " + 
                   "              		c.sbcr_name sbcr_name,                    " + 
     					 "          to_char(d.open_dt,'yyyy.mm.dd hh24:mi') open_dt," + 
                   "              		'2차 견적'  band_tag,                          " + 
                   "              		a.chg_amt unit_amt       " + 
                   "           		 FROM m_vender_est  a,                     " + 
                   "             			s_sbcr  c ,                                 " + 
                   "                 		m_estimation d                              " + 
                   "            	WHERE d.estimateyymm = a.estimateyymm and            " + 
                   "               	   d.estimateseq  = a.estimateseq and             " + 
                   "      		  			a.sbcr_code  = c.sbcr_code and                 " + 
                   "                  	a.ESTIMATEYYMM =  '" + arg_estimateyymm + "' AND             " + 
                   "                  	a.ESTIMATESEQ =  " + arg_estimateseq + " and                        " + 
                   "                  	a.est_yn = 'Y' ) a                                " + 
                   "          ORDER BY a.sbcr_name, a.band_tag ";
              }      
              else {
              	   query = query + " ) a " + 
                    "          ORDER BY a.sbcr_name, a.band_tag ";
              }                   
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>