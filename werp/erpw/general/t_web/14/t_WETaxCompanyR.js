/**************************************************************************/
/* 1. �� �� �� �� id : t_WCompanyR(����� ���)
/* 2. ����(�ó�����) : ������� ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-11)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var p;
var ph;
var peer;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "������ڵ�");
	G_addDataSet(dsLOV, null, null, null, "LOV");

}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMPANY_CODE",txtCOMP_CODE.value)
											+ D_P2("REG_NUM",txtHREG_NUM.value)
											+ D_P2("COMPANY",txtHCOMPANY.value);
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
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("�迭���ڵ带 �Է��ϼ���");
		return;
	}	
	
	gridMAIN.focus();
	D_defaultLoad();
	txtSAUP_CODE.focus();
	document.all.btnCOM_ID.disabled	= true;
	document.all.txtCOM_ID.readOnly	= true;
	document.all.txtCOM_NAME.readOnly	= true;
	document.all.txtREG_NUM.readOnly	= true;
}

// �߰�
function btnadd_onclick()
{
	gridMAIN.focus();
	D_defaultAdd();
	document.all.btnCOM_ID.disabled	= false;
	document.all.txtCOM_ID.readOnly	= false;
	document.all.txtCOM_NAME.readOnly	= false;
	document.all.txtREG_NUM.readOnly	= false;	
	txtCOM_ID.value = txtCOMP_CODE.value;
	txtCOM_NAME.value = txtCOMP_NAME.value;
	txtCOM_ID.focus();
}

// ����
function btninsert_onclick()
{
	gridMAIN.focus();
	D_defaultInsert();
	document.all.btnCOM_ID.disabled	= false;
	document.all.txtCOM_ID.readOnly	= false;
	document.all.txtCOM_NAME.readOnly	= false;
	document.all.txtREG_NUM.readOnly	= false;
	txtCOM_ID.value = txtCOMP_CODE.value;
	txtCOM_NAME.value = txtCOMP_NAME.value;	
	txtCOM_ID.focus();
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
	if (asCalendarID == "INSERT_DATE")
	{
		txtINSERT_DATE.value = asDate;
	}
	else if (asCalendarID == "UPDATE_DATE")
	{
		txtUPDATE_DATE.value = asDate;
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
function btnZIP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	if (C_isNull(txtZIP_CODE.value))
	{
		lrRet = C_LOV("T_ZIP_CODE", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_ZIP_CODE", lrArgs,"T");
	}
	
	if (lrRet == null) return;

	txtZIP_CODE.value	= lrRet.get("MASKED_ZIPCODE");
	txtADDRESS.value		= lrRet.get("AREA_NAME");
	txtADDRESS2.focus();
}
function txtZIP_CODE_onblur()
{
	if (C_isNull(txtZIP_CODE.value))
	{
//		txtADDRESS.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtZIP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_ZIP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtZIP_CODE.value	= lrRet.get("MASKED_ZIPCODE");
	txtADDRESS.value	= lrRet.get("AREA_NAME");
	txtADDRESS2.focus();
}

function	txtREG_NUM_onblur()
{
//	if (txtREG_NUM.value == "") return;
//	txtREG_NUM.value = txtREG_NUM.value.replace(/-/g, "").substr(0, 6) + "-" + txtREG_NUM.value.replace(/-/g, "").substr(6, 7);
}
//�����ã��
function	btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COM_ID", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COM_ID");
	txtCOMP_NAME.value	= lrRet.get("COM_NAME");
	txtHREG_NUM.focus();
}
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMP_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COM_ID", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COM_ID");
	txtCOMP_NAME.value	= lrRet.get("COM_NAME");
	txtHREG_NUM.focus();
}
function	btnCOM_ID_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COM_ID", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCOM_ID.value	= lrRet.get("COM_ID");
	txtCOM_NAME.value	= lrRet.get("COM_NAME");
}
function txtCOM_ID_onblur()
{ 
	if (C_isNull(txtCOM_ID.value))
	{
		txtCOM_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOM_ID.value);

	lrRet = C_AutoLov(dsLOV,"T_COM_ID", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOM_ID.value	= lrRet.get("COM_ID");
	txtCOM_NAME.value	= lrRet.get("COM_NAME");
	txtREG_NUM.focus();
}