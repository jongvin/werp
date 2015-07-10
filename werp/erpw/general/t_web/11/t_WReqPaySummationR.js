/**************************************************************************/
/* 1. �� �� �� �� id : t_WChangeBillPwR.js(���ξ�ȣ����)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

function Initialize()
{
	G_addDataSet(dsMAIN, trans, null, null, "���¾�ȣ����");
	G_addDataSet(dsLOV,null,null,null);
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
}


function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("BANK_CODE",txtBANK_CODE.value)
											+ D_P2("ACCT_NUMBER",txtACCNO_CODE.value)
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

function btnquery_onclick()
{
}

// �߰�
function btnadd_onclick()
{
}

// ����
function btninsert_onclick()
{
}

// ����
function btndelete_onclick()
{
}

// ����
function btnsave_onclick()
{
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
}


function OnKeyPress(dataset, grid, kcode)
{
}

function OnDblClick(dataset, grid, row, colid)
{
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
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

//���¹�ȣ
function txtACCNO_CODE_onblur()
{
	
	if (C_isNull(txtACCNO_CODE.value))
	{
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtACCNO_CODE.value);
	
	lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE2", lrArgs,"T");

	if (lrRet == null) return;
	txtBANK_NAME.value = lrRet.get("BANK_MAIN_NAME");
	txtBANK_CODE.value = lrRet.get("BANK_MAIN_CODE");
	txtACCNO_CODE.value = lrRet.get("ACCNO");
}
function btnACCNO_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtACCNO_CODE.value);

	lrRet = C_LOV("T_ACCNO_CODE4", lrArgs,"F");

	if (lrRet == null) return;

	txtBANK_NAME.value = lrRet.get("BANK_MAIN_NAME");
	txtBANK_CODE.value = lrRet.get("BANK_MAIN_CODE");
	txtACCNO_CODE.value = lrRet.get("ACCNO");
}

function	btnGetData_onClick()
{
	if(C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("������� �����Ͻʽÿ�.");
		return;
	}
	if(C_isNull(txtACCNO_CODE.value))
	{
		C_msgOk("���¸� �����Ͻʽÿ�.");
		return;
	}
	G_Load(dsMAIN);
}