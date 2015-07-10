/**************************************************************************/
/* 1. �� �� �� �� id : t_WTaxCompanyR.js(�����Ű����� ���)
/* 2. ����(�ó�����) : �����Ű������� ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "������ڵ�");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	txtCOMP_CODE_S.value = sCompCode;
	txtCOMPANY_NAME_S.value = sCompName;
	gridMAIN.focus();
	
	
}

function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE_S.value);
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
	if(C_isNull(txtCOMP_CODE_S.value))
	{
		C_msgOk("������ڵ带 �Է��ϼ���.", "Ȯ��");
		return;
	}
	D_defaultAdd();
}

// ����
function btninsert_onclick()
{
	if(C_isNull(txtCOMP_CODE_S.value))
	{
		C_msgOk("������ڵ带 �Է��ϼ���.", "Ȯ��");
		return;
	}
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
	if (asCalendarID == "OPEN_DT")
	{
		txtOPEN_DT.value = asDate;
	}
	else if (asCalendarID == "ACCOUNT_FDT")
	{
		txtACCOUNT_FDT.value = asDate;
	}
	else if (asCalendarID == "ACCOUNT_EDT")
	{
		txtACCOUNT_EDT.value = asDate;
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
}

function OnRowDeleteBefore(dataset)
{
	return true;
}

function OnRowDeleted(dataset, row)
{
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

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");
	
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

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE_S.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME_S.value	= lrRet.get("COMPANY_NAME");
	D_defaultLoad();
}

function btnOPEN_DT_onClick()
{
	C_Calendar("OPEN_DT", "D", txtOPEN_DT.value);
}

function btnBIZPLACE_ZIPCODE_onClick()
{
	
	var lrArgs = new C_Dictionary();
		
	lrArgs.set("SEARCH_CONDITION", "");
		
	var lrRet = null;

	lrRet = C_LOV("T_ZIP_CODE", lrArgs);
	
	if (lrRet != null)
	{
		txtBIZPLACE_ZIPCODE.value	= lrRet.get("MASKED_ZIPCODE");
		txtBIZPLACE_ADDR1.value	= lrRet.get("AREA_NAME");
		
	}

}

function btnHEADOFF_ZIPCODE_onClick()
{
}

function btnHEAD_COMP_CODE_onClick()
{
}

function btnACCOUNT_FDT_onClick()
{
	C_Calendar("ACCOUNT_FDT", "D", txtACCOUNT_FDT.value);
}

function btnACCOUNT_EDT_onClick()
{
	C_Calendar("ACCOUNT_EDT", "D", txtACCOUNT_EDT.value);
}

function	txtBIZNO2_onblur()
{
	if (txtBIZNO2.value == "") return;
	txtBIZNO2.value = txtBIZNO2.value.replace(/-/g, "").substr(0, 6) + "-" + txtBIZNO2.value.replace(/-/g, "").substr(6, 7);
}

function txtBIZPLACE_ZIPCODE_onBlur()
{
	if (C_isNull(txtBIZPLACE_ZIPCODE.value))
	{
		txtBIZPLACE_ADDR1.value = "";
		txtBIZPLACE_ADDR2.value = "";
		btnBIZPLACE_ZIPCODE.focus();
	}
	
	if (C_isNull(txtBIZPLACE_ZIPCODE.value))
	{
		txtBIZPLACE_ADDR1.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtBIZPLACE_ZIPCODE.value);

	lrRet = C_AutoLov(dsLOV,"T_ZIP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtBIZPLACE_ZIPCODE.value	= lrRet.get("MASKED_ZIPCODE");
	txtBIZPLACE_ADDR1.value		= lrRet.get("AREA_NAME");
	txtBIZPLACE_ADDR2.focus();
	
}