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
	query = query +  "and( account_code BETWEEN '111311' AND '111339' "; //��������
	query = query +  "Or account_code = '111511' "; //�ܱ�뿩��
	query = query +  "Or account_code = '112711' "; //��ġ������
	query = query +  "Or account_code = '151411' "; //������
	query = query +  "Or account_code = '151412' "; //����������
	query = query +  "Or account_code  BETWEEN '151451' AND '151479' "; //����������
	query = query +  "Or account_code = '731119' "; //���ֺ�(��Ÿ)
	query = query +  "Or account_code = '741312' "; //��)����������(M/H)
	query = query +  "Or account_code  BETWEEN '741711' AND '741713' "; //��)������(������ߺ�)
	query = query +  "Or account_code  BETWEEN '742611' AND '742615' "; //��)�ߺ���
	query = query +  "Or account_code = '743112' "; //��)�����(��)
	query = query +  "Or account_code  BETWEEN '743211' AND '743213' "; //��)���谨����
	query = query +  "Or account_code  BETWEEN '743516' AND '743519' "; //��)����δ��
	query = query +  "Or account_code  BETWEEN '743711' AND '743715' "; //��)���ں��
	query = query +  "Or account_code  BETWEEN '744111' AND '744113' "; //��)��������
	query = query +  "Or account_code = '744211' "; //��)����Ȱ����
	query = query +  "Or account_code = '744411' "; //��)������
	query = query +  "Or account_code Like '2118%' "; //������
	query = query +  "Or account_code = '151322' "; //�ŵ�����ä��
	query = query +  "Or account_code = '461114' "; //�ŵ�����ä��(����)
	query = query +  "Or account_code IN ('472211','472213','472219') "; //��α�

	query = query +  ")";
	

	if (arg_gubn.equals("1"))
		query = query + "  and account_code like " + "'" + arg_acntname + "%'";
	else
		query = query + "  and account_name like " + "'%" + arg_acntname + "%'";
	query = query + " order by account_code asc       " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%> 