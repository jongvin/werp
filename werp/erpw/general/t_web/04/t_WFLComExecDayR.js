/**************************************************************************/
/* 1. �� �� �� �� id : t_WFLComPlanR(�����ڱݼ����Ϻ���������)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-03)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			bEnter = false;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "�����ڱݼ�������",null,null,true);
	
	G_addDataSet(dsCOPY,transCopy,null,null,"����");
	G_addDataSet(dsREMOVE,transRemove,null,null,"����");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsCLOSE, null, null, null, "CLOSE");
	
	

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;

	processGridTitle();
	txtF_PUBL_DT.value = sDTT;

	G_setReadOnlyCol(gridMAIN,"LEVELED_FLOW_ITEM_NAME");
	G_setReadOnlyCol(gridMAIN,"PRE_MON_EXEC_AMT");
	G_setReadOnlyCol(gridMAIN,"PRE_EXEC_AMT");
	G_setReadOnlyCol(gridMAIN,"C_TOT_PRE_EXEC_AMT");
	G_setReadOnlyCol(gridMAIN,"SUM_EXEC_AMT");
	G_setReadOnlyCol(gridMAIN,"C_TOT_DAY_EXEC_AMT");
	G_setReadOnlyCol(gridMAIN,"C_TOT_EXEC_AMT");


	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();
	
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("WORK_DT",txtF_PUBL_DT.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value);
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
function	processGridTitle()
{
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
	if (asCalendarID == "F_PUBL_DT")
	{
		txtF_PUBL_DT.value = asDate;
	}
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
function	btnGetConsInfo_onClick()
{
	if(!checkConditions()) return;
	if(checkClose()) return;
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var ret = C_msgYesNo("�� �۾��� ���ؼ��� ���� ������ �ϼž� �մϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return ;
		}
		else if(ret == "N")
		{
			return ;
		}
	}
	G_Load(dsCOPY);
	dsCOPY.NameString(dsCOPY.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsCOPY.NameString(dsCOPY.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsCOPY.NameString(dsCOPY.RowPosition,"WORK_DT") = txtF_PUBL_DT.value;
	transCopy.Parameters = "ACT=COPY";
	if(!G_saveData(dsCOPY))return;
	C_msgOk("�����Ͽ� �������Ⱑ ���������� ����Ǿ����ϴ�.");
	G_Load(dsMAIN);
}
function	btnRemoveAll()
{
	if(!checkConditions()) return;
	if(checkClose()) return;
	var	ret = C_msgYesNo("�� �۾��� �����Ͻø� ���� ���õ� ������� �ڱݼ��� ������ ������ �����˴ϴ�.<br> ���� �۾��� �����Ͻðڽ��ϱ�?","���");
	if(ret == "N") return;
	G_Load(dsREMOVE);
	dsREMOVE.NameString(dsREMOVE.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsREMOVE.NameString(dsREMOVE.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsREMOVE.NameString(dsREMOVE.RowPosition,"WORK_DT") = txtF_PUBL_DT.value;
	transRemove.Parameters = "ACT=REMOVE";
	if(!G_saveData(dsREMOVE))return;
	C_msgOk("�ڱݼ������������� ���������� ����Ǿ����ϴ�.");
	G_Load(dsMAIN);
}
function	btnF_PUBL_DT_onClick()
{
	C_Calendar("F_PUBL_DT", "D", txtF_PUBL_DT.value);
}
function	btnShowDetail_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE"));
	lrArgs.set("CLSE_ACC_ID", dsMAIN.NameString(dsMAIN.RowPosition,"CLSE_ACC_ID"));
	lrArgs.set("FLOW_CODE", dsMAIN.NameString(dsMAIN.RowPosition,"FLOW_CODE"));
	lrArgs.set("WORK_DT", dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT"));

	var	lrRet = window.showModalDialog(
		"t_PFLDayExecR.jsp",
		lrArgs,
		"center:yes; dialogWidth:976px;	dialogHeight:623px;	status:no; help:no;	scroll:no"
	);
}
