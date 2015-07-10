<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("parent_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("parent_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("detail_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detail_spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detail_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("this_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("this_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("this_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("head_office",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_rcv_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_rqst_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("this_rqst_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("this_rcv_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_remain_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("this_remain_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = " SELECT Y_BUDGET_PARENT.SPEC_NO_SEQ," + 
     "           Y_BUDGET_PARENT.NO_SEQ   PARENT_SEQ," + 
     "           Y_BUDGET_PARENT.NAME  parent_name," + 
     "           Y_BUDGET_DETAIL.NO_SEQ   DETAIL_SEQ," + 
     "           Y_BUDGET_DETAIL.SPEC_UNQ_NUM  DETAIL_SPEC_UNQ_NUM," + 
     "           Y_BUDGET_DETAIL.NAME  detail_name," + 
     "           Y_BUDGET_DETAIL.EXP_AMT," + 
     "           nvl(exp_sum_data.exp_sum_amt,0)  exp_sum_amt," + 
     "           nvl(pre_data.amt,0)  pre_amt," + 
     "           nvl(this_data.amt,0) this_amt," + 
     "           nvl(this_data.vat,0) this_vat," + 
     "           nvl(this_data.amt,0) + nvl(this_data.vat,0) this_tot," + 
     "           nvl(hd_data.head_office,0)   head_office," + 
     "           nvl(rq_data.pre_rcv_amt,0)   pre_rcv_amt," + 
     "           nvl(rq_data.pre_rqst_amt,0)  pre_rqst_amt," + 
     "           nvl(rq_data.this_rqst_amt,0) this_rqst_amt," + 
     "           nvl(rq_data.this_rcv_amt,0)  this_rcv_amt, " + 
     "           nvl(rq_data.pre_rcv_amt,0) - nvl(rq_data.pre_rqst_amt,0)   pre_remain_amt, " + 
     "           nvl(rq_data.pre_rcv_amt,0) + nvl(rq_data.this_rcv_amt,0) - nvl(rq_data.pre_rqst_amt,0) - nvl(rq_data.this_rqst_amt,0)  this_remain_amt " + 
     "   	 FROM Y_BUDGET_DETAIL," + 
     "  		   	Y_BUDGET_PARENT," + 
     "    			( select sum(exp_amt) exp_sum_amt " + 
     "     				from y_budget_detail  " +
     " 			     where dept_code  = '" + arg_dept + "' " + 
     "                and res_class  = 'X' ) exp_sum_data," + 
     "    			( select spec_unq_num," + 
     "  					   sum(amt + vat) amt " + 
     "     				from f_request  " +
     " 			     where dept_code  = '" + arg_dept + "' " + 
     "  				    and rqst_date < " + "'" + arg_yymm + "'" + " " + 
     " 				    and receipt_rqst_type = '1' " +
     "  				    and (fund_type in ('2', '3')) " +
     "              group by spec_unq_num            ) pre_data," + 
     "    			( select spec_unq_num," + 
     "  					   sum(amt) amt," + 
     "    					sum(vat) vat " + 
     "     				from f_request  " +
     " 			     where dept_code  = '" + arg_dept + "' " + 
     "  				    and rqst_date >= " + "'" + arg_yymm + "'" + " " + 
     " 				    and rqst_date <  add_months(to_date(" + "'" + arg_yymm + "' ,'yyyy.mm.dd'),1) " +
     " 				    and receipt_rqst_type = '1' " +
     "  				    and (fund_type in ('2', '3')) " +
     "              group by spec_unq_num            ) this_data," + 
     "  			   ( select spec_unq_num," + 
     "                     sum(decode(fund_type, '1',amt + vat,0 ) ) head_office " +
     "  				    from f_request   " +
     "			      where dept_code = '" + arg_dept + "' " + 
     "  				     and rqst_date >= " + "'" + arg_yymm + "'" + " " + 
     " 				     and rqst_date <  add_months(to_date(" + "'" + arg_yymm + "' ,'yyyy.mm.dd'),1) " +
     " 				     and fund_type         = '1'  " +
     "               group by spec_unq_num            ) hd_data," + 
     "  			   (select sv_data.spec_unq_num," + 
     "                   sum(sv_data.pre_rcv_amt)   pre_rcv_amt," + 
     "                   sum(sv_data.this_rcv_amt)  this_rcv_amt," + 
     "                   sum(sv_data.pre_rqst_amt)  pre_rqst_amt,  " +
     "                   sum(sv_data.this_rqst_amt) this_rqst_amt  " +
     "               from " +
     "  					(select 9999999999999  spec_unq_num," + 
     "  							  cash_amt + bill_amt + check_amt + bank_amt + etc_amt pre_rcv_amt," + 
     "  							  0  this_rcv_amt," + 
     "   						  0  pre_rqst_amt, " +
     "  							  0  this_rqst_amt " + 
     "    					from f_receive_amt " +
     "   				  where dept_code    = '" + arg_dept + "' " + 
     "  						 and receive_date < " + "'" + arg_yymm + "'" + " " + 
     " 					 union all " +
     " 					 select 9999999999999  spec_unq_num," + 
     "  							  0  pre_rcv_amt," + 
     "  							  cash_amt + bill_amt + check_amt + bank_amt + etc_amt this_rcv_amt," + 
     "     						  0  pre_rqst_amt, " +
     "  							  0  this_rqst_amt " + 
     "    					from f_receive_amt " +
     "  					  where dept_code    = '" + arg_dept + "' " + 
     "  						 and receive_date >= " + "'" + arg_yymm + "'" + " " + 
     " 						 and receive_date <  add_months(to_date(" + "'" + arg_yymm + "' ,'yyyy.mm.dd'),1) " +
     " 					 union all " +
     " 					 select 9999999999999  spec_unq_num," + 
     "  							  0  pre_rcv_amt," + 
     "  							  0  this_rcv_amt," + 
     "  							  amt + vat  pre_rqst_amt, " +
     "  							  0  this_rqst_amt " + 
     "  						from f_request  " +
     " 					  where dept_code = '" + arg_dept + "' " + 
     "  						 and rqst_date < " + "'" + arg_yymm + "'" + " " + 
     "  						 and receipt_rqst_type = '1'  " +
     " 						 and (fund_type in ('2','3')) " +
     " 					 union all " +
     " 					 select 9999999999999  spec_unq_num," + 
     "  							  0  pre_rcv_amt," + 
     "  							  0  this_rcv_amt," + 
     "  							  0  pre_rqst_amt, " +
     "  							  amt + vat  this_rqst_amt " +
     "  						from f_request  " +
     " 					  where dept_code = '" + arg_dept + "' " + 
     "  						 and rqst_date >= " + "'" + arg_yymm + "'" + " " + 
     " 						 and rqst_date <  add_months(to_date(" + "'" + arg_yymm + "' ,'yyyy.mm.dd'),1) " +
     "  						 and receipt_rqst_type = '1'  " +
     " 						 and (fund_type in ('2','3')) " +
     " 		        ) sv_data  " +
     "             group by spec_unq_num  " +
     "         ) rq_data  " +
     "    WHERE ( Y_BUDGET_PARENT.DEPT_CODE     = Y_BUDGET_DETAIL.DEPT_CODE )   " +
     "      and ( Y_BUDGET_PARENT.CHG_NO_SEQ    = Y_BUDGET_DETAIL.CHG_NO_SEQ )  " +
     "      and ( Y_BUDGET_PARENT.SPEC_NO_SEQ   = Y_BUDGET_DETAIL.SPEC_NO_SEQ ) " +
     "      and ( Y_BUDGET_DETAIL.SPEC_UNQ_NUM  = pre_data.spec_unq_num(+) )   " + 
     "      and ( Y_BUDGET_DETAIL.SPEC_UNQ_NUM  = this_data.spec_unq_num(+) )   " + 
     "      and ( Y_BUDGET_DETAIL.SPEC_UNQ_NUM  = hd_data.spec_unq_num(+) )     " +
     "      and ( Y_BUDGET_DETAIL.DEPT_CODE     = '" + arg_dept + "') " + 
     "      and ( Y_BUDGET_DETAIL.EXP_AMT <> 0 or" + 
     "            nvl(pre_data.amt,0) <> 0 or " + 
     "            nvl(this_data.amt,0) <> 0 or " + 
     "            nvl(this_data.vat,0) <> 0 ) " + 
     "    ORDER BY Y_BUDGET_PARENT.NO_SEQ," + 
     "  			    Y_BUDGET_DETAIL.NO_SEQ       ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>