<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-05-19)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(����)
	GauceDataSet dsMAIN = null;
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(��)
	//Dataset�� �������̸� �Ʒ� ��Ÿ���� �κ��� '//�������' ���� '//���糡' ������ ���� ���� �������� '//���⿡ �ٿ���������' �ڸ��� �ٿ���������
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
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
			dsMAIN = GauceInfo.request.getGauceDataSet("dsMAIN");
			
			if (dsMAIN == null) throw new Exception("dsMAIN��(��) ��(Null)�Դϴ�.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_DEPT_CODE_ORG2_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_SHORT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("GROUP_DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COST_DEPT_KND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("INPUT_DT_F", CITData.VARCHAR2);
						lrArgData.addColumn("INPUT_DT_T", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_GRP_CODE", CITData.NUMBER);
						lrArgData.addColumn("LEGA_DEPT", CITData.VARCHAR2);
						lrArgData.addColumn("SAUP_TAX_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_CLASS_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COST_CONV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("P_DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CLOSE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CLOST_DT_SYS", CITData.VARCHAR2);
						lrArgData.addColumn("CONS_AMT", CITData.NUMBER);
						lrArgData.addColumn("BUDG_AMT", CITData.NUMBER);
						lrArgData.addColumn("BUDG_APPL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("AS_AMT", CITData.NUMBER);
						lrArgData.addColumn("COST_DESC_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("COST_GUESS_AMT", CITData.NUMBER);
						lrArgData.addColumn("F_CONS_AMT", CITData.NUMBER);
						lrArgData.addColumn("F_BUDG_AMT", CITData.NUMBER);
						lrArgData.addColumn("CHARGE_PERS", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_MNG_OFFICE", CITData.VARCHAR2);
						lrArgData.addColumn("NP_PRT_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("DEPT_NAME", rows[i].getString(dsMAIN.indexOfColumn("DEPT_NAME")));
						lrArgData.setValue("DEPT_SHORT_NAME", rows[i].getString(dsMAIN.indexOfColumn("DEPT_SHORT_NAME")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("TAX_COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("TAX_COMP_CODE")));
						lrArgData.setValue("BUDG_CLS", rows[i].getString(dsMAIN.indexOfColumn("BUDG_CLS")));
						lrArgData.setValue("GROUP_DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("GROUP_DEPT_CODE")));
						lrArgData.setValue("COST_DEPT_KND_TAG", rows[i].getString(dsMAIN.indexOfColumn("COST_DEPT_KND_TAG")));
						lrArgData.setValue("INPUT_DT_F", rows[i].getString(dsMAIN.indexOfColumn("INPUT_DT_F")));
						lrArgData.setValue("INPUT_DT_T", rows[i].getString(dsMAIN.indexOfColumn("INPUT_DT_T")));
						lrArgData.setValue("ACC_GRP_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_GRP_CODE")));
						lrArgData.setValue("LEGA_DEPT", rows[i].getString(dsMAIN.indexOfColumn("LEGA_DEPT")));
						lrArgData.setValue("SAUP_TAX_TAG", rows[i].getString(dsMAIN.indexOfColumn("SAUP_TAX_TAG")));
						lrArgData.setValue("EMP_CLASS_CODE", rows[i].getString(dsMAIN.indexOfColumn("EMP_CLASS_CODE")));
						lrArgData.setValue("COST_CONV_CODE", rows[i].getString(dsMAIN.indexOfColumn("COST_CONV_CODE")));
						lrArgData.setValue("P_DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("P_DEPT_CODE")));
						lrArgData.setValue("DEPT_KIND_TAG", rows[i].getString(dsMAIN.indexOfColumn("DEPT_KIND_TAG")));
						lrArgData.setValue("ACC_CLOSE_DT", rows[i].getString(dsMAIN.indexOfColumn("ACC_CLOSE_DT")));
						lrArgData.setValue("ACC_CLOST_DT_SYS", rows[i].getString(dsMAIN.indexOfColumn("ACC_CLOST_DT_SYS")));
						lrArgData.setValue("CONS_AMT", rows[i].getString(dsMAIN.indexOfColumn("CONS_AMT")));
						lrArgData.setValue("BUDG_AMT", rows[i].getString(dsMAIN.indexOfColumn("BUDG_AMT")));
						lrArgData.setValue("BUDG_APPL_DT", rows[i].getString(dsMAIN.indexOfColumn("BUDG_APPL_DT")));
						lrArgData.setValue("AS_AMT", rows[i].getString(dsMAIN.indexOfColumn("AS_AMT")));
						lrArgData.setValue("COST_DESC_TAG", rows[i].getString(dsMAIN.indexOfColumn("COST_DESC_TAG")));
						lrArgData.setValue("COST_GUESS_AMT", rows[i].getString(dsMAIN.indexOfColumn("COST_GUESS_AMT")));
						lrArgData.setValue("F_CONS_AMT", rows[i].getString(dsMAIN.indexOfColumn("F_CONS_AMT")));
						lrArgData.setValue("F_BUDG_AMT", rows[i].getString(dsMAIN.indexOfColumn("F_BUDG_AMT")));
						lrArgData.setValue("CHARGE_PERS", rows[i].getString(dsMAIN.indexOfColumn("CHARGE_PERS")));
						lrArgData.setValue("TAX_MNG_OFFICE", rows[i].getString(dsMAIN.indexOfColumn("TAX_MNG_OFFICE")));
						lrArgData.setValue("NP_PRT_TAG", rows[i].getString(dsMAIN.indexOfColumn("NP_PRT_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_DEPT_CODE_ORG2_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_SHORT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("GROUP_DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COST_DEPT_KND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("INPUT_DT_F", CITData.VARCHAR2);
						lrArgData.addColumn("INPUT_DT_T", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_GRP_CODE", CITData.NUMBER);
						lrArgData.addColumn("LEGA_DEPT", CITData.VARCHAR2);
						lrArgData.addColumn("SAUP_TAX_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_CLASS_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COST_CONV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("P_DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CLOSE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CLOST_DT_SYS", CITData.VARCHAR2);
						lrArgData.addColumn("CONS_AMT", CITData.NUMBER);
						lrArgData.addColumn("BUDG_AMT", CITData.NUMBER);
						lrArgData.addColumn("BUDG_APPL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("AS_AMT", CITData.NUMBER);
						lrArgData.addColumn("COST_DESC_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("COST_GUESS_AMT", CITData.NUMBER);
						lrArgData.addColumn("F_CONS_AMT", CITData.NUMBER);
						lrArgData.addColumn("F_BUDG_AMT", CITData.NUMBER);
						lrArgData.addColumn("CHARGE_PERS", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_MNG_OFFICE", CITData.VARCHAR2);
						lrArgData.addColumn("NP_PRT_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("DEPT_NAME", rows[i].getString(dsMAIN.indexOfColumn("DEPT_NAME")));
						lrArgData.setValue("DEPT_SHORT_NAME", rows[i].getString(dsMAIN.indexOfColumn("DEPT_SHORT_NAME")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("TAX_COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("TAX_COMP_CODE")));
						lrArgData.setValue("BUDG_CLS", rows[i].getString(dsMAIN.indexOfColumn("BUDG_CLS")));
						lrArgData.setValue("GROUP_DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("GROUP_DEPT_CODE")));
						lrArgData.setValue("COST_DEPT_KND_TAG", rows[i].getString(dsMAIN.indexOfColumn("COST_DEPT_KND_TAG")));
						lrArgData.setValue("INPUT_DT_F", rows[i].getString(dsMAIN.indexOfColumn("INPUT_DT_F")));
						lrArgData.setValue("INPUT_DT_T", rows[i].getString(dsMAIN.indexOfColumn("INPUT_DT_T")));
						lrArgData.setValue("ACC_GRP_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_GRP_CODE")));
						lrArgData.setValue("LEGA_DEPT", rows[i].getString(dsMAIN.indexOfColumn("LEGA_DEPT")));
						lrArgData.setValue("SAUP_TAX_TAG", rows[i].getString(dsMAIN.indexOfColumn("SAUP_TAX_TAG")));
						lrArgData.setValue("EMP_CLASS_CODE", rows[i].getString(dsMAIN.indexOfColumn("EMP_CLASS_CODE")));
						lrArgData.setValue("COST_CONV_CODE", rows[i].getString(dsMAIN.indexOfColumn("COST_CONV_CODE")));
						lrArgData.setValue("P_DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("P_DEPT_CODE")));
						lrArgData.setValue("DEPT_KIND_TAG", rows[i].getString(dsMAIN.indexOfColumn("DEPT_KIND_TAG")));
						lrArgData.setValue("ACC_CLOSE_DT", rows[i].getString(dsMAIN.indexOfColumn("ACC_CLOSE_DT")));
						lrArgData.setValue("ACC_CLOST_DT_SYS", rows[i].getString(dsMAIN.indexOfColumn("ACC_CLOST_DT_SYS")));
						lrArgData.setValue("CONS_AMT", rows[i].getString(dsMAIN.indexOfColumn("CONS_AMT")));
						lrArgData.setValue("BUDG_AMT", rows[i].getString(dsMAIN.indexOfColumn("BUDG_AMT")));
						lrArgData.setValue("BUDG_APPL_DT", rows[i].getString(dsMAIN.indexOfColumn("BUDG_APPL_DT")));
						lrArgData.setValue("AS_AMT", rows[i].getString(dsMAIN.indexOfColumn("AS_AMT")));
						lrArgData.setValue("COST_DESC_TAG", rows[i].getString(dsMAIN.indexOfColumn("COST_DESC_TAG")));
						lrArgData.setValue("COST_GUESS_AMT", rows[i].getString(dsMAIN.indexOfColumn("COST_GUESS_AMT")));
						lrArgData.setValue("F_CONS_AMT", rows[i].getString(dsMAIN.indexOfColumn("F_CONS_AMT")));
						lrArgData.setValue("F_BUDG_AMT", rows[i].getString(dsMAIN.indexOfColumn("F_BUDG_AMT")));
						lrArgData.setValue("CHARGE_PERS", rows[i].getString(dsMAIN.indexOfColumn("CHARGE_PERS")));
						lrArgData.setValue("TAX_MNG_OFFICE", rows[i].getString(dsMAIN.indexOfColumn("TAX_MNG_OFFICE")));
						lrArgData.setValue("NP_PRT_TAG", rows[i].getString(dsMAIN.indexOfColumn("NP_PRT_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_DEPT_CODE_ORG2_D(?)}";
						
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_DEPT_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
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