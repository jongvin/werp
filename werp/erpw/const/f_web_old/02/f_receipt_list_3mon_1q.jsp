<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_where = req.getParameter("arg_where");
     String arg_start_yymm = req.getParameter("arg_start_yymm");
     String arg_last_yymm = req.getParameter("arg_last_yymm");
     arg_where = arg_where.replace('!','+'); 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT	b.dept_code,   														" + 
	"			b.long_name,             																		" + 
	"			substr(b.yymm,1,4) || '�� ' || substr(b.yymm,6,2) || '��' yymm,             " + 
   "        b.amt " + 
   "  from ( " + 
   "    SELECT	dept_code,   														" + 
	"			long_name,             																		" + 
	"			yymm,             																		" + 
   "        sum(amt)	 over (partition by dept_code order by yymm) amt	"  + // �ܾ״���
	"	    FROM ( SELECT a.dept_code,                                                   " + 
   "               max(b.long_name) long_name, " +  
	"	      	a.yymm,             " + 
	"	      	sum(decode(a.tag,'1',a.amt,0)) nopay_amt, 			                           " + // ������û��
	"	      	sum(decode(a.tag,'2',a.amt,0)) susi_amt, 			                           " + // �����û��(����)
	"	      	sum(decode(a.tag,'3',a.amt,0)) jung_amt, 			                           " + // �����û��(����)
	"	      	sum(decode(a.tag,'4',a.amt,0)) receipt_amt,		                           " + // ����������
	"	      	sum(decode(a.tag,'5',a.amt,0)) profit_amt,			                           " + // ���ͱ�
	"             nvl(sum(decode(a.tag,'2',a.amt,0)),0) + 												" +		
//	"	      	nvl(lag(sum(decode(a.tag,'3',a.amt,0)),1) over (order by a.dept_code,a.yymm),0) -         " +
	"	      	nvl(lag(sum(decode(a.tag,'3',a.amt,0)),1) over (partition by a.dept_code order by a.yymm),0) -         " +
	"	      	nvl(sum(decode(a.tag,'4',a.amt,0)),0) +													" +	 
	"	      	nvl(sum(decode(a.tag,'5',a.amt,0)),0)  amt       									" + 
	"	      FROM                                                                       " + 
	"	        (                                                                          " + 
	"	           select dept_code,'1' tag, to_char(request_date,'yyyy.mm') yymm,                      " + 
	"	           		sum(nvl(amt,0)+nvl(vat,0)) amt                                       " + 
	"	           from f_nopay_request                                                 		" + // ������û�� 
	"	           where to_char(request_date,'yyyy.mm') <= '" + arg_last_yymm + "'               	" + 
	"	           group by dept_code,to_char(request_date,'yyyy.mm')                                	" + 
	"	                                                                                   	" + 
	"	           UNION ALL                                                               	" + 
	"	                                                                                   	" + 
	"	           select dept_code,'2' tag, to_char(request_date,'yyyy.mm') yymm,                   	" + 
	"	           		sum(decode(class,1,nvl(cash_amt,0)+nvl(bill_amt,0))) amt             " + 
	"	           from f_preamt_request                                                  		" + // �����û��(����)
	"	           where to_char(request_date,'yyyy.mm') <= '" + arg_last_yymm + "'               	" + 
	"	           group by dept_code,to_char(request_date,'yyyy.mm')                                	" + 
	"	                                                                                   	" + 
	"	           UNION ALL                                                               	" + 
	"	                                                                                   	" + 
	"	           select dept_code,'3' tag, to_char(request_date,'yyyy.mm') yymm,                   	" + 
	"	           		sum(decode(class,2,nvl(cash_amt,0)+nvl(bill_amt,0))) amt             " + 
	"	           from f_preamt_request                                                  		" + // �����û��(����)
	"	           where to_char(request_date,'yyyy.mm') <= '" + arg_last_yymm + "'                  " + 
	"	           group by dept_code,to_char(request_date,'yyyy.mm')                                   " + 
	"	                                                                                      " + 
	"	           UNION ALL                                                                  " + 
	"	                                                                                      " + 
	"	           select dept_code,'4' tag, to_char(rqst_date,'yyyy.mm') yymm,                         " + 
	"	           		sum(decode(cr_class,1,nvl(amt,0)+nvl(vat,0)-nvl(profit_amt,0),       " +
	"	           									 nvl(profit_amt,0)-nvl(amt,0)-nvl(vat,0))) amt  " + 
	"	           from f_request                                                 				" + // ����������
	"	           where to_char(rqst_date,'yyyy.mm') <= '" + arg_last_yymm + "'         				" + 
	"	           group by dept_code, to_char(rqst_date,'yyyy.mm')                          				" + 
	"	                                                                          				" + 
	"	           UNION ALL                                                                  " + 
	"	                                                                                      " + 
	"	           select dept_code,'5' tag, to_char(inst_date,'yyyy.mm') yymm,                         " + 
	"	           		sum(nvl(amt,0)+nvl(vat,0)) amt                                       " + 
	"	           from f_profit_detail                                                  		" + // ���ͱ�
	"	           where to_char(inst_date,'yyyy.mm') <= '" + arg_last_yymm + "'                     " + 
	"	           group by dept_code,to_char(inst_date,'yyyy.mm')                                      " + 
	"	        )  a,                                                                        " + 
	"	          z_code_dept b                                                            " + 
	"	        where " + arg_where + " " + 
	"	        group by a.dept_code,a.yymm ) b " + 
	"      ) b "  +  
	"   where b.yymm >= '" + arg_start_yymm + "'                                    " + 
	"   order by b.long_name ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>