/**************************************************************************/
/* 1. �� �� �� �� id : t_WLoanKindR.js(���������������)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-17)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "���������������");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");

	
	G_setAutoLovCol("T_ACC_CODE1",gridMAIN, dsLOV , "SEC_ACC_CODE" , "SEC_ACC_CODE:SEARCH_CONDITION" , "SEC_ACC_CODE:ACC_CODE,SEC_ACC_CODE_NAME:ACC_NAME");
	G_setAutoLovCol("T_ACC_CODE1",gridMAIN, dsLOV , "SEC_ACC_CODE_NAME" , "SEC_ACC_CODE_NAME:SEARCH_CONDITION" , "SEC_ACC_CODE:ACC_CODE,SEC_ACC_CODE_NAME:ACC_NAME");
	G_setAutoLovCol("T_ACC_CODE1",gridMAIN, dsLOV , "ITRP_ACC_CODE" , "ITRP_ACC_CODE:SEARCH_CONDITION" , "ITRP_ACC_CODE:ACC_CODE,ITRP_ACC_CODE_NAME:ACC_NAME");
	G_setAutoLovCol("T_ACC_CODE1",gridMAIN, dsLOV , "ITRP_ACC_CODE_NAME" , "ITRP_ACC_CODE_NAME:SEARCH_CONDITION" , "ITRP_ACC_CODE:ACC_CODE,ITRP_ACC_CODE_NAME:ACC_NAME");
	G_setAutoLovCol("T_ACC_CODE1",gridMAIN, dsLOV , "ITRB_ACC_CODE" , "ITRB_ACC_CODE:SEARCH_CONDITION" , "ITRB_ACC_CODE:ACC_CODE,ITRB_ACC_CODE_NAME:ACC_NAME");
	G_setAutoLovCol("T_ACC_CODE1",gridMAIN, dsLOV , "ITRB_ACC_CODE_NAME" , "ITRB_ACC_CODE_NAME:SEARCH_CONDITION" , "ITRB_ACC_CODE:ACC_CODE,ITRB_ACC_CODE_NAME:ACC_NAME");
	

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.

	gridMAIN.TabToss = false;
	gridMAIN.focus();
	//G_Load(dsMAIN, null);
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
	if(dataset == dsMAIN)
	{
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsMAIN)
	{
	}
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
}

// �̺�Ʈ����-------------------------------------------------------------------//
