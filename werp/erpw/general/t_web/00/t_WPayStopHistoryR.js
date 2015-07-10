/**************************************************************************/
/* 1. �� �� �� �� id : t_WPayStopHistoryR.js(���� ȭ��)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-24)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var oldData = "";
var oldData2 = "";
var oldData3 = "";
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "���Ұŷ�����HISTORY");
	G_addDataSet(dsSEQ, null, null, null, "���Ұŷ�����HISTORY SEQ");
	G_addDataSet(dsLOV, null, null, null, "���Ұŷ�����LOV");
	
	G_setLovCol(gridMAIN,"DEPT_NAME");
	G_setLovCol(gridMAIN,"CUST_CODE");
	G_setLovCol(gridMAIN,"CUST_NAME");
	
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	
	
	if(dataset == dsMAIN)
	{
		
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										+ D_P2("SEARCH_CONDITION",txtSEARCH_CONDITION.value);
	}
	else if(dataset == dsSEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SEQ")
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
	
	var r, re;                     //������ �����մϴ�.
   	var s = txtSEARCH_CONDITION.value;
  	 re = new RegExp("-","i");  //���Խ� ��ü�� ����ϴ�.
  	 r = s.match(re);               //���ڿ� s���� ��ġ�ϴ� �κ��� ã���ϴ�.
	if(r=='-')
	{
		C_msgOk("������(-) ���� ��ȸ�ϼ���");
		return false;	
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
	if (asCalendarID == "PAY_STOPSTR_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"PAY_STOPSTR_DT") = asDate;
	}
	else if (asCalendarID == "PAY_STOPEND_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"PAY_STOPEND_DT") = asDate;
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
	
	if(dataset == dsMAIN)
	{
		G_Load(dsSEQ);
		//dsMAIN.NameString(row,"CUST_SEQ") = hiCUST_SEQ.value;
		dsMAIN.NameString(row,"PAY_STOP_CLS") = "1";
		dsMAIN.NameString(dsMAIN.RowPosition,"PAY_STOP_SEQ") = dsSEQ.NameString(dsSEQ.RowPosition,"PAY_STOP_SEQ");
	}
	
}

function OnRowDeleteBefore(dataset)
{
	return true;
}

function OnRowDeleted(dataset, row)
{
}
function OnColumnPosChanged(dataset,grid, row,colid)
{
	var		COL_DATA2;
	var		COL_DATA3;
	if (colid == "PAY_STOPSTR_DT")
	{
		COL_DATA2 = dsMAIN.NameString(row,colid);
		oldData2 = C_toDateFormatString(COL_DATA2);
	}
	else if (colid == "PAY_STOPEND_DT")
	{
		COL_DATA3 = dsMAIN.NameString(row,colid);
		oldData3 = C_toDateFormatString(COL_DATA3);
	}
}
function OnColumnChanged(dataset, row, colid)
{
		
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if (dataset == dsMAIN)
	{
		var		COL_DATA;
		COL_DATA = dsMAIN.NameString(row,colid);
		if(colid == "PAY_STOPSTR_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
		else if(colid == "PAY_STOPEND_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
		
		if(colid == "DEPT_NAME")
		{
			if(dsMAIN.NameString(row,"DEPT_NAME")=="")
			{
				dsMAIN.NameString(row,"DEPT_CODE") ="";
			}
			
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", dsMAIN.NameString(row,"DEPT_NAME"));
		
			lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1", lrArgs,"T");
			
			if (lrRet == null) return;
			
			dsMAIN.NameString(row,"DEPT_CODE")	= lrRet.get("DEPT_CODE");
			dsMAIN.NameString(row,"DEPT_NAME")	= lrRet.get("DEPT_NAME");
			
		}
		else if(colid == "CUST_CODE")
		{
			if(C_isNull(COL_DATA))
			{
				dsMAIN.NameString(row,"CUST_CODE")	= "";
				dsMAIN.NameString(row,"CUST_NAME")	= "";
				dsMAIN.NameString(row,"CUST_SEQ")	= "";
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", COL_DATA);
		
			lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");
			
			if (lrRet == null)
			{
				dataset.NameString(row,colid) = olddata;
				return;
			}
			
			dsMAIN.NameString(row,"CUST_CODE")	= lrRet.get("CUST_CODE");
			dsMAIN.NameString(row,"CUST_NAME")	= lrRet.get("CUST_NAME");
			dsMAIN.NameString(row,"CUST_SEQ")	= lrRet.get("CUST_SEQ");
		}
		else if(colid == "CUST_NAME")
		{
			if(C_isNull(COL_DATA))
			{
				dsMAIN.NameString(row,"CUST_CODE")	= "";
				dsMAIN.NameString(row,"CUST_NAME")	= "";
				dsMAIN.NameString(row,"CUST_SEQ")	= "";
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", COL_DATA);
		
			lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");
			
			if (lrRet == null)
			{
				dataset.NameString(row,colid) = olddata;
				return;
			}
			
			dsMAIN.NameString(row,"CUST_CODE")	= lrRet.get("CUST_CODE");
			dsMAIN.NameString(row,"CUST_NAME")	= lrRet.get("CUST_NAME");
			dsMAIN.NameString(row,"CUST_SEQ")	= lrRet.get("CUST_SEQ");
		}
	}
	
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(colid == "DEPT_NAME")
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV("T_DEPT_CODE1", lrArgs,"F");
		
		if (lrRet == null) return;
		
		dsMAIN.NameString(row,"DEPT_CODE")	= lrRet.get("DEPT_CODE");
		dsMAIN.NameString(row,"DEPT_NAME")	= lrRet.get("DEPT_NAME");
	}
	else if(colid == "PAY_STOPSTR_DT")
	{
		C_Calendar("PAY_STOPSTR_DT", "D", dsMAIN.NameString(dsMAIN.RowPosition,"PAY_STOPSTR_DT"));
	} 
	else if(colid == "PAY_STOPEND_DT")
	{
		C_Calendar("PAY_STOPEND_DT", "D", dsMAIN.NameString(dsMAIN.RowPosition,"PAY_STOPEND_DT"));
	}
	else if(colid == "CUST_CODE")
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
		
		if (lrRet == null) return;
		
		dsMAIN.NameString(row,"CUST_CODE")	= lrRet.get("CUST_CODE");
		dsMAIN.NameString(row,"CUST_NAME")	= lrRet.get("CUST_NAME");
		dsMAIN.NameString(row,"CUST_SEQ")	= lrRet.get("CUST_SEQ");
	}
	else if(colid == "CUST_NAME")
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
		
		if (lrRet == null) return;
		
		dsMAIN.NameString(row,"CUST_CODE")	= lrRet.get("CUST_CODE");
		dsMAIN.NameString(row,"CUST_NAME")	= lrRet.get("CUST_NAME");
		dsMAIN.NameString(row,"CUST_SEQ")	= lrRet.get("CUST_SEQ");
	}
	
}

// �̺�Ʈ����-------------------------------------------------------------------//
function	document_onKeyDown()
{
	if(event.srcElement == txtSEARCH_CONDITION && event.keyCode == 13)
	{
		btnquery_onclick();
	}
}
