/**************************************************************************/
/* 1. �� �� �� �� id : t_WFLComPlanR(�ڱݼ������庰����)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-12)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "��ȸ���������",null,null,true);
	G_addDataSet(dsSUB01, trans, gridSUB01, null, "����׹�Ȯ��������",null,null,true);
	G_addDataSet(dsMASTER, trans, null, null, "���縶������",null,null,true);
	
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();
	
	G_setReadOnlyCol(gridSUB01,"DEPT_CODE");
	G_setReadOnlyCol(gridSUB01,"DEPT_NAME");
	//G_setReadOnlyCol(gridMAIN,"DEPT_CODE");
	//G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	
	G_Load(dsMAIN);
	//G_Load(dsSUB01);
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value);
	}
	else if(dataset == dsMASTER)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MASTER")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
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
function	CopyOneRow(arSrcDataset,arSrcRow,arDstDataset,arDstRow)
{
	for(var j = 1 ; j <= arSrcDataset.CountColumn ; ++ j)
	{
		arDstDataset.NameString(arDstRow,arSrcDataset.ColumnID(j)) = arSrcDataset.ColumnString(arSrcRow,j);
	}
	return true;
}
function	MoveSelectedRows(arSrcDataset,arDstDataset)
{
	var		lrArrayRows = new Array();
	if(arSrcDataset == dsMAIN)
	{
		for(var i = 1 ; i <= arSrcDataset.CountRow ; ++ i)
		{
			if(arSrcDataset.RowMark(i) == 1)
			{
				if(dsMAIN.NameString(i,"PLAN_CONFIRM_TAG") == "T"||dsMAIN.NameString(i,"IS_DATA_EXISTS") == "T")
				{
					C_msgOk("������ �ڷᳪ �۾��� �ڷᰡ �ִ� ������ �����Ͻ� �� �����ϴ�.");
					dsMAIN.RowPosition = i;
					return;
				}
				lrArrayRows.push(i);
			}
		}
	}
	else
	{
		for(var i = 1 ; i <= arSrcDataset.CountRow ; ++ i)
		{
			if(arSrcDataset.RowMark(i) == 1)
			{
				lrArrayRows.push(i);
			}
		}
	}
	for(var i = 0 ; i < lrArrayRows.length  ; ++i)
	{
		G_addRow(arDstDataset);
		if(!CopyOneRow(arSrcDataset,lrArrayRows[i],arDstDataset,arDstDataset.RowPosition)) return;
	}
	for(var i = lrArrayRows.length - 1 ; i >= 0 ; --i)
	{
		G_deleteRow(arSrcDataset,lrArrayRows[i],false);
	}
}
function	checkConditions()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("���� ������ڵ带 �����ϼ���.", "Ȯ��");
		return false;
	}

	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("���� ȸ�⸦ �����ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}
function	checckClose()
{
	if(isClose())
	{
		C_msgOk("�̹� ���� �����Ǿ� �ֽ��ϴ�.");
		return true;
	}
	return false;
}
function	isClose()
{
	if(dsMASTER.CountRow < 1) return false;
	if(dsMASTER.NameString(dsMASTER.RowPosition,"PLAN_CONFIRM_TAG") == "T")
	{
		return true;
	}
	return false;
}
function	processClose()
{
	if(isClose())
	{
		G_setReadOnlyCol(gridMAIN,"PLAN_CONFIRM_TAG");
	}
	else
	{
		G_setReadWriteCol(gridMAIN,"PLAN_CONFIRM_TAG");
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
	//D_defaultAdd();
}

// ����
function btninsert_onclick()
{
	//D_defaultInsert();
}

// ����
function btndelete_onclick()
{
	//D_defaultDelete();
}

// ����
function btnsave_onclick()
{
	if(!checkConditions()) return;
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
	if(dataset == dsMAIN)
	{
		G_Load(dsSUB01);
		G_Load(dsMASTER);
		processClose();
	}
}
function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN)
	{
		dataset.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
		dataset.NameString(row,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	}
	else if(dataset == dsMASTER)
	{
		dataset.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
		dataset.NameString(row,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	}
}

function OnRowDeleteBefore(dataset)
{
	return true;
}

function OnRowDeleted(dataset, row)
{
}
function OnColumnPosChanged(dataset, grid, row, colid)
{
}
function OnColumnChanged(dataset, row, colid)
{
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

// �̺�Ʈ����-------------------------------------------------------------------//

function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	dsMAIN.ClearData();
}
function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("CLSE_ACC_ID", txtCLSE_ACC_ID.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_BUDG_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
	D_defaultLoad();
}
function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	dsMAIN.ClearData();
}
function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("CLSE_ACC_ID", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
	D_defaultLoad();
}
function	CheckCompCode()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("���� ������ڵ带 �����ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}
function	btnGrantCompCode_onClick()
{
	if(checckClose()) return;
	try
	{
		MoveSelectedRows(dsSUB01,dsMAIN);
	}
	catch(e)
	{
	}
}
function	btnRevokeCompCode_onClick()
{
	if(checckClose()) return;
	try
	{
		MoveSelectedRows(dsMAIN,dsSUB01);
	}
	catch(e)
	{
	}
}
function	btnSelectAll_onClick()
{
	if(checckClose()) return;
	var			liCnt = dsMAIN.CountRow;
	for(var i = 1 ; i <= liCnt ; ++i)
	{
		dsMAIN.NameString(i,"PLAN_CONFIRM_TAG") = "T";
	}
}
function	btnDeSelectAll_onClick()
{
	if(checckClose()) return;
	var			liCnt = dsMAIN.CountRow;
	for(var i = 1 ; i <= liCnt ; ++i)
	{
		dsMAIN.NameString(i,"PLAN_CONFIRM_TAG") = "F";
	}
}
function	btnCloseB_onClick()
{
	if(!checkConditions()) return;
	if(checckClose()) return;
	if(dsMASTER.CountRow < 1)
	{
		G_addRow(dsMASTER);
	}
	dsMASTER.NameString(dsMASTER.RowPosition,"PLAN_CONFIRM_TAG") = "T";
	dsMASTER.NameString(dsMASTER.RowPosition,"PLAN_CONFIRM_TAG_NM") = "������";
	processClose();
}
function	btnOpenB_onClick()
{
	if(!checkConditions()) return;
	if(dsMASTER.CountRow < 1)
	{
		G_addRow(dsMASTER);
	}
	dsMASTER.NameString(dsMASTER.RowPosition,"PLAN_CONFIRM_TAG") = "F";
	dsMASTER.NameString(dsMASTER.RowPosition,"PLAN_CONFIRM_TAG_NM") = "�����ȵ�";
	processClose();
}
