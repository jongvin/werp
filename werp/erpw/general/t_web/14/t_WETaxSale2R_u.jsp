<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*, com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy, jxl.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : �����  �ۼ�(2006-03-31)
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

					strSql = "{call SP_T_WT_SALE_ITEM_D()}";
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
					
					for(int i=0;i<nRows;i++)
					{
						//Ÿ��Ʋ...
						if(i==0) continue;
						arrCell = sheet.getRow(i);

						//cell = arrCell[j];
						//arrCell[0].getContents()  //������ȣ
						//arrCell[1].getContents()  //�ۼ���
						//arrCell[2].getContents()  //���޹޴��ڻ����ȣ
						//arrCell[3].getContents()  //���޹޴��ڴ���ڻ��
						//arrCell[4].getContents()  //���ݰ�꼭���						
						//arrCell[5].getContents()  //�ŷ�����
						//arrCell[6].getContents()  //��ǰ��
						//arrCell[7].getContents()  //����
						//arrCell[8].getContents()  //����
						//arrCell[9].getContents() //�ܰ�
						//arrCell[10].getContents() //���ް�
						//arrCell[11].getContents() //����
						//arrCell[12].getContents() //���
						out.println("eee"+arrCell[0].getContents()+"dd");

						if(
							"".equals(""+arrCell[0].getContents()) ||
							"".equals(""+arrCell[1].getContents())
						)
						{
							strErrMsg = ""+(i+1)+"��°�࿡ ������ �÷��� �����մϴ�.";
							throw new Exception(strErrMsg);
						}

						lrArgData = new CITData();
						strSql = "{call SP_T_WT_SALE_ITEM_I(?,'',?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("TAX_GENDATE", 	CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NAME", 		CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_UNIT", 		CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NUM", 		CITData.NUMBER);
						lrArgData.addColumn("ITEM_DANGA", 	CITData.NUMBER);
						lrArgData.addColumn("TAX_SUPPRICE", CITData.NUMBER);
						lrArgData.addColumn("TAX_TAXPRICE", CITData.NUMBER);
						lrArgData.addColumn("ITEM_BIGO", 		CITData.VARCHAR2);
						lrArgData.addColumn("DOC_NUMBER", 	CITData.VARCHAR2);
						lrArgData.addColumn("GEN_TM", 			CITData.VARCHAR2);
						lrArgData.addColumn("BUY_REGNUM", 	CITData.VARCHAR2);
						lrArgData.addColumn("BUY_EMPID", 		CITData.VARCHAR2);
						lrArgData.addColumn("TAX_BIGO", 		CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("TAX_GENDATE", 	arrCell[5].getContents().trim());
						lrArgData.setValue("ITEM_NAME", 		arrCell[6].getContents().trim());
						lrArgData.setValue("ITEM_UNIT", 		arrCell[7].getContents().trim());
						lrArgData.setValue("ITEM_NUM", 			arrCell[8].getContents().trim());
						lrArgData.setValue("ITEM_DANGA", 		arrCell[9].getContents().trim());
						lrArgData.setValue("TAX_SUPPRICE", 	arrCell[10].getContents().trim());
						lrArgData.setValue("TAX_TAXPRICE", 	arrCell[11].getContents().trim());
						lrArgData.setValue("ITEM_BIGO", 		arrCell[12].getContents().trim());
						lrArgData.setValue("DOC_NUMBER", 		arrCell[0].getContents().trim());
						lrArgData.setValue("GEN_TM", 				arrCell[1].getContents().trim());						
						lrArgData.setValue("BUY_REGNUM", 		arrCell[2].getContents().trim());
						lrArgData.setValue("BUY_EMPID", 		arrCell[3].getContents().trim());
						lrArgData.setValue("TAX_BIGO", 			arrCell[4].getContents().trim());

						CITDatabase.executeProcedure(strSql, lrArgData, conn);
					}
					conn.commit();

					workbook.close();

					f.delete();
				}

			} catch (Exception ex) {
				//conn.commit();
				if("".equals(strErrMsg) ) strErrMsg = "�ε�� ������ �߻��Ͽ����ϴ�. ���� ������ �ǹٸ��� Ȯ���� �ֽʽÿ�.";
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
//	parent.gridSUB01.focus();
//	parent.btnquery_onclick();
<%
			}
%>
</script>
<%
		}
%>
