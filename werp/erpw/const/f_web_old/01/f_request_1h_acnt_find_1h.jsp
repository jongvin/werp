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
	query = query +  "and (account_code not LIKE '9%' or account_code = '915100' or account_code = '911070' or account_code = '911071' " +
	                      "or account_code = '911082' or account_code = '911083' or account_code = '911084' " +
						  "or account_code = '911085') "; //ũ���
	query = query +  "and account_code not LIKE  '1153%' "; //���, ������
	query = query +  "and account_code <> '711111' and account_code <> '947010' "; //����

	query = query +  "and account_code <> '743411' "; //��)������շ�
	query = query +  "and account_code <> '793111' "; //����(������ü)
	query = query +  "and account_code <> '151511' "; //��⼱�޺��
	query = query +  "and account_code <> '111114' "; //������(���뿹��)
	query = query +  "and account_code <> '111113' "; //�̼���
	query = query +  "and account_code NOT LIKE '1116%' "; //�̼���
	query = query +  "and account_code NOT LIKE '1117%' "; //�̼���
	query = query +  "and (account_code NOT LIKE '1118%' Or account_code = '111829') "; //�̼���
	query = query +  "and account_code NOT LIKE '1121%' "; //�̼���
	query = query +  "and account_code NOT LIKE '151%' "; //������
	query = query +  "and account_code <> '112711' and account_code <> '251511' "; //��ġ������
	query = query +  "and account_code NOT LIKE '1115%' "; //�뿩��

//�̽����
	query = query +  "and account_code NOT BETWEEN '111311' AND '111339' "; //��������
	query = query +  "and account_code <> '111511' "; //�ܱ�뿩��
	query = query +  "and account_code <> '112711' "; //��ġ������
	query = query +  "and account_code <> '151411' "; //������
	query = query +  "and account_code <> '151412' "; //����������
	query = query +  "and account_code NOT BETWEEN '151451' AND '151479' "; //����������
	query = query +  "and account_code <> '731119' "; //���ֺ�(��Ÿ)
	query = query +  "and account_code <> '741312' "; //��)����������(M/H)
	query = query +  "and account_code NOT BETWEEN '741711' AND '741713' "; //��)������(������ߺ�)
	//query = query +  "and account_code NOT BETWEEN '742611' AND '742615' "; //��)�ߺ���
	query = query +  "and account_code <> '743112' "; //��)�����(��)
	query = query +  "and account_code NOT BETWEEN '743211' AND '743213' "; //��)���谨����
	query = query +  "and account_code NOT BETWEEN '743516' AND '743519' "; //��)����δ��
	query = query +  "and account_code NOT BETWEEN '743711' AND '743715' "; //��)���ں��
	query = query +  "and account_code NOT BETWEEN '744111' AND '744113' "; //��)��������
	query = query +  "and account_code <> '744211' "; //��)����Ȱ����
	query = query +  "and account_code <> '744411' "; //��)������
	
	if (arg_gubn.equals("1"))
		query = query + "  and account_code like " + "'" + arg_acntname + "%'";
	else
		query = query + "  and account_name like " + "'%" + arg_acntname + "%'";
	query = query + " order by account_code asc       " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%> 