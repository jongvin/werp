/**************************************************************************/
/* 1. �� �� �� �� id : t_WPlMaSum.jsp(������������ �� ���)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ������������ �� ���
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-25) 
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			autopopval_1;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, null, sSelectPageName+D_P1("ACT","MAIN"), "����");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","MAIN"), "LOV");
	
	C_addDateCol(txtBUDG_YYYY_MM_FR,btnBUDG_YYYY_MM_FR,"M");
	autopopval_1 = new C_AutoPopWhenChange(dsLOV,"T_PL_MA_DEV_RAT_HIST",txtDVD_RAT_HIST,"autopopval_1",true,true);
	autopopval_1.SetArgBind("SEARCH_CONDITION",txtDVD_RAT_HIST,"value");
	
	////LOV�� ����� ���� ���� ��Ʈ���� ����
	autopopval_1.SetReturnBind("HIST_SEQ",txtHIST_SEQ,"value");
	autopopval_1.SetReturnBind("NAME",txtDVD_RAT_HIST,"value");
	autopopval_1.AttachButton(btnDVD_RAT);
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
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
		C_msgOk("�۾������ �Է��ϼ���.", "Ȯ��");
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


 
function	btnSum_onClick()
{
	if(!CheckBudgYyyyMm()) return;
	G_Load(dsMAIN);
	dsMAIN.NameString(dsMAIN.RowPosition,"YMF") = txtBUDG_YYYY_MM_FR.value.replace(/-/g,'');
	dsMAIN.NameString(dsMAIN.RowPosition,"HIST_SEQ") = txtHIST_SEQ.value;
	
	if(G_saveData(dsMAIN))
	{
		C_msgOk("���谡 ���� ����Ǿ����ϴ�.");
	}
}
