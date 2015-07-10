<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_order_number  = req.getParameter("arg_order_number");
     String arg_degree = req.getParameter("arg_degree");
     String arg_date = req.getParameter("arg_date");
     String arg_sbcr = req.getParameter("arg_sbcr");
     String arg_const_no = arg_order_number;
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("con_add_doc_id",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cst_doc_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("mod_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("file_map_id",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("unique_file_name",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("file_path",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("file_ext",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("file_size",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("file_name",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("mine_type",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("contents_type",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("contents_disp",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("sub_mine_type",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("hash_val",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("auto_cre_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cst_info_id",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cre_by",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cre_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("upd_by",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("upd_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("bonsa_sign_val",GauceDataColumn.TB_STRING,3000));
     dSet.addDataColumn(new GauceDataColumn("corp_sign_val",GauceDataColumn.TB_STRING,3000));
     dSet.addDataColumn(new GauceDataColumn("cdir",GauceDataColumn.TB_URL,255));
     dSet.addDataColumn(new GauceDataColumn("temp1",GauceDataColumn.TB_STRING,1500));
     dSet.addDataColumn(new GauceDataColumn("temp2",GauceDataColumn.TB_STRING,1500));
    String query = "  SELECT  con_add_doc_id ," + 
					    "          dept_code ," + 
					    "          cst_doc_no ," + 
					    "          mod_no ," + 
					    "          nvl(file_map_id,0) file_map_id ," + 
					    "          unique_file_name ," + 
					    "          file_path ," + 
					    "          file_ext ," + 
					    "          nvl(file_size,0) file_size ," + 
					    "          file_name ," + 
					    "          mine_type ," + 
					    "          contents_type ," + 
					    "          contents_disp ," + 
					    "          sub_mine_type ," + 
					    "          hash_val ," + 
					    "          auto_cre_yn ," + 
					    "          nvl(cst_info_id,0) cst_info_id ," + 
					    "          cre_by ," + 
					    "          to_char(cre_date,'YYYY.MM.DD') cre_date ," + 
					    "          upd_by ," + 
					    "          to_char(upd_date,'YYYY.MM.DD') upd_date  , " +
					    "          bonsa_sign_val, " +
					    "          corp_sign_val, " +
					    "          ''    cdir ," +
					    "          ''    temp1," +
					    "          ''    temp2 " +
					    "     FROM s_const_add_file  " +
					    "    WHERE DEPT_CODE = '" + arg_dept + "'" +
					    "      and CST_DOC_NO = '" + arg_const_no + "'" +
					    "      and MOD_NO = " + arg_degree +
					    "      and cre_date = '" + arg_date + "'" +
					    "      and cre_by= '" + arg_sbcr + "'" +
					    " ORDER BY con_add_doc_id          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>