<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("key",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("old_key",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("��ǥ����",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("��ǥ����",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("����_������Ī",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("����_�����ڵ�",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("�뺯_������Ī",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("�뺯_�����ڵ�",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  key , key old_key," + 
     "          ��ǥ����, "+
	 "          ��ǥ����, "+
	 "          ����_������Ī, "+
	 "          ����_�����ڵ�, "+
	 "          �뺯_������Ī, "+
	 "          �뺯_�����ڵ� "+
	 "	 FROM h_slip_acc_code_table         " + 
     "          ORDER BY key         " ;  
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>