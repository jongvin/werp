/**************************************************************************/
/* 1. �� �� �� �� id : t_WFNpItrAmtWorkR.jsp(�������ǹ̼�������ǥ����)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-26)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�������Ǹ��");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "�������ǹ̼�����");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsWORK_NO, null, null, sSelectPageName+D_P1("ACT","dsWORK_NO"), "dsWORK_NO");
	G_addDataSet(dsDATE, null, null, sSelectPageName+D_P1("ACT","dsDATE"), "dsDATE");
	G_addDataSet(dsMAKE, transMAKE, null, sSelectPageName+D_P1("ACT","MAKE"), "�����۾�");


	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"WORK_NO","WORK_NO");	
	
	G_setReadOnlyCol(gridMAIN,"MAKE_SLIPNO");
	G_setReadOnlyCol(gridMAIN,"NP_ITR_AMT");
	
	G_setReadOnlyCol(gridSUB01,"COMPANY_NAME");
	G_setReadOnlyCol(gridSUB01,"REAL_SECU_NO");
	G_setReadOnlyCol(gridSUB01,"SEC_KIND_NAME");
	G_setReadOnlyCol(gridSUB01,"PUBL_DT");
	G_setReadOnlyCol(gridSUB01,"EXPR_DT");
	G_setReadOnlyCol(gridSUB01,"GET_DT");
	G_setReadOnlyCol(gridSUB01,"PERSTOCK_AMT");
	G_setReadOnlyCol(gridSUB01,"INTR_RATE");
	G_setReadOnlyCol(gridSUB01,"NP_ITR_AMT");

	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.

	gridSUB01.TabToss = false;
	gridMAIN.focus();
	
	//G_Load(dsMAIN, null);
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										+ D_P2("WORK_DT_F",txtYM_F.value+"-01")
										+ D_P2("WORK_DT_T",txtYM_T.value+"-01");
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										+ D_P2("WORK_NO",dsMAIN.NameString(dsMAIN.RowPosition,"WORK_NO"));
	}
	else if(dataset == dsWORK_NO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","WORK_NO");
	}
	else if(dataset == dsMAKE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAKE");
	}
	else if(dataset == dsDATE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DATE")
										+ D_P2("DT",dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT"));
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
function	CalcSumUp()
{
	dsMAIN.NameString(dsMAIN.RowPosition,"NP_ITR_AMT") = dsSUB01.NameSum("NP_ITR_AMT",0,0);
}

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	if(C_isNull(txtYM_F.value))
	{
		C_msgOk("�۾������ �Է��Ͽ� �ֽʽÿ�.");
		return;
	}
	if(C_isNull(txtYM_T.value))
	{
		C_msgOk("�۾������ �Է��Ͽ� �ֽʽÿ�.");
		return;
	}
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	if(G_FocusDataset == dsMAIN)
	{
		D_defaultAdd();
	}
}

// ����
function btninsert_onclick()
{
	if(G_FocusDataset == dsMAIN)
	{
		D_defaultInsert();
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
		G_Load(dsDATE);
		dsMAIN.NameString(dsMAIN.RowPosition,"CALC_DT_FROM") = dsDATE.NameString(dsDATE.RowPosition,"DT_F");
		dsMAIN.NameString(dsMAIN.RowPosition,"CALC_DT_TO") = dsDATE.NameString(dsDATE.RowPosition,"DT_T");
	}
	else if (asCalendarID == dsMAIN.id+"."+"CALC_DT_FROM")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"CALC_DT_FROM") = asDate;
	}
	else if (asCalendarID == dsMAIN.id+"."+"CALC_DT_TO")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"CALC_DT_TO") = asDate;
	}
}


function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN)
	{
		G_Load(dsWORK_NO);
		dataset.NameString(row,"WORK_NO") = dsWORK_NO.NameString(dsWORK_NO.RowPosition,"WORK_NO");
		dataset.NameString(row,"TARGET_COMP_CODE") = "%";
	}
}

function OnRowDeleteBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		if(! C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID")))
		{
			C_msgOk("��ǥ�� ����� ���� �����Ͻ� �� �����ϴ�.");
			return false;
		}
		return true;
	}
	else
	{
		if(! C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID")))
		{
			C_msgOk("��ǥ�� ����� ���� �����Ͻ� �� �����ϴ�.");
			return false;
		}
		return true;
	}
}

function OnRowDeleted(dataset, row)
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
		if(colid == "WORK_DT"||colid == "CALC_DT_FROM"||colid == "CALC_DT_TO")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
			if(colid == "WORK_DT" && !C_isNull(COL_DATA))
			{
				G_Load(dsDATE);
				dataset.NameString(row,"CALC_DT_FROM") = dsDATE.NameString(dsDATE.RowPosition,"DT_F");
				dataset.NameString(row,"CALC_DT_TO") = dsDATE.NameString(dsDATE.RowPosition,"DT_T");
			}
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		if(colid == "WORK_DT"||colid == "CALC_DT_FROM"||colid == "CALC_DT_TO")
		{
			C_Calendar(dataset.id+"."+colid, "D", dataset.NameString(dataset.RowPosition,colid));
		}
	}
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
}

// �̺�Ʈ����-------------------------------------------------------------------//
function	btnMakeData_onClick()
{
	if (G_isChangedDataset(dsMAIN))
	{
		var ret = C_msgYesNo("����� ������ �����ϼž� �۾��� �����Ͻ� �� �ֽ��ϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(G_FocusDataset)) return ;
		}
		else if(ret == "C")
		{
			return ;
		}
		else
		{
			return;
		}
	}
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("���� ����� ��ǥ�����۾� ����� �����Ͻʽÿ�.");
		return;
	}
	G_Load(dsMAKE);
	dsMAKE.NameString(dsMAKE.RowPosition,"WORK_NO") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_NO");
	transMAKE.Parameters = "ACT=MAKE";
	if(!G_saveData(dsMAKE))return;
	C_msgOk("��� ���� �۾��� ���������� ����Ǿ����ϴ�.");
	G_Load(dsSUB01);
	CalcSumUp();
	D_defaultSave(dsMAIN);
}
function	btnCalcItr_onClick()
{
	if (G_isChangedDataset(dsMAIN))
	{
		var ret = C_msgYesNo("����� ������ �����ϼž� �۾��� �����Ͻ� �� �ֽ��ϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(G_FocusDataset)) return ;
		}
		else if(ret == "C")
		{
			return ;
		}
		else
		{
			return;
		}
	}
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("���� ����� ��ǥ�����۾� ����� �����Ͻʽÿ�.");
		return;
	}
	G_Load(dsMAKE);
	dsMAKE.NameString(dsMAKE.RowPosition,"WORK_NO") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_NO");
	transMAKE.Parameters = "ACT=CALC";
	if(!G_saveData(dsMAKE))return;
	C_msgOk("���� ��� �۾��� ���������� ����Ǿ����ϴ�.");
	G_Load(dsSUB01);
	CalcSumUp();
	D_defaultSave(dsMAIN);
}
function	btnShowSlip_onClick()
{
		var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID");
		var pSLIP_IDSEQ     = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_COMP_CODE");
		var pMAKE_DT 	     = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_DT");
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
	if (G_isChangedDataset(dsMAIN))
	{
		var ret = C_msgYesNo("����� ������ �����ϼž� �۾��� �����Ͻ� �� �ֽ��ϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(G_FocusDataset)) return ;
		}
		else if(ret == "C")
		{
			return ;
		}
		else
		{
			return;
		}
	}
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("���� ����� ��ǥ�����۾� ����� �����Ͻʽÿ�.");
		return;
	}
	G_Load(dsMAKE);
	dsMAKE.NameString(dsMAKE.RowPosition,"WORK_NO") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_NO");
	dsMAKE.NameString(dsMAKE.RowPosition,"COMP_CODE") = sCompCode;
	dsMAKE.NameString(dsMAKE.RowPosition,"DEPT_CODE") = sDeptCode;
	transMAKE.Parameters = "ACT=MAKE_SLIP";
	if(!G_saveData(dsMAKE))return;
	C_msgOk("��ǥ���� �۾��� ���������� ����Ǿ����ϴ�. ���ŵ� ������ �����ϱ� ������ ���� �ٽ� �н��ϴ�.");
	var		liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	dsMAIN.RowPosition = liRow;
}
function	btnRemoveSlip_onClick()
{
	if (G_isChangedDataset(dsMAIN))
	{
		var ret = C_msgYesNo("����� ������ �����ϼž� �۾��� �����Ͻ� �� �ֽ��ϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(G_FocusDataset)) return ;
		}
		else if(ret == "C")
		{
			return ;
		}
		else
		{
			return;
		}
	}
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("���� ����� ��ǥ�����۾� ����� �����Ͻʽÿ�.");
		return;
	}
	G_Load(dsMAKE);
	dsMAKE.NameString(dsMAKE.RowPosition,"WORK_NO") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_NO");
	dsMAKE.NameString(dsMAKE.RowPosition,"COMP_CODE") = sCompCode;
	dsMAKE.NameString(dsMAKE.RowPosition,"DEPT_CODE") = sDeptCode;
	transMAKE.Parameters = "ACT=REMOVE_SLIP";
	if(!G_saveData(dsMAKE))return;
	C_msgOk("��ǥ���� �۾��� ���������� ����Ǿ����ϴ�. ���ŵ� ������ �����ϱ� ������ ���� �ٽ� �н��ϴ�.");
	var		liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	dsMAIN.RowPosition = liRow;
}
