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
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�ڱݼ��������ڵ�");
	G_addDataSet(dsCOPY, transCOPY, null, sSelectPageName+D_P1("ACT","COPY"), "����");
	//alert(sDate);
	txtWORK_DT.value = sDate;
	G_setReadOnlyCol(gridMAIN,"ITEM_NAME");
	G_setReadOnlyCol(gridMAIN,"MONTH_AMT");
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("WORK_DT",txtWORK_DT.value);
	}
	else if(dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
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
function checkDate()
{
	if(C_isNull(txtWORK_DT.value))
	{
		C_msgOk("�������ڸ� �Է��ϼ���");
		return false;
	}
	return true;	
}
function	checkConditions()
{
	return checkDate();
}
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	if(!checkDate()) return false;
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
	if (asCalendarID == "WORK_DT")
	{                                
		txtWORK_DT.value = asDate;
	}                                	
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
		
		dataset.NameValue(row,"WORK_DT") =txtWORK_DT.value;
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
	if(dataset==dsMAIN)
	{
		if(colid=='AMT')
		{
			//dataset.NameValue(row,"MONTH_AMT") = dataset.NameValue(row,"MONTH_AMT_A") + dataset.NameValue(row,"AMT");
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsMAIN)
	{
		if(colid=='ITEM_NAME')
		{
			if(C_isNull(dsMAIN.NameValue(row, "ITEM_NAME")))
			{
				dsMAIN.NameValue(row, "ITEM_CODE")='';	
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", dsMAIN.NameValue(row, "ITEM_NAME"));
			lrRet = C_LOV("T_FL_FUND_IN_OUT_CODE1", lrArgs,"T");
		
			if (lrRet == null) return;
		
			dsMAIN.NameValue(row, "ITEM_CODE")	= lrRet.get("ITEM_CODE");
			dsMAIN.NameValue(row, "ITEM_NAME")	= lrRet.get("ITEM_NAME");
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsMAIN)
	{
		if(colid=='ITEM_NAME')
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		       lrArgs.set("SEARCH_CONDITION", "");
			lrRet = C_LOV("T_FL_FUND_IN_OUT_CODE1", lrArgs,"F");
		
			if (lrRet == null) return;
		
			dsMAIN.NameValue(row, "ITEM_CODE")	= lrRet.get("ITEM_CODE");
			dsMAIN.NameValue(row, "ITEM_NAME")	= lrRet.get("ITEM_NAME");	
		}
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
function btnWORK_DT_onClick()
{
	C_Calendar("WORK_DT", "D", txtWORK_DT.value);
}
function	btnPreView_onClick()
{
	if(!checkConditions()) return;
	G_Load(dsCOPY);
	dsCOPY.NameString(dsCOPY.RowPosition,"WORK_DT") = txtWORK_DT.value;
	transCOPY.Parameters = "ACT=COPY";
	if(!G_saveData(dsCOPY))return;
	G_Load(dsMAIN);
}
