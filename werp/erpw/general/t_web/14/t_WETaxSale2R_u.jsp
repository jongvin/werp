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

					strSql = "{call SP_T_WT_SALE_ITEM_D()}";
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
					
					for(int i=0;i<nRows;i++)
					{
						//타이틀...
						if(i==0) continue;
						arrCell = sheet.getRow(i);

						//cell = arrCell[j];
						//arrCell[0].getContents()  //문서번호
						//arrCell[1].getContents()  //작성일
						//arrCell[2].getContents()  //공급받는자사업번호
						//arrCell[3].getContents()  //공급받는자담당자사번
						//arrCell[4].getContents()  //세금계산서비고						
						//arrCell[5].getContents()  //거래일자
						//arrCell[6].getContents()  //상품명
						//arrCell[7].getContents()  //단위
						//arrCell[8].getContents()  //수량
						//arrCell[9].getContents() //단가
						//arrCell[10].getContents() //공급가
						//arrCell[11].getContents() //세액
						//arrCell[12].getContents() //비고
						out.println("eee"+arrCell[0].getContents()+"dd");

						if(
							"".equals(""+arrCell[0].getContents()) ||
							"".equals(""+arrCell[1].getContents())
						)
						{
							strErrMsg = ""+(i+1)+"번째행에 공백인 컬럼이 존재합니다.";
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
				if("".equals(strErrMsg) ) strErrMsg = "로드시 에러가 발생하였습니다. 파일 포맷이 옳바른지 확인해 주십시오.";
				if (conn != null){
					conn.rollback();
				}
				//throw new Exception("SYS-100002:페이지 종료 오류 -> " + ex.getMessage());
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
//	parent.gridSUB01.focus();
//	parent.btnquery_onclick();
<%
			}
%>
</script>
<%
		}
%>
