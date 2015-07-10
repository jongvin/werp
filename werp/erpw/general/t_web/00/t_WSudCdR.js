/**************************************************************************/
/* 1. �� �� �� �� id : t_WSudCdR.jsp(����������)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ����������
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-03) 
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�ι��ڵ���");

	G_setLovCol(gridMAIN,"ACC_CODE");
	G_setLovCol(gridMAIN,"ACC_NAME_1");
	G_setLovCol(gridMAIN,"ACC_CODE2");
	G_setLovCol(gridMAIN,"ACC_NAME_2");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	G_setReadOnlyCol(gridMAIN,"SUDANGCD");
	G_setReadOnlyCol(gridMAIN,"HNAME");
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

function OnRowInserted(dataset, row)
{
	dsMAIN.NameValue(dsMAIN.RowPosition, "USE_CLS") = "T";
}

function OnColumnChanged(dataset, row, colid)
{
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "ACC_CODE" || colid == "ACC_NAME_1" )
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode = "ACC_CODE";
			var			lsTargetName = "ACC_NAME_1";
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,lsTargetCode) = "";
				dataset.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE_MAIN", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
		else if(colid == "ACC_CODE2" || colid == "ACC_NAME_2" )
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode = "ACC_CODE2";
			var			lsTargetName = "ACC_NAME_2";
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,lsTargetCode) = "";
				dataset.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE_MAIN", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
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
		if(colid == "ACC_CODE" || colid == "ACC_NAME_1" )
		{
			var			lsTargetCode = "ACC_CODE";
			var			lsTargetName = "ACC_NAME_1";
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE_MAIN", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
		}
		else if(colid == "ACC_CODE2" || colid == "ACC_NAME_2" )
		{
			var			lsTargetCode = "ACC_CODE2";
			var			lsTargetName = "ACC_NAME_2";
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE_MAIN", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
		}
		
	}
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
	if(dataset == dsMAIN)
	{
		if(colid == "ACC_CODE")
		{
			dataset.NameString(row,"ACC_NAME_1") = dataset.NameString(row - 1,"ACC_NAME_1");
		}
		else if(colid == "ACC_NAME_1")
		{
			dataset.NameString(row,"ACC_CODE") = dataset.NameString(row - 1,"ACC_CODE");
		}
		else if(colid == "ACC_CODE2")
		{
			dataset.NameString(row,"ACC_NAME_2") = dataset.NameString(row - 1,"ACC_NAME_2");
		}
		else if(colid == "ACC_NAME_2")
		{
			dataset.NameString(row,"ACC_CODE2") = dataset.NameString(row - 1,"ACC_CODE2");
		}
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
