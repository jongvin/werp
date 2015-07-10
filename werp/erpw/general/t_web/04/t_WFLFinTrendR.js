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
	G_setReadOnlyCol(gridMAIN,"P_D_UD_TAG");
	G_setReadOnlyCol(gridMAIN,"P_D_UD_POS");
	G_setReadOnlyCol(gridMAIN,"P_M_UD_TAG");
	G_setReadOnlyCol(gridMAIN,"P_M_UD_POS");
	G_setReadOnlyCol(gridMAIN,"P_Y_UD_TAG");
	G_setReadOnlyCol(gridMAIN,"P_Y_UD_POS");
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
function	calcPDay()
{
	var			lfNow = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"ITR_RATIO"));
	var			lfCompare = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"P_D_RATIO"));
	if(lfNow > lfCompare)
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"P_D_UD_POS") = lfNow - lfCompare;
		dsMAIN.NameString(dsMAIN.RowPosition,"P_D_UD_TAG") = "U";
	}
	else if(lfNow < lfCompare)
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"P_D_UD_POS") = lfCompare - lfNow;
		dsMAIN.NameString(dsMAIN.RowPosition,"P_D_UD_TAG") = "D";
	}
	else
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"P_D_UD_POS") = 0;
		dsMAIN.NameString(dsMAIN.RowPosition,"P_D_UD_TAG") = "M";
	}
}
function	calcPMonth()
{
	var			lfNow = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"ITR_RATIO"));
	var			lfCompare = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"P_ML_RATIO"));
	if(lfNow > lfCompare)
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"P_M_UD_POS") = lfNow - lfCompare;
		dsMAIN.NameString(dsMAIN.RowPosition,"P_M_UD_TAG") = "U";
	}
	else if(lfNow < lfCompare)
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"P_M_UD_POS") = lfCompare - lfNow;
		dsMAIN.NameString(dsMAIN.RowPosition,"P_M_UD_TAG") = "D";
	}
	else
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"P_M_UD_POS") = 0;
		dsMAIN.NameString(dsMAIN.RowPosition,"P_M_UD_TAG") = "M";
	}
}
function	calcPYear()
{
	var			lfNow = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"ITR_RATIO"));
	var			lfCompare = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"P_YL_RATIO"));
	if(lfNow > lfCompare)
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"P_Y_UD_POS") = lfNow - lfCompare;
		dsMAIN.NameString(dsMAIN.RowPosition,"P_Y_UD_TAG") = "U";
	}
	else if(lfNow < lfCompare)
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"P_Y_UD_POS") = lfCompare - lfNow;
		dsMAIN.NameString(dsMAIN.RowPosition,"P_Y_UD_TAG") = "D";
	}
	else
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"P_Y_UD_POS") = 0;
		dsMAIN.NameString(dsMAIN.RowPosition,"P_Y_UD_TAG") = "M";
	}
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
	if(!checkDate()) return false;
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
		dataset.NameValue(row,"P_D_UD_TAG") ='M';
		dataset.NameValue(row,"P_M_UD_TAG") ='M';
		dataset.NameValue(row,"P_Y_UD_TAG") ='M';
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
	if(dataset == dsMAIN)
	{
		if(colid == "ITR_RATIO")
		{
			calcPDay();
			calcPMonth();
			calcPYear();
		}
		else if(colid == "P_D_RATIO")
		{
			calcPDay();
		}
		else if(colid == "P_ML_RATIO")
		{
			calcPMonth();
		}
		else if(colid == "P_YL_RATIO")
		{
			calcPYear();
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsMAIN)
	{
		if(colid=='M_MARKET_STAT_NAME')
		{
			if(C_isNull(dsMAIN.NameValue(row, "M_MARKET_STAT_NAME")))
			{
				dsMAIN.NameValue(row, "M_MARKET_STAT_CODE")='';	
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", dsMAIN.NameValue(row, "M_MARKET_STAT_NAME"));
			lrRet = C_LOV("T_FL_M_MARKET_STAT_CODE1", lrArgs,"T");
		
			if (lrRet == null) return;
		
			dsMAIN.NameValue(row, "M_MARKET_STAT_CODE")	= lrRet.get("M_MARKET_STAT_CODE");
			dsMAIN.NameValue(row, "M_MARKET_STAT_NAME")	= lrRet.get("M_MARKET_STAT_NAME");	
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsMAIN)
	{
		if(colid=='M_MARKET_STAT_NAME')
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		       lrArgs.set("SEARCH_CONDITION", "");
			lrRet = C_LOV("T_FL_M_MARKET_STAT_CODE1", lrArgs,"F");
		
			if (lrRet == null) return;
		
			dsMAIN.NameValue(row, "M_MARKET_STAT_CODE")	= lrRet.get("M_MARKET_STAT_CODE");
			dsMAIN.NameValue(row, "M_MARKET_STAT_NAME")	= lrRet.get("M_MARKET_STAT_NAME");	
		}
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
function btnWORK_DT_onClick()
{
	C_Calendar("WORK_DT", "D", txtWORK_DT.value);
}
function	btnCopyPrevDay_onClick()
{
	if(!checkConditions()) return;
	var	ret = C_msgYesNo("�� �۾��� ���� ��¥�� �Էµ� ���� �ڷ�� ���� �����˴ϴ�.<br> ���� �۾��� �����Ͻðڽ��ϱ�?","���");
	if(ret == "N") return;
	G_Load(dsCOPY);
	dsCOPY.NameString(dsCOPY.RowPosition,"WORK_DT") = txtWORK_DT.value;
	transCOPY.Parameters = "ACT=COPY";
	if(!G_saveData(dsCOPY))return;
	G_Load(dsMAIN);
}
