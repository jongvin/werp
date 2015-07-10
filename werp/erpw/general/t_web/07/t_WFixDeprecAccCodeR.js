/**************************************************************************/
/* 1. �� �� �� �� id : t_WFixDeprecAccCodeR.js(�����ڻ�󰢺�������)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : �����ڻ�󰢺������� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-17)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�󰢺����");
	
	G_addDataSet(dsFIX_ASSET_CLS_CODE, null, null, sSelectPageName+D_P1("ACT","FIX_ASSET_CLS_CODE"), "�����ڻ������ڵ�");
	G_addDataSet(dsCOST_DEPT_KND_TAG, null, null, sSelectPageName+D_P1("ACT","COST_DEPT_KND_TAG"), "�������屸��");
	G_addDataSet(dsLOV, null, null, null, "LOV"); 

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	
	gridMAIN.focus();
	G_setReadOnlyCol(gridMAIN, "ASSET_CLS_NAME");
	G_setReadOnlyCol(gridMAIN, "ACC_NAME");
	G_Load(dsFIX_ASSET_CLS_CODE, null);
	G_Load(dsCOST_DEPT_KND_TAG, null);
	D_defaultLoad();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("ASSET_CLS_CODE", dsFIX_ASSET_CLS_CODE.NameValue(dsFIX_ASSET_CLS_CODE.RowPosition, "ASSET_CLS_CODE"))
									 + D_P2("COST_DEPT_KND_TAG", dsCOST_DEPT_KND_TAG.NameValue(dsCOST_DEPT_KND_TAG.RowPosition, "COST_DEPT_KND_TAG"));
	}
	else if(dataset == dsFIX_ASSET_CLS_CODE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","FIX_ASSET_CLS_CODE");
	}
	else if(dataset == dsCOST_DEPT_KND_TAG)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COST_DEPT_KND_TAG");
									
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
		dataset.NameValue(row, "COST_DEPT_KND_TAG") = dsCOST_DEPT_KND_TAG.NameValue(dsCOST_DEPT_KND_TAG.RowPosition, "COST_DEPT_KND_TAG");
		dataset.NameValue(row, "COST_DEPT_KND_NAME") = dsCOST_DEPT_KND_TAG.NameValue(dsCOST_DEPT_KND_TAG.RowPosition, "COST_DEPT_KND_NAME");
		 	
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
		oldData = dataset.NameValue(row, "ACC_CODE");	
	}
	
}
function OnExit(dataset, grid, row, colid, olddata)
{
	if (dataset == dsMAIN)
	{
		if ( colid == "ACC_CODE")
		{
			var	lsNewData = dataset.NameString(row,colid);
			if(lsNewData == olddata) return;

			if ( C_isNull(dataset.NameValue(row, "ACC_CODE")))
			{
				dataset.NameValue(row, "ACC_NAME") = "";
			}
			else
			{
				var lrArgs = new C_Dictionary();
				var lrRet = null;
			
				
				
				lrArgs.set("SEARCH_CONDITION", dataset.NameValue(row, "ACC_CODE"));
				lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
				
				if (lrRet == null) 
				{
					dataset.NameValue(row, "ACC_CODE") = oldData;
					
					return;
				}
				
				dataset.NameValue(row, "ACC_CODE")	= lrRet.get("ACC_CODE");
				dataset.NameValue(row, "ACC_NAME")	= lrRet.get("ACC_NAME");
			}	
		}		
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		//�����ڻ�󰢺����
		if ( colid == "ACC_CODE")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row, "ACC_NAME")	= lrRet.get("ACC_NAME");
	 
		}
	}
}

function OnRowPosChanged(dataset, row)
{
	if (dataset == dsFIX_ASSET_CLS_CODE)
	{
		D_defaultLoad();	
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
