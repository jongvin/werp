/**************************************************************************/
/* 1. �� �� �� �� id : t_WPersonCostR.jsp(��������ް�����)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ��������ް�����
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-30)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			sEMPNO;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "������޳����۾����");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "��������޳���");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsWORK_SEQ, null, null, null, "�۾�����");
	G_addDataSet(dsSEQ, null, null, null, "������޸�ϼ���");
	G_addDataSet(dsACCINFO, null, null, null, "�����������");
	G_addDataSet(dsBANK_MAIN, null, null, null, "���ົ���ڵ�");
	G_addDataSet(dsSUM, transSUM, null, sSelectPageName+D_P1("ACT","SUM"), "�ڷ�����");
	G_addDataSet(dsREMOVE, transREMOVE, null, sSelectPageName+D_P1("ACT","MAIN"), "��ǥ����");
	
	
	
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB01,"WORK_NO","WORK_NO");
	

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	txtDATE_FROM.value = sDTF;
	txtDATE_TO.value = sDTT;


	G_setReadOnlyCol(gridSUB01,"MAKE_SLIPNO");
	G_setReadOnlyCol(gridSUB01,"MAKE_SLIPLINE");
	G_setReadOnlyCol(gridSUB01,"ACC_NAME");
	G_setReadOnlyCol(gridSUB01,"SUMMARY1");
	G_setReadOnlyCol(gridSUB01,"CUST_CODE");
	G_setReadOnlyCol(gridSUB01,"CUST_NAME");
	G_setReadOnlyCol(gridSUB01,"ERMP_NO");
	G_setReadOnlyCol(gridSUB01,"EXEC_AMT");
	G_setReadOnlyCol(gridSUB01,"NAME");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridMAIN.TabToss = false;

	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridSUB01.TabToss = false;
	
	G_Load(dsBANK_MAIN);

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("WORK_DT_F",txtDATE_FROM.value)
										 + D_P2("WORK_DT_T",txtDATE_TO.value);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("COMP_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE"))
										 + D_P2("WORK_NO",dsMAIN.NameString(dsMAIN.RowPosition,"WORK_NO"));
	}
	else if(dataset == dsWORK_SEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","WORK_SEQ");
	}
	else if(dataset == dsSEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SEQ");
	}
	else if(dataset == dsBANK_MAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BANK_MAIN");
	}
	else if(dataset == dsSUM)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUM");
	}
	else if(dataset == dsACCINFO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ACCINFO")
										 + D_P2("EMPNO",sEMPNO);
	}
	else if(dataset == dsREMOVE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","REMOVE");
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
function	chkTopCondition()
{
	if(C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("���� ������� �����Ͻʽÿ�.");
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
function	setEmpsAccInfo(row,empno)
{
	sEMPNO = empno;
	G_Load(dsACCINFO);
	if(dsACCINFO.CountRow > 0 )
	{
		dsSUB01.NameString(row,"IN_BANK_MAIN_CODE") = dsACCINFO.NameString(dsACCINFO.RowPosition,"IN_BANK_MAIN_CODE");
		dsSUB01.NameString(row,"IN_ACC_NO") = dsACCINFO.NameString(dsACCINFO.RowPosition,"IN_ACC_NO");
		dsSUB01.NameString(row,"ACCNO_OWNER") = dsACCINFO.NameString(dsACCINFO.RowPosition,"ACCNO_OWNER");
	}
}
function	removeSlip()
{
	if(!chkTopCondition()) return;
	if(!chkSave()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("���� ����� �۾� ����� ���� �Ͻʽÿ�.");
		return;
	}
	G_Load(dsREMOVE);
	dsREMOVE.NameString(dsREMOVE.RowPosition,"COMP_CODE") = dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE");
	dsREMOVE.NameString(dsREMOVE.RowPosition,"WORK_DT") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT");
	dsREMOVE.NameString(dsREMOVE.RowPosition,"WORK_SEQ") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_NO");
	transREMOVE.Parameters = "ACT=REMOVE";
	if(!G_saveData(dsREMOVE))return;
	C_msgOk("��ǥ�� ���������� �����Ǿ����ϴ�.");
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	dsMAIN.RowPosition = liRow;
}

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	if (txtCOMP_CODE.value == "")
	{
		C_msgOk("������� �Է� �Ͻʽÿ�.", "Ȯ��");
		return;
	}
	if (txtDATE_FROM.value == "" || txtDATE_TO.value == "")
	{
		C_msgOk("��ȸ�Ⱓ�� �Է� �Ͻʽÿ�.", "Ȯ��");
		return;
	}
	D_defaultLoad();
}

function	btnRemoveSlip_onClick()
{
	removeSlip();
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
	if (asCalendarID == "DATE_FROM")
	{
		txtDATE_FROM.value = asDate;
	}
	else if (asCalendarID == "DATE_TO")
	{
		txtDATE_TO.value = asDate;
	}
	else if (asCalendarID == dsMAIN.id+"."+"WORK_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT") = asDate;
	}
}

function OnRowDeleteBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dsSUB01.ClearData();
		return true;
	}
	else if(dataset == dsSUB01)
	{
		return false;
	}
	return false;
}
function OnRowInsertBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		if(!chkTopCondition()) return false;
		return true;
	}
	else if(dataset == dsSUB01)
	{
		return false;
	}
	return false;
}
function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN)
	{
		G_Load(dsWORK_SEQ);
		dataset.NameString(row,"WORK_NO") = dsWORK_SEQ.NameString(dsWORK_SEQ.RowPosition,"WORK_SEQ");
		dataset.NameString(row,"WORK_DT") = sDTT;
		dataset.NameString(row,"COMP_CODE") =   txtCOMP_CODE.value;
	}
	else if(dataset == dsSUB01)
	{
		G_Load(dsSEQ);
		dataset.NameString(row,"SEQ") = dsSEQ.NameString(dsSEQ.RowPosition,"SEQ");
	}
}
function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
	var		liDataRow = row;
	if (dataset == dsMAIN)
	{
		if(colid == "WORK_DT")
		{
			C_Calendar(dataset.id+"."+colid, "D", dataset.NameString(dataset.RowPosition,colid));
		}
	}
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
}

// �̺�Ʈ����-------------------------------------------------------------------//
function txtCOMP_CODE_onfocus()
{
	oldData1 = txtCOMP_CODE.value;	
}
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null)
	{
		txtCOMP_CODE.value = oldData1;
		return;
	}
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
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
}


function btnDATE_FROM_onClick()
{
	C_Calendar("DATE_FROM", "D", txtDATE_FROM.value);
}

function btnDATE_TO_onClick()
{
	C_Calendar("DATE_TO", "D", txtDATE_TO.value);
}

function	btnMakeInSlip_onClick()	//
{
	if(!chkTopCondition()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("���� �۾������ �Է��Ͻʽÿ�.");
		return;
	}
	if(!chkSave()) return;
	G_Load(dsSUM);
	dsSUM.NameString(dsSUM.RowPosition,"COMP_CODE") = dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE");
	dsSUM.NameString(dsSUM.RowPosition,"WORK_DT") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT");
	dsSUM.NameString(dsSUM.RowPosition,"WORK_NO") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_NO");
	dsSUM.NameString(dsSUM.RowPosition,"DEPT_CODE") = sDeptCode;
	transSUM.Parameters = "ACT=SUM";
	if(!G_saveData(dsSUM))return;
	C_msgOk("�ڷᰡ ���������� �����Ǿ����ϴ�.");
	G_Load(dsSUB01);
}

function	btnShowSlip_onClick()
{
	var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"TARGET_SLIP_ID");
	var pSLIP_IDSEQ     = dsSUB01.NameString(dsSUB01.RowPosition,"TARGET_SLIP_IDSEQ");
	var pMAKE_COMP_CODE = dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsSUB01.NameString(dsSUB01.RowPosition,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsSUB01.NameString(dsSUB01.RowPosition,"SLIP_KIND_TAG");
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
