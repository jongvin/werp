<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_year = req.getParameter("arg_year");
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
     String arg_seq_num = req.getParameter("arg_seq_num");
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymmdd = req.getParameter("arg_yymmdd");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("d_seq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("rent_section",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_section",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("unitcost",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("standard_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("loss_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("comp_chk",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT to_char(a.year,'YYYY.MM.DD')  year,  " + 
                   "         a.sbcr_code,   " + 
                   "         a.seq_num,   " + 
                   "         a.d_seq_num,   " + 
                   "         a.mtrcode,   " + 
                   "         a.name,   " + 
                   "         a.ssize,   " + 
                   "         a.unitcode,   " + 
                   "         a.rent_section,   " + 
                   "         a.input_section,   " + 
                   "         a.unitcost,   " + 
                   "         a.standard_amt,   " + 
                   "         a.loss_amt,   " + 
                   "         a.remark,   " + 
                   "         b.ditag, " +
                   "         0        input_qty, " +
                   "         ''           comp_chk " +
                   "    FROM m_price_contract_detail a,  " + 
                   "         m_code_material b " +
                   "   WHERE a.mtrcode = b.mtrcode (+) " +
                   "     and a.year = '" + arg_year + "'" + 
                   "     and a.sbcr_code = '" + arg_sbcr_code + "'" +
                   "     and a.seq_num = " + arg_seq_num +
                   "     and a.mtrcode not in ( select mtrcode " + 
                   "                              from m_input_detail " +
                   "                             where dept_code = '" + arg_dept_code + "'" +
                   "                               and yymmdd = '" + arg_yymmdd + "'" +
                   "                               and seq = " + arg_seq + ") " +
                   " order by a.d_seq_num asc " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>