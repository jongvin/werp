/**************************************************************************/
/* 1. �� �� �� �� id : t_WCompanyR(����� ���)
/* 2. ����(�ó�����) : ������� ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-11)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "������ڵ�");
	G_addDataSet(dsBANK_MAIN, null, null, null, "���ົ��");
	G_addDataSet(dsBANK_CODE, null, null, null, "��������");
	G_addDataSet(dsLOV, null, null, null, "LOV");

	G_addRel(dsBANK_MAIN, dsBANK_CODE);
	G_addRelCol(dsBANK_CODE, "BANK_MAIN_CODE", "BANK_MAIN_CODE");
	txtCOMP_CODE_S.value = sCompCode;
	txtCOMPANY_NAME_S.value = sCompName;
	G_Load(dsBANK_MAIN, null);
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE_S.value)
											+ D_P2("BANK_CODE",dsBANK_CODE.NameString(dsBANK_CODE.RowPosition,"BANK_CODE"))
											+ D_P2("BANK_MAIN_CODE",dsBANK_MAIN.NameString(dsBANK_MAIN.RowPosition,"BANK_MAIN_CODE"));
	}
	else if(dataset == dsBANK_MAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","BANK_MAIN");
	}
	else if(dataset == dsBANK_CODE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","BANK_CODE")
											+ D_P2("BANK_MAIN_CODE",dsBANK_MAIN.NameString(dsBANK_MAIN.RowPosition,"BANK_MAIN_CODE"));
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

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	if (C_isNull(txtCOMP_CODE_S.value))
	{
		C_msgOk("������ڵ带 �Է��ϼ���.","Ȯ��");
		return;
	}
	
	D_defaultAdd();
	txtACCNO.focus();
}

// ����
function btninsert_onclick()
{
	if (C_isNull(txtCOMP_CODE_S.value))
	{
		C_msgOk("������ڵ带 �Է��ϼ���.","Ȯ��");
		return;
	}
	
	D_defaultInsert();
	txtACCNO.focus();
}

// ����
function btndelete_onclick()
{

	D_defaultDelete();
}

// ����
function btnsave_onclick()
{
	D_defaultSave(dsMAIN);
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "CONT_DT")
	{
		txtCONT_DT.value = asDate;
	}
	else if (asCalendarID == "EXPR_DT")
	{
		txtEXPR_DT.value = asDate;
	}
	else if (asCalendarID == "EXPR_CHG_DT")
	{
		txtEXPR_CHG_DT.value = asDate;
	}
	else if (asCalendarID == "MIDD_CANCEL_DT")
	{
		txtMIDD_CANCEL_DT.value = asDate;
	}
}


function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
	dsMAIN.NameValue(row, "COMP_CODE") = txtCOMP_CODE_S.value;
	if(dsBANK_CODE.NameString(dsBANK_CODE.RowPosition,"BANK_CODE") != "%")
	{
		dsMAIN.NameValue(row, "BANK_CODE") = dsBANK_CODE.NameString(dsBANK_CODE.RowPosition,"BANK_CODE");
	}
	dsMAIN.NameValue(row, "ACCT_CLS") = "1";
	dsMAIN.NameValue(row, "PAY_ACCNO_CLS") = "F";
	dsMAIN.NameValue(row, "CHK_ACCNO_CLS") = "F";
	dsMAIN.NameValue(row, "HSMS_USE_CLS") = "F";
	dsMAIN.NameValue(row, "USE_CLS") = "T";

	dsMAIN.NameValue(row, "FBS_ACCOUNT_CLS") = "F";
	dsMAIN.NameValue(row, "FBS_TRANSFER_CLS") = "F";
	dsMAIN.NameValue(row, "VIRTUAL_ACCOUNT_CLS") = "F";
}

function OnRowDeleteBefore(dataset)
{
	return true;
}

function OnRowDeleted(dataset, row)
{
}

function OnRowPosChanged(dataset, row)
{
	if(dataset == dsBANK_CODE)
	{
		gridMAIN.focus();
		D_defaultLoad();
	}
}

function OnColumnChanged(dataset, row, colid)
{
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}

// �̺�Ʈ����-------------------------------------------------------------------//
function txtCOMP_CODE_S_onblur()
{
	if (C_isNull(txtCOMP_CODE_S.value))
	{
		txtCOMPANY_NAME_S.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE_S.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs, "T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE_S.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME_S.value	= lrRet.get("COMPANY_NAME");
	D_defaultLoad();
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs, "T");
	
	if (lrRet == null) return;

	txtCOMP_CODE_S.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME_S.value	= lrRet.get("COMPANY_NAME");
	D_defaultLoad();
}

function btnCONT_DT_onClick()
{
	C_Calendar("CONT_DT", "D", txtCONT_DT.value);
}

function btnEXPR_DT_onClick()
{
	C_Calendar("EXPR_DT", "D", txtEXPR_DT.value);
}

function btnEXPR_CHG_DT_onClick()
{
	C_Calendar("EXPR_CHG_DT", "D", txtEXPR_CHG_DT.value);
}

function btnMIDD_CANCEL_DT_onClick()
{
	C_Calendar("MIDD_CANCEL_DT", "D", txtMIDD_CANCEL_DT.value);
}

function txtDEPT_CODE_onblur()
{
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_NAME.value = "";
		return;
	}
	
	if (txtDEPT_CODE_H.value == txtDEPT_CODE.value) return;
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1", lrArgs, "T");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
}

function btnDEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);
	
	if (C_isNull(txtDEPT_CODE.value))
	{
		lrRet = C_LOV("T_DEPT_CODE1", lrArgs, "F");
	}
	else
	{
		lrRet = C_LOV("T_DEPT_CODE1", lrArgs, "T");
	}
	
	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
}

function txtACC_CODE_onblur()
{
	if (C_isNull(txtACC_CODE.value))
	{
		txtACC_NAME.value = "";
		return;
	}
	
	if (txtACC_CODE_H.value == txtACC_CODE.value) return;
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs, "T");
	
	if (lrRet == null) return;
	
	txtACC_CODE.value	= lrRet.get("ACC_CODE");
	txtACC_NAME.value	= lrRet.get("ACC_NAME");
}

function btnACC_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);
	
	if (C_isNull(txtACC_CODE.value))
	{
		lrRet = C_LOV("T_ACC_CODE1", lrArgs, "F");
	}
	else
	{
		lrRet = C_LOV("T_ACC_CODE1", lrArgs, "T");
	}
	
	if (lrRet == null) return;

	txtACC_CODE.value	= lrRet.get("ACC_CODE");
	txtACC_NAME.value	= lrRet.get("ACC_NAME");
}

function txtITR_ACC_CODE_onblur()
{
	if (C_isNull(txtITR_ACC_CODE.value))
	{
		txtITR_ACC_NAME.value = "";
		return;
	}
	
	if (txtITR_ACC_CODE_H.value == txtITR_ACC_CODE.value) return;
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtITR_ACC_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs, "T");
	
	if (lrRet == null) return;
	
	txtITR_ACC_CODE.value	= lrRet.get("ACC_CODE");
	txtITR_ACC_NAME.value	= lrRet.get("ACC_NAME");
}

function btnITR_ACC_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtITR_ACC_CODE.value);
	
	if (C_isNull(txtITR_ACC_CODE.value))
	{
		lrRet = C_LOV("T_ACC_CODE1", lrArgs, "F");
	}
	else
	{
		lrRet = C_LOV("T_ACC_CODE1", lrArgs, "T");
	}
	
	if (lrRet == null) return;

	txtITR_ACC_CODE.value	= lrRet.get("ACC_CODE");
	txtITR_ACC_NAME.value	= lrRet.get("ACC_NAME");
}
