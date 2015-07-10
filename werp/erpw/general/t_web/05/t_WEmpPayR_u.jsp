<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*, com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy, jxl.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(����)
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(��)
	//Dataset�� �������̸� �Ʒ� ��Ÿ���� �κ��� '//�������' ���� '//���糡' ������ ���� ���� �������� '//���⿡ �ٿ���������' �ڸ��� �ٿ���������
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	Connection conn = null;

	String strErrMsg = "";
	

		/* �������� */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (CITCommon.isNull(strAct))
		{
	//�������

	//���糡
	//�������

	//���糡
	//���⿡ �ٿ���������
		}
		else if (strAct.equals("FILE"))
		{
			try
			{
				String	strWORK_SEQ = CITCommon.toKOR(request.getParameter("WORK_SEQ"));
				String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
				String	strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
				String	strSEQ = null;

				/* �������� */
				String strUserN0 = CITCommon.toKOR((String)session.getAttribute("user_no"));
				conn = CITConnectionManager.getConnection(false);

				String savePath = request.getRealPath("/");
				int sizeLimit = 50 * 1024 * 1024; //

				MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit);
				Enumeration files = multi.getFileNames();
				String fname = (String)files.nextElement();
				String filename = multi.getFilesystemName(fname);
				File f = multi.getFile(fname);

				int nRows = 0;

				if (f != null) {
					Workbook workbook = Workbook.getWorkbook(f);
					Sheet sheet = workbook.getSheet(0);

					nRows = sheet.getRows();
					Cell[] arrCell = null;
					Cell cell = null;
					String cellText = null;
					CITData lrReturnData = new CITData();
					CITData lrArgData = new CITData();

					for(int i=0;i<nRows;i++)
					{
						//Ÿ��Ʋ...
						if(i==0) continue;
						arrCell = sheet.getRow(i);

						//cell = arrCell[j];
						//arrCell[0].getContents() //�Աݰ���
						//arrCell[1].getContents() //����
						//arrCell[2].getContents() //�����ܾ�
						//arrCell[3].getContents() //�Ѵ����
						//arrCell[4].getContents() //��������
						//arrCell[5].getContents() //��
						//arrCell[6].getContents() //ȣ
						//out.println("eee"+arrCell[0].getContents()+"dd");

						if(
							"".equals(""+arrCell[0].getContents()) ||
							"".equals(""+arrCell[1].getContents())
						)
						{
						}
						else
						{
							lrArgData = new CITData();
							strSql   = " Select SQ_T_EMP_PAY_LIST_SEQ.NextVal SEQ From Dual \n";
	
							lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
	
							if (lrReturnData.getRowsCount() > 0)
							{
								strSEQ		= lrReturnData.toString(0,"SEQ");
							}
							else
							{
							}
	
							lrArgData = new CITData();
							strSql = "{call SP_T_FIN_EMP_PAY_LIST_I(?,?,?,?,?,?,?,?,?,?,?,?)}";
							
							lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
							lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
							lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
							lrArgData.addColumn("SEQ", CITData.NUMBER);
							lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
							lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
							lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
							lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
							lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
							lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
							lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
							lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
	
							lrArgData.addRow();
							lrArgData.setValue("WORK_SEQ", strWORK_SEQ);
							lrArgData.setValue("COMP_CODE", strCOMP_CODE);
							lrArgData.setValue("WORK_DT", strWORK_DT);
							lrArgData.setValue("SEQ", strSEQ);
							lrArgData.setValue("CRTUSERNO", strUserNo);
							lrArgData.setValue("EMP_NO", arrCell[0].getContents().trim());
							lrArgData.setValue("EXEC_AMT", arrCell[1].getContents().trim());
							lrArgData.setValue("IN_ACC_NO", "");
							lrArgData.setValue("IN_BANK_MAIN_CODE", "");
							lrArgData.setValue("ACCNO_OWNER", "");
							lrArgData.setValue("SLIP_ID", "");
							lrArgData.setValue("SLIP_IDSEQ", "");
	
							CITDatabase.executeProcedure(strSql, lrArgData, conn);
						}


					}
					conn.commit();

					workbook.close();

					f.delete();
				}

			} catch (Exception ex) {
				//conn.commit();
				if("".equals(strErrMsg) ) strErrMsg = "�ε�� ������ �߻��Ͽ����ϴ�. ���� ������ �ǹٸ��� Ȯ���� �ֽʽÿ�."+ex.getMessage();
				if (conn != null){
					conn.rollback();
				}
				//throw new Exception("SYS-100002:������ ���� ���� -> " + ex.getMessage());
			}
			finally
			{
				try
				{
					if (conn != null){
						conn.close();
					}
				}
				catch (Exception ex)
				{
				}
			}

%>
<script language="javascript">
<%
			if( !"".equals(strErrMsg) ) {
%>
	parent.C_msgOk("<%=strErrMsg%>","Ȯ��");
<%
			} else {
%>
	parent.C_msgOk("���������� �ε�Ǿ����ϴ�.","Ȯ��");
	parent.gridSUB01.focus();
	parent.btnquery_onclick();
<%
			}
%>
</script>
<%
		}
%>
