/**************************************************************************/
/* 1. �� �� �� �� id : t_WSettFinStatmentsR.js(�繫��ǥ�����ڵ�)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-17)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsSHEET_TYPE, null, null, sSelectPageName+D_P1("ACT","SHEET_TYPE"), "�繫��ǥ���");
	G_addDataSet(dsROUND_CLS, null, null, sSelectPageName+D_P1("ACT","ROUND_CLS"), "�ݿø�����");
	G_addDataSet(dsSEQ_TYPE, null, null, sSelectPageName+D_P1("ACT","SEQ_TYPE"), "��ȣ����");
	G_addDataSet(dsITEM_LVL, null, null, sSelectPageName+D_P1("ACT","ITEM_LVL"), "�׸񷹺�");

	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�繫��ǥ�ڵ�");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "������ ��ȣ����");


	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"SHEET_CODE","SHEET_CODE");

	G_Load(dsROUND_CLS, null);
	G_Load(dsSHEET_TYPE, null);
	G_Load(dsSEQ_TYPE, null);
	G_Load(dsITEM_LVL, null);
	
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsSHEET_TYPE)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SHEET_TYPE");
	}
	else if(dataset == dsROUND_CLS)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ROUND_CLS");
	}
	else if(dataset == dsSEQ_TYPE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SEQ_TYPE");
	}
	else if(dataset == dsITEM_LVL)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ITEM_LVL");
	}
	else if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsSUB01)
	{
		var			strSHEET_CODE = dsMAIN.NameString(dsMAIN.RowPosition,"SHEET_CODE");
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
							+ D_P2("SHEET_CODE",strSHEET_CODE);
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
