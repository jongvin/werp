/**************************************************************************/
/* 1. �� �� �� �� id : t_WNpDeptProjR(�����ڵ�)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-12)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			sProjCode = "";
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�μ����");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsINFO, null, null, sSelectPageName+D_P1("ACT","LOV"), "����");
	

	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	
	G_setReadOnlyCol(gridMAIN,"DEPT_CODE");
	G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"DEPT_SHORT_NAME");
	G_setReadOnlyCol(gridMAIN,"ACC_CLOSE_DT");

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLOSE_TAG",cboTAG.value)
											+ D_P2("DEPT_PROJ_TAG",cboDEPT_PROJ_TAG.value)
											+ D_P2("DEPT_NAME",txtSEARCH_CONDITION.value);
	}
	if (dataset == dsINFO)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","INFO")
											+ D_P2("DEPT_CODE",sProjCode)
											+ D_P2("BASE_DT",sDate);
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
function	ApplyInfo(row)
{
	sProjCode = dsMAIN.NameString(row,"DEPT_CODE");
	G_Load(dsINFO);
	dsMAIN.NameString(row,"BUDG_APPL_DT") = sDate;
	dsMAIN.NameString(row,"CONS_AMT") = dsINFO.NameString(dsINFO.RowPosition,"CONS_AMT");
	dsMAIN.NameString(row,"BUDG_AMT") = dsINFO.NameString(dsINFO.RowPosition,"BUDG_AMT");
}
function	ApplyInfo2(row)
{
	sProjCode = dsMAIN.NameString(row,"DEPT_CODE");
	G_Load(dsINFO);
	dsMAIN.NameString(row,"COST_GUESS_AMT") = dsINFO.NameString(dsINFO.RowPosition,"COST_GUESS_AMT");
}
function	ApplyInfo3(row)
{
	sProjCode = dsMAIN.NameString(row,"DEPT_CODE");
	G_Load(dsINFO);
	dsMAIN.NameString(row,"F_CONS_AMT") = dsINFO.NameString(dsINFO.RowPosition,"F_CONS_AMT");
	dsMAIN.NameString(row,"F_BUDG_AMT") = dsINFO.NameString(dsINFO.RowPosition,"F_BUDG_AMT");
}

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	if(!CheckCompCode()) return;
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	D_defaultAdd();
	dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsMAIN.NameString(dsMAIN.RowPosition,"COMP_NAME") = txtCOMPANY_NAME.value;

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
	if (asCalendarID == "ACC_CLOSE_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"ACC_CLOSE_DT") = asDate;
	}
	else if (asCalendarID == "BUDG_APPL_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_APPL_DT") = asDate;
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
		if(colid == "ACC_CLOSE_DT" || colid == "BUDG_APPL_DT")
		{
			var		COL_DATA;
			COL_DATA = dataset.NameString(row,colid);
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "ACC_CLOSE_DT")
		{
			C_Calendar("ACC_CLOSE_DT", "D", dsMAIN.NameString(dsMAIN.RowPosition,"ACC_CLOSE_DT"));
		}
		else if(colid == "BUDG_APPL_DT")
		{
			C_Calendar("BUDG_APPL_DT", "D", dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_APPL_DT"));
		}
	}
}

function OnDuplicateColumn(dataset,grid,row,colid) {
}

// �̺�Ʈ����-------------------------------------------------------------------//
function	document_onKeyDown()
{
	if(event.altLeft && event.keyCode == 112)
	{
		//SetDefaultCheckDept();
	}
}
function	txtCOMP_CODE_onChange()
{
	gridMAIN.focus();
	btnquery_onclick();
}

function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}
	
	if (txtCOMP_CODE.value == '%')
	{
		txtCOMPANY_NAME.value = "��ü";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
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




function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}
	
	if (txtCOMP_CODE.value == '%')
	{
		txtCOMPANY_NAME.value = "��ü";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}
