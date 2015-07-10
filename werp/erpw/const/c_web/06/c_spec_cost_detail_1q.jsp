<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
     String arg_spec_unq_num = req.getParameter("arg_spec_unq_num");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pay_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.tag,a.name,a.ssize,a.unit,a.work_date,a.pay_amt" + 
     "       FROM ( " + 
     "              SELECT '노무비' tag ,c.job_name name,' '  ssize ,'      ' unit, a.work_date , sum(nvl(a.pay_amt,0)) pay_amt " + 
     "					    from  l_labor_dailywork a , l_labor_basic b, l_code_job c " + 
     "							 where a.dept_code    = b.dept_code  " + 
     "							   and a.spec_no     = b.spec_no " + 
     "							   and b.job_code = c.job_code  " + 
     "							   and a.dept_code    = '" + arg_dept_code + "' " + 
     "								and a.work_date    >= '2005.06.01' " + 
     "								and a.work_date    >= '" + arg_date + "'" + 
     "								and a.work_date    < ADD_MONTHS('" + arg_date + "',1)" + 
     "								and a.spec_unq_num = " + arg_spec_unq_num + " " + 
     "                                                   group by c.job_name, a.work_date " + 
     "				  union all" + 
     "              SELECT '퇴직금' tag ,c.job_name name,' '  ssize ,'      ' unit, a.resign_date , sum(nvl(a.resign_amt,0)) pay_amt " + 
     "					    from  l_resignation a , l_labor_basic b, l_code_job c " + 
     "							 where a.dept_code    = b.dept_code  " + 
     "							   and a.spec_no     = b.spec_no " + 
     "							   and b.job_code = c.job_code  " + 
     "							   and a.dept_code    = '" + arg_dept_code + "' " + 
     "								and a.resign_date    >= '" + arg_date + "'" + 
     "								and a.resign_date    < ADD_MONTHS('" + arg_date + "',1)" + 
     "								and a.spec_unq_num = " + arg_spec_unq_num + " " + 
     "                           group by c.job_name, a.resign_date " + 
     "				  union all" + 
     "              SELECT '장비비' tag ,b.eqp_name,b.eqp_size,'      ',a.run_date, nvl(a.settle_amt,0)" + 
     "				       from  q_daily_run a, q_code_equipment b" + 
     "							 where a.dept_code    = b.dept_code " + 
     "							   and a.equp_code    = b.equp_code " + 
     "							   and a.dept_code    = '" + arg_dept_code + "' " + 
     "								and a.run_date     >= '" + arg_date + "'" + 
     "								and a.run_date     < ADD_MONTHS('" + arg_date + "',1)" + 
     "								and a.spec_unq_num = " + arg_spec_unq_num + " " + 
     "				  union all" + 
     "              SELECT '자재(출고)' tag, a.name, a.ssize,a.unitcode,a.yymmdd, " + 
     "                       a.amt  " + 
     "							  from m_output_detail a " + 
     "							 where a.dept_code    = '" + arg_dept_code + "'" + 
 	  "     							and a.INOUTTYPECODE = '2' " +  
	  "   							and a.ditag = '1' " + 
     "							   and a.yymmdd       >= '" + arg_date + "'  " + 
     "								and a.yymmdd       < ADD_MONTHS('" + arg_date + "',1)  " + 
     "								and a.spec_unq_num = " + arg_spec_unq_num + " " + 
     "				  union all" + 
     "              SELECT '자재(입고)' tag, b.name, b.ssize,b.unitcode,b.yymmdd, " + 
     "                       b.amt  " + 
	  "					  from m_input_detail b " + 
	  "					 where b.dept_code    = '" + arg_dept_code + "'" + 
	  "					   and b.yymmdd >= '" + arg_date + "'" + 
	  "					   and b.yymmdd <  ADD_MONTHS('" + arg_date + "',1)" + 
	  "						and b.ditag in ('5','6','7','8','9') " + 
     "						and b.spec_unq_num = " + arg_spec_unq_num + " " + 
     "				  union all" + 
     "              SELECT '손료' tag, c.name, c.ssize,c.unitcode,b.yymmdd, " + 
     "                    CASE WHEN a.vattag = '3' AND a.inouttypecode IN ('1','8') THEN " + 
	"					         round(b.amt / 1.1,0) else b.amt end  " + 
	  "					  from m_tmat_proj_rent b, " + 
		"					       m_tmat_stock c, " + 
		"					       m_input_detail a " + 
		"					 where b.dept_code    = '" + arg_dept_code + "'" + 
		"					   and b.month= '" + arg_date + "'" + 
		"						and b.dept_code = c.dept_code " + 
     "                  and b.yymmdd = c.yymmdd " + 
     "                  and b.seq = c.seq " + 
     "                  and b.input_unq_num = c.input_unq_num " + 
		"						and c.dept_code = a.dept_code  " + 
		"						and c.input_unq_num = a.input_unq_num " + 
     "						and b.spec_unq_num = " + arg_spec_unq_num + " " + 
      "             union all " + 
     "              SELECT '외주비' tag, d.sbcr_name ,c.sbc_name,'',to_date(to_char(a.yymm,'yyyy.mm') || '.25'),nvl(a.tm_prgs_amt,0)" + 
     "							  from  s_prgs_detail a," + 
     "									 s_cn_detail b, " + 
     "									 s_cn_list c, " + 
     "									 s_sbcr d " + 
     "							 where b.dept_code      = a.dept_code" + 
     "								and b.order_number   = a.order_number " + 
     "								and b.spec_no_seq    = a.spec_no_seq " + 
     "								and b.detail_unq_num = a.detail_unq_num" + 
     "							   and a.dept_code      = c.dept_code" + 
     "								and a.order_number   = c.order_number " + 
     "								and c.sbcr_code   = d.sbcr_code " + 
     "								and a.dept_code      = '" + arg_dept_code + "' " + 
     "								and b.spec_unq_num    = " + arg_spec_unq_num + "  " + 
     "								and a.yymm           = '" + arg_date + "'" + 
     "				  union all" + 
     "              SELECT '예비비' tag, b.account_name,a.cont,'      ',a.rqst_date, " + 
	  "					         nvl((a.amt - a.profit_amt) * decode(cr_class,'1',1,-1),0) " + 
     "							  from  f_request a," +
     "                             efin_accounts_v b " +  
     "							 where a.dept_code    = '" + arg_dept_code + "' " + 
     "								and a.rqst_date     >= '" + arg_date + "'" + 
     "								and a.rqst_date    < ADD_MONTHS('" + arg_date + "',1) " + 
     "								and a.spec_unq_num = " + arg_spec_unq_num + " " + 
     "                        AND a.acntcode = b.account_code(+) " +
     "								and a.cost_type = '1' " + 
     "				  union all" + 
     "              SELECT '미지급' tag, b.account_name,a.cont,'      ',a.request_date," + 
     "                              nvl(a.amt,0)" + 
     "							  from  f_nopay_request a," + 
     "                             efin_accounts_v b " +  
     "							 where a.dept_code    = '" + arg_dept_code + "' " + 
     "								and a.request_date     >= '" + arg_date + "'" + 
     "								and a.request_date    < ADD_MONTHS('" + arg_date + "',1) " + 
     "								and a.spec_unq_num = " + arg_spec_unq_num + " " + 
     "                        AND a.acntcode = b.account_code(+) " +
     "				  union all" + 
     "              SELECT '본사투입' tag, b.acntname,'                ','      ',a.yymm,nvl(a.amt,0)" + 
     "							  from  c_invest_detail a,c_invest_parent b " + 
     "                      where a.dept_code = b.dept_code   " + 
     "                        and a.acntcode = b.acntcode " + 
     "                        and a.yymm = b.yymm " + 
     "							   and a.dept_code    = '" + arg_dept_code + "' " + 
     "								and a.yymm     >= '" + arg_date + "'" + 
     "								and a.yymm    < ADD_MONTHS('" + arg_date + "',1) " + 
     "								and a.spec_unq_num = " + arg_spec_unq_num + " " + 
     "                      ) a" + 
     "      ORDER BY a.tag	,a.work_date ,a.name    ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>