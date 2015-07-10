/**************************************************************************/
/* 1. �� �� �� �� id : t_WCommonCodeR(�����ڵ� ���)
/* 2. ����(�ó�����) : �����ڵ��� ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-04)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�ڵ�׷�");
	G_addDataSet(dsGROUP_NO, null, null, sSelectPageName+D_P1("ACT","GROUP_NO"), "�׷��ȣ");
	G_addDataSet(dsLIST, trans, gridSUB01, sSelectPageName+D_P1("ACT","LIST"), "�׷캰�ڵ�");

	G_addRel(dsMAIN, dsLIST);
	G_addRelCol(dsLIST, "CODE_GROUP_NO", "CODE_GROUP_NO");

	G_Load(dsMAIN, null);
	
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("CODE_GROUP_ID",txtCODE_GROUP_ID.value)
											+ D_P2("CODE_GROUP_NAME",txtCODE_GROUP_NAME.value);
	}
	else if(dataset == dsGROUP_NO)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","GROUP_NO");
	}
	else if (dataset == dsLIST)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","LIST")
											+ D_P2("CODE_GROUP_NO",dsMAIN.NameString(dsMAIN.RowPosition, "CODE_GROUP_NO"));
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

function OnRowInserted(dataset, row)
{
	if (dataset == dsMAIN)
	{
		var strGROUP_NO;
		
		G_Load(dsGROUP_NO, null);
		
		strGROUP_NO = dsGROUP_NO.NameString(dsGROUP_NO.RowPosition,"GROUP_NO");
		
		dsMAIN.NameString(row,"CODE_GROUP_NO") = strGROUP_NO;
		dsMAIN.NameString(row,"OPEN_TAG") = "F";
	}
	else if(dataset == dsLIST)
	{
		dsLIST.NameString(row,"USE_TAG") = "T";
	}
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
