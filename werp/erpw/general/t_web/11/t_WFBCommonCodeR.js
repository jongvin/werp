/**************************************************************************/
/* 1. �� �� �� �� id : t_WFBSendMailR(���¾�ȣ����)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMASTER, null, null, null, "�ڵ�з�");
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "��Ÿ�ڵ�");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	G_addRel(dsMASTER,dsMAIN);
	G_addRelCol(dsMAIN,"CODE","LOOKUP_TYPE");
	
	
	G_Load(dsMASTER);
	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("LOOKUP_TYPE",dsMASTER.NameString(dsMASTER.RowPosition,"CODE"));
	}
	else if(dataset == dsMASTER)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MASTER");
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
function	checkConditions()
{
	return true;
}

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	if(!checkConditions()) return;
	D_defaultAdd();
}

// ����
function btninsert_onclick()
{
	if(!checkConditions()) return;
	D_defaultInsert();
}

// ����
function btndelete_onclick()
{
	if(!checkConditions()) return;
	D_defaultDelete();
}

// ����
function btnsave_onclick()
{
	if(!checkConditions()) return;
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
	if(dataset == dsMAIN)
	{
		dataset.NameString(row,"USE_YN") = "T";
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


