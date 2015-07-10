/**************************************************************************/
/* 1. �� �� �� �� id : t_WPLMADeptR(���庰����������ȸ)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-25)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			bEnter = false;
var			strLastColId = "";
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "������",null,null,true);
	G_addDataSet(dsSUB01, trans, gridSUB01, null, "���庰����������ȸ",null,null,true);
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"DEPT_CODE","DEPT_CODE");
	
	G_addDataSet(dsCOPY,transCopy,null,null,"����");
	G_addDataSet(dsREMOVE,transRemove,null,null,"����");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsCLOSE, null, null, null, "CLOSE");
	
	

	txtCLSE_ACC_ID.value = sClseAccId;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();
	
	
	G_setReadOnlyCol(gridMAIN,"DEPT_CODE");
	G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"LEVELED_NAME");
	G_setReadOnlyCol(gridMAIN,"SUBTITLE_NAME");
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("WORK_YM",txtCLSE_ACC_ID.value)
											+ D_P2("DEPT_NAME",txtDEPT_NAME.value);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("WORK_YM",txtCLSE_ACC_ID.value)
											+ D_P2("DEPT_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"DEPT_CODE"));
	}
	else if(dataset == dsREMOVE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","REMOVE");
	}
	else if (dataset == dsCLOSE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CLOSE")
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value);
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
function	CalcSum(row,colid)
{
	if(dsMAIN.NameString(row,"LV") != "2") return;
	if(dsMAIN.NameString(row,"IS_LEAF_TAG") != "T") return;
	dsMAIN.NameString(row + 1,colid) = C_convSafeFloat(dsMAIN.NameString(row - 1,colid)) + C_convSafeFloat(dsMAIN.NameString(row ,colid));
}
function	checkConditions()
{

	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("���� ȸ�⸦ �����ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}
function	isClose()
{
	return false;
}
function	checkClose()
{
	if(isClose())
	{
		C_msgOk("�̹� �����Ǿ����ϴ�.");
		return true;
	}
	else
	{
		return false;
	}
}
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	if(!checkConditions()) return;
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
}

// ����
function btninsert_onclick()
{
	btnadd_onclick();
}

// ����
function btndelete_onclick()
{
}

// ����
function btnsave_onclick()
{
	var			lbRet = D_defaultSave(dsMAIN);
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
	if(dataset == dsMAIN)
	{
		G_Load(dsCLOSE);
		if(checkClose())
		{
			gridMAIN.Editable = false;
		}
		else
		{
			gridMAIN.Editable = true;
		}
	}
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
	return false;
}

function OnRowDeleted(dataset, row)
{
}
function OnColumnPosChanged(dataset, grid, row, colid)
{
	if(dataset == dsSUB01)
	{
		strLastColId = colid;
	}
}
function OnColumnChanged(dataset, row, colid)
{
	if(bEnter) return;
	bEnter = true;
	if(dataset == dsMAIN)
	{
		try
		{
			CalcSum(row,colid);
		}
		catch(e)
		{
		}
	}
	bEnter = false;
}

function OnExit(dataset, grid, row, colid, olddata)
{
}
function OnClick(dataset, grid, row, colid)
{
}
	
function OnPopup(dataset, grid, row, colid, data)
{
}
function OnPostBefore(dataset, trans)
{
	return true;
}
function	OnSuccess(dataset,trans)
{
}

// �̺�Ʈ����-------------------------------------------------------------------//

function txtCLSE_ACC_ID_onblur()
{
	
}
function	CheckCompCode()
{
	return true;
}
function	btnShowDetail_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("���λ����� ������� ���� �����Ͻʽÿ�.");
		return;
	}
	if(dsSUB01.NameString(dsSUB01.RowPosition,"IS_LEAF_TAG") != "T")
	{
		C_msgOk("���� �׸��� ���λ����� ���� �� �����ϴ�.");
		return;
	}
	
	if(strLastColId == "AMT_01")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "01");
	}
	else if (strLastColId == "AMT_02")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "02");
	}
	else if (strLastColId == "AMT_03")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "03");
	}
	else if (strLastColId == "AMT_04")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "04");
	}
	else if (strLastColId == "AMT_05")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "05");
	}
	else if (strLastColId == "AMT_06")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "06");
	}
	else if (strLastColId == "AMT_07")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "07");
	}
	else if (strLastColId == "AMT_08")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "08");
	}
	else if (strLastColId == "AMT_09")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "09");
	}
	else if (strLastColId == "AMT_10")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "10");
	}
	else if (strLastColId == "AMT_11")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "11");
	}
	else if (strLastColId == "AMT_12")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "12");
	}
	else
	{
		C_msgOk("���λ����� ������� ��(��)�� �����Ͻʽÿ�.");
		return;
	}
	

	lrArgs.set("DEPT_CODE", dsSUB01.NameString(dsSUB01.RowPosition,"DEPT_CODE"));
	lrArgs.set("ITEM_NO", dsSUB01.NameString(dsSUB01.RowPosition,"ITEM_NO"));
	var	lrRet = window.showModalDialog(
		"t_PPLMaDeptExecR.jsp",
		lrArgs,
		"center:yes; dialogWidth:976px;	dialogHeight:623px;	status:no; help:no;	scroll:no"
	);
}
