/**************************************************************************/
/* 1. �� �� �� �� id : t_WSlipAllSumRegister.jsp(��ǥ�Ⱓ����)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ��ǥ�Ⱓ����
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-03) 
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, null, sSelectPageName+D_P1("ACT","MAIN"), "����");
	G_addDataSet(dsSLIP_CHECK, trans, null, sSelectPageName+D_P1("ACT","SLIP_CHECK"), "�̿���ǥ����üũ");
	G_addDataSet(dsCLSE_ACC_ID, null, null, sSelectPageName+D_P1("ACT","CLSE_ACC_ID"), "ȸ��⵵");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	G_Load(dsCLSE_ACC_ID);

	dsCLSE_ACC_ID.RowPosition = dsCLSE_ACC_ID.CountRow
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}

	else if(dataset == dsSLIP_CHECK)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SLIP_CHECK")
										+ D_P2("COMP_CODE",txtCOMP_CODE.value)
										+ D_P2("MAKE_DT",(parseInt(dsCLSE_ACC_ID.NameString(dsCLSE_ACC_ID.RowPosition,"CLSE_ACC_ID"))+1)+'0101');
	}
	else if(dataset == dsCLSE_ACC_ID)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CLSE_ACC_ID")
										+ D_P2("COMP_CODE",txtCOMP_CODE.value);
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
function	CheckBudgYyyyMm()
{
	if (C_isNull(txtBUDG_YYYY_MM_FR.value))
	{
		C_msgOk("�Ⱓ�� �Է��ϼ���.", "Ȯ��");
		return false;
	}
	if (C_isNull(txtBUDG_YYYY_MM_TO.value))
	{
		C_msgOk("�Ⱓ�� �Է��ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	//D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	//D_defaultAdd();
}

// ����
function btninsert_onclick()
{
	//D_defaultInsert();
}

// ����
function btndelete_onclick()
{
	//D_defaultDelete();
}

// ����
function btnsave_onclick()
{
	//D_defaultSave(dsMAIN);
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "BUDG_YYYY_MM_FR")
	{
		txtBUDG_YYYY_MM_FR.value = asDate;
	}
	else if (asCalendarID == "BUDG_YYYY_MM_TO")
	{
		txtBUDG_YYYY_MM_TO.value = asDate;
	}
}

function OnRowInserted(dataset, row)
{
	dsMAIN.NameValue(dsMAIN.RowPosition, "USE_CLS") = "T";
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

function btnBUDG_YYYY_MM_FR_onClick()
{
	C_Calendar("BUDG_YYYY_MM_FR", "M", txtBUDG_YYYY_MM_FR.value);
	 
}

function btnBUDG_YYYY_MM_TO_onClick()
{
	C_Calendar("BUDG_YYYY_MM_TO", "M", txtBUDG_YYYY_MM_TO.value);
	
}
 
function	btnSum_onClick()
{
	if(dsCLSE_ACC_ID.RowPosition < 1){
		C_msgOk("ȸ�Ⱑ ��ϵ��� �ʾҽ��ϴ�.");
		return;
	}
	G_Load(dsSLIP_CHECK);
	if(dsSLIP_CHECK.NameString(1,"CNT")!="0"){
		var	vRet = C_msgYesNo("�̿���ǥ�� �̹� �����Ǿ����ϴ�. �����ϰ� �ٽ� �����Ͻðڽ��ϱ�?", "Ȯ��");
		if (vRet != "Y") return;
	}

	G_Load(dsMAIN);
	dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE") = dsCLSE_ACC_ID.NameString(dsCLSE_ACC_ID.RowPosition,"COMP_CODE");
	dsMAIN.NameString(dsMAIN.RowPosition,"CLSE_ACC_ID") = dsCLSE_ACC_ID.NameString(dsCLSE_ACC_ID.RowPosition,"CLSE_ACC_ID");
	
	if(G_saveData(dsMAIN))
	{
		C_msgOk("�����̿��۾��� ���� ����Ǿ����ϴ�.");
	}
}
