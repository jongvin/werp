<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
	String arg_acntname = req.getParameter("arg_acntname") + "%";
	String arg_gubn = req.getParameter("arg_gubn");
 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("account_code",GauceDataColumn.TB_STRING,8));
	dSet.addDataColumn(new GauceDataColumn("account_name",GauceDataColumn.TB_STRING,30));
	String query = "  SELECT  account_code ," + 
	"         		      account_name  " + 
	"         		 FROM efin_accounts_v " +
	"               where enabled_flag = 'Y'" +
	"                 and summary_flag = 'N'" +
	"                 and hierarchy_level = 6 ";
	query = query +  "and account_code not LIKE '155%' "; //�����ڻ�
	query = query +  "and (account_code not LIKE '9%' or account_code = '915100') "; //ũ���\
	query = query +  "and account_code not LIKE  '1153%' "; //���, ������
	query = query +  "and account_code <> '711111' "; //����
	query = query +  "and account_code <> '743411' "; //��)������շ�
	query = query +  "and account_code <> '793111' "; //����(������ü)
	query = query +  "and account_code <> '151511' "; //��⼱�޺��
    query = query +  "and account_code <> '112311' "; //���޺��

	if (arg_gubn.equals("1"))
		query = query + "  and account_code like " + "'" + arg_acntname + "%'";
	else
		query = query + "  and account_name like " + "'%" + arg_acntname + "%'";
	query = query + " order by account_code asc       " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%> 