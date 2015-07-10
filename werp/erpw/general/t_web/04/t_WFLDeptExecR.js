/**************************************************************************/
/* 1. �� �� �� �� id : t_WFLDeptExecR(���庰�ڱݼ�����������)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-17)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			bEnter = false;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "���庰�ڱݼ�������",null,null,true);
	
	G_addDataSet(dsCOPY,transCopy,null,null,"����");
	G_addDataSet(dsREMOVE,transRemove,null,null,"����");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsCLOSE, null, null, null, "CLOSE");
	
	
	cboWORK_YM.value = sWORK_YM;
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtDEPT_CODE.value = sDeptCode;
	txtDEPT_NAME.value = sDeptName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;

	processGridTitle();
	
	G_setReadOnlyCol(gridMAIN,"LEVELED_FLOW_ITEM_NAME");
	G_setReadOnlyCol(gridMAIN,"PRE_EXEC_AMT");
	G_setReadOnlyCol(gridMAIN,"SUM_EXEC_AMT");
	G_setReadOnlyCol(gridMAIN,"TOT_EXEC_AMT");
	G_setReadOnlyCol(gridMAIN,"PRE_PLAN_AMT");
	G_setReadOnlyCol(gridMAIN,"PLAN_AMT");
	G_setReadOnlyCol(gridMAIN,"TOT_PLAN_AMT");
	G_setReadOnlyCol(gridMAIN,"FORECAST_AMT");
	G_setReadOnlyCol(gridMAIN,"PRE_RATIO");
	G_setReadOnlyCol(gridMAIN,"CUR_RATIO");
	G_setReadOnlyCol(gridMAIN,"SUM_RATIO");

	
	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();

}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
											+ D_P2("WORK_YM",txtCLSE_ACC_ID.value+cboWORK_YM.value)
											+ D_P2("DEPT_CODE",txtDEPT_CODE.value);
	}
	else if(dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","COPY");
	}
	else if(dataset == dsREMOVE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","REMOVE");
	}
	else if (dataset == dsCLOSE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CLOSE")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
											+ D_P2("WORK_YM",txtCLSE_ACC_ID.value+cboWORK_YM.value)
											+ D_P2("DEPT_CODE",txtDEPT_CODE.value);
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
function	processGridTitle()
{
	/*
	G_setReadOnlyCol(gridMAIN,"LEVELED_FLOW_ITEM_NAME");
	G_setReadOnlyCol(gridMAIN,"SUBTITLE_NAME");
	G_setReadOnlyCol(gridMAIN,"EXEC_AMT");
	G_setReadOnlyCol(gridMAIN,"PLAN_AMT_01");
	G_setReadOnlyCol(gridMAIN,"PLAN_AMT_02");
	G_setReadOnlyCol(gridMAIN,"PLAN_AMT_03");
	G_setReadOnlyCol(gridMAIN,"EXEC_AMT_01");
	G_setReadOnlyCol(gridMAIN,"EXEC_AMT_02");
	G_setReadOnlyCol(gridMAIN,"EXEC_AMT_03");
	*/
}
function	checkConditions()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("���� ������ڵ带 �����ϼ���.", "Ȯ��");
		return false;
	}
	if(C_isNull(txtDEPT_CODE.value))
	{
		C_msgOk("���� �μ��ڵ带 �����ϼ���.", "Ȯ��");
		return false;
	}

	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("���� ȸ�⸦ �����ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}
function	isClose()
{
	if(dsCLOSE.NameString(dsCLOSE.RowPosition,"FORE_CONFIRM_TAG") == "T")
	{
		return true;
	}
	else
	{
		return false;
	}
}
function	checkClose()
{
	if(isClose())
	{
		C_msgOk("�̹� �����Ǿ����ϴ�.");
		return true;
	}
	else
	{
		return false;
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
}

// ����
function btninsert_onclick()
{
	btnadd_onclick();
}

// ����
function btndelete_onclick()
{
}

// ����
function btnsave_onclick()
{
	var			lbRet = D_defaultSave(dsMAIN);
	if(lbRet&&chkAutoRetrieve.checked)
	{
		liRow = dsMAIN.RowPosition;
		D_defaultLoad();
		if(dsMAIN.CountRow >= liRow)
		{
			dsMAIN.RowPosition = liRow;
		}
	}
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
		G_Load(dsCLOSE);
	}
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
	return false;
}

function OnRowDeleted(dataset, row)
{
}
function OnColumnPosChanged(dataset, grid, row, colid)
{
	if(colid == 'MOD_EXEC_AMT')
	{
		if(dataset.NameString(row,"IS_LEAF_TAG") == "T")
		{
			grid.ColumnProp(colid,'Edit') = 'Numeric';
		}
		else
		{
			grid.ColumnProp(colid,'Edit') = 'None';
		}
	}
}
function OnColumnChanged(dataset, row, colid)
{
	if(bEnter) return;
	bEnter = true;
	if(dataset == dsMAIN)
	{
		try
		{
		}
		catch(e)
		{
		}
	}
	bEnter = false;
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
function	OnSuccess(dataset,trans)
{
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
	txtDEPT_CODE.value = "";
	txtDEPT_NAME.value = "";
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	dsMAIN.ClearData();
}
function txtDEPT_CODE_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_NAME.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE_PROJ", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		dsMAIN.ClearData();
	}
	else
	{
		D_defaultLoad();
	}
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
	
	if(C_isNull(txtDEPT_CODE.value))
	{
		dsMAIN.ClearData();
	}
	else
	{
		D_defaultLoad();
	}
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
	txtDEPT_CODE.value = "";
	txtDEPT_NAME.value = "";
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	dsMAIN.ClearData();
}
function btnDEPT_CODE_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_DEPT_CODE_PROJ", lrArgs,"F");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	
	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		dsMAIN.ClearData();
	}
	else
	{
		D_defaultLoad();
	}
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
	
	if(C_isNull(txtDEPT_CODE.value))
	{
		dsMAIN.ClearData();
	}
	else
	{
		D_defaultLoad();
	}
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
function	btnGetConsInfo_onClick()
{
	if(!checkConditions()) return;
	if(checkClose()) return;
	G_Load(dsCOPY);
	dsCOPY.NameString(dsCOPY.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsCOPY.NameString(dsCOPY.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsCOPY.NameString(dsCOPY.RowPosition,"DEPT_CODE") = txtDEPT_CODE.value;
	dsCOPY.NameString(dsCOPY.RowPosition,"WORK_YM") = txtCLSE_ACC_ID.value+cboWORK_YM.value;
	transCopy.Parameters = "ACT=COPY";
	if(!G_saveData(dsCOPY))return;
	C_msgOk("�����Ͽ� �������Ⱑ ���������� ����Ǿ����ϴ�.");
	G_Load(dsMAIN);
}
function	btnRemoveAll_onClick()
{
	if(!checkConditions()) return;
	if(checkClose()) return;
	var	ret = C_msgYesNo("�� �۾��� �����Ͻø� ���� ���õ� ������ �ڱݼ��� ������ ������ �����˴ϴ�.<br> ���� �۾��� �����Ͻðڽ��ϱ�?","���");
	if(ret == "N") return;
	G_Load(dsREMOVE);
	dsREMOVE.NameString(dsREMOVE.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsREMOVE.NameString(dsREMOVE.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsREMOVE.NameString(dsREMOVE.RowPosition,"DEPT_CODE") = txtDEPT_CODE.value;
	dsREMOVE.NameString(dsREMOVE.RowPosition,"WORK_YM") = txtCLSE_ACC_ID.value+cboWORK_YM.value;
	transRemove.Parameters = "ACT=REMOVE";
	if(!G_saveData(dsREMOVE))return;
	C_msgOk("�ڱݼ������������� ���������� ����Ǿ����ϴ�.");
	G_Load(dsMAIN);
}
function	cboWORK_YM_onChange()
{
	processGridTitle();
	if(C_isNull(txtCLSE_ACC_ID.value) || C_isNull(txtDEPT_CODE.value))
	{
		dsMAIN.ClearData();
	}
	else
	{
		D_defaultLoad();
	}
}
function	btnShowDetail_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE"));
	lrArgs.set("CLSE_ACC_ID", dsMAIN.NameString(dsMAIN.RowPosition,"CLSE_ACC_ID"));
	lrArgs.set("DEPT_CODE", dsMAIN.NameString(dsMAIN.RowPosition,"DEPT_CODE"));
	lrArgs.set("FLOW_CODE", dsMAIN.NameString(dsMAIN.RowPosition,"FLOW_CODE"));
	lrArgs.set("WORK_YM", dsMAIN.NameString(dsMAIN.RowPosition,"WORK_YM"));

	var	lrRet = window.showModalDialog(
		"t_PFLDeptExecR.jsp",
		lrArgs,
		"center:yes; dialogWidth:976px;	dialogHeight:623px;	status:no; help:no;	scroll:no"
	);
}