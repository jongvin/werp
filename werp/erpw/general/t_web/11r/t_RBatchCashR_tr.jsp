<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(����)
	GauceDataSet dsPARAM = null;
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(��)
	//Dataset�� �������̸� �Ʒ� ��Ÿ���� �κ��� '//�������' ���� '//���糡' ������ ���� ���� �������� '//���⿡ �ٿ���������' �ڸ��� �ٿ���������
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	CITData lrArgData;
	Connection conn = null;
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* �������� */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if (CITCommon.isNull(strAct))
		{
	//�������
			dsPARAM = GauceInfo.request.getGauceDataSet("dsPARAM");
			
			if (dsPARAM == null) throw new Exception("dsPARAM��(��) ��(Null)�Դϴ�.");
			
			rows = dsPARAM.getDataRows();
			
			try
			{
				lrArgData = new CITData();
				
				strSql = "{call SP_T_FB_REPORT_TARGET2_ALL_D(?)}";
				
				lrArgData.addColumn("CREATION_EMP_NO", CITData.VARCHAR2);

				lrArgData.addRow();
				lrArgData.setValue("CREATION_EMP_NO", strUserNo);
				
				CITDatabase.executeProcedure(strSql, lrArgData, conn);
				for	(int i = 0;	i <	rows.length; i++)
				{
					lrArgData = new CITData();
					
					strSql = "{call SP_T_FB_REPORT_TARGET2_I(?,?)}";
					
					lrArgData.addColumn("CREATION_EMP_NO", CITData.VARCHAR2);
					lrArgData.addColumn("PAY_SEQ", CITData.NUMBER);

					lrArgData.addRow();
					lrArgData.setValue("CREATION_EMP_NO", strUserNo);
					lrArgData.setValue("PAY_SEQ", rows[i].getString(dsPARAM.indexOfColumn("PAY_SEQ")));
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_FB_REPORT_TARGET1 ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//���糡
	//���⿡ �ٿ���������
		}
		conn.commit();
	}
	catch (Exception ex)
	{
		if (conn != null) conn.rollback();
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "������ �ʱ�ȭ ���� -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITConnectionManager.freeConnection(conn);
			CITCommon.finalServerPage(GauceInfo);
		}
	    catch (Exception ex)
	    {
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
	    	GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
	    }
	}
%>
