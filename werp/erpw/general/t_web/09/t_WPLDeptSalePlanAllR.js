/**************************************************************************/
/* 1. �� �� �� �� id : t_WPLDeptPlanR(���庰�濵��ȹ��ȹ����)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-27)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			bEnter = false;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "���庰�濵��ȹ��ȹ",null,null,true);
	
	G_addDataSet(dsCOPY,transCopy,null,null,"����");
	G_addDataSet(dsREMOVE,transRemove,null,null,"����");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsCLOSE, null, null, null, "CLOSE");
	
	

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();
	
	G_setReadOnlyCol(gridMAIN,"DEPT_CODE");
	G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"LEVELED_NAME");
	G_setReadOnlyCol(gridMAIN,"SUBTITLE_NAME");
	G_setReadOnlyCol(gridMAIN,"SUBTITLE_NAME2");
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
											+ D_P2("DEPT_NAME",txtDEPT_NAME.value);
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
function	GetColumnName(iCol)
{
	return "AMT_"+C_LPad(iCol.toString(),2,"0");
}
function	SumToColumn(row,colid)
{
	var			lfSum = 0;
	var			liCol = C_convSafeInt(colid.substring(4,6));
	for(var i = 0 ; i <= liCol ; ++i)
	{
		var			lsColName = GetColumnName(i);
		lfSum += C_convSafeFloat(dsMAIN.NameString(row,lsColName));
	}
	return lfSum;
}
function	SumToPrevColumn(row,colid)
{
	var			lfSum = 0;
	var			liCol = C_convSafeInt(colid.substring(4,6));
	
	for(var i = 0 ; i < liCol ; ++i)
	{
		var			lsColName = GetColumnName(i);
		lfSum += C_convSafeFloat(dsMAIN.NameString(row,lsColName));
	}
	return lfSum;
}
function	CalcSumOneCol(row,colid)
{
	var			liLv = C_convSafeInt(dsMAIN.NameString(row,"LV"));
	var			liRowCons = row - liLv + 1;
	var			liRowBudg = row - liLv + 2;
	var			liRowCost = row - liLv + 3;
	var			liRowSale = row - liLv + 4;
	var			lfBudgAmt = SumToColumn(liRowBudg,colid);
	if(lfBudgAmt == 0)
	{
		dsMAIN.NameString(liRowSale,colid) = 0;
		return;
	}
	var			lfConsAmt = SumToColumn(liRowCons,colid);
	var			lfCostSum = SumToColumn(liRowCost,colid);
	var			lfPrevSaleSum = SumToPrevColumn(liRowSale,colid);
	var			lfNowSale = C_Round((lfCostSum * lfConsAmt / lfBudgAmt) - lfPrevSaleSum,0);
	dsMAIN.NameString(liRowSale,colid) = lfNowSale;
}

function	CalcSum(row,colid)
{
	if(colid == "AMT_00") return;	//���ʱݾ��� �����ô� ��� ����
	var			liLv = C_convSafeInt(dsMAIN.NameString(row,"LV"));
	if(liLv == 1 || liLv == 2)
	{
		var			liCol = C_convSafeInt(colid.substring(4,6));
		for(var	i = liCol ; i <= 12 ; ++i)
		{
			var			lsColName = GetColumnName(i);
			CalcSumOneCol(row,lsColName);
		}
	}
	else
	{
		CalcSumOneCol(row,colid);			//������ �ٲ�� ���� ���� �ݾ��� ���� ���� �ʴ´�.
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
function	isClose()
{
	return false;
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
		if(checkClose())
		{
			gridMAIN.Editable = false;
		}
		else
		{
			gridMAIN.Editable = true;
		}
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
	if(dataset == dsMAIN)
	{
		var		lsLv = dataset.NameString(row,"LV");
		if(lsLv == "4")
		{
			grid.ColumnProp(colid,'Edit') = 'None';
		}
		else
		{
			grid.ColumnProp(colid,'Edit') = 'Numeric';
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
			CalcSum(row,colid);
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
	txtDEPT_NAME.value = "";
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
	txtDEPT_NAME.value = "";
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
	var			lsDeptCode = "";
	for(var i = 1 ; i <= dsMAIN.CountRow ; ++i)
	{
		if(dsMAIN.NameString(i,"DEPT_CODE") == lsDeptCode)
		{
		}
		else
		{
			lsDeptCode = dsMAIN.NameString(i,"DEPT_CODE");
			G_addRow(dsCOPY);
			dsCOPY.NameString(dsCOPY.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
			dsCOPY.NameString(dsCOPY.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
			dsCOPY.NameString(dsCOPY.RowPosition,"DEPT_CODE") = lsDeptCode;
		}
	}
	transCopy.Parameters = "ACT=COPY";
	if(!G_saveData(dsCOPY))return;
	C_msgOk("�⺻���谡 ���������� ����Ǿ����ϴ�.");
	G_Load(dsMAIN);
}
function	btnGetConsInfo1_onClick()
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
	lsDeptCode = dsMAIN.NameString(dsMAIN.RowPosition,"DEPT_CODE");
	G_addRow(dsCOPY);
	dsCOPY.NameString(dsCOPY.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsCOPY.NameString(dsCOPY.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsCOPY.NameString(dsCOPY.RowPosition,"DEPT_CODE") = lsDeptCode;
	transCopy.Parameters = "ACT=COPY";
	if(!G_saveData(dsCOPY))return;
	C_msgOk("�⺻���谡 ���������� ����Ǿ����ϴ�.");
	var		liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	dsMAIN.RowPosition = liRow;
}
function	btnRemoveAll()
{
	if(!checkConditions()) return;
	if(checkClose()) return;
	var	ret = C_msgYesNo("�� �۾��� �����Ͻø� ���� ���õ� ������ �濵��ȹ ��ȹ�� ������ �����˴ϴ�.<br> ���� �۾��� �����Ͻðڽ��ϱ�?","���");
	if(ret == "N") return;
	G_Load(dsREMOVE);
	var			lsDeptCode = "";
	for(var i = 1 ; i <= dsMAIN.CountRow ; ++i)
	{
		if(dsMAIN.NameString(i,"DEPT_CODE") == lsDeptCode)
		{
		}
		else
		{
			lsDeptCode = dsMAIN.NameString(i,"DEPT_CODE");
			G_addRow(dsREMOVE);
			dsREMOVE.NameString(dsREMOVE.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
			dsREMOVE.NameString(dsREMOVE.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
			dsREMOVE.NameString(dsREMOVE.RowPosition,"DEPT_CODE") = lsDeptCode;
		}
	}
	transRemove.Parameters = "ACT=REMOVE";
	if(!G_saveData(dsREMOVE))return;
	C_msgOk("�濵��ȹ��ȹ������ ���������� ����Ǿ����ϴ�.");
	G_Load(dsMAIN);
}