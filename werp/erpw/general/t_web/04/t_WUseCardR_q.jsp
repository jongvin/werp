<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/***************************************************/
/* 이 프로그램은 대보시스템(주) 의 재산입니다.
/* 최초작성자 : 백승기
/* 최초작성일 : 2005-02-02
/* 최종수정자 :
/* 최종수정일 :
/***************************************************/

	CITGauceInfo GauceInfo = null;

	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;
	String	strSql = "";
	String	strAct = "";
	String	strDT_CLS = "";

	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);

		CITData lrArgData = new CITData();

		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		strDT_CLS = CITCommon.toKOR(request.getParameter("DT_CLS"));

		if (strAct.equals("MAIN"))
		{
			if (strDT_CLS.equals("B"))
			{
				String strCARD_CLS = CITCommon.toKOR(request.getParameter("CARD_CLS"));
				String strMAKE_COMPANY = CITCommon.toKOR(request.getParameter("MAKE_COMPANY"));
				String strCARDNO = CITCommon.toKOR(request.getParameter("CARDNO"));
				String strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
				String strKEEP_DT_F = CITCommon.toKOR(request.getParameter("KEEP_DT_F"));
				String strKEEP_DT_T = CITCommon.toKOR(request.getParameter("KEEP_DT_T"));
				
				strSql  = " SELECT \n";
				strSql += " 	A.CARDNO , \n";
				strSql += " 	A.BANK_CODE , \n";
				strSql += " 	H.BANK_NAME , \n";
				strSql += " 	C.KEEP_SLIPNO , \n";
				strSql += " 	C.MAKE_SLIPNO , \n";
				strSql += " 	A.CARD_NAME , \n";
				strSql += " 	A.CARD_CLS , \n";
				strSql += " 	a.CARD_OWNER OWNER , \n";
				strSql += " 	A.ACCNO , \n";
				strSql += " 	B.REQ_TG , \n";
				strSql += " 	B.TRADE_AMT , \n";
				strSql += " 	B.CUST_CODE , \n";
				strSql += " 	B.CUST_NAME , \n";
				strSql += " 	c.MAKE_COMP_CODE MAKE_COMPANY , \n";
				strSql += " 	D.SUMMARY1 , \n";
				strSql += " 	D.ACC_CODE , \n";
				strSql += " 	E.ACC_NAME , \n";
				strSql += " 	To_Char(B.SLIP_ID) SLIP_ID, \n";
				strSql += " 	To_Char(B.SLIP_IDSEQ) SLIP_IDSEQ , \n";
				strSql += " 	C.MAKE_DT_TRANS , \n";
				strSql += " 	C.SLIP_KIND_TAG , \n";
				strSql += " 	c.MAKE_DEPT_CODE MAKE_DEPT , \n";
				strSql += " 	C.MAKE_DT , \n";
				strSql += " 	C.MAKE_SEQ , \n";
				strSql += " 	C.GROUPWARE_SLIPSTATUS , \n";
				strSql += " 	F_T_DATETOSTRING(B.USE_DT) USE_DT , \n";
				strSql += " 	D.EMP_NO , \n";
				strSql += " 	G.NAME NAME , \n";
				strSql += " 	'' CODE_LIST_NAME \n";
				strSql += " FROM      \n";
				strSql += " 	T_ACC_CREDCARD A, \n";
				strSql += " 	T_ACC_SLIP_EXPENSE_CARDS B, \n";
				strSql += " 	T_ACC_SLIP_HEAD C , \n";
				strSql += " 	T_ACC_SLIP_BODY D , \n";
				strSql += " 	T_ACC_CODE E , \n";
				strSql += " 	Z_AUTHORITY_USER G    , \n";
				strSql += " 	T_BANK_CODE H \n";
				strSql += " WHERE	A.CARD_CLS              LIKE '%'||   ?   ||'%' \n";
				strSql += " AND		A.USE_TG               = 'T' \n";
				strSql += " AND		A.BANK_CODE 			 = H.BANK_CODE(+) \n";
				strSql += " AND		A.CARDNO                = B.CARDNO \n";
				strSql += " AND		B.SLIP_ID               = C.SLIP_ID \n";
				strSql += " AND		B.SLIP_ID               = D.SLIP_ID \n";
				strSql += " AND		B.SLIP_IDSEQ            = D.SLIP_IDSEQ \n";
				strSql += " AND		D.ACC_CODE              = E.ACC_CODE \n";
				strSql += " AND		D.EMP_NO                = G.EMPNO(+) \n";
				strSql += " AND		C.MAKE_COMP_CODE          =   ?  \n";
				strSql += " AND		A.CARDNO                LIKE '%'||   ?   ||'%' \n";
				strSql += " AND		A.BANK_CODE                LIKE '%'||   ?   ||'%' \n";
				strSql += " AND		C.MAKE_DT               BETWEEN   ?   AND   ?  \n";
				strSql += " ORDER BY \n";
				strSql += " 	BANK_CODE , \n";
				strSql += " 	CARD_CLS , \n";
				strSql += " 	CARDNO , \n";
				strSql += " 	KEEP_SLIPNO , \n";
				strSql += " 	USE_DT , \n";
				strSql += " 	MAKE_SLIPNO \n";
				strSql += "  ";
				
				lrArgData.addColumn("1CARD_CLS", CITData.VARCHAR2);
				lrArgData.addColumn("2MAKE_COMPANY", CITData.VARCHAR2);
				lrArgData.addColumn("3CARDNO", CITData.VARCHAR2);
				lrArgData.addColumn("4BANK_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("5KEEP_DT_F", CITData.DATE);
				lrArgData.addColumn("6KEEP_DT_T", CITData.DATE);
				lrArgData.addRow();
				lrArgData.setValue("1CARD_CLS", strCARD_CLS);
				lrArgData.setValue("2MAKE_COMPANY", strMAKE_COMPANY);
				lrArgData.setValue("3CARDNO", strCARDNO);
				lrArgData.setValue("4BANK_CODE", strBANK_CODE);
				lrArgData.setValue("5KEEP_DT_F", strKEEP_DT_F);
				lrArgData.setValue("6KEEP_DT_T", strKEEP_DT_T);
			}
			else	if (strDT_CLS.equals("C"))
			{
				String strCARD_CLS = CITCommon.toKOR(request.getParameter("CARD_CLS"));
				String strMAKE_COMPANY = CITCommon.toKOR(request.getParameter("MAKE_COMPANY"));
				String strCARDNO = CITCommon.toKOR(request.getParameter("CARDNO"));
				String strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
				String strKEEP_DT_F = CITCommon.toKOR(request.getParameter("KEEP_DT_F"));
				String strKEEP_DT_T = CITCommon.toKOR(request.getParameter("KEEP_DT_T"));
				
				strSql  = " SELECT \n";
				strSql += " 	A.CARDNO , \n";
				strSql += " 	A.BANK_CODE , \n";
				strSql += " 	H.BANK_NAME , \n";
				strSql += " 	C.KEEP_SLIPNO , \n";
				strSql += " 	C.MAKE_SLIPNO , \n";
				strSql += " 	A.CARD_NAME , \n";
				strSql += " 	A.CARD_CLS , \n";
				strSql += " 	a.CARD_OWNER OWNER , \n";
				strSql += " 	A.ACCNO , \n";
				strSql += " 	B.REQ_TG , \n";
				strSql += " 	B.TRADE_AMT , \n";
				strSql += " 	B.CUST_CODE , \n";
				strSql += " 	B.CUST_NAME , \n";
				strSql += " 	c.MAKE_COMP_CODE MAKE_COMPANY , \n";
				strSql += " 	D.SUMMARY1 , \n";
				strSql += " 	D.ACC_CODE , \n";
				strSql += " 	E.ACC_NAME , \n";
				strSql += " 	To_Char(B.SLIP_ID) SLIP_ID, \n";
				strSql += " 	To_Char(B.SLIP_IDSEQ) SLIP_IDSEQ , \n";
				strSql += " 	C.MAKE_DT_TRANS , \n";
				strSql += " 	C.SLIP_KIND_TAG , \n";
				strSql += " 	c.MAKE_DEPT_CODE MAKE_DEPT , \n";
				strSql += " 	C.MAKE_DT , \n";
				strSql += " 	C.MAKE_SEQ , \n";
				strSql += " 	C.GROUPWARE_SLIPSTATUS , \n";
				strSql += " 	F_T_DATETOSTRING(B.USE_DT) USE_DT , \n";
				strSql += " 	D.EMP_NO , \n";
				strSql += " 	G.NAME NAME , \n";
				strSql += " 	'' CODE_LIST_NAME \n";
				strSql += " FROM      \n";
				strSql += " 	T_ACC_CREDCARD A, \n";
				strSql += " 	T_ACC_SLIP_EXPENSE_CARDS B, \n";
				strSql += " 	T_ACC_SLIP_HEAD C , \n";
				strSql += " 	T_ACC_SLIP_BODY D , \n";
				strSql += " 	T_ACC_CODE E , \n";
				strSql += " 	Z_AUTHORITY_USER G    , \n";
				strSql += " 	T_BANK_CODE H \n";
				strSql += " WHERE	A.CARD_CLS              LIKE '%'||   ?   ||'%' \n";
				strSql += " AND		A.USE_TG               = 'T' \n";
				strSql += " AND		A.BANK_CODE 			 = H.BANK_CODE(+) \n";
				strSql += " AND		A.CARDNO                = B.CARDNO \n";
				strSql += " AND		B.SLIP_ID               = C.SLIP_ID \n";
				strSql += " AND		B.SLIP_ID               = D.SLIP_ID \n";
				strSql += " AND		B.SLIP_IDSEQ            = D.SLIP_IDSEQ \n";
				strSql += " AND		D.ACC_CODE              = E.ACC_CODE \n";
				strSql += " AND		D.EMP_NO                = G.EMPNO(+) \n";
				strSql += " AND		C.MAKE_COMP_CODE          =   ?  \n";
				strSql += " AND		A.CARDNO                LIKE '%'||   ?   ||'%' \n";
				strSql += " AND		A.BANK_CODE                LIKE '%'||   ?   ||'%' \n";
				strSql += " AND		B.USE_DT               BETWEEN   ?   AND   ?  \n";
				strSql += " ORDER BY \n";
				strSql += " 	BANK_CODE , \n";
				strSql += " 	CARD_CLS , \n";
				strSql += " 	CARDNO , \n";
				strSql += " 	KEEP_SLIPNO , \n";
				strSql += " 	USE_DT , \n";
				strSql += " 	MAKE_SLIPNO \n";
				strSql += "  ";
				
				lrArgData.addColumn("1CARD_CLS", CITData.VARCHAR2);
				lrArgData.addColumn("2MAKE_COMPANY", CITData.VARCHAR2);
				lrArgData.addColumn("3CARDNO", CITData.VARCHAR2);
				lrArgData.addColumn("4BANK_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("5KEEP_DT_F", CITData.DATE);
				lrArgData.addColumn("6KEEP_DT_T", CITData.DATE);
				lrArgData.addRow();
				lrArgData.setValue("1CARD_CLS", strCARD_CLS);
				lrArgData.setValue("2MAKE_COMPANY", strMAKE_COMPANY);
				lrArgData.setValue("3CARDNO", strCARDNO);
				lrArgData.setValue("4BANK_CODE", strBANK_CODE);
				lrArgData.setValue("5KEEP_DT_F", strKEEP_DT_F);
				lrArgData.setValue("6KEEP_DT_T", strKEEP_DT_T);
			}
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrReturnData.setKey("CARDNO",true);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
		if (GauceInfo != null) GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo != null) GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
			 throw new Exception("SYS-100002:페이지 종료 오류 -> " + ex.getMessage());
		}
	}
%>
