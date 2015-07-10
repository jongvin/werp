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
				String	strCOM_ID = CITCommon.toKOR(request.getParameter("COM_ID"));

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
						//arrCell[0].getContents() //��ǰ�ڵ�
						//arrCell[1].getContents() //��ǰ��
						//arrCell[2].getContents() //��ǰSIZE
						//out.println("eee"+arrCell[0].getContents()+"dd");

						if(
							"".equals(""+arrCell[0].getContents()) ||
							"".equals(""+arrCell[1].getContents())
						)
						{
							strErrMsg = ""+(i+1)+"��°�࿡ ������ �÷��� �����մϴ�.";
							throw new Exception(strErrMsg);
						}

						lrArgData = new CITData();
						strSql = "{call SP_TB_WT_ITEM_I(?,?,?,?,?)}";
						
						
						lrArgData.addColumn("COM_ID", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", CITData.NUMBER);
						lrArgData.addColumn("ITEM_NAME", CITData.NUMBER);
						lrArgData.addColumn("ITEM_SIZE", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COM_ID", strCOM_ID);
						lrArgData.setValue("ITEM_CODE", arrCell[0].getContents().trim());
						lrArgData.setValue("ITEM_NAME", arrCell[1].getContents().trim());
						lrArgData.setValue("ITEM_SIZE", arrCell[2].getContents().trim());
						lrArgData.setValue("EMP_NO", strUserNo);

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
	parent.gridSUB01.focus();
	parent.btnquery_onclick();
<%
			}
%>
</script>
<%
		}
%>
