/**************************************************************************/
/* 1. �� �� �� �� id : t_WBillKindR.js(���α׷�������µ��)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-06)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			sMenuNo = "";
var			sProgramNo= "";
var			sMenuName = "";
var			sProgramName = "";
var			sProgramId = "";
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "���α׷����");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	

	G_setReadOnlyCol(gridMAIN,"MENU_NAME");
	G_setReadOnlyCol(gridMAIN,"PROGRAM_NAME");
	G_setReadOnlyCol(gridMAIN,"MAKE_PROGRAMMER");
	G_setReadOnlyCol(gridMAIN,"REQ_DT");
	G_setReadOnlyCol(gridMAIN,"REQ_USER_NAME");
	G_setReadOnlyCol(gridMAIN,"CONFIRM_TAG");
	G_setReadOnlyCol(gridMAIN,"CONFIRM_DT");
	

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.

	gridMAIN.TabToss = false;
	gridMAIN.focus();
	//G_Load(dsMAIN, null);
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										+ D_P2("MENU_NAME",txtMENU_NAME.value)
										+ D_P2("PROGRAM_NAME",txtPROGRAM_NAME.value)
										+ D_P2("MAKE_PROGRAMMER",txtMAKE_PROGRAMMER.value)
										+ D_P2("REQ_DT_F",txtDT_F.value)
										+ D_P2("REQ_DT_T",txtDT_T.value)
										+ D_P2("PROCESS_TAG",cboPROCESS_TAG.value)
										+ D_P2("CONFIRM_TAG",cboCONFIRM_TAG.value)
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
	if (asCalendarID == "PROCESS_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,asCalendarID) = asDate;
	}
	else if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
	}
	else if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
}


function OnRowInsertBefore(dataset)
{
	return false;
}

function OnRowInserted(dataset, row)
{
}

function OnRowDeleteBefore(dataset)
{
	return false;
}

function OnRowDeleted(dataset, row)
{
}

function OnColumnChanged(dataset, row, colid)
{
	if(dataset == dsMAIN && colid == "PROCESS_TAG")
	{
		if(dataset.NameString(row,colid) == "T")
		{
			dataset.NameString(row,"PROCESS_DT") = sNow;
			dataset.NameString(row,"CHANGE_PROGRAMMER") = sName;
		}
		else
		{
			dataset.NameString(row,"PROCESS_DT") = "";
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	var		COL_DATA;
	if (dataset == dsMAIN)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "PROCESS_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		if(colid == "PROCESS_DT")
		{
			C_Calendar(colid, "D", dataset.NameString(row,colid));
		}
	}
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
}

// �̺�Ʈ����-------------------------------------------------------------------//
function btnDT_F_onClick()
{
	C_Calendar("DT_F", "D", txtDT_F.value);
	S_nextFocus(btnDT_F);
}

function btnDT_T_onClick()
{
	C_Calendar("DT_T", "D", txtDT_T.value);
	S_nextFocus(btnDT_T);
}
