/**************************************************************************/
/* 1. �� �� �� �� id : t_WLoanSheetR.js(���Դ������)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : ���Դ������
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-05)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var				R_SLIP_ID = "";
var				vSTART_DT = "";
var				vEND_DT = "";
var				vRATIO = "";
var				vAMT = "";
var				vSLIP_ID = "";
var				vSLIP_IDSEQ = "";
function Initialize()
{
	
	G_addDataSet(dsMASTER, trans,  gridMASTER, sSelectPageName+D_P1("ACT","MAIN"), "���Ծ���");
	G_addDataSet(dsMAIN, trans,  gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "���Դ���");
	G_addDataSet(dsSUB01, trans,  gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "��ȯ����");
	G_addDataSet(dsSUB02, trans,  gridSUB02, sSelectPageName+D_P1("ACT","SUB02"), "��������");
	G_addDataSet(dsLOAN_REFUND_SEQ, null,  null, sSelectPageName+D_P1("ACT","LOAN_REFUND_SEQ"), "��ȯ��������");
	G_addDataSet(dsGUAR_SEQ, null,  null, sSelectPageName+D_P1("ACT","GUAR_SEQ"), "���⺸������");
	G_addDataSet(dsSLIP_INFO,null,null,"","");
	G_addDataSet(dsCALC_ITR_AMT,null,null,"","");
	G_addDataSet(dsCALC_PE_ITR_AMT,null,null,"","");
	G_addDataSet(dsCALC_DATE1,null,null,"","");
	G_addDataSet(dsCALC_DATE2,null,null,"","");
	G_addDataSet(dsCALC_DATE3,null,null,"","");
	G_addDataSet(dsPE_SLIP_ID,null,null,"","");
	G_addDataSet(dsAE_SLIP_ID,null,null,"","");
	G_addDataSet(dsSLIP_REMAIN_AMT,null,null,"","");
	G_addDataSet(dsLOAN_NO,null,null,"","");
	G_addDataSet(dsLOAN_CONT_NO,null,null,"","");
	
	
	

	G_addDataSet(dsDVD, transDvd,  null, sSelectPageName+D_P1("ACT","DVD"), "��ȯ��������");
	G_addDataSet(dsMAKE_ITR_SLIP, transMAKE_ITR_SLIP,  null, sSelectPageName+D_P1("ACT","MAKE_ITR_SLIP"), "������ǥ");
	G_addDataSet(dsREMOVE_SLIP, transREMOVE_SLIP,  null, sSelectPageName+D_P1("ACT","MAKE_ITR_SLIP"), "��ǥ����");
	
    G_addDataSet(dsLOV, null, null, "", "LOV");

	G_addRel(dsMASTER,dsMAIN);
	G_addRelCol(dsMAIN,"LOAN_CONT_NO","LOAN_CONT_NO");


	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"LOAN_NO","LOAN_NO");

	G_addRel(dsMAIN,dsSUB02);
	G_addRelCol(dsSUB02,"LOAN_NO","LOAN_NO");

	//gridMAIN.focus();
	txtCOMP_CODE.value    = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	G_setLovCol(gridMAIN,"CUST_CODE");
	G_setReadOnlyCol(gridMASTER,"BANK_NAME");
	G_setReadOnlyCol(gridMAIN,"CUST_NAME");
	G_setReadOnlyCol(gridMAIN,"BANK_NAME");
	G_setReadOnlyCol(gridMAIN,"SLIP_NO");
	

	G_setReadOnlyCol(gridSUB01,"LOAN_REMAIN_AMT");
	G_setReadOnlyCol(gridSUB01,"LOAN_SLIP_NO");
	G_setReadOnlyCol(gridSUB01,"REFUND_SLIP_NO");
	G_setReadOnlyCol(gridSUB01,"INTR_SLIP_NO");
	G_setReadOnlyCol(gridSUB01,"SCH_LOAN_REMAIN_AMT");

	G_setReadOnlyCol(gridSUB01,"PE_RESET_SLIP_NO");
	G_setReadOnlyCol(gridSUB01,"AE_RESET_SLIP_NO");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;

	selectTab(1,2);
	
	gridMASTER.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMASTER)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MASTER")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("BANK_CODE",txtBANK_CODE.value);
	}
	else if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("LOAN_CONT_NO",dsMASTER.NameString(dsMASTER.RowPosition,"LOAN_CONT_NO"));
	}
	else if(dataset == dsSUB01)
	{

		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("LOAN_NO",dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_NO"));
	}
	else if(dataset == dsSUB02)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB02")
										 + D_P2("LOAN_NO",dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_NO"));
	}
	else if(dataset == dsLOAN_REFUND_SEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","LOAN_REFUND_SEQ");
	}
	else if(dataset == dsGUAR_SEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","GUAR_SEQ");
	}
	else if(dataset == dsDVD)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DVD");
	}
	else if (dataset == dsSLIP_INFO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SLIP_INFO")
										 + D_P2("SLIP_ID",R_SLIP_ID);
	}
	else if(dataset == dsCALC_ITR_AMT)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CALC_ITR_AMT")
										 + D_P2("START_DT",vSTART_DT)
										 + D_P2("END_DT",vEND_DT)
										 + D_P2("AMT",vAMT)
										 + D_P2("RATIO",vRATIO);
	}
	else if(dataset == dsCALC_PE_ITR_AMT)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CALC_PE_ITR_AMT")
										 + D_P2("START_DT",dsSUB01.NameString(dsSUB01.RowPosition,"PE_START_DT"))
										 + D_P2("END_DT",dsSUB01.NameString(dsSUB01.RowPosition,"PE_END_DT"))
										 + D_P2("AMT",vAMT)
										 + D_P2("RATIO",vRATIO);
	}
	else if(dataset == dsCALC_DATE1)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CALC_DATE1")
										 + D_P2("BASE_DT",dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT"));
	}
	else if(dataset == dsCALC_DATE2)
	{
		var			lsExprDt = getExprDt();
		dataset.DataID = sSelectPageName + D_P1("ACT","CALC_DATE2")
										 + D_P2("BASE_DT",dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT"))
										 + D_P2("EXPR_DT",lsExprDt);
	}
	else if(dataset == dsCALC_DATE3)
	{
		var			lsExprDt = getExprDt();
		var			lsPrevDt = getPrevDt();
		dataset.DataID = sSelectPageName + D_P1("ACT","CALC_DATE3")
										 + D_P2("PREV_DT",lsPrevDt)
										 + D_P2("BASE_DT",dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT"))
										 + D_P2("EXPR_DT",lsExprDt)
										 + D_P2("DAYS",dsMAIN.NameString(dsMAIN.RowPosition,"INTR_REFUND_DAY"));
	}
	else if(dataset == dsPE_SLIP_ID)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","PE_SLIP_ID")
										 + D_P2("LOAN_NO",dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_NO"));
	}
	else if(dataset == dsAE_SLIP_ID)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","AE_SLIP_ID")
										 + D_P2("LOAN_NO",dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_NO"));
	}
	else if(dataset == dsSLIP_REMAIN_AMT)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SLIP_REMAIN_AMT")
										 + D_P2("SLIP_ID",vSLIP_ID)
										 + D_P2("SLIP_IDSEQ",vSLIP_IDSEQ);
	}
	else if(dataset == dsLOAN_NO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","LOAN_NO");
	}
	else if(dataset == dsREMOVE_SLIP)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","REMOVE_SLIP");
	}
	else if(dataset == dsLOAN_CONT_NO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","LOAN_CONT_NO");
	}
	
	
}

// ���ǰ��� �Լ�----------------------------------------------------------------//
function SetSession()
{
}

function GetSession()
{
}

function ReportSession(asName, asValue)
{
}

// �Լ�����---------------------------------------------------------------------//
function	updateConfirm()
{
	if (dsMASTER.IsUpdated || G_isChanged(dsMASTER.id))
	{
		var ret = C_msgYesNo("�� �۾��� ���ؼ��� ���� ������ �ϼž� �մϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMASTER)) return false;
		}
		else if(ret == "N")
		{
			return false;
		}
	}
	return true;
}
function	chkTopCondition()
{
	if(C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("����� ������� �����Ͽ� �ֽʽÿ�.");
		return false;
	}
	if(C_isNull(txtBANK_CODE.value))
	{
		C_msgOk("����� �����ڵ带 �����Ͽ� �ֽʽÿ�.");
		return false;
	}
	return true;
}
function	getExprDt()
{
	var			lsExprDt;
	lsExprDt = dsMAIN.NameString(dsMAIN.RowPosition,"CHG_EXPR_DT");
	if(C_isNull(lsExprDt))
	{
		return dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_EXPR_DT");
	}
	else
	{
		return lsExprDt;
	}
}
function	getPrevDt()
{
	var			lsPrevDt;
	for(var i = dsSUB01.RowPosition - 1; i >= 1 ; --i)
	{
		lsPrevDt = dsSUB01.NameString(i,"REFUND_INTR_DT");
		if(!C_isNull(lsPrevDt))
		{
			break;
		}
	}
	if(C_isNull(lsPrevDt))
	{
		return dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_FDT");
	}
	else
	{
		return lsPrevDt;
	}
}
function	changeDatetoNumber(datestr)
{
	return C_convSafeFloat(datestr.replace(/-/g,""));
}
function	chkNullDatasetColumn(aDataset,aColumnName)
{
	return C_isNull(aDataset.NameString(aDataset.RowPosition,aColumnName));
}
function	chkMainColumnNull(aColumnName)
{
	return chkNullDatasetColumn(dsMAIN,aColumnName);
}
function	calcRemainAmt()
{
	var		lfSumLoan = 0;
	var		lfSumRefund = 0;
	var		i;
	var		iCount = dsSUB01.CountRow;
	for(i = 1 ; i <= iCount ; ++i)
	{
		lfSumLoan += C_convSafeFloat(dsSUB01.NameString(i,"LOAN_AMT"));
		lfSumRefund += C_convSafeFloat(dsSUB01.NameString(i,"REFUND_AMT"));
		dsSUB01.NameString(i,"LOAN_REMAIN_AMT") = lfSumLoan - lfSumRefund;
	}
}
function	getPrevRemainAmt()
{
	return C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_REMAIN_AMT")) + C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_AMT"));
}
function	calcSchRemainAmt()
{
	var		lfSumLoan = 0;
	var		lfSumRefund = 0;
	var		i;
	var		iCount = dsSUB01.CountRow;
	for(i = 1 ; i <= iCount ; ++i)
	{
		lfSumLoan += C_convSafeFloat(dsSUB01.NameString(i,"LOAN_AMT"));
		lfSumRefund += C_convSafeFloat(dsSUB01.NameString(i,"REFUND_SCH_ORG_AMT"));
		dsSUB01.NameString(i,"SCH_LOAN_REMAIN_AMT") = lfSumLoan - lfSumRefund;
	}
}
function	sumUpLoanAmt()
{
	dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_AMT") = dsSUB01.NameSum("LOAN_AMT",0,0);
}
function	HideAllTabPage()
{
	divTabPage1.style.display = "none";
	divTabPage2.style.display = "none";
}
function selectTab(index, totcount)
{
	// ���������� �̹��� ��ȯ �����Լ�
	if (!C_selectTab(index, totcount)) return;
	HideAllTabPage();
	switch (index)
	{
		case 1:
			divTabPage1.style.display = "";
			sTab = "1";
			break;
		case 2:
			divTabPage2.style.display = "";
			sTab = "2";
			break;

	}
}


// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	D_defaultLoad();

}

// �߰�
function btnadd_onclick()
{
	D_defaultAdd();
}

// ����
function btninsert_onclick()
{
	D_defaultInsert();
}

// ����
function btndelete_onclick()
{
	D_defaultDelete();
}

// ����
function btnsave_onclick()
{
	D_defaultSave();
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "LOAN_FDT" || asCalendarID == "INTR_REFUND_FIRST_DT" || asCalendarID == "LOAN_EXPR_DT" || asCalendarID == "CHG_EXPR_DT" ||asCalendarID == "INTR_REFUND_FIRST_DT"
				||asCalendarID == "ORG_REFUND_FIRST_MONTH" )
	{
		dsMAIN.NameString(dsMAIN.RowPosition,asCalendarID) = asDate;
	}
	else if (asCalendarID == "REFUND_SCH_DT" || asCalendarID == "REFUND_INTR_DT" || asCalendarID == "INTR_START_DT" || asCalendarID == "INTR_END_DT" ||
				asCalendarID == "PE_START_DT" || asCalendarID == "PE_END_DT" ||
				asCalendarID == "AE_START_DT" || asCalendarID == "AE_END_DT" )
	{
		dsSUB01.NameString(dsSUB01.RowPosition,asCalendarID) = asDate;
	}
	else if (asCalendarID == "GUAR_START_DT" || asCalendarID == "GUAR_END_DT" || asCalendarID == "GUAR_PAYMENT_DT" || asCalendarID == "GUAR_ESTAB_DT" || asCalendarID == "GUAR_CANCEL_DT")
	{
		dsSUB02.NameString(dsSUB02.RowPosition,asCalendarID) = asDate;
	}
	else if (asCalendarID == "LOAN_CONT_EXPR_DT")
	{
		dsMASTER.NameString(dsMASTER.RowPosition,asCalendarID) = asDate;
	}
}


function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	if(dataset == dsMASTER)
	{
		if(!chkTopCondition()) return false;
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsMASTER)
	{
		G_Load(dsLOAN_CONT_NO);
		dataset.NameString(row,"LOAN_CONT_NO") =   dsLOAN_CONT_NO.NameString(dsLOAN_CONT_NO.RowPosition,"LOAN_CONT_NO");
		dataset.NameValue(row,"BANK_CODE") =   txtBANK_CODE.value;
		dataset.NameValue(row,"BANK_NAME") 	= txtBANK_NAME.value;
		dataset.NameValue(row,"COMP_CODE")   = txtCOMP_CODE.value;
	}
	if(dataset == dsMAIN)
	{
		G_Load(dsLOAN_NO);
		dataset.NameString(row,"LOAN_NO") =   dsLOAN_NO.NameString(dsLOAN_NO.RowPosition,"LOAN_NO");
		dataset.NameValue(row,"BANK_CODE") =   dsMASTER.NameString(dsMASTER.RowPosition,"BANK_CODE");
		dataset.NameValue(row,"BANK_NAME") 	= dsMASTER.NameString(dsMASTER.RowPosition,"BANK_NAME");
		dataset.NameValue(row,"COMP_CODE")   = dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE");
		dataset.NameValue(row,"LOAN_NAME")   = dsMASTER.NameString(dsMASTER.RowPosition,"LOAN_CONT_NAME");
		dataset.NameValue(row,"ITR_TAR_TAG")   = "A";
	}
	else if(dataset == dsSUB01)
	{
		G_Load(dsLOAN_REFUND_SEQ);
		dataset.NameString(row,"LOAN_REFUND_SEQ") = dsLOAN_REFUND_SEQ.NameString(dsLOAN_REFUND_SEQ.RowPosition,"LOAN_REFUND_SEQ");
		if(dataset.CountRow == 1)		//���� ����
		{
			dataset.NameString(row,"REFUND_INTR_DT") = dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_FDT");
			dataset.NameString(row,"LOAN_AMT") = dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_AMT");
		}
		calcRemainAmt();
	}
	else if(dataset == dsSUB02)
	{
		G_Load(dsGUAR_SEQ);
		dataset.NameString(row,"GUAR_SEQ") = dsGUAR_SEQ.NameString(dsGUAR_SEQ.RowPosition,"GUAR_SEQ");
	}
}

function OnRowDeleteBefore(dataset)
{
	if(dataset == dsSUB01)
	{
		if(dsSUB01.RowPosition < 1) return true;
		if(!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_NO")) ||
			!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_NO")) ||
			!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"INTR_SLIP_NO")))
		{
			C_msgOk("��ǥ�� ����� ���� ������ �Ұ����մϴ�.");
			return false;
		}
	}
	return true;
}

function OnRowDeleted(dataset, row)
{
	if(dataset == dsSUB01)
	{
		sumUpLoanAmt();
		calcRemainAmt();
	}
}
function	reCalcDate(dataset,row,colid)
{
	var		lsItrTag = dataset.NameString(row,"ITR_TAG");
	if(lsItrTag == "1")			//��������
	{
		//���������� ��� ���� ���� ��� �Ⱓ�� �����Ͽ��� ���� ������ ���� �̴�.
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_FDT");
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_EXPR_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_END_DT") = dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_EXPR_DT");
		G_Load(dsCALC_DATE1);
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_START_DT") = dsCALC_DATE1.NameString(dsCALC_DATE1.RowPosition,"INTR_START_DT");
	}
	else if(lsItrTag == "2")			//��������
	{
		//���������� ���� ���ٸ� ���� ���� �ʴ´�.
		//���������� ���� ���� ���� ���� �۾��� �������� ���޿��� ó���ȴ�.
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = "";
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = "";
	}
	else if(lsItrTag == "3")			//�������� ����
	{
		//�������� ������ ���� ���� �ش� ���Թ�ȣ�� �Ǿ� �ִ� ���޺�� �������� ��ǥ�� ã�Ƽ� ��ǥ��ȣ�� �����´�.
		G_Load(dsCALC_DATE2);
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = "";
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = "";
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_START_DT") = dsCALC_DATE2.NameString(dsCALC_DATE2.RowPosition,"INTR_START_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_END_DT") = dsCALC_DATE2.NameString(dsCALC_DATE2.RowPosition,"INTR_END_DT");
		G_Load(dsPE_SLIP_ID);
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_ID") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"SLIP_ID");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_IDSEQ") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"SLIP_IDSEQ");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_SLIP_NO") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"MAKE_SLIPNO");
		if(C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_ID")))
		{
			C_msgOk("������ ���޺�� �������ڸ� ã�� �� �����ϴ�.");
		}
	}
	else if(lsItrTag == "4")			//�������� ����
	{
		//������ ������ ��� ���� ��ǥ�� �ܾ��� ���� �ִ� ���� ������ �����´�.
		//���� ������ڴ� ������ ���� ������ + 1�Ϻ���  �̹��� ���� �����ϱ����� �Ѵ�.
		G_Load(dsCALC_DATE3);
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = dsCALC_DATE3.NameString(dsCALC_DATE3.RowPosition,"INTR_START_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_START_DT") = dsCALC_DATE3.NameString(dsCALC_DATE3.RowPosition,"AE_INTR_START_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_END_DT") = dsCALC_DATE3.NameString(dsCALC_DATE3.RowPosition,"AE_INTR_END_DT");
		G_Load(dsAE_SLIP_ID);
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_ITR_ID") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"SLIP_ID");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_ITR_IDSEQ") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"SLIP_IDSEQ");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_SLIP_NO") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"MAKE_SLIPNO");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_ITR_AMT") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"REMAIN_AMT");
	}
	else if(lsItrTag == "5")			//���� ���� ��ȯ
	{
		//���� ���ڸ� ��� �ϰ�
		//���� �̹����� ���޺���� �ִٸ� ��������
		G_Load(dsPE_SLIP_ID);
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_ID") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"SLIP_ID");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_IDSEQ") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"SLIP_IDSEQ");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_SLIP_NO") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"MAKE_SLIPNO");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_AMT") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"REMAIN_AMT");
		//���� ������ ��ȯ�̸� �������ڸ� ������ ������ش�.
		var			lsExprDt = getExprDt();
		var			lsBaseDt = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT");
		if(changeDatetoNumber(lsExprDt) != changeDatetoNumber(lsBaseDt))
		{
			dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = lsExprDt;
			dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = lsBaseDt;
		}
		else
		{
			dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = "";
			dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = "";
		}
	}
	else if(lsItrTag == "6")			//���� ���� ��ȯ
	{
		//���� ���ڸ� ��� �ϰ�
		G_Load(dsCALC_DATE3);
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = dsCALC_DATE3.NameString(dsCALC_DATE3.RowPosition,"INTR_START_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT");
		//���� �����޺���� �ִٸ� ��������
		G_Load(dsAE_SLIP_ID);
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_ITR_ID") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"SLIP_ID");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_ITR_IDSEQ") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"SLIP_IDSEQ");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_SLIP_NO") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"MAKE_SLIPNO");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_ITR_AMT") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"REMAIN_AMT");
	}
	else if(lsItrTag == "7")			//�������� ����
	{
		//�������� ������ ���� ���� �ش� ���Թ�ȣ�� �Ǿ� �ִ� ���޺�� �������� ��ǥ�� ã�Ƽ� ��ǥ��ȣ�� �����´�.
		G_Load(dsCALC_DATE2);
		G_Load(dsCALC_DATE3);
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = dsCALC_DATE3.NameString(dsCALC_DATE3.RowPosition,"INTR_START_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_START_DT") = dsCALC_DATE2.NameString(dsCALC_DATE2.RowPosition,"INTR_START_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_END_DT") = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT");
		G_Load(dsPE_SLIP_ID);
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_ID") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"SLIP_ID");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_IDSEQ") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"SLIP_IDSEQ");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_SLIP_NO") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"MAKE_SLIPNO");
	}
	fCalcItrAmt();
}
function	OnColumnPosChanged(dataset, grid, row, colid)
{
	if(dataset == dsSUB01)
	{
		if(!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_NO")) ||
			!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_NO")) ||
			!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"INTR_SLIP_NO")))
		{
			grid.ColumnProp(colid, "Edit") = "None";
		}
		else
		{
			grid.ColumnProp(colid, "Edit") = "";
		}
	}
}

function OnColumnChanged(dataset, row, colid)
{
	if(dataset == dsSUB01)
	{
		if(colid == "LOAN_AMT" )
		{
			calcRemainAmt();
			calcSchRemainAmt();
			sumUpLoanAmt();
		}
		else if(colid == "REFUND_AMT")
		{
			calcRemainAmt();
		}
		else if(colid == "REFUND_SCH_ORG_AMT")
		{
			calcSchRemainAmt();
		}
		else if(colid == "ITR_TAG")
		{
			reCalcDate(dataset,row,colid);
		}
		else if(colid == "ITR_TAR_TAG")
		{
			fCalcItrAmt();
		}
		else if(colid == "REFUND_INTR_DT")
		{
			reCalcDate(dataset,row,colid);
		}
	}
}
function OnExit(dataset, grid, row, colid, olddata)
{
	var		COL_DATA;
	if (dataset == dsMASTER)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "LOAN_CONT_EXPR_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	else if (dataset == dsMAIN)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "LOAN_FDT" || colid == "LOAN_EXPR_DT" ||colid == "INTR_REFUND_FIRST_DT"|| colid == "CHG_EXPR_DT" || colid == "INTR_REFUND_FIRST_DT"||colid == "ORG_REFUND_FIRST_MONTH")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	else if(dataset == dsSUB01)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "REFUND_SCH_DT" || colid == "REFUND_INTR_DT" || colid == "INTR_START_DT" || colid == "INTR_END_DT"||
				colid == "PE_START_DT" || colid == "PE_END_DT" ||
				colid == "AE_START_DT" || colid == "AE_END_DT" )
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	else if(dataset == dsSUB02)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "GUAR_START_DT" || colid == "GUAR_END_DT" || colid == "GUAR_PAYMENT_DT" || colid == "GUAR_ESTAB_DT" || colid == "GUAR_CANCEL_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMASTER)
	{
		if(colid == "LOAN_CONT_EXPR_DT")
		{
			C_Calendar(colid, "D", dataset.NameString(row,colid));
		}
	}
	else if (dataset == dsMAIN)
	{
		if(colid == "LOAN_FDT" || colid == "LOAN_EXPR_DT" ||colid == "INTR_REFUND_FIRST_DT"|| colid == "CHG_EXPR_DT" || colid == "INTR_REFUND_FIRST_DT"||colid == "ORG_REFUND_FIRST_MONTH")
		{
			C_Calendar(colid, "D", dataset.NameString(row,colid));
		}
	}
	else if(dataset == dsSUB01)
	{
		if(colid == "REFUND_SCH_DT" || colid == "REFUND_INTR_DT" || colid == "INTR_START_DT" || colid == "INTR_END_DT"||
				colid == "PE_START_DT" || colid == "PE_END_DT" ||
				colid == "AE_START_DT" || colid == "AE_END_DT" )
		{
			C_Calendar(colid, "D", dataset.NameString(row,colid));
		}
	}
	else if(dataset == dsSUB02)
	{
		if(colid == "GUAR_START_DT" || colid == "GUAR_END_DT" || colid == "GUAR_PAYMENT_DT" || colid == "GUAR_ESTAB_DT" || colid == "GUAR_CANCEL_DT")
		{
			C_Calendar(colid, "D", dataset.NameString(row,colid));
		}
	}

}


// �̺�Ʈ����-------------------------------------------------------------------//
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	txtCOMP_CODE.value	  = lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value = lrRet.get("COMPANY_NAME");
	D_defaultLoad();
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	D_defaultLoad();
}
//�����ڵ�˻�
function txtBANK_CODE_onblur()
{
	if (C_isNull(txtBANK_CODE.value))
	{
		txtBANK_NAME.value = "";
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtBANK_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_BANK_CODE1", lrArgs,"T");	//

	if (lrRet == null) return;

	txtBANK_CODE.value	= lrRet.get("BANK_CODE");
	txtBANK_NAME.value	= lrRet.get("BANK_NAME");

}

function btnBANK_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_BANK_CODE1", lrArgs,"T");	//

	if (lrRet == null) return;

	txtBANK_CODE.value	= lrRet.get("BANK_CODE");
	txtBANK_NAME.value	= lrRet.get("BANK_NAME");

}

function	btnMakeSchedule_onClick()
{
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("���� ����� ���Դ����� �����ϼž� �մϴ�.");
		return;
	}
	if(chkMainColumnNull("LOAN_FDT"))
	{
		C_msgOk("�������� �Է��ϼž� �մϴ�.");
		return;
	}
	if(chkMainColumnNull("LOAN_EXPR_DT"))
	{
		C_msgOk("�������� �Է��ϼž� �մϴ�.");
		return;
	}
	if(chkMainColumnNull("ORG_REFUND_MONTH"))
	{
		C_msgOk("��ȯ�ֱ⸦ �Է��ϼž� �մϴ�.");
		return;
	}
	if(chkMainColumnNull("ORG_REFUND_FIRST_MONTH"))
	{
		C_msgOk("���ʻ�ȯ���� �Է��ϼž� �մϴ�.");
		return;
	}
	if(chkMainColumnNull("INTR_REFUND_DAY"))
	{
		C_msgOk("���� �������ڸ� �Է��ϼž� �մϴ�.");
		return;
	}
	if(chkMainColumnNull("INTR_REFUND_FIRST_DT"))
	{
		C_msgOk("���� ������������ �Է��ϼž� �մϴ�.");
		return;
	}
	if(chkMainColumnNull("INTR_REFUND_DIV_MONTH"))
	{
		C_msgOk("���� �����ֱ⸦ �Է��ϼž� �մϴ�.");
		return;
	}
	var		lf_LOAN_AMT = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_AMT"));	//���Կ���
	var		lf_TITLE_INTR_RATE = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"TITLE_INTR_RATE"));	//�������
	if(lf_LOAN_AMT == 0)
	{
		C_msgOk("���Կ����� �Է��ϼž� �մϴ�.");
		return;
	}
	if(!updateConfirm()) return;
	G_Load(dsDVD);
	dsDVD.NameString(dsDVD.RowPosition,"LOAN_NO") = dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_NO");
	
	transDvd.Parameters = "ACT=DVD";
	if(!G_saveData(dsDVD))return;
	C_msgOk("��ȯ������ ���������� �����Ǿ����ϴ�.");
	var			liRow = dsSUB01.RowPosition;
	G_Load(dsSUB01);
	if(liRow > 0) dsSUB01.RowPosition = liRow;
}
function	btnMakeLoanSlip_onClick()
{
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("���� ���� ����� ���� �� �۾��Ͻʽÿ�.");
		return;
	}
	var			lfAmt;
	lfAmt = C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_AMT"));
	if(lfAmt <= 0)
	{
		C_msgOk("���Աݾ��� ��ϵ� ���� �����Ͽ� �ֽʽÿ�.");
		return;
	}
	var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_ID");
	if(!C_isNull(pSLIP_ID))
	{
		C_msgOk("�̹� ��ǥ�� ����� ���� �ֽ��ϴ�.");
		return;
	}
	pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_ID");
	if(!C_isNull(pSLIP_ID))
	{
		C_msgOk("�̹� ��ȯ ��ǥ�� ����� ���� �ֽ��ϴ�.");
		return;
	}
	if(!updateConfirm()) return;
	var			lrObject = new Object();
	lrObject.dept_code = sDeptCode;
	lrObject.comp_code = sCompCode;
	lrObject.emp_no = sEmpNo;
	lrObject.loan_no = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_NO");
	lrObject.loan_refund_seq = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_REFUND_SEQ");

	var		arrRtn2 = window.showModalDialog("./t_PMakeLoanSlipR.jsp", lrObject, "center:yes; dialogWidth:410px; dialogHeight:600px; status:no; help:no; scroll:no");
	if(C_isNull(arrRtn2)) return;
	var			liRow = dsSUB01.RowPosition;
	G_Load(dsSUB01);
	if(liRow > 0) dsSUB01.RowPosition = liRow;
}
function	btnMakeRefundSlip_onClick()
{
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("���� ���� ����� ���� �� �۾��Ͻʽÿ�.");
		return;
	}
	var			lfAmt;
	lfAmt = C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_AMT"));
	if(lfAmt <= 0)
	{
		C_msgOk("��ȯ�ݾ��� ��ϵ� ���� �����Ͽ� �ֽʽÿ�.");
		return;
	}
	var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_ID");
	if(!C_isNull(pSLIP_ID))
	{
		C_msgOk("�̹� ��ǥ�� ����� ���� �ֽ��ϴ�.");
		return;
	}
	pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_ID");
	if(!C_isNull(pSLIP_ID))
	{
		C_msgOk("�̹� ��ȯ ��ǥ�� ����� ���� �ֽ��ϴ�.");
		return;
	}
	if(!updateConfirm()) return;
	var			lrObject = new Object();
	lrObject.dept_code = sDeptCode;
	lrObject.comp_code = sCompCode;
	lrObject.emp_no = sEmpNo;
	lrObject.loan_no = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_NO");
	lrObject.loan_refund_seq = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_REFUND_SEQ");

	var		arrRtn2 = window.showModalDialog("./t_PMakeLoanRefundSlipR.jsp", lrObject, "center:yes; dialogWidth:410px; dialogHeight:600px; status:no; help:no; scroll:no");
	if(C_isNull(arrRtn2)) return;
	var			liRow = dsSUB01.RowPosition;
	G_Load(dsSUB01);
	if(liRow > 0) dsSUB01.RowPosition = liRow;
}
function	btnMakeItrSlip_onClick()
{
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("���� ���� ����� ���� �� �۾��Ͻʽÿ�.");
		return;
	}
	var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_ID");
	if(!C_isNull(pSLIP_ID))
	{
		C_msgOk("�̹� ��ǥ�� ����� ���� �ֽ��ϴ�.");
		return;
	}
	pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_ID");
	if(!C_isNull(pSLIP_ID))
	{
		C_msgOk("�̹� ��ȯ ��ǥ�� ����� ���� �ֽ��ϴ�.");
		return;
	}
	pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"INTR_SLIP_ID");
	if(!C_isNull(pSLIP_ID))
	{
		C_msgOk("�̹� ���� ��ǥ�� ����� ���� �ֽ��ϴ�.");
		return;
	}
	if(!updateConfirm()) return;
	var		lsItrTag = dsSUB01.NameString(dsSUB01.RowPosition,"ITR_TAG");
	if(lsItrTag == "3")		//�������� �����̸�
	{
		G_Load(dsMAKE_ITR_SLIP);
		dsMAKE_ITR_SLIP.NameString(dsMAKE_ITR_SLIP.RowPosition,"LOAN_NO") = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_NO");
		dsMAKE_ITR_SLIP.NameString(dsMAKE_ITR_SLIP.RowPosition,"LOAN_REFUND_SEQ") = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_REFUND_SEQ");
		dsMAKE_ITR_SLIP.NameString(dsMAKE_ITR_SLIP.RowPosition,"DEPT_CODE") = sDeptCode;
		dsMAKE_ITR_SLIP.NameString(dsMAKE_ITR_SLIP.RowPosition,"COMP_CODE") = sCompCode;
		
		transMAKE_ITR_SLIP.Parameters = "ACT=MAKE_ITR_SLIP";
		if(!G_saveData(dsMAKE_ITR_SLIP))return;
		C_msgOk("������ǥ�� ���������� �����Ǿ����ϴ�.");
		var			liRow = dsSUB01.RowPosition;
		G_Load(dsSUB01);
		if(liRow > 0) dsSUB01.RowPosition = liRow;
	}
	else if(lsItrTag == "4" || lsItrTag == "7")		//�������� ���޶Ǵ� �������� �����̸�
	{
		var			lrObject = new Object();
		lrObject.dept_code = sDeptCode;
		lrObject.comp_code = sCompCode;
		lrObject.emp_no = sEmpNo;
		lrObject.loan_no = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_NO");
		lrObject.loan_refund_seq = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_REFUND_SEQ");
	
		var		arrRtn2 = window.showModalDialog("./t_PMakeAEItrSlipR.jsp", lrObject, "center:yes; dialogWidth:410px; dialogHeight:600px; status:no; help:no; scroll:no");
		if(C_isNull(arrRtn2)) return;
		var			liRow = dsSUB01.RowPosition;
		G_Load(dsSUB01);
		if(liRow > 0) dsSUB01.RowPosition = liRow;
	}
	else
	{
		C_msgOk("���ڱ����� �������� ���� �Ǵ� �������� ���޶Ǵ� �������������� ������ �۾��ϼž� �մϴ�.");
	}
	
}
function	btnRemoveSlip_onClick()
{
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("���� ���� ����� ���� �� �۾��Ͻʽÿ�.");
		return;
	}
	var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_ID");
	var pSLIP_ID2        = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_ID");
	var pSLIP_ID3        = dsSUB01.NameString(dsSUB01.RowPosition,"INTR_SLIP_ID");
	if(C_isNull(pSLIP_ID) && C_isNull(pSLIP_ID2) && C_isNull(pSLIP_ID3))
	{
		C_msgOk("��ǥ�� ����� ���� �����ϴ�.");
		return;
	}
	if(!updateConfirm()) return;
	G_Load(dsREMOVE_SLIP);
	dsREMOVE_SLIP.NameString(dsREMOVE_SLIP.RowPosition,"LOAN_NO") = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_NO");
	dsREMOVE_SLIP.NameString(dsREMOVE_SLIP.RowPosition,"LOAN_REFUND_SEQ") = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_REFUND_SEQ");
	
	transREMOVE_SLIP.Parameters = "ACT=REMOVE_SLIP";
	if(!G_saveData(dsREMOVE_SLIP))return;
	C_msgOk("��ǥ�� ���������� �����Ǿ����ϴ�.");
	var			liRow = dsSUB01.RowPosition;
	G_Load(dsSUB01);
	if(liRow > 0) dsSUB01.RowPosition = liRow;
}
function	btnExecSchedule_onClick()
{
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("���� ���� �� ��ȯ������ �����ϼž� �մϴ�.");
		return;
	}
	if(C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SCH_DT")))
	{
		C_msgOk("��ȯ �Ǵ� �������� �������� �ִ� �ڷḦ �����Ͻʽÿ�.");
		return;
	}
	if(!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_NO")) ||
		!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_NO")) ||
		!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"INTR_SLIP_NO")))
	{
		C_msgOk("��ǥ�� ����� ���� �۾��� �Ұ����մϴ�.");
		return false;
	}
	dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT") = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SCH_DT");
	dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_AMT") = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SCH_ORG_AMT");
	dsSUB01.NameString(dsSUB01.RowPosition,"INTR_AMT") = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SCH_INTR_AMT");
}
function	btnShowLoanSlip_onClick()
{
	var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_ID");
	var pSLIP_IDSEQ     = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_IDSEQ");
	R_SLIP_ID = pSLIP_ID;
	G_Load(dsSLIP_INFO);
	var pMAKE_COMP_CODE = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"SLIP_KIND_TAG");
	var pREADONLY_TF    = "F";
	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("��ǥ�� ����� ���� �����ϴ�.");
		return;
	}
	
	PopupOpen_AccSlipRetrieve (
		pSLIP_ID,
		pSLIP_IDSEQ,
		pMAKE_DT,
		pMAKE_SEQ,
		pSLIP_KIND_TAG,
		pMAKE_COMP_CODE,
		pREADONLY_TF
	);
}
function	btnShowRefundSlip_onClick()
{
	var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_ID");
	var pSLIP_IDSEQ     = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_IDSEQ");
	R_SLIP_ID = pSLIP_ID;
	G_Load(dsSLIP_INFO);
	var pMAKE_COMP_CODE = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"SLIP_KIND_TAG");
	var pREADONLY_TF    = "F";
	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("��ǥ�� ����� ���� �����ϴ�.");
		return;
	}
	
	PopupOpen_AccSlipRetrieve (
		pSLIP_ID,
		pSLIP_IDSEQ,
		pMAKE_DT,
		pMAKE_SEQ,
		pSLIP_KIND_TAG,
		pMAKE_COMP_CODE,
		pREADONLY_TF
	);
}
function	btnShowItrSlip_onClick()
{
	var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"INTR_SLIP_ID");
	var pSLIP_IDSEQ     = dsSUB01.NameString(dsSUB01.RowPosition,"INTR_SLIP_IDSEQ");
	R_SLIP_ID = pSLIP_ID;
	G_Load(dsSLIP_INFO);
	var pMAKE_COMP_CODE = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"SLIP_KIND_TAG");
	var pREADONLY_TF    = "F";
	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("��ǥ�� ����� ���� �����ϴ�.");
		return;
	}
	
	PopupOpen_AccSlipRetrieve (
		pSLIP_ID,
		pSLIP_IDSEQ,
		pMAKE_DT,
		pMAKE_SEQ,
		pSLIP_KIND_TAG,
		pMAKE_COMP_CODE,
		pREADONLY_TF
	);
}
//���������ް��
function	fCalcItrBase()
{
	if(C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT")))
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_AMT") = 0;
		return true;
	}
	if(C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT")))
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_AMT") = 0;
		return true;
	}
	vSTART_DT = dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT");
	vEND_DT = dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT");
	vRATIO = dsMAIN.NameString(dsMAIN.RowPosition,"REAL_INTR_RATE");
	if(dsSUB01.NameString(dsSUB01.RowPosition,"ITR_TAR_TAG") == "R")
	{
		vAMT = C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_AMT"));
	}
	else
	{
		vAMT = getPrevRemainAmt();
	}
	G_Load(dsCALC_ITR_AMT);
	dsSUB01.NameString(dsSUB01.RowPosition,"INTR_AMT") = dsCALC_ITR_AMT.NameString(dsCALC_ITR_AMT.RowPosition,"ITR_AMT");
	return true;
}
//������������
function	fCalcItr_1()
{
	if(!fCalcItrBase())
	{
		C_msgOk("���� ��������� �Է��Ͻʽÿ�.");
		return;
	}
	G_Load(dsCALC_PE_ITR_AMT);
	dsSUB01.NameString(dsSUB01.RowPosition,"PE_ITR_AMT") = dsCALC_PE_ITR_AMT.NameString(dsCALC_PE_ITR_AMT.RowPosition,"ITR_AMT");
}
//�������ڹ���
function	fCalcItr_3()
{
	vSLIP_ID = dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_ID");
	vSLIP_IDSEQ =  dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_IDSEQ");
	vRATIO = dsMAIN.NameString(dsMAIN.RowPosition,"REAL_INTR_RATE");
	vAMT = getPrevRemainAmt();
	G_Load(dsCALC_PE_ITR_AMT);
	G_Load(dsSLIP_REMAIN_AMT);
	var		lnLimitAmt = C_convSafeFloat(dsSLIP_REMAIN_AMT.NameString(dsSLIP_REMAIN_AMT.RowPosition,"REMAIN_AMT"));
	var		lnItrAmt = C_convSafeFloat(dsCALC_PE_ITR_AMT.NameString(dsCALC_PE_ITR_AMT.RowPosition,"ITR_AMT"));
	if(lnItrAmt > lnLimitAmt)
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_AMT") = lnLimitAmt;
	}
	else
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_AMT") = lnItrAmt;
	}
}
//��������
function	fCalcItr_4()
{
	if(!fCalcItrBase())
	{
		C_msgOk("���� ��������� �Է��Ͻʽÿ�.");
		return;
	}
	vSTART_DT = dsSUB01.NameString(dsSUB01.RowPosition,"AE_START_DT");
	vEND_DT = dsSUB01.NameString(dsSUB01.RowPosition,"AE_END_DT");
	vRATIO = dsMAIN.NameString(dsMAIN.RowPosition,"REAL_INTR_RATE");
	vAMT = getPrevRemainAmt();
	G_Load(dsCALC_ITR_AMT);
	dsSUB01.NameString(dsSUB01.RowPosition,"AE_ITR_AMT") = dsCALC_ITR_AMT.NameString(dsCALC_ITR_AMT.RowPosition,"ITR_AMT");
}
//���ݻ�ȯ
function	fCalcItr_5()
{
	if(!fCalcItrBase()) return;
}
function	fCalcItr_6()
{
	if(!fCalcItrBase()) return;
	return;
}
function	fCalcItr_7()
{
	vSLIP_ID = dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_ID");
	vSLIP_IDSEQ =  dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_IDSEQ");
	if(!C_isNull(vSLIP_ID))
	{
		vRATIO = dsMAIN.NameString(dsMAIN.RowPosition,"REAL_INTR_RATE");
		vAMT = getPrevRemainAmt();
		G_Load(dsCALC_PE_ITR_AMT);
		G_Load(dsSLIP_REMAIN_AMT);
		var		lnLimitAmt = C_convSafeFloat(dsSLIP_REMAIN_AMT.NameString(dsSLIP_REMAIN_AMT.RowPosition,"REMAIN_AMT"));
		var		lnItrAmt = C_convSafeFloat(dsCALC_PE_ITR_AMT.NameString(dsCALC_PE_ITR_AMT.RowPosition,"ITR_AMT"));
		if(lnItrAmt > lnLimitAmt)
		{
			dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_AMT") = lnLimitAmt;
		}
		else
		{
			dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_AMT") = lnItrAmt;
		}
	}
	G_Load(dsCALC_PE_ITR_AMT);
	dsSUB01.NameString(dsSUB01.RowPosition,"PE_ITR_AMT") = dsCALC_PE_ITR_AMT.NameString(dsCALC_PE_ITR_AMT.RowPosition,"ITR_AMT");
	if(!fCalcItrBase()) return;
	return;
}
function	fCalcItrAmt()
{
	var			vITR_TAG = dsSUB01.NameString(dsSUB01.RowPosition,"ITR_TAG");
	if(vITR_TAG == "1")		//������������
	{
		fCalcItr_1();
	}
	else if(vITR_TAG == "3")	//�������ڹ���
	{
		fCalcItr_3();
	}
	else if(vITR_TAG == "4")	//��������
	{
		fCalcItr_4();
	}
	else if(vITR_TAG == "5")	//������ݻ�ȯ
	{
		fCalcItr_5();
	}
	else if(vITR_TAG == "6")	//������ݻ�ȯ
	{
		fCalcItr_6();
	}
	else if(vITR_TAG == "7")	//�������� ����
	{
		fCalcItr_7();
	}
}
function	btnCalcItrAmt_onClick()
{
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("���ڸ� ����� ���� ��ȯ������ �����Ͻʽÿ�.");
		return;
	}
	if(C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"ITR_TAG")))
	{
		C_msgOk("���ڱ����� �����Ͻʽÿ�.");
		return;
	}
	fCalcItrAmt();
}
