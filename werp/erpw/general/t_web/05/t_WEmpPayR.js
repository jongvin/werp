/**************************************************************************/
/* 1. �� �� �� �� id : t_WEmpPayR.jsp(��������޳�����Ȳ)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ��������޳�����Ȳ��ȸ
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-07)
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
	
	G_addDataSet(dsREMOVE, transREMOVE, null, sSelectPageName+D_P1("ACT","MAIN"), "��ǥ����");
	
	
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB01,"WORK_DT","WORK_DT");
	G_addRelCol(dsSUB01,"WORK_SEQ","WORK_SEQ");
	

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	txtDATE_FROM.value = sDTF;
	txtDATE_TO.value = sDTT;

	G_setLovCol(gridMAIN,"COST_ACC_CODE");
	G_setLovCol(gridMAIN,"PAY_ACC_CODE");
	G_setLovCol(gridMAIN,"COST_ACC_CODE_NAME");
	G_setLovCol(gridMAIN,"PAY_ACC_CODE_NAME");
	G_setLovCol(gridMAIN,"ACC_N_BANK_NAME");
	
	G_setLovCol(gridSUB01,"NAME");
	G_setLovCol(gridSUB01,"EMP_NO");

	G_setReadOnlyCol(gridMAIN,"MAKE_SLIPNO");
	G_setReadOnlyCol(gridSUB01,"MAKE_SLIPNO");

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
										 + D_P2("WORK_DT",dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT"))
										 + D_P2("WORK_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ"));
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
function	makeInSlip()
{
	if(!chkTopCondition()) return;
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
	if(dsSUB01.CountRow < 1)
	{
		C_msgOk("��ǥ�� ������ �ڷᰡ �����ϴ�.");
		return;
	}
	var			lrObject = new Object();
	lrObject.dept_code = sDeptCode;
	lrObject.comp_code = sCompCode;
	lrObject.emp_no = sEmpNo;
	lrObject.work_dt = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT");
	lrObject.work_seq = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ");

	var		arrRtn2 = window.showModalDialog("./t_PMakeEmpPaySlipR.jsp", lrObject, "center:yes; dialogWidth:410px; dialogHeight:600px; status:no; help:no; scroll:no");
	if(C_isNull(arrRtn2)) return;
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	if(liRow > 0) dsMAIN.RowPosition = liRow;
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
	dsREMOVE.NameString(dsREMOVE.RowPosition,"WORK_SEQ") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ");
	transREMOVE.Parameters = "ACT=REMOVE";
	if(!G_saveData(dsREMOVE))return;
	C_msgOk("������ǥ�� ���������� �����Ǿ����ϴ�.");
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

function OnRowInsertBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		if(!chkTopCondition()) return false;
		return true;
	}
	else if(dataset == dsSUB01)
	{
		return true;
	}
	return false;
}
function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN)
	{
		G_Load(dsWORK_SEQ);
		dataset.NameString(row,"WORK_SEQ") = dsWORK_SEQ.NameString(dsWORK_SEQ.RowPosition,"WORK_SEQ");
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
	if (dataset == dsMAIN)
	{
		var		COL_DATA;
		var		liDataRow = row;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "PAY_ACC_CODE" || colid == "PAY_ACC_CODE_NAME")
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode = "PAY_ACC_CODE";
			var			lsTargetName = "PAY_ACC_CODE_NAME";
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,lsTargetCode) = "";
				dataset.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
		else if(colid == "COST_ACC_CODE" || colid == "COST_ACC_CODE_NAME")
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode = "COST_ACC_CODE";
			var			lsTargetName = "COST_ACC_CODE_NAME";
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,lsTargetCode) = "";
				dataset.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE_MAIN", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
		else if(colid == "ACC_N_BANK_NAME")
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode = "OUT_ACC_NO";
			var			lsTargetName = "ACC_N_BANK_NAME";
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,lsTargetCode) = "";
				dataset.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACCNO");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_N_BANK_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
		else if(colid == "WORK_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	else if(dataset == dsSUB01)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "EMP_NO" || colid == "NAME")
		{
			var			lsTargetCode = "EMP_NO";
			var			lsTargetName = "NAME";
			if(COL_DATA == olddata) return;
			if(C_isNull(COL_DATA))
			{
				dataset.NameString(row,lsTargetCode) = "";
				dataset.NameString(row,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", COL_DATA);
		
			lrRet = C_AutoLov(dsLOV,"T_EMP_NO1", lrArgs,"T");
			if (lrRet != null)
			{
				dataset.NameString(row,lsTargetCode) = lrRet.get("EMPNO");
				dataset.NameString(row,lsTargetName) = lrRet.get("NAME");
				setEmpsAccInfo(row,dataset.NameString(row,lsTargetCode));
			}
			else
			{
				dataset.NameString(row,colid) = olddata;
			}
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	var		liDataRow = row;
	if(grid == gridMAIN && (colid == "PAY_ACC_CODE"||colid == "PAY_ACC_CODE_NAME" ))
	{
		var			lsTargetCode = "PAY_ACC_CODE";
		var			lsTargetName = "PAY_ACC_CODE_NAME";
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
		if (lrRet != null)
		{
			if(liDataRow > 0)
			{
				dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
				dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
			}
		}
	}
	if(grid == gridMAIN && (colid == "COST_ACC_CODE"||colid == "COST_ACC_CODE_NAME" ))
	{
		var			lsTargetCode = "COST_ACC_CODE";
		var			lsTargetName = "COST_ACC_CODE_NAME";
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV("T_ACC_CODE_MAIN", lrArgs,"F");
		if (lrRet != null)
		{
			if(liDataRow > 0)
			{
				dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
				dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
			}
		}
	}
	if(grid == gridMAIN && colid == "ACC_N_BANK_NAME")
	{
		var			lsTargetCode = "OUT_ACC_NO";
		var			lsTargetName = "ACC_N_BANK_NAME";
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV("T_ACCNO_CODE1", lrArgs,"F");
		if (lrRet != null)
		{
			if(liDataRow > 0)
			{
				dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACCNO");
				dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_N_BANK_NAME");
			}
		}
	}
	if (dataset == dsMAIN)
	{
		if(colid == "WORK_DT")
		{
			C_Calendar(dataset.id+"."+colid, "D", dataset.NameString(dataset.RowPosition,colid));
		}
	}
	else if(dataset == dsSUB01)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "EMP_NO" || colid == "NAME")
		{
			var			lsTargetCode = "EMP_NO";
			var			lsTargetName = "NAME";

			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_EMP_NO1", lrArgs,"F");
			if (lrRet != null)
			{
				dataset.NameString(row,lsTargetCode) = lrRet.get("EMPNO");
				dataset.NameString(row,lsTargetName) = lrRet.get("NAME");
				setEmpsAccInfo(row,dataset.NameString(row,lsTargetCode));
			}
		}
	}

}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
	if(dataset == dsMAIN)
	{
		if(colid == "OUT_ACC_NO")
		{
			dataset.NameString(row,"ACC_N_BANK_NAME") = dataset.NameString(row - 1,"ACC_N_BANK_NAME");
		}
		else if(colid == "ACC_N_BANK_NAME")
		{
			dataset.NameString(row,"OUT_ACC_NO") = dataset.NameString(row - 1,"OUT_ACC_NO");
		}
		else if(colid == "COST_ACC_CODE")
		{
			dataset.NameString(row,"COST_ACC_CODE_NAME") = dataset.NameString(row - 1,"COST_ACC_CODE_NAME");
		}
		else if(colid == "COST_ACC_CODE_NAME")
		{
			dataset.NameString(row,"COST_ACC_CODE") = dataset.NameString(row - 1,"COST_ACC_CODE");
		}
		else if(colid == "PAY_ACC_CODE")
		{
			dataset.NameString(row,"PAY_ACC_CODE_NAME") = dataset.NameString(row - 1,"PAY_ACC_CODE_NAME");
		}
		else if(colid == "PAY_ACC_CODE_NAME")
		{
			dataset.NameString(row,"PAY_ACC_CODE") = dataset.NameString(row - 1,"PAY_ACC_CODE");
		}
	}
	else if(dataset ==dsSUB01)
	{
		if(colid == "EMP_NO")
		{
			dataset.NameString(row,"NAME") = dataset.NameString(row - 1,"NAME");
		}
		else if(colid == "NAME")
		{
			dataset.NameString(row,"EMP_NO") = dataset.NameString(row - 1,"EMP_NO");
		}
	}
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

function	btnRemoveAll_onClick()
{
	G_deleteAllRow(dsSUB01);
}
function	btnMakeInSlip_onClick()	//
{
	makeInSlip();
}
function	btnRemoveSlip_onClick()	//
{
	removeSlip();
}

function btnFileLoad_onClick()
{
	if(dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ") == '')
	{
			C_msgOk("����������۾� ����� ���� ����Ͻʽÿ�.","Ȯ��");
			return;
	}
	if (G_isChangedDataset(dsMAIN))
	{
		var ret = C_msgYesNoCancel("����� ������ �����ϼž� �۾��� �����Ͻ� �� �ֽ��ϴ�. �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return ;
		}
		else if(ret == "C")
		{
			return ;
		}
	}
	
	if(fileUploadForm.fileCMS.value == '')
	{
			C_msgOk("������ �����Ͻʽÿ�.","Ȯ��");
			return;
	}

	fileUploadForm.action =	"./t_WEmpPayR_u.jsp?ACT=FILE"+
							"&WORK_SEQ=" + dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ")+
							"&COMP_CODE=" + dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE")+
							"&WORK_DT=" + dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT");
	//alert(fileUploadForm.action);

	fileUploadForm.submit();
}
function	btnShowSlip_onClick()
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
