/**************************************************************************/
/* 1. �� �� �� �� id : t_WMngItemR.js(�����׸��ڵ���)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : �����׸��ڵ带 ��� �� ��ȸ�Ѵ�.
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-10-15)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�����׸��ڵ���");
	G_addDataSet(dsDATA_TYPE, null, null, sSelectPageName+D_P1("ACT","DATA_TYPE"), "����ŸŸ��");

	
	G_Load(dsDATA_TYPE, null);

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsDATA_TYPE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DATA_TYPE");
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
	if (G_FocusDataset == dsMAIN)
	{
		G_Load(dsMAIN, null);
	}
	
	if (G_FocusObject != null) G_FocusObject.focus();
}

// �߰�
function btnadd_onclick()
{
	if (G_FocusDataset == dsMAIN)
	{
		G_addRow(dsMAIN);
	}
	
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ����
function btninsert_onclick()
{
	if (G_FocusDataset == dsMAIN)
	{
		G_insertRow(dsMAIN);
	}
	
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ����
function btndelete_onclick()
{
	if (G_FocusDataset == dsMAIN)
	{
		G_deleteRow(dsMAIN);
	}
	
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ����
function btnsave_onclick()
{
	if (G_FocusDataset == dsMAIN)
	{
		G_saveDataMsg(dsMAIN);
	}
	
	if (G_FocusObject != null) G_FocusObject.focus();
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
	if(dataset == dsMAIN)
	{
		dsMAIN.NameString(row,"DATA_TYPE") = "C";
		dsMAIN.NameString(row,"USE_TG") = "T";
		dsMAIN.NameString(row,"SEQ") = row;
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
