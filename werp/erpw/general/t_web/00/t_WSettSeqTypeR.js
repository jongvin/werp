/**************************************************************************/
/* 1. �� �� �� �� id : t_WUserAuthR.jsp(����ں����Ѱ���)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : ����ں����Ѱ���
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-12)
/* 5. ����  ���α׷� : ����
/* 6. Ư  ��  ��  �� : ����
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�繫��ǥ��������");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "�繫��ǥ�������");


	G_addRel(dsMAIN, dsSUB01);
	G_addRelCol(dsSUB01, "SEQ_TYPE", "SEQ_TYPE");
	
	gridMAIN.focus();
	//G_focusDataset(dsMAIN);
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//�������� ��������
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsSUB01)
	{
		var 	strSEQ_TYPE = dsMAIN.NameString(dsMAIN.RowPosition,"SEQ_TYPE");
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
							+ D_P2("SEQ_TYPE",strSEQ_TYPE);
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
	D_defaultSave(dsSUB01);
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
	if(dataset == dsSUB01)
	{
		dataset.NameString(row,"SEQ_SEQ") = dataset.CountRow;
	}
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
function txtMAIN_onblur()
{
	G_Load(dsMAIN,null);
}
