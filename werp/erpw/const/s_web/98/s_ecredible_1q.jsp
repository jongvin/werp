<%@ page contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
	String arg_resno = req.getParameter("resno");
 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("����ſ���",GauceDataColumn.TB_STRING,10,0));
	dSet.addDataColumn(new GauceDataColumn("�����帧���",GauceDataColumn.TB_STRING,10,0));
	dSet.addDataColumn(new GauceDataColumn("WATCH���",GauceDataColumn.TB_STRING,10,0));
	dSet.addDataColumn(new GauceDataColumn("WATCH������",GauceDataColumn.TB_STRING,8,0));
	dSet.addDataColumn(new GauceDataColumn("���س����",GauceDataColumn.TB_STRING,8,0));
	dSet.addDataColumn(new GauceDataColumn("����ں���",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("��������ڻ�",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("���������ä",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("����ں��Ѱ�",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("�����ں���",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("���������ڻ�",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("����������ä",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("�����ں��Ѱ�",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("�������ں���",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("�����������ڻ�",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("������������ä",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("�������ں��Ѱ�",GauceDataColumn.TB_DECIMAL,18,0));

	dSet.addDataColumn(new GauceDataColumn("�������",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("��������",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("����������",GauceDataColumn.TB_DECIMAL,18,0));

	dSet.addDataColumn(new GauceDataColumn("��������",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("���������",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("�����������",GauceDataColumn.TB_DECIMAL,18,0));

	dSet.addDataColumn(new GauceDataColumn("�������ä����",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("�����ä����",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("����ä����",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("����������������",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("��������������",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("�������������",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("�����������������",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("���������������",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("��������������",GauceDataColumn.TB_DECIMAL,18,1));

    String query = " " +
			" SELECT" +
			" 	CC.LASTGRD2 ����ſ���," +
			" 	DD.DECISION �����帧���," +
			" 	EE.FWATCHD WATCH���," +
			" 	EE.FDGBYIL WATCH������," +

			" 	'20' || AA.���س���� ���س����," +

			" 	AA.����ں���," +
			"	AA.��������ڻ�," +
			"	AA.���������ä," +
			"	AA.����ں��Ѱ�," +
			 
			"	AA.�����ں���," +
			"	AA.���������ڻ�," +
			"	AA.����������ä," +
			"	AA.�����ں��Ѱ�," +
			 
			"	AA.�������ں���," +
			"	AA.�����������ڻ�," +
			"	AA.������������ä," +
			"	AA.�������ں��Ѱ�," +

			"	FF.�������," +
			"	FF.��������," +
			"	FF.����������," +

			"	FF.��������," +
			"	FF.���������," +
			"	FF.�����������," +

			" 	BB.TR0051 �������ä����," +
			" 	BB.TR0052 �����ä����," +
			" 	BB.TR0053 ����ä����," +

			" 	BB.TR0221 ����������������," +
			" 	BB.TR0222 ��������������," +
			" 	BB.TR0223 �������������," +

			" 	BB.TR0231 �����������������," +
			" 	BB.TR0232 ���������������," +
			" 	BB.TR0233 ��������������" +
			" FROM" +
			"	(" +
			"	 SELECT" +
			"     	B.SUVDT," +
			"     	B.RESNO," +
			"     	MAX(A.BS_ESETDT) ���س����," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0000' THEN A.BS0092 ELSE 0 END) ����ں���," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0000' THEN A.BS0001 ELSE 0 END) ��������ڻ�," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0000' THEN A.BS0060 ELSE 0 END) ���������ä," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0000' THEN A.BS0113 ELSE 0 END) ����ں��Ѱ�," +

			"     	SUM(CASE WHEN A.TRANSEQ = '0001' THEN A.BS0092 ELSE 0 END) �����ں���," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0001' THEN A.BS0001 ELSE 0 END) ���������ڻ�," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0001' THEN A.BS0060 ELSE 0 END) ����������ä," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0001' THEN A.BS0113 ELSE 0 END) �����ں��Ѱ�," +

			"     	SUM(CASE WHEN A.TRANSEQ = '0002' THEN A.BS0092 ELSE 0 END) �������ں���," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0002' THEN A.BS0001 ELSE 0 END) �����������ڻ�," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0002' THEN A.BS0060 ELSE 0 END) ������������ä," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0002' THEN A.BS0113 ELSE 0 END) �������ں��Ѱ�" +
			"     FROM" +
			"     	(SELECT MAX(SUVDT) SUVDT, RESNO FROM DCC_PACKET01 GROUP BY RESNO) B," +
			"     	DCC_PACKET06 A" +
			"     WHERE" +
			"     	A.SUVDT(+) = B.SUVDT AND A.RESNO(+) = B.RESNO" +
			"     AND A.RESNO = '" + arg_resno + "'" +
			"     GROUP BY" +
			"     	B.SUVDT, B.RESNO" +
			" 	) AA," +
			" 	DCC_PACKET10 BB," +
			" 	DCC_PACKET01 CC," +
			" 	DCC_PACKET11 DD," +
			" 	(" +
			" 	SELECT A.* FROM WATCH_GRADE A, (SELECT RESNO,MAX(FDGBYIL) FDGBYIL FROM WATCH_GRADE GROUP BY RESNO) B WHERE A.RESNO = B.RESNO AND A.FDGBYIL = B.FDGBYIL" +
			" 	) EE," +
			"	(" +
			"	SELECT" +
			" 		A.SUVDT," +
			" 		A.RESNO," +

			" 		SUM(CASE WHEN A.TRANSEQ = '0000' THEN A.PL0001 ELSE 0 END) �������," +
			" 		SUM(CASE WHEN A.TRANSEQ = '0001' THEN A.PL0001 ELSE 0 END) ��������," +
			" 		SUM(CASE WHEN A.TRANSEQ = '0003' THEN A.PL0001 ELSE 0 END) ����������," +

			" 		SUM(CASE WHEN A.TRANSEQ = '0000' THEN A.PL0071 ELSE 0 END) ��������," +
			" 		SUM(CASE WHEN A.TRANSEQ = '0001' THEN A.PL0071 ELSE 0 END) ���������," +
			" 		SUM(CASE WHEN A.TRANSEQ = '0003' THEN A.PL0071 ELSE 0 END) �����������" +
			"	FROM" +
			" 		DCC_PACKET07 A" +
			"	GROUP BY" +
			" 		A.SUVDT," +
			" 		A.RESNO" +
			"	) FF" +
	
			" WHERE" +
			" 	AA.SUVDT = BB.SUVDT(+) AND AA.RESNO = BB.RESNO(+)" +
			" AND AA.SUVDT = CC.SUVDT(+) AND AA.RESNO = CC.RESNO(+)" +
			" AND AA.SUVDT = DD.SUVDT(+) AND AA.RESNO = DD.RESNO(+)" +
			" AND AA.RESNO = EE.RESNO(+)" +
			" AND AA.SUVDT = FF.SUVDT(+) AND AA.RESNO = FF.RESNO(+)" ;


%><%@ include file="../../../comm_function/conn_q_end.jsp"%>