/**************************************************************************/
/* 1. �� �� �� �� id : t_WFixItemNmCodeR.js(�����ڻ�ǰ���ڵ���)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : �����ڻ�ǰ���ڵ��� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-17)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�����ڻ�ǰ���ڵ�");
	
	G_addDataSet(dsFIX_ASSET_CLS_CODE, null, null, sSelectPageName+D_P1("ACT","FIX_ASSET_CLS_CODE"), "�����ڻ������ڵ�");
	G_addDataSet(dsITEM_CODE, null, null, sSelectPageName+D_P1("ACT","ITEM_CODE"), "�����ڻ�ǰ���ڵ�");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	G_addRel(dsFIX_ASSET_CLS_CODE, dsITEM_CODE);
	G_addRelCol(dsITEM_CODE, "ASSET_CLS_CODE", "ASSET_CLS_CODE");
	gridMAIN.focus();
	G_setReadOnlyCol(gridMAIN, "ASSET_CLS_NAME");
	G_setReadOnlyCol(gridMAIN, "ITEM_NAME");
	G_setReadOnlyCol(gridMAIN, "DEPREC_RAT");
	G_Load(dsFIX_ASSET_CLS_CODE, null);
	//D_defaultLoad();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("ASSET_CLS_CODE", dsFIX_ASSET_CLS_CODE.NameValue(dsFIX_ASSET_CLS_CODE.RowPosition, "ASSET_CLS_CODE"))
									 + D_P2("ITEM_CODE", dsITEM_CODE.NameValue(dsITEM_CODE.RowPosition, "ITEM_CODE"));
	}
	else if(dataset == dsFIX_ASSET_CLS_CODE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","FIX_ASSET_CLS_CODE");
	}
	else if(dataset == dsITEM_CODE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ITEM_CODE")
									 + D_P2("ASSET_CLS_CODE", dsFIX_ASSET_CLS_CODE.NameValue(dsFIX_ASSET_CLS_CODE.RowPosition, "ASSET_CLS_CODE"));
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
	D_defaultAdd();
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
	if (dataset == dsMAIN)
	{
		dataset.NameValue(row, "ASSET_CLS_NAME") = dsFIX_ASSET_CLS_CODE.NameValue(dsFIX_ASSET_CLS_CODE.RowPosition, "ASSET_CLS_NAME"); 
		dataset.NameValue(row, "ASSET_CLS_CODE") = dsFIX_ASSET_CLS_CODE.NameValue(dsFIX_ASSET_CLS_CODE.RowPosition, "ASSET_CLS_CODE");
		dataset.NameValue(row, "ITEM_CODE") 	   = dsITEM_CODE.NameValue(dsITEM_CODE.RowPosition, "ITEM_CODE"); 
		dataset.NameValue(row, "ITEM_NAME")          = dsITEM_CODE.NameValue(dsITEM_CODE.RowPosition, "ITEM_NAME");  	
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
function OnRowPosChanged(dataset, row)
{
	if (dataset == dsMAIN)
	{
		oldData = dataset.NameValue(row, "SRVLIFE");	
	}
}
function OnExit(dataset, grid, row, colid, olddata)
{
	if ( dataset == dsMAIN)
	{
		if (colid=="SRVLIFE")
		{
			if (C_isNull(dataset.NameValue(row, colid)))
			{
				dataset.NameValue(row, "DEPREC_RAT") = "";	
			}
			else
			{
				var lrArgs = new C_Dictionary();
				var lrRet = null;

				lrArgs.set("SEARCH_CONDITION", dataset.NameValue(row, "SRVLIFE"));
				lrRet = C_AutoLov(dsLOV,"T_FIX_DEPREC_RAT1", lrArgs,"T");
				
				if (lrRet == null) 
				{
					dataset.NameValue(row, "SRVLIFE") = oldData;
					
					return;
				}
				
				dataset.NameValue(row, "SRVLIFE")		= lrRet.get("SRVLIFE");
				dataset.NameValue(row, "DEPREC_RAT")	= lrRet.get("DEPREC_RAT");
			}	
		}	
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if ( dataset == dsMAIN)
	{
		if (colid=="SRVLIFE")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_FIX_DEPREC_RAT1", lrArgs,"T");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "SRVLIFE")		= lrRet.get("SRVLIFE");
			dataset.NameValue(row, "DEPREC_RAT")	= lrRet.get("DEPREC_RAT");	
		}
	}
}

function OnRowPosChanged(dataset, row)
{
	if (dataset == dsITEM_CODE)
	{
		D_defaultLoad();	
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
