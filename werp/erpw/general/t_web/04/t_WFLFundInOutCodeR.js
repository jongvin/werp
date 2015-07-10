/**************************************************************************/
/* 1. �� �� �� �� id : HTML_1.js(���� ȭ��)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-18)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "����ݳ����ڵ�");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "�����������");

	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"ITEM_CODE","ITEM_CODE");
	gridMAIN.focus();
	G_setLovCol(gridSUB01,"FLOW_ITEM_NAME");
	//G_setReadOnlyCol(gridSUB01,"FLOW_ITEM_NAME");
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
									 + D_P2("ITEM_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"ITEM_CODE"));
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
	D_defaultSave();
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
	if(dataset==dsMAIN)
	{
		dataset.NameValue(row,"IO_TAG") = "1";	
	}
	else if(dataset ==dsSUB01)
	{
		
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
	if(dataset == dsSUB01)
	{
		if(colid=='FLOW_ITEM_NAME')
		{
			if(C_isNull(dataset.NameValue(row, "FLOW_ITEM_NAME")))
			{
				dataset.NameValue(row, "FLOW_CODE_B")='';	
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", dataset.NameValue(row, "FLOW_CODE_B"));
			lrRet = C_LOV("T_FL_FLOW_CODE_B1", lrArgs,"T");
		
			if (lrRet == null) return;
		
			dataset.NameValue(row, "FLOW_CODE_B")	= lrRet.get("FLOW_CODE_B");
			dataset.NameValue(row, "FLOW_ITEM_NAME")	= lrRet.get("FLOW_ITEM_NAME");	
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsSUB01)
	{
		if(colid=='FLOW_ITEM_NAME')
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		       lrArgs.set("SEARCH_CONDITION", "");
			lrRet = C_LOV("T_FL_FLOW_CODE_B1", lrArgs,"F");
		
			if (lrRet == null) return;
		
			dataset.NameValue(row, "FLOW_CODE_B")	= lrRet.get("FLOW_CODE_B");
			dataset.NameValue(row, "FLOW_ITEM_NAME")	= lrRet.get("FLOW_ITEM_NAME");	
		}
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
