/**************************************************************************/
/* 1. �� �� �� �� id : t_WCostDeptKindR.js(���屸�е��)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-21)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "���屸�и��");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");

	
	

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.

	gridMAIN.TabToss = false;
	gridMAIN.focus();
	//G_Load(dsMAIN, null);
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
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
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "SEC_ACC_CODE" || colid == "SEC_ACC_CODE_NAME" 
			|| colid == "ITRP_ACC_CODE" || colid == "ITRP_ACC_CODE_NAME"
			|| colid == "ITRB_ACC_CODE" || colid == "ITRB_ACC_CODE_NAME")
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode = colid == "SEC_ACC_CODE" || colid == "SEC_ACC_CODE_NAME" ? "SEC_ACC_CODE":
												(colid == "ITRP_ACC_CODE" || colid == "ITRP_ACC_CODE_NAME" ? "ITRP_ACC_CODE":"ITRB_ACC_CODE");
			var			lsTargetName = colid == "SEC_ACC_CODE" || colid == "SEC_ACC_CODE_NAME" ? "SEC_ACC_CODE_NAME":
												(colid == "ITRP_ACC_CODE" || colid == "ITRP_ACC_CODE_NAME" ? "ITRP_ACC_CODE_NAME":"ITRB_ACC_CODE_NAME");
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,lsTargetCode) = "";
				dsMAIN.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsMAIN.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dsMAIN.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "SEC_ACC_CODE" || colid == "SEC_ACC_CODE_NAME" 
			|| colid == "ITRP_ACC_CODE" || colid == "ITRP_ACC_CODE_NAME"
			|| colid == "ITRB_ACC_CODE" || colid == "ITRB_ACC_CODE_NAME")
		{
			var			lsTargetCode = colid == "SEC_ACC_CODE" || colid == "SEC_ACC_CODE_NAME" ? "SEC_ACC_CODE":
												(colid == "ITRP_ACC_CODE" || colid == "ITRP_ACC_CODE_NAME" ? "ITRP_ACC_CODE":"ITRB_ACC_CODE");
			var			lsTargetName = colid == "SEC_ACC_CODE" || colid == "SEC_ACC_CODE_NAME" ? "SEC_ACC_CODE_NAME":
												(colid == "ITRP_ACC_CODE" || colid == "ITRP_ACC_CODE_NAME" ? "ITRP_ACC_CODE_NAME":"ITRB_ACC_CODE_NAME");
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsMAIN.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dsMAIN.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
		}
	}
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
	if(colid == "SEC_ACC_CODE")
	{
		dataset.NameString(row,"SEC_ACC_CODE_NAME") = dataset.NameString(row - 1,"SEC_ACC_CODE_NAME");
	}
	else if(colid == "SEC_ACC_CODE_NAME")
	{
		dataset.NameString(row,"SEC_ACC_CODE") = dataset.NameString(row - 1,"SEC_ACC_CODE");
	}
	else if(colid == "ITRP_ACC_CODE")
	{
		dataset.NameString(row,"ITRP_ACC_CODE_NAME") = dataset.NameString(row - 1,"ITRP_ACC_CODE_NAME");
	}
	else if(colid == "ITRP_ACC_CODE_NAME")
	{
		dataset.NameString(row,"ITRP_ACC_CODE") = dataset.NameString(row - 1,"ITRP_ACC_CODE");
	}
	else if(colid == "ITRB_ACC_CODE")
	{
		dataset.NameString(row,"ITRB_ACC_CODE_NAME") = dataset.NameString(row - 1,"ITRB_ACC_CODE_NAME");
	}
	else if(colid == "ITRB_ACC_CODE_NAME")
	{
		dataset.NameString(row,"ITRB_ACC_CODE") = dataset.NameString(row - 1,"ITRB_ACC_CODE");
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
