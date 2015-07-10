<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-04)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String strCARDNUMBER = CITCommon.toKOR(request.getParameter("CARDNUMBER"));
			String strSENDDATE_F = CITCommon.toKOR(request.getParameter("SENDDATE_F"));
			
			strSql  = " Select \n";
			strSql += " 	'F' SELECT_YN, \n";
			strSql += " 	a.CARDNUMBER, \n";
			strSql += " 	a.ADJUSTYEARMONTH, \n";
			strSql += " 	b.ACCTSUBSEQ, \n";
			strSql += " 	F_T_StringToYMDFormat(b.APPROVALDATE) ||' '|| F_T_StringToTimeFormat(b.APPROVALTIME) USE_DATE_TIME, \n";
			strSql += " 	b.SUPPLYAmt +  NVL(b.VatAmt,0) Amt, \n";			
			strSql += " 	decode(b.TAXGubun,'1',b.SUPPLYAmt,b.SUPPLYAmt + NVL(b.VatAmt,0)) SUPPLYAmt, \n";
			strSql += " 	decode(b.TAXGubun,'1',NVL(b.VatAmt,0),0) VatAmt, \n";
			strSql += " 	b.MerchantName, \n";
			strSql += " 	b.USAGEGUBUN , \n";
			strSql += " 	F_T_StringToYMDFormat(b.PAYHOPEDATE) PAYHOPEDATE , \n";
			strSql += " 	b.ACC_CODE , \n";
			strSql += " 	( select e.ACC_NAME  \n";
			strSql += " 	  from   T_ACC_CODE_VIEW  e  \n";
			strSql += " 	  where	 e.ACC_CODE = b.ACC_CODE  \n";
			strSql += " 	 ) ACC_NAME , \n";			
			strSql += " 	b.VAT_ACC_CODE , \n";
			strSql += " 	( select e.ACC_NAME  \n";
			strSql += " 	  from   T_ACC_CODE_VIEW  e  \n";
			strSql += " 	  where	 e.ACC_CODE = b.VAT_ACC_CODE  \n";
			strSql += " 	 ) VAT_ACC_NAME , \n";			
			strSql += " 	b.APPROVALNumber , \n";
			strSql += " 	b.MCCName , \n";
			strSql += " 	b.TAXGubun TAX , \n";
			strSql += " 	c.LOOKUP_VALUE TAXGubun , \n";
			strSql += "		''||f.SLIP_ID SLIP_ID, \n";
			strSql += "		f.MAKE_SLIPNO, \n";
			strSql += "		DECODE(f.SLIP_ID, null, 'F', 'T') MAKE_CLS, \n";
			strSql += "		DECODE(f.KEEP_DT_TRANS, null, 'F', 'T') KEEP_CLS, \n";
			strSql += " 	-- ��ǥ��ȸ ���� \n";
			strSql += " 	f.MAKE_COMP_CODE , \n";
			strSql += " 	F_T_DateToString(f.MAKE_DT) MAKE_DT, \n";
			strSql += " 	f.MAKE_SEQ , \n";
			strSql += " 	f.SLIP_KIND_TAG, \n";
			strSql += " 	b.DEPT_CODE, \n";
			strSql += " 	( select e.DEPT_SHORT_NAME  \n";
			strSql += " 	  from   T_DEPT_CODE  e  \n";
			strSql += " 	  where	 e.DEPT_CODE = b.DEPT_CODE  \n";
			strSql += " 	 ) DEPT_NAME  \n";						
			strSql += " From	T_CARD_ACCOUNTING_MASTER a , \n";
			strSql += "       T_CARD_ACCOUNTING_DETAIL b ,  \n";
			strSql += "       ( Select \n";
			strSql += " 	             a.LOOKUP_CODE  , \n";
			strSql += " 	             a.LOOKUP_VALUE  \n";
			strSql += "         From	 T_FB_LOOKUP_VALUES a \n";
			strSql += "         Where	 a.LOOKUP_TYPE = 'VatGubun'  \n";
			strSql += "         And  	 a.USE_YN = 'Y' ) c,  \n";
			strSql += "       T_ACC_SLIP_HEAD f \n";
			strSql += " Where	a.CARDNUMBER      = b.CARDNUMBER  \n";
			strSql += " And		a.ADJUSTYEARMONTH = b.ADJUSTYEARMONTH \n";
			strSql += " And		c.LOOKUP_CODE(+)  = b.TAXGubun \n";
			strSql += " And		b.SLIP_ID = f.SLIP_ID(+) \n";
			strSql += " And   Replace(a.CARDNUMBER,'-','') = Replace( ? ,'-','') \n";
			strSql += " And		a.ADJUSTYEARMONTH =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	b.APPROVALDATE ";
			
			lrArgData.addColumn("1CARDNUMBER", CITData.VARCHAR2);
			lrArgData.addColumn("2SENDDATE_F", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1CARDNUMBER", strCARDNUMBER);
			lrArgData.setValue("2SENDDATE_F", strSENDDATE_F);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CARDNUMBER", true);
				lrReturnData.setKey("ADJUSTYEARMONTH", true);
				lrReturnData.setKey("ACCTSUBSEQ", true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("COPY"))
		{
			strSql  = " Select \n";
			strSql += " 	'XXXXXXXXXXXXXXXX' CARDNUMBER, \n";
			strSql += " 	'XXXXXX' ADJUSTYEARMONTH, \n";
			strSql += " 	'000000' ACCTSUBSEQ \n";
			strSql += " From	DUAL \n";

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","COPY Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("DAY_CLOSE"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strCLSE_DAY = CITCommon.toKOR(request.getParameter("CLSE_DAY"));
			
			strSql  = " SELECT \n";
			strSql += " 	ROWNUM, \n";
			strSql += " 	A.COMP_CODE,   \n";
			strSql += " 	A.CLSE_ACC_ID,   \n";
			strSql += " 	A.ACC_ID,   \n";
			strSql += " 	F_T_DATETOSTRING(A.ACCOUNT_FDT) ACCOUNT_FDT,   \n";
			strSql += " 	F_T_DATETOSTRING(A.ACCOUNT_EDT) ACCOUNT_EDT,   \n";
			strSql += " 	NVL(A.CLSE_CLS, 'F') ACC_CLSE_CLS,   \n";
			strSql += " 	B.CLSE_MONTH,   \n";
			strSql += " 	NVL(B.CLSE_CLS, 'F') MON_CLSE_CLS, 				  \n";
			strSql += " 	F_T_DateToString(C.CLSE_DAY) CLSE_DAY,   \n";
			strSql += " 	NVL(C.CLSE_CLS, 'F') DAY_CLSE_CLS ,  \n";
			strSql += " 	D.INPUT_DT_F, \n";
			strSql += " 	D.INPUT_DT_T, \n";
			strSql += " 	D.INPUT_DT_F||'~'||D.INPUT_DT_T INPUT_DT, \n";
			strSql += " 	D.DEPT_CLSE_CLS, \n";
			strSql += " 	(  \n";
			strSql += " 		CASE  \n";
			strSql += " 			WHEN (A.CLSE_CLS='T') OR (B.CLSE_CLS='T') OR (B.CLSE_CLS='T') OR (D.DEPT_CLSE_CLS='T') THEN 'T'  \n";
			strSql += " 			ELSE 'F'  \n";
			strSql += " 		END  \n";
			strSql += " 	) CLSE_CLS \n";
			strSql += " FROM  \n";
			strSql += " 	T_YEAR_CLOSE A,  \n";
			strSql += " 	T_MONTH_CLOSE B,  \n";
			strSql += " 	T_DAY_CLOSE C, \n";
			strSql += " 	( \n";
			strSql += " 	 	-- �μ� �Է±Ⱓ üũ \n";
			strSql += " 		SELECT \n";
			strSql += " 			 ROWNUM RN, \n";
			strSql += " 			 F_T_DATETOSTRING(NVL(INPUT_DT_F, '19000101')) INPUT_DT_F, \n";
			strSql += " 			 F_T_DATETOSTRING(NVL(INPUT_DT_T, '19000101')) INPUT_DT_T, \n";
			strSql += " 			 CASE \n";
			strSql += " 			 	 WHEN ( F_T_DATETOSTRING(F_T_STRINGTODATE(?)) BETWEEN F_T_DATETOSTRING(NVL(INPUT_DT_F, '19000101')) AND F_T_DATETOSTRING(NVL(INPUT_DT_T, '19000101')) ) \n";
			strSql += " 				 THEN 'F' -- �Է±Ⱓ \n";
			strSql += " 				 ELSE 'T' -- �Է¸��� \n";
			strSql += " 			END DEPT_CLSE_CLS \n";
			strSql += " 		FROM \n";
			strSql += " 			T_DEPT_CODE_ORG A \n";
			strSql += " 		WHERE   \n";
			strSql += " 			A.COMP_CODE = ? \n";
			strSql += " 			AND DEPT_CODE = ? \n";
			strSql += " 	) D \n";
			strSql += " WHERE   \n";
			strSql += " 	A.COMP_CODE = B.COMP_CODE  \n";
			strSql += " 	AND A.CLSE_ACC_ID = B.CLSE_ACC_ID  \n";
			strSql += " 	AND B.COMP_CODE = C.COMP_CODE  \n";
			strSql += " 	AND B.CLSE_ACC_ID = C.CLSE_ACC_ID  \n";
			strSql += " 	AND B.CLSE_MONTH = C.CLSE_MONTH  \n";
			strSql += " 	AND ROWNUM = D.RN(+) \n";
			strSql += " 	AND A.COMP_CODE = ? \n";
			strSql += " 	AND C.CLSE_DAY = ? ";

			lrArgData.addColumn("CLSE_DAY1", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE1", CITData.VARCHAR2);
			
			lrArgData.addColumn("COMP_CODE2", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_DAY2", CITData.VARCHAR2);
			
			lrArgData.addRow();
			
			lrArgData.setValue("CLSE_DAY1", strCLSE_DAY);
			lrArgData.setValue("COMP_CODE1", strCOMP_CODE);
			lrArgData.setValue("DEPT_CODE1", strDEPT_CODE);

			lrArgData.setValue("COMP_CODE2", strCOMP_CODE);
			lrArgData.setValue("CLSE_DAY2", strCLSE_DAY);

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);	
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CARDNUMBER", true);
				lrReturnData.setKey("ADJUSTYEARMONTH", true);
				lrReturnData.setKey("ACCTSUBSEQ", true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("AUTO_FBS_CARD_ACNT_SEQ"))
		{
			strSql  = " Select SQ_T_AUTO_FBS_CARD_ACNT.NEXTVAL AUTO_FBS_CARD_ACNT_SEQ From DUAL ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CARDNUMBER", true);
				lrReturnData.setKey("ADJUSTYEARMONTH", true);
				lrReturnData.setKey("ACCTSUBSEQ", true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("ACCT_CHK"))
		{
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strACC_CODE = CITCommon.toKOR(request.getParameter("ACC_CODE"));
			
			strSql  = " SELECT 														\n";
			strSql += " 	a.ACC_CODE , 										\n";
			strSql += " 	a.ACC_NAME 											\n";
			strSql += " From T_ACC_CODE_VIEW a,						\n";
			strSql += " 		(	SELECT 											\n";
			strSql += " 				Bi.ACC_CODE 							\n";
			strSql += " 			FROM 												\n";
			strSql += " 				T_DEPT_CODE_ORG Ai, 			\n";
			strSql += " 				T_GRP_ACC_CODE Bi 				\n";
			strSql += " 			WHERE	Ai.ACC_GRP_CODE = Bi.ACC_GRP_CODE \n";
			strSql += " 			AND Ai.DEPT_CODE = ? 										\n";
			strSql += " 		) b 																			\n";
			strSql += " Where 																				\n";
			strSql += " 	a.ACC_CODE = b.ACC_CODE 										\n";
			strSql += " 	AND  ( a.ACC_NAME Like  '%'|| Replace('����������',' ','%') || '%' 	\n";
			strSql += " 	or a.ACC_NAME Like  '%'|| Replace('�����',' ','%') 								\n";
			strSql += " 	or a.ACC_NAME Like  '%'|| Replace('�������',' ','%') 						\n";
			strSql += " 	or a.ACC_NAME Like  '%'|| Replace('ȸ�Ǻ�',' ','%') 								\n";
			strSql += " 	or a.ACC_NAME Like  '%'|| Replace('�ڷ�����',' ','%') || '%' ) 		\n";
			strSql += " 	And a.ACC_CODE = ? 				\n";
			strSql += " 	And a.FUND_INPUT_CLS = 'T' 	";
			
			lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);			
			lrArgData.addRow();			
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("ACC_CODE", strACC_CODE);
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select ����-> "+ ex.getMessage());
			}
		}		
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "������ �ʱ�ȭ ���� -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
			GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
		}
	}
%>