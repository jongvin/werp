/**************************************************************************/
/* 1. �� �� �� �� id : t_WFinPaySumAccGroupR.jsp(���������������)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : �����������������ȸ
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-10)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			sACC_CODE = "";
var			sACC_NAME = "";
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "��������������");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "�������");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"ACC_KIND_CODE","ACC_KIND_CODE");
	

	G_setReadOnlyCol(gridSUB01,"ACC_CODE");
	G_setReadOnlyCol(gridSUB01,"ACC_NAME");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridMAIN.TabToss = false;

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("ACC_KIND_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"ACC_KIND_CODE"));
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
function	getAccCode()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
	if (lrRet != null)
	{
		sACC_CODE = lrRet.get("ACC_CODE");
		sACC_NAME = lrRet.get("ACC_NAME");
		return true;
	}
	
	return false;
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

function OnRowInsertBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		return true;
	}
	else if(dataset == dsSUB01)
	{
		return getAccCode();
	}
	return false;
}
function OnRowInserted(dataset, row)
{
	if(dataset == dsSUB01)
	{
		dataset.NameString(row,"ACC_CODE") = sACC_CODE;
		dataset.NameString(row,"ACC_NAME") = sACC_NAME;
	}
}
function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}

// �̺�Ʈ����-------------------------------------------------------------------//
