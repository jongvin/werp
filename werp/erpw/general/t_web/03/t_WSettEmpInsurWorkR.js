/**************************************************************************/
/* 1. �� �� �� �� id : t_WSettEmpInsurWorkR(��뺸�����ǥ����)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-22)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			bEnter = false;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "��뺸�����",null,null,true);
	G_addDataSet(dsSUB01, null, gridSUB01, null, "��뺸�������ǥ���",null,null,true);
	
	G_addDataSet(dsREMOVE_SLIP, transREMOVE_SLIP, null, null, "��ǥ����",null,null,true);
	
	
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsWORK_NO, null, null, null, "���纸���ȣ");
	G_addDataSet(dsMAKE_DATA, transMAKE_DATA, null, null, "�������ݾ׻���");
	G_addDataSet(dsMAKE_SLIP, transMAKE_SLIP, null, null, "�������ݾ׻���");
	
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB01,"INSUR_WORK_NO","INSUR_WORK_NO");
	
	

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtF_PUBL_DT.value = sDTF;
	txtE_PUBL_DT.value = sDTT;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();
	
	G_setReadOnlyCol(gridMAIN,"MAKE_SLIPNO");
	G_setReadOnlyCol(gridSUB01,"DEPT_CODE");
	G_setReadOnlyCol(gridSUB01,"DEPT_NAME");
	G_setReadOnlyCol(gridSUB01,"ACC_NAME");
	G_setReadOnlyCol(gridSUB01,"MAKE_SLIPNO");
	G_setReadOnlyCol(gridSUB01,"DB_AMT");
	G_setReadOnlyCol(gridSUB01,"SUMMARY1");
	
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("WORK_DT_F",txtF_PUBL_DT.value)
											+ D_P2("WORK_DT_T",txtE_PUBL_DT.value);
	}
	else if (dataset == dsSUB01)	
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("COMP_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE"))
											+ D_P2("INSUR_WORK_NO",dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_WORK_NO"));
	}
	else if(dataset == dsWORK_NO)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","WORK_NO");
	}
	else if(dataset == dsREMOVE_SLIP)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAKE_DATA");
	}
	else if(dataset == dsMAKE_DATA)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAKE_DATA");
	}
	else if(dataset == dsMAKE_SLIP)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAKE_DATA");
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
	if (C_isNull(txtF_PUBL_DT.value) || C_isNull(txtE_PUBL_DT.value))
	{
		C_msgOk("��ȸ�Ⱓ�� �Է��Ͻʽÿ�.", "Ȯ��");
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
	if(G_FocusDataset == dsMAIN)
	{
		D_defaultAdd();
	}
	else if(G_FocusDataset == dsSUB01)
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("DT_F", dsMAIN.NameString(dsMAIN.RowPosition,"TARGET_DT_F"));
		lrArgs.set("DT_T", dsMAIN.NameString(dsMAIN.RowPosition,"TARGET_DT_T"));
		lrArgs.set("COMP_CODE", dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE"));
		lrArgs.set("INSUR_WORK_NO",dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_WORK_NO"));
	
		lrRet = C_LOV_NEW("T_SELECT_SLIP1", null, lrArgs, "F", "T");
		
		if (lrRet == null) return;
	
		var idx = 0;
		for (idx = 0; idx < lrRet.length; idx++)
		{
			lrArgs = lrRet[idx];
			//D_defaultAdd();
			G_addRow(dsSUB01);
	
			dsSUB01.NameString(dsSUB01.RowPosition,"SLIP_ID") = lrArgs.get("SLIP_ID");
			dsSUB01.NameString(dsSUB01.RowPosition,"SLIP_IDSEQ") = lrArgs.get("SLIP_IDSEQ");
			dsSUB01.NameString(dsSUB01.RowPosition,"DEPT_CODE") = lrArgs.get("DEPT_CODE");

			dsSUB01.NameString(dsSUB01.RowPosition,"DEPT_NAME") = lrArgs.get("DEPT_NAME");
			dsSUB01.NameString(dsSUB01.RowPosition,"ACC_CODE") = lrArgs.get("ACC_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition,"ACC_NAME") = lrArgs.get("ACC_NAME");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_SLIPCLS") = lrArgs.get("MAKE_SLIPCLS");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_SLIPNO") = lrArgs.get("MAKE_SLIPNO");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_COMP_CODE") = lrArgs.get("MAKE_COMP_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_DEPT_CODE") = lrArgs.get("MAKE_DEPT_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_DT") = lrArgs.get("MAKE_DT");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_DT_TRANS") = lrArgs.get("MAKE_DT_TRANS");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_SEQ") = lrArgs.get("MAKE_SEQ");

			dsSUB01.NameString(dsSUB01.RowPosition,"SLIP_KIND_TAG") = lrArgs.get("SLIP_KIND_TAG");
			dsSUB01.NameString(dsSUB01.RowPosition,"DB_AMT") = lrArgs.get("DB_AMT");
			dsSUB01.NameString(dsSUB01.RowPosition,"SUMMARY1") = lrArgs.get("SUMMARY1");
		}
	}
}

// ����
function btninsert_onclick()
{
	if(G_FocusDataset == dsMAIN)
	{
		D_defaultInsert();
	}
	else if(G_FocusDataset == dsSUB01)
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("DT_F", dsMAIN.NameString(dsMAIN.RowPosition,"TARGET_DT_F"));
		lrArgs.set("DT_T", dsMAIN.NameString(dsMAIN.RowPosition,"TARGET_DT_T"));
		lrArgs.set("COMP_CODE", dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE"));
		lrArgs.set("INSUR_WORK_NO",dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_WORK_NO"));
	
		lrRet = C_LOV_NEW("T_SELECT_SLIP2", null, lrArgs, "F", "T");
		
		if (lrRet == null) return;
	
		var idx = 0;
		for (idx = 0; idx < lrRet.length; idx++)
		{
			lrArgs = lrRet[idx];
			//D_defaultAdd();
			G_addRow(dsSUB01);
			dsSUB01.NameString(dsSUB01.RowPosition,"SLIP_ID") = lrArgs.get("SLIP_ID");
			dsSUB01.NameString(dsSUB01.RowPosition,"SLIP_IDSEQ") = lrArgs.get("SLIP_IDSEQ");
			dsSUB01.NameString(dsSUB01.RowPosition,"DEPT_CODE") = lrArgs.get("DEPT_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition,"DEPT_NAME") = lrArgs.get("DEPT_NAME");
			dsSUB01.NameString(dsSUB01.RowPosition,"ACC_CODE") = lrArgs.get("ACC_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition,"ACC_NAME") = lrArgs.get("ACC_NAME");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_SLIPCLS") = lrArgs.get("MAKE_SLIPCLS");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_SLIPNO") = lrArgs.get("MAKE_SLIPNO");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_COMP_CODE") = lrArgs.get("MAKE_COMP_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_DEPT_CODE") = lrArgs.get("MAKE_DEPT_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_DT") = lrArgs.get("MAKE_DT");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_DT_TRANS") = lrArgs.get("MAKE_DT_TRANS");
			dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_SEQ") = lrArgs.get("MAKE_SEQ");
			dsSUB01.NameString(dsSUB01.RowPosition,"SLIP_KIND_TAG") = lrArgs.get("SLIP_KIND_TAG");
			dsSUB01.NameString(dsSUB01.RowPosition,"DB_AMT") = lrArgs.get("DB_AMT");
			dsSUB01.NameString(dsSUB01.RowPosition,"SUMMARY1") = lrArgs.get("SUMMARY1");
		}
	}
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
	if (asCalendarID == dsMAIN.id+"."+"WORK_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT") = asDate;
	}
	else if (asCalendarID == dsMAIN.id+"."+"TARGET_DT_F")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"TARGET_DT_F") = asDate;
	}
	else if (asCalendarID == dsMAIN.id+"."+"TARGET_DT_T")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"TARGET_DT_T") = asDate;
	}
	else if (asCalendarID == "F_PUBL_DT")
	{
		txtF_PUBL_DT.value = asDate;
	}
	else if (asCalendarID == "E_PUBL_DT")
	{
		txtE_PUBL_DT.value = asDate;
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
		G_Load(dsWORK_NO);
		dataset.NameString(row,"INSUR_WORK_NO") = dsWORK_NO.NameString(dsWORK_NO.RowPosition,"WORK_NO");
		dataset.NameString(row,"WORK_DT") = dsWORK_NO.NameString(dsWORK_NO.RowPosition,"EDT");
		dataset.NameString(row,"TARGET_DT_F") = dsWORK_NO.NameString(dsWORK_NO.RowPosition,"SDT");
		dataset.NameString(row,"TARGET_DT_T") = dsWORK_NO.NameString(dsWORK_NO.RowPosition,"EDT");
		dataset.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
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
		return true;
	}
	else if(dataset == dsSUB01)
	{
		if(!C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID")))
		{
			C_msgOk("��ǥ�� ����� ���� ������ �Ұ����մϴ�.");
			return false;
		}
		return true;
	}
	return false;
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
		if(colid == "WORK_DT"||colid == "TARGET_DT_F"||colid == "TARGET_DT_T")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
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
		if(colid == "WORK_DT"||colid == "TARGET_DT_F"||colid == "TARGET_DT_T")
		{
			C_Calendar(dataset.id+"."+colid, "D", dataset.NameString(dataset.RowPosition,colid));
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
	dsMAIN.ClearData();
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
	dsMAIN.ClearData();
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
		C_msgOk("�� ���� ��� ������ ���� �����Ͽ� �ֽʽÿ�.");
		return;
	}
	if(C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT")))
	{
		C_msgOk("�۾� �������� �Է��Ͽ� �ֽʽÿ�.");
		return;
	}
	if(!C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID")))
	{
		C_msgOk("�̹� ��ǥ�� ����� ���� �����Ͽ����ϴ�.");
		return;
	}
	G_Load(dsMAKE_DATA);

	dsMAKE_DATA.NameString(dsMAKE_DATA.RowPosition,"COMP_CODE") = dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE");
	dsMAKE_DATA.NameString(dsMAKE_DATA.RowPosition,"WORK_NO") = dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_WORK_NO");
	
	alert(dsMAKE_DATA.NameString(dsMAKE_DATA.RowPosition,"COMP_CODE"));
	alert(dsMAKE_DATA.NameString(dsMAKE_DATA.RowPosition,"WORK_NO"));
	transMAKE_DATA.Parameters = "ACT=MAKE_DATA";
	if(!G_saveData(dsMAKE_DATA))return;
	C_msgOk("�ڷᰡ ���������� ����Ǿ����ϴ�.");
	G_Load(dsSUB01);
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
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("�� ���� ��� ������ ���� �����Ͽ� �ֽʽÿ�.");
		return;
	}
	if(C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT")))
	{
		C_msgOk("�۾� �������� �Է��Ͽ� �ֽʽÿ�.");
		return;
	}
	if(!C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID")))
	{
		C_msgOk("�̹� ��ǥ�� ����� ���� �����Ͽ����ϴ�.");
		return;
	}
	G_Load(dsMAKE_SLIP);

	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"COMP_CODE") = dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE");
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"DEPT_CODE") = sMakeDeptCode;
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"WORK_NO") = dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_WORK_NO");
	
	
	transMAKE_SLIP.Parameters = "ACT=MAKE_SLIP";
	if(!G_saveData(dsMAKE_SLIP))return;
	C_msgOk("��ǥ�� ���������� ����Ǿ����ϴ�.");
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
	dsREMOVE_SLIP.NameString(dsREMOVE_SLIP.RowPosition,"COMP_CODE") = dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE");
	dsREMOVE_SLIP.NameString(dsREMOVE_SLIP.RowPosition,"WORK_NO") = dsMAIN.NameString(dsMAIN.RowPosition,"INSUR_WORK_NO");
	
	transREMOVE_SLIP.Parameters = "ACT=REMOVE_SLIP";
	if(!G_saveData(dsREMOVE_SLIP))return;
	C_msgOk("��ǥ�� ���������� �����Ǿ����ϴ�.");
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	if(liRow > 0) dsMAIN.RowPosition = liRow;
}
function	btnF_PUBL_DT_onClick()
{
	C_Calendar("F_PUBL_DT", "D", txtF_PUBL_DT.value);
}
function	btnE_PUBL_DT_onClick()
{
	C_Calendar("E_PUBL_DT", "D", txtE_PUBL_DT.value);
}
