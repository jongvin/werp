/**************************************************************************/
/* 1. �� �� �� �� id : t_WSettConsInsurR(���纸�����)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-22)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			bEnter = false;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "���纸�����",null,null,true);
	G_addDataSet(dsSUB01, null, gridSUB01, null, "���纸����������",null,null,true);
	
	G_addDataSet(dsREMOVE_SLIP, transREMOVE_SLIP, null, null, "��ǥ����",null,null,true);
	
	
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsINSUR_NO, null, null, null, "���纸���ȣ");
	G_addDataSet(dsDEC_AMT, null, null, null, "�������ݾ׻���");
	
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"DEPT_CODE","DEPT_CODE");
	G_addRelCol(dsSUB01,"INSUR_NO","INSUR_NO");
	
	

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtDEPT_CODE.value = sDeptCode;
	txtDEPT_NAME.value = sDeptName;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();
	
	G_setReadOnlyCol(gridMAIN,"REMAIN_AMT");
	G_setReadOnlyCol(gridMAIN,"MAKE_SLIPNO");
	G_setReadOnlyCol(gridMAIN,"SUM_AMT");
	
	G_setLovCol(gridMAIN,"CUST_CODE");
	G_setLovCol(gridMAIN,"CUST_NAME");
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("DEPT_CODE",txtDEPT_CODE.value);
	}
	else if (dataset == dsSUB01)	
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("DEPT_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"DEPT_CODE"))
											+ D_P2("INSUR_NO",dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_NO"));
	}
	else if(dataset == dsINSUR_NO)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","INSUR_NO");
	}
	else if(dataset == dsREMOVE_SLIP)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","REMOVE_SLIP");
	}
	else if(dataset == dsDEC_AMT)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","DEC_AMT")
											+ D_P2("AMT",dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_AMT"))
											+ D_P2("START_DT",dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_DT_F"))
											+ D_P2("END_DT",dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_DT_T"));
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

	return true;
}
function	chkSave()
{
	if (G_isChangedDataset(dsMAIN))
	{
		var ret = C_msgYesNo("��������� ������ �� �۾��� �����մϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return false;
			return true;
		}
		else
		{
			return false;
		}
	}
	return true;
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
	if (asCalendarID == dsMAIN.id+"."+"INSUR_DT_F")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_DT_F") = asDate;
	}
	else if (asCalendarID == dsMAIN.id+"."+"INSUR_DT_T")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_DT_T") = asDate;
	}
	else if (asCalendarID == dsMAIN.id+"."+"SLIP_MAKE_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_MAKE_DT") = asDate;
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
	if(dataset == dsMAIN)
	{
		G_Load(dsINSUR_NO);
		dataset.NameString(row,"INSUR_NO") = dsINSUR_NO.NameString(dsINSUR_NO.RowPosition,"INSUR_NO");
		dataset.NameString(row,"DEPT_CODE") = txtDEPT_CODE.value;
	}
	
}

function OnRowDeleteBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		if(!C_isNull(dataset.NameString(dataset.RowPosition,"SLIP_ID")))
		{
			C_msgOk("��ǥ�� ����� ���� ������ �Ұ����մϴ�.");
			return false;
		}
	}
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
	if (dataset == dsMAIN)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "INSUR_DT_F"||colid == "INSUR_DT_T"||colid == "SLIP_MAKE_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
		else if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			if(C_isNull(COL_DATA))
			{
				dataset.NameString(row,"CUST_SEQ") = "";
				dataset.NameString(row,"CUST_CODE") = "";
				dataset.NameString(row,"CUST_NAME") = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", COL_DATA);
		
			lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");
		
			if (lrRet == null)
			{
				dataset.NameString(row,colid) = olddata;
				return;
			}
			dataset.NameString(row,"CUST_SEQ") = lrRet.get("CUST_SEQ");
			dataset.NameString(row,"CUST_CODE") = lrRet.get("CUST_CODE");
			dataset.NameString(row,"CUST_NAME") = lrRet.get("CUST_NAME");
		}
	}
}
function OnClick(dataset, grid, row, colid)
{
}
	
function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		if(colid == "INSUR_DT_F"||colid == "INSUR_DT_T"||colid == "SLIP_MAKE_DT")
		{
			C_Calendar(dataset.id+"."+colid, "D", dataset.NameString(dataset.RowPosition,colid));
		}
		else if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
		
			if (lrRet == null) return;
			dataset.NameString(row,"CUST_SEQ") = lrRet.get("CUST_SEQ");
			dataset.NameString(row,"CUST_CODE") = lrRet.get("CUST_CODE");
			dataset.NameString(row,"CUST_NAME") = lrRet.get("CUST_NAME");
		}
	}
}
function OnPostBefore(dataset, trans)
{
	return true;
}
function	OnSuccess(dataset,trans)
{
}
function OnDuplicateColumn(dataset,grid,row,colid)
{
	if(dataset == dsMAIN)
	{
		if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			if(row>=2) {
				dsMAIN.NameString(row,"CUST_SEQ") = dsMAIN.NameString(row-1,"CUST_SEQ");
				dsMAIN.NameString(row,"CUST_CODE") = dsMAIN.NameString(row-1,"CUST_CODE");
				dsMAIN.NameString(row,"CUST_NAME") = dsMAIN.NameString(row-1,"CUST_NAME");
			}
		}
	}
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
	txtDEPT_CODE.value = "";
	txtDEPT_NAME.value = "";
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
function	btnCalcMonthDecAmt_onClick()
{
	if(!checkConditions()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("���������� ������ ���� �����Ͽ� �ֽʽÿ�.");
		return;
	}
	if(C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_DT_F")))
	{
		C_msgOk("����� ��� �Ⱓ �������� �Է��Ͽ� �ֽʽÿ�.");
		return;
	}
	if(C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_DT_T")))
	{
		C_msgOk("����� ��� �Ⱓ �������� �Է��Ͽ� �ֽʽÿ�.");
		return;
	}
	G_Load(dsDEC_AMT);
	dsMAIN.NameString(dsMAIN.RowPosition,"MONTH_DEC_AMT") = dsDEC_AMT.NameString(dsDEC_AMT.RowPosition,"DEC_AMT");
}
function	btnShowLoanSlip_onClick()
{
	var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID");
	var pSLIP_IDSEQ     = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_IDSEQ");
	var pMAKE_COMP_CODE = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_KIND_TAG");
	var pREADONLY_TF    = "F";
	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("��ǥ�� ����� ���� �����ϴ�.");
		return;
	}
	
	PopupOpen_AccSlipRetrieve (
		pSLIP_ID,
		pSLIP_IDSEQ,
		pMAKE_DT,
		pMAKE_SEQ,
		pSLIP_KIND_TAG,
		pMAKE_COMP_CODE,
		pREADONLY_TF
	);
}
function	btnMakeSlip_onClick()
{
	if(!checkConditions()) return;
	if(!chkSave()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("���� ��ǥ�� ������ ���� �����Ͻʽÿ�.");
		return;
	}
	if(!C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID")))
	{
		C_msgOk("�̹� ��ǥ�� ����Ǿ� �ֽ��ϴ�.");
		return;
	}
	if(C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_MAKE_DT")))
	{
		C_msgOk("��ǥ �������� �Է��Ͽ� �ֽʽÿ�.");
		return;
	}
	if(C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"REMARKS")))
	{
		C_msgOk("��ǥ������ ���� ������(����)�� �Է��Ͽ��ֽʽÿ�.");
		return;
	}
	if(C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"CUST_SEQ")))
	{
		C_msgOk("��ǥ������ ���� ����ó�� �Է��Ͽ��ֽʽÿ�.");
		return;
	}
	var			lrObject = new Object();
	lrObject.dept_code = sMakeDeptCode;
	lrObject.comp_code = sCompCode;
	lrObject.emp_no = sEmpNo;
	lrObject.work_dept_code = dsMAIN.NameString(dsMAIN.RowPosition,"DEPT_CODE");
	lrObject.insur_no = dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_NO");

	var		arrRtn2 = window.showModalDialog("./t_PSettMakeConsInsurSlipR.jsp", lrObject, "center:yes; dialogWidth:410px; dialogHeight:600px; status:no; help:no; scroll:no");
	if(C_isNull(arrRtn2)) return;
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	if(liRow > 0) dsMAIN.RowPosition = liRow;
}
function	btnRemoveSlip_onClick()
{
	if(!checkConditions()) return;
	if(!chkSave()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("���� ������ ��ǥ�� �ִ� ���� ���� �� �۾��Ͻʽÿ�.");
		return;
	}
	var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID");
	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("��ǥ�� ����� ���� �����ϴ�.");
		return;
	}
	G_Load(dsREMOVE_SLIP);
	dsREMOVE_SLIP.NameString(dsREMOVE_SLIP.RowPosition,"DEPT_CODE") = dsMAIN.NameString(dsMAIN.RowPosition,"DEPT_CODE");
	dsREMOVE_SLIP.NameString(dsREMOVE_SLIP.RowPosition,"INSUR_NO") = dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_NO");
	
	transREMOVE_SLIP.Parameters = "ACT=REMOVE_SLIP";
	if(!G_saveData(dsREMOVE_SLIP))return;
	C_msgOk("��ǥ�� ���������� �����Ǿ����ϴ�.");
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	if(liRow > 0) dsMAIN.RowPosition = liRow;
}
