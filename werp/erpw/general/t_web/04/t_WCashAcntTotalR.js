/**************************************************************************/
/* 1. �� �� �� �� id : t_WAcntTotalR(���º�������ȸ)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-22)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�μ����");
	G_addDataSet(dsCASH, trans, gridCASH, sSelectPageName+D_P1("ACT","MAIN"), "�μ����");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	
	
	
	G_setReadOnlyCol(gridCASH,"CASH_NAME");
	

	gridMAIN.focus();
}

function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("MAKE_DT_F",txtDT_T.value)
											+ D_P2("MAKE_DT_T",txtDT_T.value)
											+ D_P2("COMP_CODE",txtCOMP_CODE.value);
	}
	else if (dataset == dsCASH)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CASH")
											+ D_P2("WORK_DT",txtDT_T.value)
											+ D_P2("COMP_CODE",txtCOMP_CODE.value);
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
	if(!CheckCompCode()) return;
	G_Load(dsMAIN);
	G_Load(dsCASH);
}

// �߰�
function btnadd_onclick()
{
	//D_defaultAdd();
	//dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	//dsMAIN.NameString(dsMAIN.RowPosition,"COMP_NAME") = txtCOMPANY_NAME.value;

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
	D_defaultSave(dsCASH);
}

// ���
function btncancel_onclick()
{
	//if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
	if(dataset == dsMAIN)
	{
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
	return true;
}

function OnRowDeleted(dataset, row)
{
}

function OnColumnPosChanged(dataset, grid, row, colid)
{
	if(grid == gridCASH)
	{
		if(colid == 'QTY')
		{
			if(dataset.NameString(row,"UNIT_COST") == "0")
			{
				grid.ColumnProp(colid,'Edit') = 'None';
			}
			else
			{
				grid.ColumnProp(colid,'Edit') = 'Numeric';
			}
		}
		else if(colid == 'AMT')
		{
			if(dataset.NameString(row,"UNIT_COST") == "0")
			{
				grid.ColumnProp(colid,'Edit') = 'Numeric';
			}
			else
			{
				grid.ColumnProp(colid,'Edit') = 'None';
			}
		}
	}
}
function	OnColumnChanged(dataset, row, colid)
{
	if(dataset == dsCASH)
	{
		if(colid == "QTY")
		{
			dataset.NameString(row,"AMT") = C_convSafeFloat(dataset.NameString(row,"QTY")) * C_convSafeFloat(dataset.NameString(row,"UNIT_COST"));
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}

function OnDuplicateColumn(dataset,grid,row,colid) 
{
}

function OnDblClick(dataset, grid, row, colid)
{
	if(dataset == dsMAIN)
	{
		showDetail(dataset, grid, row, colid);
	}
}

function	showDetail(dataset,grid,row,colid)
{
	if(row < 1) return;
	if (C_isNull(dataset.NameString(row,"MAKE_COMP_CODE"))) return;
	
	var			lfAmt1 = C_convSafeFloat(dataset.NameString(row,"SET_AMT"));
	var			lfAmt2 = C_convSafeFloat(dataset.NameString(row,"RESET_AMT"));
	if(lfAmt1 == 0 && lfAmt2 == 0)
	{
		C_msgOk("���� �Ǵ� ���� �ݾ��� �ִ� ���� �����Ͻʽÿ�.");
		return;
	}

	var myObject = new Object;
	myObject.window = window;

	var 	strMAKE_COMPANY		= dsMAIN.NameString(row,"MAKE_COMP_CODE");
	var 	strCOMPANY_NAME		= dsMAIN.NameString(row,"COMPANY_NAME");
	var 	strKEEP_DT_FROM		= txtDT_T.value;
	var 	strKEEP_DT_TO		= txtDT_T.value;
	var 	strACCNO			= dsMAIN.NameString(row,"MNG_ITEM");
	var 	strBANK_CODE			= dsMAIN.NameString(row,"BANK_CODE");
	var 	strBANK_NAME			= dsMAIN.NameString(row,"BANK_NAME");
	var 	strACC_CODE			= dsMAIN.NameString(row,"ACC_CODE");
	var 	strACC_NAME			= dsMAIN.NameString(row,"ACC_NAME");
	var 	strPROJ_CODE		= dsMAIN.NameString(row,"POSS_DEPT_PROJ");
	var 	strPROJ_NAME		= dsMAIN.NameString(row,"PROJ_NAME");

	var arrRtn = window.showModalDialog
	(
		"t_WAcntDetailR.jsp?MAKE_COMPANY="+strMAKE_COMPANY+
										"&MAKE_COMPANY_NAME="+strCOMPANY_NAME+
										"&KEEP_DT_FROM="+strKEEP_DT_FROM+
										"&KEEP_DT_TO="+strKEEP_DT_TO+
										"&ACC_CODE="+strACC_CODE+
										"&ACC_NAME="+strACC_NAME+
										"&ACCNO="+strACCNO+
										"&PROJ_CODE="+strPROJ_CODE+
										"&PROJ_NAME="+strPROJ_NAME+
										"&BANK_NAME="+strBANK_NAME+
										"&BANK_CODE="+strBANK_CODE,
		myObject,
		"center:yes; dialogWidth:1024px; dialogHeight:768px; status:no; help:no; scroll:no"
	);
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


function btnDT_T_onClick()
{
	C_Calendar("DT_T", "D", txtDT_T.value);
	S_nextFocus(btnDT_T);
}

function btnKEEP_DT_onClick()
{
	C_Calendar("KEEP_DT", "D", txtKEEP_DT.value);
	S_nextFocus(btnKEEP_DT);
}

function	btnShowDetail_onClick()
{
	if(dsMAIN.CountRow < 1)
	{
		C_msgOk("���� ���賻���� ��ȸ�Ͻʽÿ�.");
		return;
	}
	showDetail(dsMAIN,gridMAIN,dsMAIN.RowPosition,"");
}
