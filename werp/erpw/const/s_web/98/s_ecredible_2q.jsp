<%@ page contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
	String arg_resno = req.getParameter("resno");
 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("���س⵵",GauceDataColumn.TB_STRING,8,0));
	dSet.addDataColumn(new GauceDataColumn("��������",GauceDataColumn.TB_STRING,50,0));
	dSet.addDataColumn(new GauceDataColumn("�����ȣ",GauceDataColumn.TB_STRING,50,0));
	dSet.addDataColumn(new GauceDataColumn("�ð��ɷ��򰡾�",GauceDataColumn.TB_DECIMAL,8,0));
	dSet.addDataColumn(new GauceDataColumn("��������",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("����������ü",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("��������",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("����������ü",GauceDataColumn.TB_DECIMAL,18,0));

    String query = " " +
					" SELECT" +
					" 	CONABYR ���س⵵," +
					" 	CONUPJN ��������," +
					" 	CONUPNM �����ȣ," +
					" 	CONABMN �ð��ɷ��򰡾�," +
					" 	CLCABRK ��������," +
					" 	CLCABST ����������ü," +
					" 	CWCABRK ��������," +
					" 	CWCABST ����������ü" +
					" FROM" +
					" 	CNT_PACKET03" +
					" WHERE" +
					" 	RESNO = '" + arg_resno + "'" +
					" ORDER BY" +
					" 	CONUPJN, CONABYR DESC";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>