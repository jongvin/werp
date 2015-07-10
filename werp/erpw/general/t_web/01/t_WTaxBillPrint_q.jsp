<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
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
		
		if (strAct.equals("SUB01"))
		{
			String strDATE_CLS = CITCommon.toKOR(request.getParameter("DATE_CLS"));
			String strDT_F = CITCommon.toKOR(request.getParameter("DT_F"));
			String strDT_T = CITCommon.toKOR(request.getParameter("DT_T"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strKEEP_CLS = CITCommon.toKOR(request.getParameter("KEEP_CLS"));
			String strRCPTBILL_CLS = CITCommon.toKOR(request.getParameter("RCPTBILL_CLS"));
			String strMAKE_DEPT_CODE = CITCommon.toKOR(request.getParameter("MAKE_DEPT_CODE"));
			String strCHARGE_PERS = CITCommon.toKOR(request.getParameter("CHARGE_PERS"));
			String strCUST_CODE = CITCommon.toKOR(request.getParameter("CUST_CODE"));
			String strDBCR_FAMT = CITCommon.toKOR(request.getParameter("DBCR_FAMT"));
			String strDBCR_EAMT = CITCommon.toKOR(request.getParameter("DBCR_EAMT"));
			String strACC_CODE = CITCommon.toKOR(request.getParameter("ACC_CODE"));
			String strVAT_CODE = CITCommon.toKOR(request.getParameter("VAT_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strSUMMARY1 = CITCommon.toKOR(request.getParameter("SUMMARY1"));
			String strTAX_COMP_CODE = CITCommon.toKOR(request.getParameter("TAX_COMP_CODE"));
			String strAMT_CLS = CITCommon.toKOR(request.getParameter("AMT_CLS"));
			String strMAKE_PERS = CITCommon.toKOR(request.getParameter("MAKE_PERS"));
			String strMAKE_SLIPNO = CITCommon.toKOR(request.getParameter("MAKE_SLIPNO"));
			String strSLIP_KIND_TAG = CITCommon.toKOR(request.getParameter("SLIP_KIND_TAG"));

			strSql  = " 		 SELECT  \n";
			strSql += " 			'F' CHK_CLS,   \n";
			strSql += " 		 	A.SLIP_ID ,   \n";
			strSql += " 		  	B1.SLIP_IDSEQ ,   \n";
			strSql += " 		 	A.MAKE_COMP_CODE ,   \n";
			strSql += " 		 	A.MAKE_DT ,   \n";
			strSql += " 		 	A.MAKE_SEQ ,   \n";
			strSql += " 		 	A.SLIP_KIND_TAG ,   \n";
			strSql += " 		  	A.MAKE_SLIPNO ,   \n";
			strSql += " 		  	B1.MAKE_SLIPLINE ,  \n";
			strSql += " 		  	A.MAKE_SLIPNO||'-'||B1.MAKE_SLIPLINE MAKE_SLIPNOLINE,  \n";
			strSql += " 		 	DECODE(A.KEEP_SLIPNO, NULL, NULL, '확정  ') KEEP_CLS,  \n";
			strSql += " 		  	B1.ACC_CODE ,   \n";
			strSql += " 		  	C1.ACC_NAME ,   \n";
			strSql += " 		  	C1.ACC_REMAIN_POSITION ,   \n";
			strSql += " 		  	B1.DB_AMT ,   \n";
			strSql += " 		  	TO_CHAR(B1.DB_AMT, 'FM9,999,999,999,999') DB_AMT_D ,   \n";
			strSql += " 		  	B1.CR_AMT ,   \n";
			strSql += " 		  	TO_CHAR(B1.CR_AMT, 'FM9,999,999,999,999') CR_AMT_D ,   \n";
			strSql += " 		  	--적요코드관리   \n";
			strSql += " 		  	C1.SUMMARY_CLS ,   \n";
			strSql += " 		  	B1.SUMMARY_CODE ,   \n";
			strSql += " 		  	B2.SUMMARY1 ,   \n";
			strSql += " 		  	B2.SUMMARY2 ,   \n";
			strSql += " 		  	B1.TAX_COMP_CODE ,   \n";
			strSql += " 		  	C7.COMPANY_NAME TAX_COMP_NAME,   \n";
			strSql += " 		  	B1.COMP_CODE ,   \n";
			strSql += " 		  	--귀속부서   \n";
			strSql += " 		  	B1.DEPT_CODE ,   \n";
			strSql += " 		  	C2.DEPT_NAME ,   \n";
			strSql += " 		  	--부문코드   \n";
			strSql += " 		  	B1.CLASS_CODE ,   \n";
			strSql += " 		  	C3.CLASS_CODE_NAME ,   \n";
			strSql += " 		  	--증빙코드   \n";
			strSql += " 		  	B1.VAT_CODE ,   \n";
			strSql += " 		  	C4.VAT_NAME ,   \n";
			strSql += " 		  	--거래처코드관리   \n";
			strSql += " 		  	C1.CUST_CODE_MNG ,   \n";
			strSql += " 		  	C1.CUST_CODE_MNG_TG ,   \n";
			strSql += " 		  	TO_CHAR(B1.CUST_SEQ) CUST_SEQ ,   \n";
			strSql += " 		  	F_T_CUST_MASK(C6.CUST_CODE) CUST_CODE ,   \n";
			strSql += " 		  	--거래처명관리   \n";
			strSql += " 		  	C1.CUST_NAME_MNG ,   \n";
			strSql += " 		  	C1.CUST_NAME_MNG_TG ,   \n";
			strSql += " 		  	C6.CUST_NAME ,   \n";
			strSql += " 		  	--은행관리   \n";
			strSql += " 		  	C1.BANK_MNG ,   \n";
			strSql += " 		  	C1.BANK_MNG_TG ,   \n";
			strSql += " 		  	B1.BANK_CODE ,   \n";
			strSql += " 		  	C5.BANK_NAME ,   \n";
			strSql += " 		  	--사원번호   \n";
			strSql += " 		  	C1.EMP_NO_MNG ,   \n";
			strSql += " 		  	C1.EMP_NO_MNG_TG ,   \n";
			strSql += " 		  	B2.EMP_NO ,   \n";
			strSql += " 		  	C8.NAME EMP_NAME ,   \n";
			strSql += " 		  	C1.RCPTBILL_CLS ,   \n";
			strSql += " 			F_T_Datetostring(B1.VAT_DT) VAT_DT,   \n";
			strSql += " 		  	B1.SUPAMT ,   \n";
			strSql += " 		  	B1.VATAMT ,   \n";
			strSql += " 		  	DECODE( B1.RESET_SLIP_ID, NULL, '', 0, '', F_T_Get_Make_Slipno(B1.RESET_SLIP_ID, B1.RESET_SLIP_IDSEQ) ) RESET_SLIPNO,   \n";
			strSql += " 		  	DECODE(C9.SLIP_ID, NULL, 'INSERT', 'UPDATE') TB_JOB, \n";
			strSql += " 		  	C9.BOOK_NO, \n";
			strSql += " 		  	C9.BOOK_SEQ, \n";
			strSql += " 		  	C9.SER_NO \n";
			strSql += "  		FROM  \n";
			strSql += "  			T_ACC_SLIP_HEAD A,   \n";
			strSql += " 			T_ACC_SLIP_BODY1 B1, \n";
			strSql += " 			T_ACC_SLIP_BODY2 B2, \n";
			strSql += " 		 	T_ACC_CODE_VIEW C1,   \n";
			strSql += " 		 	T_DEPT_CODE C2,   \n";
			strSql += " 		 	T_CLASS_CODE C3,   \n";
			strSql += " 		 	T_ACC_VAT_CODE C4,   \n";
			strSql += " 		 	T_BANK_CODE C5,   \n";
			strSql += " 		 	T_CUST_CODE C6,   \n";
			strSql += " 		 	T_COMPANY C7, \n";
			strSql += " 		 	Z_AUTHORITY_USER C8,   \n";
			strSql += " 		 	T_TAX_BILL_HEAD C9   \n";
			strSql += "  		WHERE  \n";
			strSql += "  			A.SLIP_ID = B1.SLIP_ID \n";
			strSql += "  			AND B1.SLIP_ID = B2.SLIP_ID \n";
			strSql += "  			AND B1.SLIP_IDSEQ = B2.SLIP_IDSEQ \n";
			strSql += " 			AND B1.ACC_CODE = C1.ACC_CODE   \n";
			strSql += " 			AND	B1.DEPT_CODE = C2.DEPT_CODE   \n";
			strSql += " 			AND	B1.CLASS_CODE = C3.CLASS_CODE(+)   \n";
			strSql += " 			AND	B1.VAT_CODE = C4.VAT_CODE(+)   \n";
			strSql += " 			AND	B1.BANK_CODE = C5.BANK_CODE(+)   \n";
			strSql += " 			AND	B1.CUST_SEQ = C6.CUST_SEQ(+)   \n";
			strSql += " 			AND	B1.TAX_COMP_CODE = C7.COMP_CODE(+)   \n";
			strSql += " 			AND	B2.EMP_NO = C8.EMPNO(+)   \n";
			strSql += "  			AND B1.SLIP_ID = C9.SLIP_ID(+) \n";
			strSql += "  			AND B1.SLIP_IDSEQ = C9.SLIP_IDSEQ(+) \n";
			strSql += " 			AND C1.SALEBUY_CLS = '1' \n";
			strSql += "  			-- 헤더조건 추가  \n";
			strSql += "  			--발의일자 / 확정일자  \n";
			strSql += "  			AND A.MAKE_SLIPNO LIKE '%'||?||'%'  \n";
			strSql += "  			AND (  \n";
			strSql += "  				( 'M' =  ?   AND A.MAKE_DT BETWEEN  F_T_STRINGTODATE( ? )  AND  F_T_STRINGTODATE( ? )  )  \n";
			strSql += "  				OR  \n";
			strSql += "  				( 'K' =  ?   AND B1.VAT_DT BETWEEN   F_T_STRINGTODATE( ? )  AND  F_T_STRINGTODATE( ? )  )  \n";
			strSql += "  			)  \n";
			strSql += "  			--사업장  \n";
			if(!"".equals(strCOMP_CODE)) strSql += "  			AND A.MAKE_COMP_CODE =   ?   \n";
			strSql += "  			--확정구분  \n";
			strSql += "  			AND (  \n";
			strSql += "  				('A'=  ?  )  \n";
			strSql += "  				OR  \n";
			strSql += "  				( ('M'=  ?  ) AND A.KEEP_DT IS NULL )  \n";
			strSql += "  				OR  \n";
			strSql += "  				( ('K'=  ?  ) AND A.KEEP_DT IS NOT NULL )  \n";
			strSql += "  			)  \n";
			strSql += "  			--발의부서  \n";
			if(!"".equals(strMAKE_DEPT_CODE)) strSql += "  			AND A.MAKE_DEPT_CODE =   ?  \n";
			strSql += "  			--발의자  \n";
			strSql += "  			AND A.MAKE_PERS LIKE '%'||?||'%'  \n";
			strSql += "  			--관리담당  \n";
			if(!"".equals(strCHARGE_PERS)) strSql += "  			AND A.CHARGE_PERS =   ?  \n";
			strSql += " 			-- 바디조건 추가  \n";
			strSql += " 			--거래처  \n";
			if(!"".equals(strCUST_CODE)) strSql += " 			AND C6.CUST_CODE =  ?  \n";
			strSql += " 			--금액  \n";
			if("A".equals(strAMT_CLS)) {
				if(!"".equals(strDBCR_FAMT)) strSql += " 	AND NVL(B1.DB_AMT,0)+NVL(B1.CR_AMT,0)>= ?  \n";
				if(!"".equals(strDBCR_EAMT)) strSql += " 	AND NVL(B1.DB_AMT,0)+NVL(B1.CR_AMT,0)<= ?  \n";
			} else if("D".equals(strAMT_CLS)) {
				if(!"".equals(strDBCR_FAMT)) strSql += " 	AND NVL(B1.DB_AMT,0)>= ?  \n";
				if(!"".equals(strDBCR_EAMT)) strSql += " 	AND NVL(B1.DB_AMT,0)<= ?  \n";
			} else if("C".equals(strAMT_CLS)) {
				if(!"".equals(strDBCR_FAMT)) strSql += " 	AND NVL(B1.CR_AMT,0)>= ?  \n";
				if(!"".equals(strDBCR_EAMT)) strSql += " 	AND NVL(B1.CR_AMT,0)<= ?  \n";
			}
			strSql += " 			--계정과목  \n";
			if(!"".equals(strACC_CODE)) strSql += " 			AND B1.ACC_CODE =  ?  \n";
			strSql += " 			--부가세코드  \n";
			if(!"".equals(strVAT_CODE)) strSql += " 			AND B1.VAT_CODE =  ?  \n";
			strSql += " 			--귀속부서  \n";
			if(!"".equals(strDEPT_CODE)) strSql += " 			AND B1.DEPT_CODE =  ?  \n";
			strSql += " 			--적요  \n";
			if(!"".equals(strSUMMARY1)) strSql += " 			AND B2.SUMMARY1 LIKE ? ||'%' \n";
			strSql += " 			--세무사업장  \n";
			if(!"".equals(strTAX_COMP_CODE)) strSql += " 			AND B1.TAX_COMP_CODE =  ?  \n";
			if(!"%".equals(strSLIP_KIND_TAG)) strSql += " 			AND A.SLIP_KIND_TAG =  ?  \n";

			strSql += " 			AND C1.RCPTBILL_CLS LIKE  ? ||'%' \n";

			strSql += " ORDER BY \n";
			strSql += " 	A.MAKE_SLIPNO DESC, \n";
			strSql += " 	b1.MAKE_SLIPLINE ";
			
			lrArgData.addColumn("0MAKE_SLIPNO", CITData.VARCHAR2);
			lrArgData.addColumn("1DATE_CLS", CITData.VARCHAR2);
			lrArgData.addColumn("2DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("3DT_T", CITData.VARCHAR2);
			lrArgData.addColumn("4DATE_CLS", CITData.VARCHAR2);
			lrArgData.addColumn("5DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("6DT_T", CITData.VARCHAR2);
			if(!"".equals(strCOMP_CODE)) lrArgData.addColumn("7COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("8KEEP_CLS", CITData.VARCHAR2);
			lrArgData.addColumn("9KEEP_CLS", CITData.VARCHAR2);
			lrArgData.addColumn("10KEEP_CLS", CITData.VARCHAR2);
			if(!"".equals(strMAKE_DEPT_CODE)) lrArgData.addColumn("11MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("12MAKE_PERS", CITData.VARCHAR2);
			if(!"".equals(strCHARGE_PERS)) lrArgData.addColumn("13CHARGE_PERS", CITData.VARCHAR2);
			if(!"".equals(strCUST_CODE)) lrArgData.addColumn("14CUST_CODE", CITData.VARCHAR2);
			if(!"".equals(strDBCR_FAMT)) lrArgData.addColumn("DBCR_FAMT", CITData.VARCHAR2);
			if(!"".equals(strDBCR_EAMT)) lrArgData.addColumn("DBCR_EAMT", CITData.VARCHAR2);
			if(!"".equals(strACC_CODE)) lrArgData.addColumn("15ACC_CODE", CITData.VARCHAR2);
			if(!"".equals(strVAT_CODE)) lrArgData.addColumn("16VAT_CODE", CITData.VARCHAR2);
			if(!"".equals(strDEPT_CODE)) lrArgData.addColumn("17DEPT_CODE", CITData.VARCHAR2);
			if(!"".equals(strTAX_COMP_CODE)) lrArgData.addColumn("18TAX_COMP_CODE", CITData.VARCHAR2);
			if(!"%".equals(strSLIP_KIND_TAG)) lrArgData.addColumn("19SLIP_KIND_TAG", CITData.VARCHAR2);
			lrArgData.addColumn("20RCPTBILL_CLS", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("0MAKE_SLIPNO", strMAKE_SLIPNO);
			lrArgData.setValue("1DATE_CLS", strDATE_CLS);
			lrArgData.setValue("2DT_F", strDT_F);
			lrArgData.setValue("3DT_T", strDT_T);
			lrArgData.setValue("4DATE_CLS", strDATE_CLS);
			lrArgData.setValue("5DT_F", strDT_F);
			lrArgData.setValue("6DT_T", strDT_T);
			if(!"".equals(strCOMP_CODE)) lrArgData.setValue("7COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("8KEEP_CLS", strKEEP_CLS);
			lrArgData.setValue("9KEEP_CLS", strKEEP_CLS);
			lrArgData.setValue("10KEEP_CLS", strKEEP_CLS);
			if(!"".equals(strMAKE_DEPT_CODE)) lrArgData.setValue("11MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			lrArgData.setValue("12MAKE_PERS", strMAKE_PERS);
			if(!"".equals(strCHARGE_PERS)) lrArgData.setValue("13CHARGE_PERS", strCHARGE_PERS);
			if(!"".equals(strCUST_CODE)) lrArgData.setValue("14CUST_CODE", strCUST_CODE);
			if(!"".equals(strDBCR_FAMT)) lrArgData.setValue("DBCR_FAMT", strDBCR_FAMT);
			if(!"".equals(strDBCR_EAMT)) lrArgData.setValue("DBCR_EAMT", strDBCR_EAMT);
			if(!"".equals(strACC_CODE)) lrArgData.setValue("15ACC_CODE", strACC_CODE);
			if(!"".equals(strVAT_CODE)) lrArgData.setValue("16VAT_CODE", strVAT_CODE);
			if(!"".equals(strDEPT_CODE)) lrArgData.setValue("17DEPT_CODE", strDEPT_CODE);
			if(!"".equals(strTAX_COMP_CODE)) lrArgData.setValue("18TAX_COMP_CODE", strTAX_COMP_CODE);
			if(!"%".equals(strSLIP_KIND_TAG)) lrArgData.setValue("19SLIP_KIND_TAG", strSLIP_KIND_TAG);
			lrArgData.setValue("20RCPTBILL_CLS", strRCPTBILL_CLS);

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
				GauceInfo.response.writeException("USER", "900001","SUB01 Select 오류-> "+ ex.getMessage());
			}
		}

		else if (strAct.equals("SUB02"))
		{
			String strSLIP_ID = CITCommon.toKOR(request.getParameter("SLIP_ID"));
			String strSLIP_IDSEQ = CITCommon.toKOR(request.getParameter("SLIP_IDSEQ"));
			
			strSql  = " SELECT \n";
			strSql += " 	SLIP_ID ,   \n";
			strSql += " 	SLIP_IDSEQ ,   \n";
			strSql += " 	BODY_SEQ, \n";
			strSql += " 	F_T_Datetostring(PUBL_DT) PUBL_DT, \n";
			strSql += " 	ITEM, \n";
			strSql += " 	ITEM_SIZE, \n";
			strSql += " 	CNT, \n";
			strSql += " 	UCOST, \n";
			strSql += " 	SUPAMT, \n";
			strSql += " 	VATAMT, \n";
			strSql += " 	REMARK \n";
			strSql += " FROM \n";
			strSql += " 	T_TAX_BILL_BODY \n";
			strSql += " WHERE \n";
			strSql += " 	SLIP_ID =  ?  \n";
			strSql += " 	AND	SLIP_IDSEQ =  ?  \n";
			strSql += " ORDER BY \n";
			strSql += " 	BODY_SEQ ";
			
			lrArgData.addColumn("1SLIP_ID", CITData.VARCHAR2);
			lrArgData.addColumn("2SLIP_IDSEQ", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1SLIP_ID", strSLIP_ID);
			lrArgData.setValue("2SLIP_IDSEQ", strSLIP_IDSEQ);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("SLIP_ID", true);
				lrReturnData.setKey("SLIP_IDSEQ", true);
				lrReturnData.setKey("BODY_SEQ", true);
				lrReturnData.setNotNull("ITEM", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}

	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
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
			GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
		}
	}
%>