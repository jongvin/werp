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
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "�μ��ڵ�");
	G_addDataSet(dsLOV, null, null, null, "LOV");

}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMPANY_CODE",txtCOMP_CODE.value)
											+ D_P2("USER_CODE",txtHUSER_CODE.value)
											+ D_P2("WEBTAX21_ID",txtHWEBTAX21_ID.value)
											+ D_P2("USER_NAME",txtHUSER_NAME.value)	;
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
	txtEMP_NAME.focus();
	document.all.btnCOM_ID.disabled	= true;
	document.all.txtCOM_ID.readOnly	= true;
	document.all.txtCOM_NAME.readOnly	= true;
	document.all.txtEMP_NO.readOnly	= true;	
	document.all.txtEMP_ID.readOnly	= true;	
}

// �߰�
function btnadd_onclick()
{
	gridMAIN.focus();
	D_defaultAdd();
	document.all.btnCOM_ID.disabled	= false;
	document.all.txtCOM_ID.readOnly	= false;
	document.all.txtCOM_NAME.readOnly	= false;
	document.all.txtEMP_NO.readOnly	= false;	
	document.all.txtEMP_ID.readOnly	= false;	
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
	document.all.txtEMP_NO.readOnly	= false;	
	document.all.txtEMP_ID.readOnly	= false;	
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
	txtHDEPT_CODE.focus();
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
	txtEMP_NO.focus();
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
	txtSECT_CODE.focus();
}
function	btnREG_NUM_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	if (C_isNull(txtCOM_ID.value))
	{		
		return;
	}
	
	lrArgs.set("COM_ID" , txtCOM_ID.value);
	lrArgs.set("REG_NUM", "");

	lrRet = C_LOV("TB_WT_PLANT", lrArgs,"F");
	
	if (lrRet == null) return;

	txtREG_NUM.value	= lrRet.get("REG_NUM");
	txtCOMPANY.value	= lrRet.get("COMPANY");
}
function txtREG_NUM_onblur()
{ 
	if (C_isNull(txtCOM_ID.value))
	{
		return;
	}
	if (C_isNull(txtREG_NUM.value))
	{
		txtCOMPANY.value = "";
		return;
	}	
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COM_ID" , txtCOM_ID.value);
	lrArgs.set("REG_NUM", txtREG_NUM.value);

	lrRet = C_AutoLov(dsLOV,"TB_WT_PLANT", lrArgs,"T");
	
	if (lrRet == null) return;

	txtREG_NUM.value	= lrRet.get("REG_NUM");
	txtCOMPANY.value	= lrRet.get("COMPANY");
	txtSECT_CODE.focus();
}
function	btnSECT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	if (C_isNull(txtCOM_ID.value))
	{		
		return;
	}
	
	lrArgs.set("COM_ID" , txtCOM_ID.value);
	lrArgs.set("SECT_CODE", "");

	lrRet = C_LOV("TB_WT_SECT", lrArgs,"F");
	
	if (lrRet == null) return;

	txtSECT_CODE.value	= lrRet.get("SECT_CODE");
	txtSECT_NAME.value	= lrRet.get("SECT_NAME");
	txtGRADE.focus();
}
function txtSECT_CODE_onblur()
{ 
	if (C_isNull(txtCOM_ID.value))
	{
		return;
	}
	if (C_isNull(txtSECT_CODE.value))
	{
		txtSECT_NAME.value = "";
		return;
	}	
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COM_ID" , txtCOM_ID.value);
	lrArgs.set("SECT_CODE", txtSECT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"TB_WT_SECT", lrArgs,"T");
	
	if (lrRet == null) return;

	txtSECT_CODE.value	= lrRet.get("SECT_CODE");
	txtSECT_NAME.value	= lrRet.get("SECT_NAME");
	txtGRADE.focus();
}