<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*, com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy, jxl.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원  작성(2006-03-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(시작)
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(끝)
	//Dataset이 여러개이면 아래 나타나는 부분중 '//복사시작' 에서 '//복사끝' 까지를 기존 갱신 페이지의 '//여기에 붙여넣으세요' 자리에 붙여넣으세요
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	Connection conn = null;

	String strErrMsg = "";
	

		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (CITCommon.isNull(strAct))
		{
	//복사시작

	//복사끝
	//복사시작

	//복사끝
	//여기에 붙여넣으세요
		}
		else if (strAct.equals("FILE"))
		{
			try
			{
				String	strWORK_NO = CITCommon.toKOR(request.getParameter("WORK_NO"));
				String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
				String	strLIST_NO = null;

				/* 세션정보 */
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
						//타이틀...
						if(i==0) continue;
						arrCell = sheet.getRow(i);

						//cell = arrCell[j];
						//arrCell[0].getContents() //입금계좌
						//arrCell[1].getContents() //고객명
						//arrCell[2].getContents() //대출잔액
						//arrCell[3].getContents() //총대출금
						//arrCell[4].getContents() //약정이자
						//arrCell[5].getContents() //동
						//arrCell[6].getContents() //호
						//out.println("eee"+arrCell[0].getContents()+"dd");

						if(
							"".equals(""+arrCell[0].getContents()) ||
							"".equals(""+arrCell[1].getContents())
						)
						{
							strErrMsg = ""+(i+1)+"번째행에 공백인 컬럼이 존재합니다.";
							throw new Exception(strErrMsg);
						}


						lrArgData = new CITData();
						strSql  = " Select SQ_T_SET_RESET_COST_LIST.NextVal LIST_NO From Dual \n";

						lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

						if (lrReturnData.getRowsCount() > 0)
						{
							strLIST_NO		= lrReturnData.toString(0,"LIST_NO");
						}
						else
						{
						}

						lrArgData = new CITData();
						strSql = "{call SP_T_SET_RESET_COST_LIST_I(?,?,?,?,?,?,?,?,?)}";
						
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("LIST_NO", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("AMT", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", strCOMP_CODE);
						lrArgData.setValue("WORK_NO", strWORK_NO);
						lrArgData.setValue("LIST_NO", strLIST_NO);
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("EMP_NO", arrCell[0].getContents().trim());
						lrArgData.setValue("AMT", arrCell[1].getContents().trim());
						lrArgData.setValue("SLIP_ID", "");
						lrArgData.setValue("SLIP_IDSEQ", "");
						lrArgData.setValue("REMARKS", "");

						CITDatabase.executeProcedure(strSql, lrArgData, conn);
					}
					conn.commit();

					workbook.close();

					f.delete();
				}

			} catch (Exception ex) {
				//conn.commit();
				if("".equals(strErrMsg) ) strErrMsg = "로드시 에러가 발생하였습니다. 파일 포맷이 옳바른지 확인해 주십시오.";
				if (conn != null){
					conn.rollback();
				}
				throw new Exception("SYS-100002:페이지 종료 오류 -> " + ex.getMessage());
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
	parent.C_msgOk("<%=strErrMsg%>","확인");
<%
			} else {
%>
	parent.C_msgOk("정상적으로 로드되었습니다.","확인");
	parent.gridSUB01.focus();
	parent.btnquery_onclick();
<%
			}
%>
</script>
<%
		}
%>
