<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_initial_year = req.getParameter("arg_initial_year");
     String arg_last_year = req.getParameter("arg_last_year");
     String arg_current_yymm = req.getParameter("arg_current_yymm");
     String arg_next_yymm = req.getParameter("arg_next_yymm");
     String arg_chg_no_seq = req.getParameter("arg_chg_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("test_exeamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ground_area",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("gross_floor_area_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("floor",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("chg_const_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("goal_const_st",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("goal_const_ed",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("goal_const_term",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pre_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_result_per",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_plan_per",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("real_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_real_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_real_per",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_amt_2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_cost_amt_2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bef_year_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bef_year_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cur_bef_mm_plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cur_bef_mm_plan_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cur_mm_plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cur_mm_plan_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));

     dSet.addDataColumn(new GauceDataColumn("nugae_mmtot_plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("nugae_mmtot_plan_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));


     dSet.addDataColumn(new GauceDataColumn("cur_year_plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cur_year_plan_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bef_year_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bef_yeart_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cur_bef_mm_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cur_bef_mm_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cur_mm_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cur_mm_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     
     dSet.addDataColumn(new GauceDataColumn("nugae_mmtot_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("nugae_mmtot_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     
     dSet.addDataColumn(new GauceDataColumn("cur_year_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cur_year_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));

     dSet.addDataColumn(new GauceDataColumn("iwol_plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("iwol_plan_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));

     dSet.addDataColumn(new GauceDataColumn("bef_tot_cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cur_mm_cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     
     dSet.addDataColumn(new GauceDataColumn("tot_dogub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("junwol_tot_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_tot_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     
     dSet.addDataColumn(new GauceDataColumn("bef_tot_request_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cur_mm_request_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_request_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bef_tot_accept_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cur_mm_accept_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_accept_amt",GauceDataColumn.TB_DECIMAL,18,0));

     dSet.addDataColumn(new GauceDataColumn("profit_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profit_bef_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profit_mm_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profit_nugae",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("misu_bef_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("misu_mm_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("misu_nugae",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select a.dept_code," + 
     "       nvl(a.test_exeamt,0) test_exeamt ," +   //������
     "       a.ground_area," +                       //��������
     "       a.gross_floor_area_sum," +              //������
     "       a.floor," +                             //����
     "       a.chg_const_start_date," +              //��׽�����
     "       a.chg_const_end_date," +                //���������
     "       a.chg_const_term," +                //��ళ����
     "       a.goal_const_st," +                     //��ǥ���������
     "       a.goal_const_ed," +                     //��ǥ����������
     "       a.goal_const_term," +                     //��ǥ���ⰳ����
     "       b.pre_result_amt," +                    //�ذ�����
     "       b.amt,        " +                       //����ݾ�(������)
     "       decode(nvl(b.amt,0),0,0,trunc(nvl(b.pre_result_amt,0) / b.amt * 100,1)) pre_result_per," +   //�ذ����������
     " " + 
     "       c.plan_amt,   " +                       //������Ұ�ȹ
     "       c.tot_plan_amt," +                      //��ü ���Ұ�ȹ
     "       decode(nvl(b.amt,0),0,0,trunc(nvl(c.tot_plan_amt,0) / b.amt * 100,1)) tot_plan_per," +   // ��ȹ�� 
     "       c.real_amt," +                          //������ҽ���
     "       c.tot_real_amt," +                      //��ü���ҽ���
     "       decode(nvl(b.pre_result_amt,0),0,0,trunc(nvl(b.total_cost_amt,0) / b.pre_result_amt * 100,1)) tot_real_per," +   // ������
     "       " + 
     "       d.tot_amt," +                           //�����ȹ�ѱݾ�
     "       nvl(h.bef_year_result_amt,0) +  nvl(i.cur_bef_mm_result_amt,0) + nvl(i.cur_mm_result_amt,0) tot_amt_2," +                           //��������ѱݾ�
     "       d.tot_cost_amt," +                      //������ȹ�ѱݾ�
     "       nvl(h.bef_yeart_cost_amt,0) +  nvl(i.cur_bef_mm_cost_amt,0) + nvl(i.cur_mm_cost_amt,0) tot_cost_amt_2," +          //���������ѱݾ�
     "       d.tot_cnt_amt," +                       //���ޱ⼺�ѱݾ� 
     "       " + 
     "       e.bef_year_amt," +                      //�����ȹ���⵵����
     "       e.bef_year_cost_amt," +                 //������ȹ���⵵����
     "       " + 
     "       f.cur_bef_mm_amt cur_bef_mm_plan_amt," +                    //���س⵵���� �����ȹ����
     "       f.cur_bef_mm_cost_amt   cur_bef_mm_plan_cost_amt," +               //���س⵵���� ������ȹ����
     "       f.cur_mm_amt cur_mm_plan_amt," +                        //��� �����ȹ
     "       f.cur_mm_cost_amt cur_mm_plan_cost_amt," +                   //��� ������ȹ 
     "       nvl(f.cur_bef_mm_amt,0) + nvl(f.cur_mm_amt,0) nugae_mmtot_plan_amt, " + // ���س⵵ �����ȹ ���� 
     "       nvl(f.cur_bef_mm_cost_amt,0) + nvl(f.cur_mm_cost_amt,0) nugae_mmtot_plan_cost_amt, " + // ���س⵵ ������ȹ ���� 
     "       " + 
     "       g.cur_year_amt cur_year_plan_amt," +                      //���س⵵ �����ȹ�ݾ�
     "       g.cur_year_cost_amt cur_year_plan_cost_amt," +            //���س⵵ ������ȹ�ݾ� 
     "       " + 
     "       h.bef_year_result_amt," +               //���⵵���� ����ݾ�
     "       h.bef_yeart_cost_amt," +                //���⵵���� �����ݾ�
     "       " + 
     "       i.cur_bef_mm_result_amt," +             //���س⵵���� ����ݾ״���
     "       i.cur_bef_mm_cost_amt," +               //���س⵵���� �����ݾ״���
     "       i.cur_mm_result_amt," +                 //��� ����⼺�ݾ�
     "       i.cur_mm_cost_amt," +                   //��� �����ݾ�
     "       nvl(i.cur_bef_mm_result_amt,0) + nvl(i.cur_mm_result_amt,0) nugae_mmtot_result_amt, " + // ���س⵵ ����ݾ� ���� 
     "       nvl(i.cur_bef_mm_cost_amt,0) + nvl(i.cur_mm_cost_amt,0) nugae_mmtot_cost_amt, " + // ���س⵵ �����ݾ� ���� 
     "       " + 
     "       j.cur_year_result_amt," +               //���س⵵ ����ݾ�
     "       j.cur_year_cost_amt," +                //���س⵵ �����ݾ�
     " " + 
     "       nvl(d.tot_amt,0) - nvl(e.bef_year_amt,0) - nvl(g.cur_year_amt,0) iwol_plan_amt, " + // �̿������ȹ�ݾ�
     "       nvl(d.tot_cost_amt,0) - nvl(e.bef_year_cost_amt,0) - nvl(g.cur_year_cost_amt,0) iwol_plan_cost_amt, " + // �̿�������ȹ�ݾ�
     " " + 
     "       k.bef_tot_cnt_amt," +                   //�������� ���ޱ⼺����
     "       k.cur_mm_cnt_amt," +                    //���     ���ޱ⼺
     "       nvl(k.bef_tot_cnt_amt,0) + nvl(k.cur_mm_cnt_amt,0)  tot_dogub_amt, " + // ���ޱ⼺����
     "       nvl(h.bef_yeart_cost_amt,0) + nvl(i.cur_bef_mm_cost_amt,0)  junwol_tot_cost_amt, " + // ��������������� 
     "       nvl(h.bef_yeart_cost_amt,0) + nvl(i.cur_bef_mm_cost_amt,0) + " + 
     "                           nvl(i.cur_mm_cost_amt,0) tot_tot_cost_amt, " + // ���������ü���� 
     "       " + 
     "       l.bef_tot_request_amt," +               //�������� �⼺û����
     "       m.cur_mm_request_amt," +                //��� �⼺û����
     "       nvl(l.bef_tot_request_amt,0) + nvl(m.cur_mm_request_amt,0) tot_request_amt, " +  //�⼺û������
     "       " + 
     "       n.bef_tot_accept_amt," +                //�������� �⼺���ݾ�
     "       o.cur_mm_accept_amt," +                 //��� �⼺���ݾ� 
     "       nvl( n.bef_tot_accept_amt,0) + nvl(o.cur_mm_accept_amt,0) tot_accept_amt, "  + // �⼺���ݴ��� 
     " " + 
     "       nvl(d.tot_cnt_amt,0) - nvl(d.tot_cost_amt,0) profit_tot, "  + // ���� ���� (�Ѿ�)
     "       nvl(k.bef_tot_cnt_amt,0) - (nvl(h.bef_yeart_cost_amt,0) + nvl(i.cur_bef_mm_cost_amt,0)) profit_bef_tot, "  +  // ���� ����(��������) 
     "       nvl(k.cur_mm_cnt_amt,0) - nvl(i.cur_mm_cost_amt,0)  profit_mm_tot, " +  // ���� ����(���) 
     "       (nvl(k.bef_tot_cnt_amt,0) + nvl(k.cur_mm_cnt_amt,0)) -  " +   
     "       (nvl(h.bef_yeart_cost_amt,0) + nvl(i.cur_bef_mm_cost_amt,0) + " + 
     "                           nvl(i.cur_mm_cost_amt,0)) profit_nugae, " + // ���� ����(��ü����)
     "       " + 
     "       nvl(l.bef_tot_request_amt,0) - nvl(n.bef_tot_accept_amt,0) misu_bef_tot, " +  // �̼��� (��������) 
     "       nvl(m.cur_mm_request_amt,0) - nvl(o.cur_mm_accept_amt,0) misu_mm_tot, " +  // �̼��� (���) 
     "       nvl(l.bef_tot_request_amt,0) + nvl(m.cur_mm_request_amt,0) - ( "  + 
     "        nvl( n.bef_tot_accept_amt,0) + nvl(o.cur_mm_accept_amt,0)) misu_nugae " + // �̼���(��ü����)  
 "   from (                                                                                                           " +
 "         select a.dept_code,                                                                                        " +
 "                nvl(a.test_exeamt,0) test_exeamt ,                                                                  " +
 "                a.ground_area,                                                                                      " +
 "                a.gross_floor_area_sum,                                                                             " +
 "                a.floor,                                                                                            " +
 "                to_char(a.chg_const_start_date,'yyyy.mm.dd') chg_const_start_date,                                  " +
 "                to_char(a.chg_const_end_date,'yyyy.mm.dd') chg_const_end_date,                                      " +
 "                nvl(a.chg_const_term,0) chg_const_term,                                      " +
 "                to_char(a.goal_const_st,'yyyy.mm.dd') goal_const_st,                                                " +
 "                to_char(a.goal_const_ed,'yyyy.mm.dd') goal_const_ed,                                                 " +
 "                nvl(a.goal_const_term,0)   goal_const_term                                               " +
 "             from z_code_dept a                                                                                     " +
 "             where a.dept_code = '" + arg_dept_code + "' ) a,                                                                " +
 "                                                                                                                    " +
 "       (                                                                                                            " +
 "         select a.dept_code,                                                                                        " +
 "                a.pre_result_amt,                                                                                   " +
 "                a.cost_amt + a.ls_cost_amt total_cost_amt,                                                                                   " +
 "                b.amt                                                                                               " +
 "             from c_spec_const_parent a,                                                                            " +
 "                  y_budget_parent b                                                                                 " +
 "             where a.dept_code = b.dept_code                                                                        " +
 "               and a.spec_no_seq = b.spec_no_seq                                                                    " +
 "               and a.yymm = '" + arg_current_yymm + "'                                                                       " +
 "               and a.dept_code = '" + arg_dept_code + "'                                                                     " +
 "               and b.sum_code = '01' ) b,                                                                           " +
 "                                                                                                                    " +
 "       (                                                                                                            " +
 "         select a.dept_code,                                                                                        " +
 "                sum(decode(to_char(b.year,'yyyy.mm.dd'),'" + arg_current_yymm + "',b.plan_mm_amt,0)) plan_amt,               " +
 "                sum(b.plan_mm_amt)  tot_plan_amt,                                                                   " +
 "                sum(decode(to_char(b.year,'yyyy.mm.dd'),'" + arg_current_yymm + "',b.real_mm_amt,0)) real_amt,               " +
 "                sum(b.real_mm_amt)  tot_real_amt                                                                    " +
 "            from c_progress_parent a,                                                                               " +
 "                 c_progress_detail b,                                                                               " +
 "                 (select a.dept_code,                                                                               " +
 "                         max(a.chg_no_seq) chg_no_seq                                                               " +
 "                    from c_chg_progress a                                                                           " +
 "                    where a.dept_code = '" + arg_dept_code + "'                                                              " +
 "                    group by a.dept_code) c                                                                         " +
 "           WHERE a.dept_code = b.dept_code                                                                          " +
 "             and a.wbs_code = b.wbs_code                                                                            " +
 "             and a.chg_no_seq = b.chg_no_seq                                                                        " +
 "             and a.dept_code = c.dept_code                                                                          " +
 "             and a.chg_no_seq = c.chg_no_seq                                                                        " +
 "             and b.year <= '" + arg_current_yymm + "'                                                                        " +
 "             and a.invest_class = 'Y'                                                                               " +
 "           group by a.dept_code ) c,                                                                                " +
 "                                                                                                                    " +
 "                                                                                                                    " +
 "       (                                                                                                            " +
 "         select a.dept_code,                                                                                        " +
 "                sum(a.amt)  tot_amt,                                                                                " +
 "                sum(a.cost_amt) tot_cost_amt,                                                                       " +
 "                sum(a.cnt_amt) tot_cnt_amt                                                                          " +
 "            from c_cost_plan a                                                                                      " +
 "            where a.dept_code = '" + arg_dept_code + "'                                                             " +
 "              and a.chg_no_seq = " + arg_chg_no_seq + " " + 
 "            group by a.dept_code ) d,                                                                               " +
 "                                                                                                                    " +
 "      (                                                                                                             " +
 "       select a.dept_code,                                                                                          " +
 "              sum(a.amt) bef_year_amt,                                                                              " +
 "              sum(a.cost_amt) bef_year_cost_amt                                                                     " +
 "          from c_cost_plan a                                                                                        " +
 "          where a.dept_code = '" + arg_dept_code + "'                                                               " +
 "            and a.chg_no_seq = " + arg_chg_no_seq + " " + 
 "            and a.yymm < '" + arg_initial_year + "'                                                                 " +
 "          group by a.dept_code ) e,                                                                                 " +
 "                                                                                                                    " +
 "      (                                                                                                             " +
 "       select a.dept_code,                                                                                          " +
 "                SUM(decode(SIGN(a.yymm - TO_DATE('" + arg_current_yymm + "' )),-1,a.amt,0)) cur_bef_mm_amt,  " +
 "                SUM(decode(SIGN(a.yymm - TO_DATE('" + arg_current_yymm + "' )),-1,a.cost_amt,0)) cur_bef_mm_cost_amt,  " +
 "              sum(decode(to_char(a.yymm,'yyyy.mm.dd'),'" + arg_current_yymm + "',a.amt,0)) cur_mm_amt,                       " +
 "              sum(decode(to_char(a.yymm,'yyyy.mm.dd'),'" + arg_current_yymm + "',a.cost_amt,0)) cur_mm_cost_amt              " +
 "          from c_cost_plan a                                                                                        " +
 "          where a.dept_code = '" + arg_dept_code + "'                                                                        " +
 "              and a.chg_no_seq = " + arg_chg_no_seq + " " + 
 "            and a.yymm >= '" + arg_initial_year + "'                                                                         " +
 "            and a.yymm <= '" + arg_current_yymm + "'                                                                         " +
 "          group by a.dept_code ) f,                                                                                 " +
 "                                                                                                                    " +
 "       (                                                                                                            " +
 "        select a.dept_code,                                                                                         " +
 "               sum(a.amt) cur_year_amt,                                                                             " +
 "               sum(a.cost_amt) cur_year_cost_amt                                                                    " +
 "           from c_cost_plan a                                                                                       " +
 "           where a.dept_code = '" + arg_dept_code + "'                                                                       " +
 "              and a.chg_no_seq = " + arg_chg_no_seq + " " + 
 "             and a.yymm >= '" + arg_initial_year + "'                                                                        " +
 "             and a.yymm <= '" + arg_last_year + "'                                                                           " +
 "           group by a.dept_code ) g,                                                                                " +
 "                                                                                                                    " +
 "        (                                                                                                           " +
 "         select a.dept_code,                                                                                        " +
 "                sum(a.result_amt) bef_year_result_amt,                                                              " +
 "                sum(a.cost_amt) bef_yeart_cost_amt                                                                  " +
 "             from c_spec_const_parent a,                                                                            " +
 "                  y_budget_parent b                                                                                 " +
 "             where a.dept_code = b.dept_code                                                                        " +
 "               and a.spec_no_seq = b.spec_no_seq                                                                    " +
 "               and a.dept_code = '" + arg_dept_code + "'                                                                     " +
 "               and b.sum_code = '01'                                                                                " +
 "               and a.yymm < '" + arg_initial_year + "'                                                                       " +
 "             group by a.dept_code ) h,                                                                              " +
 "                                                                                                                    " +
 "        (                                                                                                           " +
 "         select a.dept_code, " +   
 "                SUM(decode(SIGN(a.yymm - TO_DATE('" + arg_current_yymm + "' )),-1,a.result_amt,0)) cur_bef_mm_result_amt,  " +
 "                SUM(decode(SIGN(a.yymm - TO_DATE('" + arg_current_yymm + "' )),-1,a.cost_amt,0)) cur_bef_mm_cost_amt,  " +
 "                sum(decode(to_char(a.yymm,'yyyy.mm.dd'),'" + arg_current_yymm + "',a.result_amt,0)) cur_mm_result_amt,       " +
 "                sum(decode(to_char(a.yymm,'yyyy.mm.dd'),'" + arg_current_yymm + "',a.cost_amt,0)) cur_mm_cost_amt            " +
 "             from c_spec_const_parent a,                                                                            " +
 "                  y_budget_parent b                                                                                 " +
 "             where a.dept_code = b.dept_code                                                                        " +
 "               and a.spec_no_seq = b.spec_no_seq                                                                    " +
 "               and a.dept_code = '" + arg_dept_code + "'                                                                     " +
 "               and b.sum_code = '01'                                                                                " +
 "               and a.yymm >= '" + arg_initial_year + "'                                                                      " +
 "               and a.yymm <= '" + arg_current_yymm + "'                                                                      " +
 "             group by a.dept_code) i,                                                                               " +
 "       (                                                                                                            " +
 "         select a.dept_code,                                                                                        " +
 "                sum(a.result_amt) cur_year_result_amt,                                                              " +
 "                sum(a.cost_amt) cur_year_cost_amt                                                                  " +
 "             from c_spec_const_parent a,                                                                            " +
 "                  y_budget_parent b                                                                                 " +
 "             where a.dept_code = b.dept_code                                                                        " +
 "               and a.spec_no_seq = b.spec_no_seq                                                                    " +
 "               and a.dept_code = '" + arg_dept_code + "'                                                                     " +
 "               and b.sum_code = '01'                                                                                " +
 "               and a.yymm >= '" + arg_initial_year + "'                                                                      " +
 "               and a.yymm <= '" + arg_last_year + "'                                                                         " +
 "             group by a.dept_code ) j,                                                                              " +
 "                                                                                                                    " +
 "        (                                                                                                           " +
 "         select a.dept_code,                                                                                        " +
 "                sum(a.cnt_amt) - sum(decode(to_char(a.yymm,'yyyy.mm.dd'),'" + arg_current_yymm + "',a.cnt_amt,0)) bef_tot_cnt_amt,                                                                     " +
 "                sum(decode(to_char(a.yymm,'yyyy.mm.dd'),'" + arg_current_yymm + "',a.cnt_amt,0)) cur_mm_cnt_amt              " +
 "            from c_cost_plan a                                                                                      " +
 "            where a.dept_code = '" + arg_dept_code + "'                                                                      " +
 "              and a.chg_no_seq = " + arg_chg_no_seq + " " + 
 "              and a.yymm <=  '" + arg_current_yymm + "'                                                                       " +
 "            group by a.dept_code  ) k,                                                                              " +
 "        (                                                                                                           " +
 "         select a.dept_code,                                                                                        " +
 "               sum(a.request_amt) + sum(a.request_vat) bef_tot_request_amt                                                               " +
 "            from c_progress_amt_parent a                                                                            " +
 "            where a.dept_code = '" + arg_dept_code + "'                                                                      " +
 "              and a.request_date < '" + arg_current_yymm + "'                                                                   " +
 "            group by a.dept_code ) l,                                                                               " +
 "        (                                                                                                           " +
 "          select a.dept_code,                                                                                       " +
 "               sum(a.request_amt) + sum(a.request_vat) cur_mm_request_amt                                                                " +
 "             from c_progress_amt_parent a                                                                           " +
 "             where a.dept_code = '" + arg_dept_code + "'                                                                     " +
 "               and a.request_date >= '" + arg_current_yymm + "'                                                              " +
 "               and a.request_date < '" + arg_next_yymm + "'                                                                  " +
 "             group by a.dept_code ) m,                                                                              " +
 "        (                                                                                                           " +
 "         select a.dept_code,                                                                                        " +
 "               sum(a.accept_amt) + sum(a.accept_vat) bef_tot_accept_amt                                                                 " +
 "            from c_progress_amt_detail a                                                                            " +
 "            where a.dept_code = '" + arg_dept_code + "'                                                                      " +
 "              and a.accept_date < '" + arg_current_yymm + "'                                                                    " +
 "              group by a.dept_code ) n,                                                                             " +
 "        (                                                                                                           " +
 "         select a.dept_code,                                                                                        " +
 "               sum(a.accept_amt) + sum(a.accept_vat) cur_mm_accept_amt                                                                 " +
 "            from c_progress_amt_detail a                                                                            " +
 "            where a.dept_code = '" + arg_dept_code + "'                                                                      " +
 "              and a.accept_date >= '" + arg_current_yymm + "'                                                                " +
 "              and a.accept_date < '" + arg_next_yymm + "'                                                                    " +
 "              group by a.dept_code ) o                                                                              " +
 "   where a.dept_code = b.dept_code (+)                                                                              " +
 "     and a.dept_code = c.dept_code (+)                                                                              " +
 "     and a.dept_code = d.dept_code (+)                                                                              " +
 "     and a.dept_code = e.dept_code (+)                                                                              " +
 "     and a.dept_code = f.dept_code (+)                                                                              " +
 "     and a.dept_code = g.dept_code (+)                                                                              " +
 "     and a.dept_code = h.dept_code (+)                                                                              " +
 "     and a.dept_code = i.dept_code (+)                                                                              " +
 "     and a.dept_code = j.dept_code (+)                                                                              " +
 "     and a.dept_code = k.dept_code (+)                                                                              " +
 "     and a.dept_code = l.dept_code (+)                                                                              " +
 "     and a.dept_code = m.dept_code (+)                                                                              " +
 "     and a.dept_code = n.dept_code (+)                                                                              " +
 "     and a.dept_code = o.dept_code (+)                                                                              " +
     "           ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>