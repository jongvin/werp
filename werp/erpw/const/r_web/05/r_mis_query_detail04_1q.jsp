<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("extablish_time",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("tag1",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("child_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("supply_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("prepay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rcv_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rcv_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rcv_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rcb_pre",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select a.extablish_time,                " + 
     "		               a.order_tag," + 
     "		               a.tag1,                      " + 
     "                     a.child_name,                    " + 
     "		               to_char(a.work_date,'YYYY.MM.DD') work_date,          " + 
     "                     a.supply_amt,                    " + 
     " 		               a.vat_amt,                       " + 
     "		               a.sum_amt," + 
     "		               a.prepay_amt,                    " + 
     "                     a.rcv_amt,                       " + 
     " 		               a.rcv_vat,                       " + 
     "		               a.rcv_sum,                       " + 
     "		               a.rcb_pre                        " + 
     "                from ( select a.extablish_time,         " + 
     "	                           '1' order_tag,                " + 
     "	                           'û��' tag1,                 " + 
     "	                           b.child_name,                    " + 
     "	                    		   a.issue_date work_date,          " + 
     "	                           a.supply_amt,                    " + 
     "	                     		a.vat_amt,                       " + 
     "	                    		   a.supply_amt + a.vat_amt sum_amt," + 
     "	                    		   a.prepay_amt,                    " + 
     "	                           0 rcv_amt,                       " + 
     "	                     		0 rcv_vat,                       " + 
     "	                    		   0 rcv_sum,                       " + 
     "	                    		   0 rcb_pre                        " + 
     "	                      from r_contract_time_extablished a,     " + 
     "	                           z_code_etc_child b                 " + 
     "	                     where b.class_tag = '005'               " + 
     "	                       and b.etc_code = a.extablish_tag      " + 
     "	                       and a.dept_code = " + "'" + arg_dept_code + "'" + 
     "	                     union all                               " + 
     "	                    select a.extablish_time," + 
     "	                  		  '2' order_tag,                " + 
     "	                   		  '����' tag1,                      " + 
     "                      		  b.child_name,                    " + 
     "	                   		  a.received_date work_date,       " + 
     "                      		  0 supply_amt,                    " + 
     " 	                   		  0 vat_amt,                       " + 
     "	                   		  0 sum_amt,                       " + 
     "	                   		  0 prepay_amt,                    " + 
     "                      		  a.supply_amt rcv_amt,            " + 
     " 	                   		  a.vat_amt    rcv_vat,            " + 
     "	                   		  a.supply_amt + a.vat_amt rcv_sum," + 
     "	                   		  a.prepay_amt rcb_pre             " + 
     "	                  	from r_contract_time_collection a,      " + 
     "	                  	     z_code_etc_child b                 " + 
     "	                    where b.class_tag = '005'               " + 
     "	                      and b.etc_code = a.extablish_tag      " + 
     "	                      and a.dept_code = " + "'" + arg_dept_code + "'" + "  ) a " + 
     "  order by a.extablish_time asc,a.order_tag asc,a.work_date asc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>