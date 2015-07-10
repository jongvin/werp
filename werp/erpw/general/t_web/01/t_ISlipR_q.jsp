<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WSlipR_q.jsp(��ǥ���)
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-21)
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
		
		if (strAct.equals("SLIP_H"))
		{
			String strMAKE_COMP_CODE = CITCommon.toKOR(request.getParameter("MAKE_COMP_CODE"));
			String strMAKE_DT_TRANS = CITCommon.toKOR(request.getParameter("MAKE_DT_TRANS"));
			String strMAKE_SEQ = CITCommon.toKOR(request.getParameter("MAKE_SEQ"));
			
			strSql  = " Select	A.SLIP_ID , \n";
			strSql += " 		A.MAKE_SLIPCLS , \n";
			strSql += " 		A.MAKE_SLIPNO , \n";
			strSql += " 		A.MAKE_COMP_CODE , \n";
			strSql += " 		B.COMPANY_NAME , \n";
			strSql += " 		A.MAKE_DEPT_CODE , \n";
			strSql += " 		C.DEPT_NAME MAKE_DEPT_NAME , \n";
			strSql += " 		A.MAKE_DT , \n";
			strSql += " 		A.MAKE_DT_TRANS , \n";
			strSql += " 		A.MAKE_SEQ , \n";
			strSql += " 		A.INOUT_DEPT_CODE , \n";
			strSql += " 		D.DEPT_NAME  INOUT_DEPT_NAME , \n";
			strSql += " 		A.MAKE_PERS , \n";
			strSql += " 		A.MAKE_NAME , \n";
			strSql += " 		A.GROUPWARE_SLIPSTATUS , \n";
			strSql += " 		DECODE(A.KEEP_SLIPNO, NULL, 'F', 'T') KEEP_CLS , \n";
			strSql += " 		A.KEEP_SLIPNO , \n";
			strSql += " 		A.KEEP_DT , \n";
			strSql += " 		A.KEEP_DT_TRANS , \n";
			strSql += " 		A.KEEP_SEQ , \n";
			strSql += " 		A.KEEP_DEPT_CODE , \n";
			strSql += " 		E.DEPT_NAME KEEP_DEPT_NAME , \n";
			strSql += " 		A.KEEP_KEEPER , \n";
			strSql += " 		A.WORK_CODE , \n";
			strSql += " 		F.WORK_NAME , \n";
			strSql += " 		A.CHARGE_PERS , \n";
			strSql += " 		G.NAME CHARGE_PERS_NAME , \n";
			strSql += " 		A.SLIP_KIND_TAG , \n";
			strSql += " 		NVL(A.TRANSFER_TAG, 'F') TRANSFER_TAG, \n";
			strSql += " 		NVL(A.IGNORE_SET_RESET_TAG, 'F') IGNORE_SET_RESET_TAG, \n";
			strSql += " 		NVL(F.SLIP_UPDATE_CLS, 'T') SLIP_UPDATE_CLS \n";
			strSql += " From	T_ACC_SLIP_HEAD A, \n";
			strSql += " 		T_COMPANY B, \n";
			strSql += " 		T_DEPT_CODE C, \n";
			strSql += " 		T_DEPT_CODE D, \n";
			strSql += " 		T_DEPT_CODE E, \n";
			strSql += " 		T_WORK_CODE F, \n";
			strSql += " 		Z_AUTHORITY_USER G \n";
			strSql += " Where	A.MAKE_COMP_CODE = B.COMP_CODE \n";
			strSql += " And		A.MAKE_DEPT_CODE = C.DEPT_CODE \n";
			strSql += " And		A.INOUT_DEPT_CODE = D.DEPT_CODE(+) \n";
			strSql += " And		A.KEEP_DEPT_CODE = E.DEPT_CODE(+) \n";
			strSql += " And		A.WORK_CODE = F.WORK_CODE(+) \n";
			strSql += " And		A.CHARGE_PERS = G.EMPNO(+) \n";
			strSql += " And		A.MAKE_COMP_CODE =  ?  \n";
			strSql += " And		A.MAKE_DT_TRANS =  ?  \n";
			strSql += " And		A.MAKE_SEQ =  ?  ";
			
			lrArgData.addColumn("MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("MAKE_DT_TRANS", CITData.VARCHAR2);
			lrArgData.addColumn("MAKE_SEQ", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("MAKE_DT_TRANS", strMAKE_DT_TRANS);
			lrArgData.setValue("MAKE_SEQ", strMAKE_SEQ);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("SLIP_ID", true);
				lrReturnData.setNotNull("MAKE_SLIPCLS", true);
				lrReturnData.setNotNull("MAKE_COMP_CODE", true);
				lrReturnData.setNotNull("MAKE_DEPT_CODE", true);
				lrReturnData.setNotNull("MAKE_DT", true);
				lrReturnData.setNotNull("MAKE_DT_TRANS", true);
				lrReturnData.setNotNull("MAKE_SEQ", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SLIP_H Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("WORK_SLIP_D"))
		{
			String strWORK_SLIP_ID = CITCommon.toKOR(request.getParameter("WORK_SLIP_ID"));
			String strWORK_SLIP_IDSEQ = CITCommon.toKOR(request.getParameter("WORK_SLIP_IDSEQ"));
			
			strSql  = "  \n";
			strSql += " Select	AA.SLIP_ID ,  \n";
			strSql += "        	AA.SLIP_IDSEQ ,  \n";
			strSql += "        	AA.MAKE_SLIPLINE ,  \n";
			strSql += "        	AA.ACC_CODE ,  \n";
			strSql += "        	A1.ACC_NAME ,  \n";
			strSql += "        	A1.ACC_REMAIN_POSITION ,  \n";
			strSql += "        	AA.DB_AMT ,  \n";
			strSql += "        	TO_CHAR(AA.DB_AMT, 'FM9,999,999,999,999') DB_AMT_D ,  \n";
			strSql += "        	AA.CR_AMT ,  \n";
			strSql += "        	TO_CHAR(AA.CR_AMT, 'FM9,999,999,999,999') CR_AMT_D ,  \n";
			strSql += "        	--�����ڵ����  \n";
			strSql += "        	A1.SUMMARY_CLS ,  \n";
			strSql += "        	AA.SUMMARY_CODE ,  \n";
			strSql += "        	AA.SUMMARY1 ,  \n";
			strSql += "        	AA.SUMMARY2 ,  \n";
			strSql += "        	AA.TAX_COMP_CODE ,  \n";
			strSql += "        	A7.COMPANY_NAME TAX_COMP_NAME,  \n";
			strSql += "        	AA.COMP_CODE ,  \n";
			strSql += "        	A8.COMPANY_NAME COMP_NAME,  \n";
			strSql += "        	--�ͼӺμ�  \n";
			strSql += "        	AA.DEPT_CODE ,  \n";
			strSql += "        	A2.DEPT_NAME ,  \n";
			strSql += "        	--�ι��ڵ�  \n";
			strSql += "        	AA.CLASS_CODE ,  \n";
			strSql += "        	A3.CLASS_CODE_NAME ,  \n";
			strSql += "        	--�����ڵ�  \n";
			strSql += "        	AA.VAT_CODE ,  \n";
			strSql += "        	A4.VAT_NAME ,  \n";
			strSql += "        	F_T_DATETOSTRING(AA.VAT_DT) VAT_DT ,  \n";
			strSql += "        	TO_CHAR(AA.SUPAMT, 'FM9,999,999,999,999') SUPAMT ,  \n";
			strSql += "        	TO_CHAR(AA.VATAMT, 'FM9,999,999,999,999') VATAMT ,  \n";
			strSql += "        	A1.RCPTBILL_CLS ,  \n";
			strSql += "        	A1.SUBTR_CLS ,  \n";
			strSql += "        	A1.SALEBUY_CLS ,  \n";
			strSql += "        	A1.VATOCCUR_CLS ,  \n";
			strSql += "        	A1.SLIP_DETAIL_LIST ,  \n";
			strSql += "        	--�������  \n";
			strSql += "        	A1.BUDG_MNG ,  \n";
			strSql += "        	--��������  \n";
			strSql += "        	A1.BUDG_EXEC_CLS ,  \n";
			strSql += "        	--�ŷ�ó�ڵ����  \n";
			strSql += "        	A1.CUST_CODE_MNG ,  \n";
			strSql += "        	A1.CUST_CODE_MNG_TG ,  \n";
			strSql += "        	TO_CHAR(AA.CUST_SEQ) CUST_SEQ ,  \n";
			strSql += "        	F_T_CUST_MASK(A6.CUST_CODE) CUST_CODE ,  \n";
			strSql += "        	--�ŷ�ó������  \n";
			strSql += "        	A1.CUST_NAME_MNG ,  \n";
			strSql += "        	A1.CUST_NAME_MNG_TG ,  \n";
			strSql += "        	AA.CUST_NAME ,  \n";
			strSql += "        	--�������  \n";
			strSql += "        	A1.BANK_MNG ,  \n";
			strSql += "        	A1.BANK_MNG_TG ,  \n";
			strSql += "        	AA.BANK_CODE ,  \n";
			strSql += "        	A5.BANK_NAME ,  \n";
			strSql += "        	--���°���  \n";
			strSql += "        	A1.ACCNO_MNG ,  \n";
			strSql += "        	A1.ACCNO_MNG_TG ,  \n";
			strSql += "        	AA.ACCNO ,  \n";
			strSql += "        	--�ܾװ���  \n";
			strSql += "        	A1.ACC_REMAIN_MNG ,  \n";
			strSql += "        	AA.RESET_SLIP_ID ,  \n";
			strSql += "        	AA.RESET_SLIP_IDSEQ ,  \n";
			strSql += "         --ī���ȣ   \n";
			strSql += "         A1.CARD_SEQ_MNG ,   \n";
			strSql += "         A1.CARD_SEQ_MNG_TG ,   \n";
			strSql += "         ''||AA.CARD_SEQ CARD_SEQ_B,   \n";
			strSql += "         B0.CARDNO CARD_NO,   \n";
			strSql += "        	--���¼�ǥ  \n";
			strSql += "        	A1.CHK_NO_MNG ,  \n";
			strSql += "        	A1.CHK_NO_MNG_TG ,  \n";
			strSql += "        	AA.CHK_NO ,  \n";
			strSql += "        	F_T_DATETOSTRING(B1.PUBL_DT) CHK_PUBL_DT ,  \n";
			strSql += "        	--���޾���  \n";
			strSql += "        	A1.BILL_NO_MNG ,  \n";
			strSql += "        	A1.BILL_NO_MNG_TG ,  \n";
			strSql += "        	AA.BILL_NO ,  \n";
			strSql += "        	--���޾��� ����  \n";
			strSql += "        	B2.CHK_BILL_NO BILL_NO_S ,  \n";
			strSql += "        	F_T_DATETOSTRING(B2.PUBL_DT) BILL_PUBL_DT ,  \n";
			strSql += "        	F_T_DATETOSTRING(B2.EXPR_DT) BILL_EXPR_DT ,  \n";
			strSql += "        	--���޾��� ����  \n";
			strSql += "        	B3.CHK_BILL_NO BILL_NO_R ,  \n";
			strSql += "        	F_T_DATETOSTRING(B3.PUBL_DT) BILL_PUBL_DT_R ,  \n";
			strSql += "        	F_T_DATETOSTRING(B3.EXPR_DT) BILL_EXPR_DT_R ,  \n";
			strSql += "        	F_T_DATETOSTRING(B3.CHG_EXPR_DT) BILL_CHG_EXPR_DT_R ,  \n";
			strSql += "       	--������������ \n";
			strSql += "       	A1.REC_BILL_NO_MNG , \n";
			strSql += "       	A1.REC_BILL_NO_MNG_TG , \n";
			strSql += "       	AA.REC_BILL_NO , \n";
			strSql += "       	C1.REC_CHK_BILL_NO REC_BILL_NO_S , \n";
			strSql += "       	F_T_DATETOSTRING(C1.PUBL_DT) REC_BILL_PUBL_DT , \n";
			strSql += "       	F_T_DATETOSTRING(C1.EXPR_DT) REC_BILL_EXPR_DT , \n";
			strSql += "       	--������������ \n";
			strSql += "       	C2.REC_CHK_BILL_NO REC_BILL_NO_R , \n";
			strSql += "       	F_T_DATETOSTRING(C2.PUBL_DT) REC_BILL_PUBL_DT_R , \n";
			strSql += "       	F_T_DATETOSTRING(C2.EXPR_DT) REC_BILL_EXPR_DT_R , \n";
			strSql += "       	TO_CHAR(C2.PUBL_AMT, 'FM9,999,999,999,999') REC_BILL_PUBL_AMT_R , \n";
			strSql += "       	F_T_DATETOSTRING(C2.DISH_DT) REC_BILL_DISH_DT_R , \n";
			strSql += "       	F_T_DATETOSTRING(C2.TRUST_DT) REC_BILL_TRUST_DT_R , \n";
			strSql += "       	C2.TRUST_BANK_CODE REC_BILL_TRUST_BANK_CODE_R, \n";
			strSql += "       	C21.BANK_NAME REC_BILL_TRUST_BANK_NAME_R , \n";
			strSql += "       	F_T_DATETOSTRING(C2.DISC_DT) REC_BILL_DISC_DT_R , \n";
			strSql += "       	C2.DISC_BANK_CODE REC_BILL_DISC_BANK_CODE_R, \n";
			strSql += "       	C22.BANK_NAME REC_BILL_DISC_BANK_NAME_R , \n";
			strSql += "       	TO_CHAR(C2.DISC_RAT, 'FM9,999,999,999,999') REC_BILL_DISC_RAT_R, \n";
			strSql += "       	TO_CHAR(C2.DISC_AMT, 'FM9,999,999,999,999') REC_BILL_DISC_AMT_R, \n";
			strSql += "        	--CP ����  \n";
			strSql += "        	A1.CP_NO_MNG ,  \n";
			strSql += "        	A1.CP_NO_MNG_TG ,  \n";
			strSql += "        	AA.CP_NO ,  \n";
			strSql += "        	--CP����  \n";
			strSql += "        	D1.CP_NO CP_NO_S ,  \n";
			strSql += "        	F_T_DATETOSTRING(D1.PUBL_DT) CP_BUY_PUBL_DT,  \n";
			strSql += "        	F_T_DATETOSTRING(D1.EXPR_DT) CP_BUY_EXPR_DT,  \n";
			strSql += "        	F_T_DATETOSTRING(D1.DUSE_DT) CP_BUY_DUSE_DT,  \n";
			strSql += "        	TO_CHAR(D1.PUBL_AMT, 'FM9,999,999,999,999') CP_BUY_PUBL_AMT,  \n";
			strSql += "        	TO_CHAR(D1.INCOME_AMT, 'FM9,999,999,999,999') CP_BUY_INCOME_AMT,  \n";
			strSql += "        	D1.PUBL_PLACE CP_BUY_PUBL_PLACE,  \n";
			strSql += "        	D1.PUBL_NAME CP_BUY_PUBL_NAME,  \n";
			strSql += "        	D1.INTR_RAT CP_BUY_INTR_RAT,  \n";
			strSql += "        	D1.CUST_SEQ CP_BUY_CUST_SEQ,  \n";
			strSql += "        	F_T_CUST_MASK(D11.CUST_CODE) CP_BUY_CUST_CODE,  \n";
			strSql += "        	D11.CUST_NAME CP_BUY_CUST_NAME,  \n";
			strSql += "        	--CP����  \n";
			strSql += "        	D2.CP_NO CP_NO_R ,  \n";
			strSql += "        	F_T_DATETOSTRING(D2.PUBL_DT) CP_BUY_PUBL_DT_R,  \n";
			strSql += "        	F_T_DATETOSTRING(D2.EXPR_DT) CP_BUY_EXPR_DT_R,  \n";
			strSql += "        	F_T_DATETOSTRING(D2.DUSE_DT) CP_BUY_DUSE_DT_R,  \n";
			strSql += "        	TO_CHAR(D2.PUBL_AMT, 'FM9,999,999,999,999') CP_BUY_PUBL_AMT_R,  \n";
			strSql += "        	TO_CHAR(D2.INCOME_AMT, 'FM9,999,999,999,999') CP_BUY_INCOME_AMT_R,  \n";
			strSql += "        	D2.PUBL_PLACE CP_BUY_PUBL_PLACE_R,  \n";
			strSql += "        	D2.PUBL_NAME CP_BUY_PUBL_NAME_R,  \n";
			strSql += "        	D2.INTR_RAT CP_BUY_INTR_RAT_R,  \n";
			strSql += "        	D2.CUST_SEQ CP_BUY_CUST_SEQ_R,  \n";
			strSql += "        	F_T_CUST_MASK(D21.CUST_CODE) CP_BUY_CUST_CODE_R,  \n";
			strSql += "        	D21.CUST_NAME CP_BUY_CUST_NAME_R,  \n";
			strSql += "        	TO_CHAR(D2.RESET_AMT, 'FM9,999,999,999,999') CP_BUY_RESET_AMT_R,  \n";
			strSql += "        	--��������  \n";
			strSql += "        	A1.SECU_MNG ,  \n";
			strSql += "        	A1.SECU_MNG_TG ,  \n";
			strSql += "        	AA.SECU_NO ,  \n";
			strSql += "        	NVL(E1.REAL_SECU_NO,'')||NVL(E2.REAL_SECU_NO,'') SECU_REAL_SECU_NO,  \n";
			strSql += "        	--�������� ����  \n";
			strSql += "        	E1.SECU_NO SECU_NO_S ,  \n";
			strSql += "        	E1.REAL_SECU_NO SECU_REAL_SECU_NO_S,  \n";
			strSql += "        	E1.SEC_KIND_CODE SECU_SEC_KIND_CODE,  \n";
			strSql += "        	E1.GET_DT SECU_GET_DT,  \n";
			strSql += "        	E1.GET_PLACE SECU_GET_PLACE,  \n";
			strSql += "        	TO_CHAR(E1.PERSTOCK_AMT, 'FM9,999,999,999,999') SECU_PERSTOCK_AMT ,  \n";
			strSql += "        	TO_CHAR(E1.INCOME_AMT, 'FM9,999,999,999,999') SECU_INCOME_AMT,  \n";
			strSql += "        	TO_CHAR(E1.BF_GET_ITR_AMT, 'FM9,999,999,999,999') SECU_BF_GET_ITR_AMT,  \n";
			strSql += "        	TO_CHAR(E1.GET_ITR_AMT, 'FM9,999,999,999,999') SECU_GET_ITR_AMT,  \n";
			strSql += "        	F_T_DATETOSTRING(E1.PUBL_DT) SECU_PUBL_DT ,  \n";
			strSql += "        	E1.ITR_TAG SECU_ITR_TAG,  \n";
			strSql += "        	F_T_DATETOSTRING(E1.EXPR_DT) SECU_EXPR_DT ,  \n";
			strSql += "        	E1.INTR_RATE SECU_INTR_RATE ,  \n";
			strSql += "        	--�������� ����  \n";
			strSql += "        	E2.SECU_NO SECU_NO_R ,  \n";
			strSql += "        	E2.REAL_SECU_NO SECU_REAL_SECU_NO_R,  \n";
			strSql += "        	TO_CHAR(E2.PERSTOCK_AMT, 'FM9,999,999,999,999') SECU_PERSTOCK_AMT_R ,  \n";
			strSql += "        	F_T_DATETOSTRING(E2.PUBL_DT) SECU_PUBL_DT_R ,  \n";
			strSql += "        	F_T_DATETOSTRING(E2.EXPR_DT) SECU_EXPR_DT_R ,  \n";
			strSql += "        	E2.INTR_RATE SECU_INTR_RATE_R ,  \n";
			strSql += "        	TO_CHAR(E2.SALE_AMT, 'FM9,999,999,999,999') SECU_SALE_AMT_R ,  \n";
			strSql += "        	F_T_DATETOSTRING(E2.SALE_DT) SECU_SALE_DT_R ,  \n";
			strSql += "        	F_T_DATETOSTRING(E2.RETURN_DT) SECU_RETURN_DT_R ,  \n";
			strSql += "        	E2.CONSIGN_BANK SECU_CONSIGN_BANK_R ,  \n";
			strSql += "        	E3.BANK_NAME SECU_CONSIGN_BANK_NAME_R ,  \n";
			strSql += "        	TO_CHAR(E2.SALE_ITR_AMT, 'FM9,999,999,999,999') SECU_SALE_ITR_AMT_R ,  \n";
			strSql += "        	TO_CHAR(E2.SALE_TAX, 'FM9,999,999,999,999') SECU_SALE_TAX_R ,  \n";
			strSql += "        	TO_CHAR(E2.SALE_LOSS, 'FM9,999,999,999,999') SECU_SALE_LOSS_R ,  \n";
			strSql += "        	TO_CHAR(E2.SALE_NP_ITR_AMT, 'FM9,999,999,999,999') SECU_SALE_NP_ITR_AMT_R ,  \n";
			strSql += "        	--����  \n";
			strSql += "        	A1.LOAN_NO_MNG ,  \n";
			strSql += "        	A1.LOAN_NO_MNG_TG ,  \n";
			strSql += "        	AA.LOAN_REFUND_NO ,  \n";
			strSql += "        	AA.LOAN_REFUND_SEQ ,  \n";
			strSql += "        	--���Լ���  \n";
			strSql += "        	F1.LOAN_NO LOAN_REFUND_NO_S,  \n";
			strSql += "        	F1.LOAN_REFUND_SEQ LOAN_REFUND_SEQ_S,  \n";
			strSql += "        	F_T_DATETOSTRING(F1.TRANS_DT) LOAN_TRANS_DT,  \n";
			strSql += "        	F_T_DATETOSTRING(F1.LOAN_FDT) LOAN_FDT ,  \n";
			strSql += "        	F_T_DATETOSTRING(F1.LOAN_EXPR_DT) LOAN_EXPR_DT ,  \n";
			strSql += "        	F1.REAL_INTR_RATE LOAN_REAL_INTR_RATE ,  \n";
			strSql += "        	F1.TITLE_INTR_RATE LOAN_TITLE_INTR_RATE ,  \n";
			strSql += "        	--���Թ���  \n";
			strSql += "        	F2.LOAN_NO LOAN_REFUND_NO_R ,  \n";
			strSql += "        	F2.LOAN_REFUND_SEQ LOAN_REFUND_SEQ_R ,  \n";
			strSql += "        	TO_CHAR(F2.REFUND_AMT, 'FM9,999,999,999,999') LOAN_REFUND_AMT_R ,  \n";
			strSql += "        	F_T_DATETOSTRING(F2.TRANS_DT) LOAN_TRANS_DT_R,  \n";
			strSql += "        	F_T_DATETOSTRING(F2.REFUND_SCH_DT) LOAN_REFUND_SCH_DT_R ,  \n";
			strSql += "        	TO_CHAR(F2.REFUND_SCH_ORG_AMT, 'FM9,999,999,999,999') LOAN_REFUND_SCH_ORG_AMT_R ,  \n";
			strSql += "        	TO_CHAR(F2.REFUND_SCH_INTR_AMT, 'FM9,999,999,999,999') LOAN_REFUND_SCH_INTR_AMT_R ,  \n";
			strSql += "        	DECODE(NVL(F2.REFUND_AMT,0), 0, NULL, F_T_DATETOSTRING(F2.REFUND_INTR_DT)) LOAN_REFUND_DT_R ,  \n";
			strSql += "        	--��������  \n";
			strSql += "        	F3.LOAN_NO LOAN_REFUND_NO_I ,  \n";
			strSql += "        	F3.LOAN_REFUND_SEQ LOAN_REFUND_SEQ_I ,  \n";
			strSql += "        	F_T_DATETOSTRING(F3.REFUND_SCH_DT) LOAN_REFUND_SCH_DT_I ,  \n";
			strSql += "        	F3.REFUND_SCH_ORG_AMT LOAN_REFUND_SCH_ORG_AMT_I ,  \n";
			strSql += "        	DECODE(NVL(F3.INTR_AMT,0), 0, NULL, F_T_DATETOSTRING(F3.REFUND_INTR_DT)) LOAN_INTR_DT_I ,  \n";
			strSql += "        	--�����ڻ�  \n";
			strSql += "        	A1.FIXED_MNG ,  \n";
			strSql += "        	A1.FIXED_MNG_TG ,  \n";
			strSql += "       	TO_CHAR(AA.FIX_ASSET_SEQ) FIX_ASSET_SEQ, \n";
			strSql += "        	--����  \n";
			strSql += "        	A1.DEPOSIT_PAY_MNG ,  \n";
			strSql += "        	A1.DEPOSIT_PAY_MNG_TG ,  \n";
			strSql += "        	AA.DEPOSIT_ACCNO ,  \n";
			strSql += "        	AA.PAYMENT_SEQ ,  \n";
			strSql += "        	F_T_DATETOSTRING(G1.PAYMENT_SCH_DT) PAYMENT_SCH_DT ,  \n";
			strSql += "        	TO_CHAR(G1.PAYMENT_SCH_AMT, 'FM9,999,999,999,999') PAYMENT_SCH_AMT ,  \n";
			strSql += "        	F_T_DATETOSTRING(G1.PAYMENT_DT) PAYMENT_DT ,  \n";
			strSql += "        	TO_CHAR(G1.PAYMENT_AMT, 'FM9,999,999,999,999') PAYMENT_AMT ,  \n";
			strSql += "        	--�����������  \n";
			strSql += "        	A1.PAY_CON_MNG ,  \n";
			strSql += "        	A1.PAY_CON_MNG_TG ,  \n";
			strSql += "        	TO_CHAR(AA.PAY_CON_CASH, 'FM9,999,999,999,999') PAY_CON_CASH ,  \n";
			strSql += "        	TO_CHAR(AA.PAY_CON_BILL, 'FM9,999,999,999,999') PAY_CON_BILL ,  \n";
			strSql += "        	TO_CHAR(AA.PAY_CON_BILL_DAYS, 'FM9,999,999,999,999') PAY_CON_BILL_DAYS ,  \n";
			strSql += "        	A1.BILL_EXPR_MNG ,  \n";
			strSql += "        	A1.BILL_EXPR_MNG_TG ,  \n";
			strSql += "        	F_T_DATETOSTRING(AA.PAY_CON_BILL_DT) PAY_CON_BILL_DT ,  \n";
			strSql += "        	--�����ȣ  \n";
			strSql += "        	A1.EMP_NO_MNG ,  \n";
			strSql += "        	A1.EMP_NO_MNG_TG ,  \n";
			strSql += "        	AA.EMP_NO ,  \n";
			strSql += "        	ZZ.NAME EMP_NAME ,  \n";
			strSql += "        	--���������  \n";
			strSql += "        	A1.ANTICIPATION_DT_MNG ,  \n";
			strSql += "        	A1.ANTICIPATION_DT_MNG_TG ,  \n";
			strSql += "        	F_T_DATETOSTRING(AA.ANTICIPATION_DT) ANTICIPATION_DT ,  \n";
			strSql += "        	--���ݿ�����  \n";
			strSql += "        	DECODE(A1.SLIP_DETAIL_LIST,'P','T','F') CASH_MNG,  \n";
			strSql += "        	H1.CASH_SEQ,  \n";
			strSql += "        	H1.CASHNO CASH_CASHNO,  \n";
			strSql += "        	F_T_DATETOSTRING(H1.USE_DT) CASH_USE_DT,  \n";
			strSql += "        	TO_CHAR(H1.TRADE_AMT, 'FM9,999,999,999,999') CASH_TRADE_AMT,  \n";
			strSql += "        	H1.REQ_TG CASH_REQ_TG,  \n";
			strSql += "        	--�ſ�ī��  \n";
			strSql += "        	DECODE(A1.SLIP_DETAIL_LIST,'C','T','F') CARD_MNG,  \n";
			strSql += "        	I1.CARD_SEQ,  \n";
			strSql += "        	I1.CARDNO CARD_CARDNO,  \n";
			strSql += "        	F_T_DATETOSTRING(I1.USE_DT) CARD_USE_DT,  \n";
			strSql += "        	I1.HAVE_PERS CARD_HAVE_PERS,  \n";
			strSql += "        	TO_CHAR(I1.TRADE_AMT, 'FM9,999,999,999,999') CARD_TRADE_AMT,  \n";
			strSql += "        	I1.REQ_TG CARD_REQ_TG,  \n";
			strSql += "        	--�����׸�  \n";
			strSql += "        	A1.MNG_NAME_CHAR1 ,  \n";
			strSql += "        	A1.MNG_TG_CHAR1 ,  \n";
			strSql += "        	AA.MNG_ITEM_CHAR1 ,  \n";
			strSql += "        	A1.MNG_NAME_CHAR2 ,  \n";
			strSql += "        	A1.MNG_TG_CHAR2 ,  \n";
			strSql += "        	AA.MNG_ITEM_CHAR2 ,  \n";
			strSql += "        	A1.MNG_NAME_CHAR3 ,  \n";
			strSql += "        	A1.MNG_TG_CHAR3 ,  \n";
			strSql += "        	AA.MNG_ITEM_CHAR3 ,  \n";
			strSql += "        	A1.MNG_NAME_CHAR4 ,  \n";
			strSql += "        	A1.MNG_TG_CHAR4 ,  \n";
			strSql += "        	AA.MNG_ITEM_CHAR4 ,  \n";
			strSql += "        	A1.MNG_NAME_NUM1 ,  \n";
			strSql += "        	A1.MNG_TG_NUM1 ,  \n";
			strSql += "        	TO_CHAR(AA.MNG_ITEM_NUM1, 'FM9,999,999,999,999') MNG_ITEM_NUM1 ,  \n";
			strSql += "        	A1.MNG_NAME_NUM2 ,  \n";
			strSql += "        	A1.MNG_TG_NUM2 ,  \n";
			strSql += "        	TO_CHAR(AA.MNG_ITEM_NUM2, 'FM9,999,999,999,999') MNG_ITEM_NUM2 ,  \n";
			strSql += "        	A1.MNG_NAME_NUM3 ,  \n";
			strSql += "        	A1.MNG_TG_NUM3 ,  \n";
			strSql += "        	TO_CHAR(AA.MNG_ITEM_NUM3, 'FM9,999,999,999,999') MNG_ITEM_NUM3 ,  \n";
			strSql += "        	A1.MNG_NAME_NUM4 ,  \n";
			strSql += "        	A1.MNG_TG_NUM4 ,  \n";
			strSql += "        	TO_CHAR(AA.MNG_ITEM_NUM1, 'FM9,999,999,999,999') MNG_ITEM_NUM4 ,  \n";
			strSql += "        	A1.MNG_NAME_DT1 ,  \n";
			strSql += "        	A1.MNG_TG_DT1 ,  \n";
			strSql += "        	F_T_DATETOSTRING(AA.MNG_ITEM_DT1) MNG_ITEM_DT1 ,  \n";
			strSql += "        	A1.MNG_NAME_DT2 ,  \n";
			strSql += "        	A1.MNG_TG_DT2 ,  \n";
			strSql += "        	F_T_DATETOSTRING(AA.MNG_ITEM_DT2) MNG_ITEM_DT2 ,  \n";
			strSql += "        	A1.MNG_NAME_DT3 ,  \n";
			strSql += "        	A1.MNG_TG_DT3 ,  \n";
			strSql += "        	F_T_DATETOSTRING(AA.MNG_ITEM_DT3) MNG_ITEM_DT3 ,  \n";
			strSql += "        	A1.MNG_NAME_DT4 ,  \n";
			strSql += "        	A1.MNG_TG_DT4 ,  \n";
			strSql += "        	F_T_DATETOSTRING(AA.MNG_ITEM_DT4) MNG_ITEM_DT4 ,  \n";
			strSql += "        	DECODE( AA.RESET_SLIP_ID, NULL, '', 0, '', F_T_Get_Make_Slipno(AA.RESET_SLIP_ID, AA.RESET_SLIP_IDSEQ) ) RESET_SLIPNO  \n";
			strSql += "  From \n";
			strSql += "  		T_WORK_ACC_SLIP_BODY AA,  \n";
			strSql += "  		T_ACC_CODE_VIEW A1,  \n";
			strSql += "  		T_DEPT_CODE A2,  \n";
			strSql += "  		T_CLASS_CODE A3,  \n";
			strSql += "  		T_ACC_VAT_CODE A4,  \n";
			strSql += "  		T_BANK_CODE A5,  \n";
			strSql += "  		T_CUST_CODE A6,  \n";
			strSql += "  		T_COMPANY A7,  \n";
			strSql += "  		T_COMPANY A8, \n";
			strSql += "   		T_ACC_CREDCARD B0,   \n";
			strSql += "  		(--���¼�ǥ���� \n";
			strSql += " 	 		SELECT * FROM T_FIN_PAY_CHK_BILL \n";
			strSql += " 	 		WHERE \n";
			strSql += " 		 		CHK_BILL_CLS = 'C' \n";
			strSql += " 		 		And NVL(SLIP_ID, 0) = 0 \n";
			strSql += "  		) B1,  \n";
			strSql += "  		(--���޾������� \n";
			strSql += " 	 		SELECT * FROM T_FIN_PAY_CHK_BILL \n";
			strSql += " 	 		WHERE \n";
			strSql += " 		 		CHK_BILL_CLS = 'B' \n";
			strSql += " 		 		And NVL(SLIP_ID, 0) = 0 \n";
			strSql += "  		) B2,  \n";
			strSql += "  		(--���޾������� \n";
			strSql += " 	 		SELECT * FROM T_FIN_PAY_CHK_BILL \n";
			strSql += " 	 		WHERE \n";
			strSql += " 		 		CHK_BILL_CLS = 'B' \n";
			strSql += " 		 		And NVL(SLIP_ID, 0) <> 0 \n";
			strSql += "  		) B3,  \n";
			strSql += "  		(--������������ \n";
			strSql += " 	 		SELECT * FROM T_FIN_RECEIVE_CHK_BILL \n";
			strSql += " 	 		WHERE \n";
			strSql += " 		 		NVL(SLIP_ID, 0) = 0 \n";
			strSql += "  		) C1,  \n";
			strSql += "  		(--������������ \n";
			strSql += " 	 		SELECT * FROM T_FIN_RECEIVE_CHK_BILL \n";
			strSql += " 	 		WHERE \n";
			strSql += " 		 		NVL(SLIP_ID, 0) <> 0 \n";
			strSql += "  		) C2,  \n";
			strSql += "			T_BANK_CODE C21, \n";
			strSql += "			T_BANK_CODE C22, \n";
			strSql += "  		( \n";
			strSql += " 	 		SELECT * FROM T_FIN_CP_BUY \n";
			strSql += " 	 		WHERE \n";
			strSql += " 		 		NVL(SLIP_ID, 0) = 0 \n";
			strSql += "  		) D1,  \n";
			strSql += "  		T_CUST_CODE D11,  \n";
			strSql += "  		( \n";
			strSql += " 	 		SELECT * FROM T_FIN_CP_BUY \n";
			strSql += " 	 		WHERE \n";
			strSql += " 		 		NVL(SLIP_ID, 0) <> 0 \n";
			strSql += "  		) D2,  \n";
			strSql += "  		T_CUST_CODE D21,  \n";
			strSql += "  		( \n";
			strSql += " 	 		SELECT * FROM T_FIN_SECURTY \n";
			strSql += " 	 		WHERE \n";
			strSql += " 		 		NVL(SLIP_ID, 0) = 0 \n";
			strSql += "  		) E1,  \n";
			strSql += "  		( \n";
			strSql += " 	 		SELECT * FROM T_FIN_SECURTY \n";
			strSql += " 	 		WHERE \n";
			strSql += " 		 		NVL(SLIP_ID, 0) <> 0 \n";
			strSql += "  		) E2,  \n";
			strSql += "  		T_BANK_CODE E3,  \n";
			strSql += " 		(  \n";
			strSql += " 			SELECT  \n";
			strSql += " 				A.LOAN_NO, \n";
			strSql += " 				A.TITLE_INTR_RATE, \n";
			strSql += " 				A.REAL_INTR_RATE, \n";
			strSql += " 				A.LOAN_EXPR_DT, \n";
			strSql += " 				A.LOAN_FDT, \n";
			strSql += " 				B.LOAN_REFUND_SEQ,  \n";
			strSql += " 				B.TRANS_DT,  \n";
			strSql += " 				B.LOAN_AMT,  \n";
			strSql += " 				B.LOAN_SLIP_ID,  \n";
			strSql += " 				B.LOAN_SLIP_IDSEQ   \n";
			strSql += " 			FROM  \n";
			strSql += " 		 		T_FIN_LOAN_SHEET A,  \n";
			strSql += " 		 		T_FIN_LOAN_REFUND_LIST B  \n";
			strSql += " 			WHERE  \n";
			strSql += " 				A.LOAN_NO = B.LOAN_NO  \n";
			strSql += " 				And	NVL(B.LOAN_AMT, 0) <> 0 \n";
			strSql += " 		) F1,  \n";
			strSql += "  		( \n";
			strSql += " 	 		SELECT * FROM T_FIN_LOAN_REFUND_LIST \n";
			strSql += " 	 		WHERE \n";
			strSql += " 		 		NVL(REFUND_AMT, 0) <> 0 \n";
			strSql += "  		) F2,  \n";
			strSql += "  		( \n";
			strSql += " 	 		SELECT * FROM T_FIN_LOAN_REFUND_LIST \n";
			strSql += " 	 		WHERE \n";
			strSql += " 		 		NVL(INTR_AMT, 0) <> 0 \n";
			strSql += "  		) F3,  \n";
			strSql += "  		( \n";
			strSql += " 	 		SELECT * FROM T_DEPOSIT_PAYMENT_LIST \n";
			strSql += " 	 		WHERE \n";
			strSql += " 		 		NVL(SLIP_ID, 0) = 0 \n";
			strSql += "  		) G1,  \n";
			strSql += "  		T_WORK_ACC_SLIP_EXPENSE_CASH H1,  \n";
			strSql += "  		T_WORK_ACC_SLIP_EXPENSE_CARDS I1,  \n";
			strSql += "  		Z_AUTHORITY_USER ZZ  \n";
			strSql += "  Where \n";
			strSql += "  AA.ACC_CODE = A1.ACC_CODE  \n";
			strSql += "  And		AA.DEPT_CODE = A2.DEPT_CODE(+)  \n";
			strSql += "  And		AA.CLASS_CODE = A3.CLASS_CODE(+)  \n";
			strSql += "  And		AA.VAT_CODE = A4.VAT_CODE(+)  \n";
			strSql += "  And		AA.BANK_CODE = A5.BANK_CODE(+)  \n";
			strSql += "  And		AA.CUST_SEQ = A6.CUST_SEQ(+)  \n";
			strSql += "  And		AA.TAX_COMP_CODE = A7.COMP_CODE(+)  \n";
			strSql += "  And		AA.COMP_CODE = A8.COMP_CODE(+) \n";
			strSql += "  And		AA.CARD_SEQ = B0.CARD_SEQ(+) \n";
			strSql += "  --���¼�ǥ \n";
			strSql += "  And		NVL(AA.CHK_NO,' ') = B1.CHK_BILL_NO(+) \n";
			strSql += "  --���޾��� ���� \n";
			strSql += "  And		NVL(AA.BILL_NO,' ') = B2.CHK_BILL_NO(+) \n";
			strSql += "  --���޾��� ���� \n";
			strSql += "  And		NVL(AA.BILL_NO,' ') = B3.CHK_BILL_NO(+) \n";
			strSql += "  --�������� ���� \n";
			strSql += "  And		NVL(AA.REC_BILL_NO,' ') = C1.REC_CHK_BILL_NO(+) \n";
			strSql += "  --�������� ���� \n";
			strSql += "  And		NVL(AA.REC_BILL_NO,' ') = C2.REC_CHK_BILL_NO(+) \n";
			strSql += "	 And		C2.TRUST_BANK_CODE = C21.BANK_CODE(+) \n";
			strSql += "	 And		C2.DISC_BANK_CODE = C22.BANK_CODE(+) \n";
			strSql += "  --CP���Լ��� \n";
			strSql += "  And		NVL(AA.CP_NO,' ') = D1.CP_NO(+) \n";
			strSql += "  And		D1.CUST_SEQ = D11.CUST_SEQ(+)  \n";
			strSql += "  --CP���Թ��� \n";
			strSql += "  And		NVL(AA.CP_NO,' ') = D2.CP_NO(+) \n";
			strSql += "  And		D2.CUST_SEQ = D21.CUST_SEQ(+) \n";
			strSql += "  --�������Ǽ��� \n";
			strSql += "  And		NVL(AA.SECU_NO,0) = E1.SECU_NO(+) \n";
			strSql += "  --�������ǹ��� \n";
			strSql += "  And		NVL(AA.SECU_NO,0) = E2.SECU_NO(+) \n";
			strSql += "  And		E2.CONSIGN_BANK = E3.BANK_CODE(+) \n";
			strSql += "  --���� ���� \n";
			strSql += "  And		NVL(AA.LOAN_REFUND_NO, ' ') = F1.LOAN_NO(+) \n";
			strSql += "  And		NVL(AA.LOAN_REFUND_SEQ, 0) = F1.LOAN_REFUND_SEQ(+) \n";
			strSql += "  --���� ����  \n";
			strSql += "  And		NVL(AA.LOAN_REFUND_NO, ' ') = F2.LOAN_NO(+) \n";
			strSql += "  And		NVL(AA.LOAN_REFUND_SEQ, 0) = F2.LOAN_REFUND_SEQ(+) \n";
			strSql += "  --���� ����  \n";
			strSql += "  And		NVL(AA.LOAN_REFUND_NO, ' ') = F3.LOAN_NO(+) \n";
			strSql += "  And		NVL(AA.LOAN_REFUND_SEQ, 0) = F3.LOAN_REFUND_SEQ(+) \n";
			strSql += "  --������ \n";
			strSql += "  And		NVL(AA.ACCNO, ' ') = G1.ACCNO(+) \n";
			strSql += "  And		NVL(AA.PAYMENT_SEQ, 0) = G1.PAYMENT_SEQ(+) \n";
			strSql += "  And		NVL(G1.SLIP_ID, 0) = 0 \n";
			strSql += "  And		AA.SLIP_ID = H1.SLIP_ID(+)  \n";
			strSql += "  And		AA.SLIP_IDSEQ = H1.SLIP_IDSEQ(+)  \n";
			strSql += "  And		AA.SLIP_ID = I1.SLIP_ID(+)   \n";
			strSql += "  And		AA.SLIP_IDSEQ = I1.SLIP_IDSEQ(+)  \n";
			strSql += "  And		AA.EMP_NO = ZZ.EMPNO(+)  \n";
			strSql += "  And		AA.SLIP_ID =   ?    \n";
			strSql += "  And		AA.SLIP_IDSEQ =  ?  \n";
			strSql += "  Order By AA.MAKE_SLIPLINE  \n";
			strSql += "  ";
			
			lrArgData.addColumn("WORK_SLIP_ID", CITData.NUMBER);
			lrArgData.addColumn("WORK_SLIP_IDSEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("WORK_SLIP_ID", strWORK_SLIP_ID);
			lrArgData.setValue("WORK_SLIP_IDSEQ", strWORK_SLIP_IDSEQ);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("SLIP_ID", true);
				lrReturnData.setKey("SLIP_IDSEQ", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SLIP_D Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("RESET_CNT"))
		{
			String strSLIP_ID = CITCommon.toKOR(request.getParameter("SLIP_ID"));
			String strSLIP_IDSEQ = CITCommon.toKOR(request.getParameter("SLIP_IDSEQ"));
			
			strSql  = " SELECT	COUNT(*) RESET_CNT \n";
			strSql += " FROM	T_ACC_SLIP_BODY1 A \n";
			strSql += " WHERE	A.RESET_SLIP_ID =  ? \n";
			strSql += " AND		A.RESET_SLIP_IDSEQ =  ?  ";
			
			lrArgData.addColumn("SLIP_ID", CITData.VARCHAR2);
			lrArgData.addColumn("SLIP_IDSEQ", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("SLIP_ID", strSLIP_ID);
			lrArgData.setValue("SLIP_IDSEQ", strSLIP_IDSEQ);
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
		else if (strAct.equals("SLIP_ID"))
		{
			strSql  = " Select F_T_Get_NewSlip_Id() SLIP_ID	From DUAL ";

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
				GauceInfo.response.writeException("USER", "900001","SLIP_ID Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SLIP_IDSEQ"))
		{
			strSql  = " Select F_T_Get_NewSlip_IdSeq() SLIP_IDSEQ	From DUAL ";

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
				GauceInfo.response.writeException("USER", "900001","SLIP_IDSEQ Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAKE_SEQ"))
		{
			String strMAKE_COMP_CODE = CITCommon.toKOR(request.getParameter("MAKE_COMP_CODE"));
			String strMAKE_DT_TRANS = CITCommon.toKOR(request.getParameter("MAKE_DT_TRANS"));
			
			strSql  = " Select F_T_GET_NEW_MAKE_SEQ(?,?) MAKE_SEQ	From DUAL ";
			
			lrArgData.addColumn("MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("MAKE_DT_TRANS", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("MAKE_DT_TRANS", strMAKE_DT_TRANS);

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
				GauceInfo.response.writeException("USER", "900001","MAKE_SEQ Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CLASS_CODE"))
		{
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			
			strSql  = " SELECT	A.DEPT_CODE , \n";
			strSql += "       	A.CLASS_CODE , \n";
			strSql += "       	B.CLASS_CODE_NAME , \n";
			strSql += "       	A.DFLT_TAG \n";
			strSql += " FROM	T_DEPT_CLASS_CODE A, \n";
			strSql += " 		T_CLASS_CODE B \n";
			strSql += " WHERE	A.CLASS_CODE = B.CLASS_CODE \n";
			strSql += " AND		A.DEPT_CODE =  ?  \n";
			strSql += " AND		A.DFLT_TAG = 'T' ";
			
			lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
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
				GauceInfo.response.writeException("USER", "900001","CLASS_CODE Select ����-> "+ ex.getMessage());
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
				GauceInfo.response.writeException("USER", "900001","CLSE_CLS Select ����-> "+ ex.getMessage());
			}
		}
		
		else if (strAct.equals("EXEC_PROC"))
		{
			String	strCMD = CITCommon.toKOR(request.getParameter("CMD"));
			if(strCMD.equals("ACC_SLIP_CONF"))
			{
				String	strSLIP_ID = CITCommon.toKOR(request.getParameter("SLIP_ID"));
				
				strSql = "{call SPHS_TOTAL_REPORT_I(?)} ";
			
				lrArgData.addColumn("SLIP_ID",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("SLIP_ID",strSLIP_ID);
			
				try
				{
					CITDatabase.executeProcedure(strSql, lrArgData);
				}
				catch (Exception ex)
				{
					if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","??? Select ����-> "+ ex.getMessage());
					throw new Exception("USER-900001:??? Select ���� -> " + ex.getMessage());
				}
			}
		}
		
		else if (strAct.equals("DEPT_ACC_CHK"))
		{
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strACC_CODE = CITCommon.toKOR(request.getParameter("ACC_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.ACC_CODE \n";
			strSql += " From \n";
			strSql += " 	T_ACC_CODE a, \n";
			strSql += " 	( \n";
			strSql += " 		SELECT \n";
			strSql += " 			Bi.ACC_CODE \n";
			strSql += " 		FROM \n";
			strSql += " 			T_DEPT_CODE_ORG Ai, \n";
			strSql += " 			T_GRP_ACC_CODE Bi \n";
			strSql += " 		WHERE \n";
			strSql += " 			Ai.ACC_GRP_CODE = Bi.ACC_GRP_CODE \n";
			strSql += " 			AND Ai.DEPT_CODE =  ?  \n";
			strSql += " 	) b \n";
			strSql += " Where \n";
			strSql += " 	a.ACC_CODE = b.ACC_CODE \n";
			strSql += " 	AND a.ACC_CODE =  ?  \n";
			strSql += " And		a.FUND_INPUT_CLS = 'T' \n";
			strSql += " Order By \n";
			strSql += " 	a.ACC_CODE ";
			
			lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("ACC_CODE", strACC_CODE);
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
				GauceInfo.response.writeException("USER", "900001","DEPT_ACC_CHK Select ����-> "+ ex.getMessage());
			}
		}

		else if (strAct.equals("CUST_CODE"))
		{
			String strCUST_CODE = CITCommon.toKOR(request.getParameter("CUST_CODE"));
			
			strSql  = " Select	A.CUST_SEQ , \n";
			strSql += "       	A.CRTUSERNO , \n";
			strSql += "       	A.CRTDATE , \n";
			strSql += "       	A.MODUSERNO , \n";
			strSql += "       	A.MODDATE , \n";
			strSql += "       	F_T_CUST_MASK(A.CUST_CODE) CUST_CODE , \n";
			strSql += "       	A.CUST_NAME , \n";
			strSql += "       	A.BOSS_NAME , \n";
			strSql += "       	A.TRADE_CLS , \n";
			strSql += "       	A.BIZCOND , \n";
			strSql += "       	A.BIZKND , \n";
			strSql += "       	F_T_ZIP_MASK(A.ZIPCODE) ZIPCODE , \n";
			strSql += "       	A.ADDR1 , \n";
			strSql += "       	A.ADDR2 , \n";
			strSql += "       	A.TELNO , \n";
			strSql += "       	A.GROUP_COMP_CLS , \n";
			strSql += "       	A.REPRESENT_CUST_SEQ , \n";
			strSql += "       	F_T_CUST_MASK(B.CUST_CODE) REPRESENT_CUST_CODE , \n";
			strSql += "       	B.CUST_NAME REPRESENT_CUST_NAME , \n";
			strSql += "       	A.USE_CLS \n";
			strSql += " From	T_CUST_CODE A, \n";
			strSql += " 		T_CUST_CODE B \n";
			strSql += " Where	A.CUST_SEQ = B.REPRESENT_CUST_SEQ(+) \n";
			strSql += " And		A.CUST_CODE||A.CUST_NAME Like '%'||  ?  ||'%' ";
			strSql += " And		A.USE_CLS = 'T' ";
			
			lrArgData.addColumn("CUST_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("CUST_CODE", strCUST_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CUST_SEQ", true);
				lrReturnData.setNotNull("CUST_CODE", true);
				lrReturnData.setNotNull("CUST_NAME", true);
				lrReturnData.setNotNull("TRADE_CLS", true);
				lrReturnData.setNotNull("ZIPCODE", true);
				lrReturnData.setNotNull("GROUP_COMP_CLS", true);
				lrReturnData.setNotNull("USE_CLS", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","T_CUST_CODE Select ����-> "+ ex.getMessage());
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
























