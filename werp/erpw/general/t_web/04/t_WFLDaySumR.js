/**************************************************************************/
/* 1. �� �� �� �� id : t_WFLDaySumR.jsp(�ڱݼ����Ϻ���������)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : �ڱݼ����Ϻ���������
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-30)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			sEMPNO;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�۾����");
	G_addDataSet(dsSUB01, null, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "���γ���");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsSUM, transSUM, null, sSelectPageName+D_P1("ACT","SUM"), "�ڷ�����");
	
	
	
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"WORK_DT","WORK_DT");
	

	
	txtDATE_FROM.value = sDTF;
	txtDATE_TO.value = sDTT;


	G_setReadOnlyCol(gridMAIN,"EMP_NO");
	G_setReadOnlyCol(gridMAIN,"NAME");
	G_setReadOnlyCol(gridMAIN,"START_DT_TIME");
	G_setReadOnlyCol(gridMAIN,"END_DT_TIME");
	G_setReadOnlyCol(gridMAIN,"ERRM");

	G_setReadOnlyCol(gridSUB01,"EMP_NO");
	G_setReadOnlyCol(gridSUB01,"NAME");
	G_setReadOnlyCol(gridSUB01,"START_DT_TIME");
	G_setReadOnlyCol(gridSUB01,"END_DT_TIME");
	G_setReadOnlyCol(gridSUB01,"ERRM");


	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridMAIN.TabToss = false;

	

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("WORK_DT_F",txtDATE_FROM.value)
										 + D_P2("WORK_DT_T",txtDATE_TO.value);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("WORK_DT",dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT"));
	}
	else if(dataset == dsSUM)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUM");
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
function	chkTopCondition()
{
	return true;
}
function	chkSave()
{
	if (G_isChangedDataset(dsMAIN))
	{
		var ret = C_msgYesNo("��������� ������ �� �۾��� �����մϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return false;
			return true;
		}
		else
		{
			return false;
		}
	}
	return true;
}
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	if (txtDATE_FROM.value == "" || txtDATE_TO.value == "")
	{
		C_msgOk("��ȸ�Ⱓ�� �Է� �Ͻʽÿ�.", "Ȯ��");
		return;
	}
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
	if (asCalendarID == "DATE_FROM")
	{
		txtDATE_FROM.value = asDate;
	}
	else if (asCalendarID == "DATE_TO")
	{
		txtDATE_TO.value = asDate;
	}
	else if (asCalendarID == dsMAIN.id+"."+"WORK_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT") = asDate;
	}
}

function OnRowDeleteBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		return false;
	}
	else if(dataset == dsSUB01)
	{
		return false;
	}
	return false;
}
function OnRowInsertBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		if(!chkTopCondition()) return false;
		return true;
	}
	else if(dataset == dsSUB01)
	{
		return false;
	}
	return true;
}
function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN)
	{
		dataset.NameString(row,"WORK_DT") = sDTT;
	}
}
function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsMAIN)
	{
		if(colid == "WORK_DT")
		{
			COL_DATA = dataset.NameString(row,colid);
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	var		liDataRow = row;
	if (dataset == dsMAIN)
	{
		if(colid == "WORK_DT")
		{
			C_Calendar(dataset.id+"."+colid, "D", dataset.NameString(dataset.RowPosition,colid));
		}
	}
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
}

// �̺�Ʈ����-------------------------------------------------------------------//


function btnDATE_FROM_onClick()
{
	C_Calendar("DATE_FROM", "D", txtDATE_FROM.value);
}

function btnDATE_TO_onClick()
{
	C_Calendar("DATE_TO", "D", txtDATE_TO.value);
}

function	btnMakeInSlip_onClick()	//
{
	if(!chkTopCondition()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("���� �۾������ �Է��Ͻʽÿ�.");
		return;
	}
	if(!chkSave()) return;
	G_Load(dsSUM);
	for(var i = 1 ; i <= dsMAIN.Countrow ; i ++)
	{
		if(dsMAIN.RowMark(i) == 1)
		{
			G_addRow(dsSUM);
			dsSUM.NameString(dsSUM.RowPosition,"WORK_DT") = dsMAIN.NameString(i,"WORK_DT");
		}
	}
	transSUM.Parameters = "ACT=SUM";
	if(!G_saveData(dsSUM))return;
	C_msgOk("�ڷᰡ ���������� ����Ǿ����ϴ�.");
	G_Load(dsSUB01);
	var			liRow = dsSUB01.CountRow;
	dsMAIN.NameString(dsMAIN.RowPosition,"EMP_NO") = dsSUB01.NameString(liRow,"EMP_NO");
	dsMAIN.NameString(dsMAIN.RowPosition,"NAME") = dsSUB01.NameString(liRow,"NAME");
	dsMAIN.NameString(dsMAIN.RowPosition,"START_DT_TIME") = dsSUB01.NameString(liRow,"START_DT_TIME");
	dsMAIN.NameString(dsMAIN.RowPosition,"END_DT_TIME") = dsSUB01.NameString(liRow,"END_DT_TIME");
	dsMAIN.NameString(dsMAIN.RowPosition,"ERRM") = dsSUB01.NameString(liRow,"ERRM");
	dsMAIN.ResetStatus();
}

