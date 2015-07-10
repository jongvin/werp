/**************************************************************************/
/* 1. �� �� �� �� id : t_PPLCompExecR.jsp(�濵��ȹ�������賻��)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-28)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

var opnrArgs = window.dialogArguments;

function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "�ŷ�ó�ڵ�");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	

	gridMAIN.Focus();
	G_Load(dsMAIN);
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("BIZ_PLAN_ITEM_NO",opnrArgs.get("BIZ_PLAN_ITEM_NO"))
											+ D_P2("COMP_CODE",opnrArgs.get("COMP_CODE"))
											+ D_P2("CLSE_ACC_ID",opnrArgs.get("CLSE_ACC_ID"))
											+ D_P2("WORK_YM",opnrArgs.get("WORK_YM"));
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
function	showSlip(dataset,row)
{
	var pSLIP_ID        = dataset.NameString(row,"SLIP_ID");
	var pSLIP_IDSEQ     = dataset.NameString(row,"SLIP_IDSEQ");
	var pMAKE_COMP_CODE = dataset.NameString(row,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dataset.NameString(row,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dataset.NameString(row,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dataset.NameString(row,"SLIP_KIND_TAG");
	var pREADONLY_TF    = "F";

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
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	if ((G_FocusDataset == dsMAIN) && (cboTRADE_CLS.value == "%"))
	{
		C_msgOk("�ŷ�ó������ ��ü�϶��� �߰��Ҽ� �����ϴ�. <br><br> ���� �ŷ��߱����� �����ϼ���.", "Ȯ��");
		return;
	}
	
	D_defaultAdd();
}

// ����
function btninsert_onclick()
{
	if ((G_FocusDataset == dsMAIN) && (cboTRADE_CLS.value == "%"))
	{
		C_msgOk("�ŷ�ó������ ��ü�϶��� �����Ҽ� �����ϴ�. <br><br> ���� �ŷ��߱����� �����ϼ���.", "Ȯ��");
		return;
	}
	
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
	if (asCalendarID == "BUDG_YM")
	{
		txtBUDG_YM.value = asDate;
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
	if (dataset == dsMAIN)
	{
	}

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
	
}

function OnPopup(dataset, grid, row, colid, data)
{
	
}
function OnDblClick(dataset, grid, row, colid)
{
	showSlip(dataset,row);
}

// �̺�Ʈ����-------------------------------------------------------------------//
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}
	
	if (txtCOMP_CODE_F.value == txtCOMP_CODE.value) return;
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) {
		txtCOMP_CODE.value = txtCOMP_CODE_F.value;
		return;
	}
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	
	txtDEPT_CODE.value = '';
	txtDEPT_NAME.value = '';
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	if (txtCOMP_CODE.value	== lrRet.get("COMP_CODE")) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	
	txtDEPT_CODE.value = '';
	txtDEPT_NAME.value = '';
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

//�ͼӺμ�
function txtDEPT_CODE_onblur()
{
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_CODE.value = '';
		txtDEPT_NAME.value = '';
		return;
	}
	
	if (txtDEPT_CODE_F.value == txtDEPT_CODE.value) return;
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) {
		txtDEPT_CODE.value = txtDEPT_CODE_F.value;
		return;
	}

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	//G_Load(dsCLASS_CODE, null);
}

function btnDEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"F");

	if (lrRet == null) return;
	
	if (txtDEPT_CODE.value	== lrRet.get("DEPT_CODE")) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	//G_Load(dsCLASS_CODE, null);
}

//��������
function txtACC_CODE_onblur()
{
	if (C_isNull(txtACC_CODE.value))
	{
		txtACC_CODE.value = '';
		txtACC_NAME.value = '';
		return;
	}
	
	if (txtACC_CODE_F.value == txtACC_CODE.value) return;

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_BUDG_REL_ACC_CODE", lrArgs,"T");

	if (lrRet == null) {
		txtACC_CODE.value = txtACC_CODE_F.value;
		return;
	}

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
}

function btnACC_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", '');

	lrRet = C_LOV("T_BUDG_REL_ACC_CODE", lrArgs,"F");
	
	if (lrRet == null) return;
	
	if (txtACC_CODE.value	== lrRet.get("ACC_CODE")) return;

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
}

function btnBUDG_YM_onClick()
{
	C_Calendar("BUDG_YM", "M", txtBUDG_YM.value);
	 
}
function	btnShowSlip_onclick()
{
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("��ȸ�� ���� �����Ͻʽÿ�.");
		return;
	}
	showSlip(dsMAIN,dsMAIN.RowPosition);
}

