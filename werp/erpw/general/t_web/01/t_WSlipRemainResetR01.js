/**************************************************************************/
/* 1. �� �� �� �� id : t_WSlipRemainResetR01.js(���ޱ��Ź�����ǥ�ڵ�����)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-30)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var vAccClse = false;
var vMonClse = false;
var vDayClse = false;
var vDeptClse = false;

var vMAKE_COMP_CODE = "";
var vMAKE_DEPT_CODE = "";
var vMAKE_DT_TRANS  = "";

var vGET_TYPE = "";
var vWORK_SLIP_ID = "";
var vWORK_SLIP_IDSEQ = "";
var	liInterval;

function Initialize()
{
	btnSlipDelete.style.display = "none";
	btnAllSelect01.style.display = "none";
	btnAllSelCancle01.style.display = "none";

	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�̹��� ������ǥ����");
	G_addDataSet(dsMAIN01, trans, gridMAIN01, sSelectPageName+D_P1("ACT","MAIN01"), "������ǥ����");
	G_addDataSet(dsMAKE_SEQ, null, null, null, "��ǥ����");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsDAY_CLOSE, null, null, null, "��������");
	G_addDataSet(dsWORK_SLIP_IDSEQ, null, null, null, "�ڵ���ǥID����");
	G_addDataSet(dsNEW_WORK_SLIP, null, null, null, "�ڵ���ǥ�������űԻ���");	
	
	G_addDataSet(dsAUTO_REMAIN_RESET_SEQ, null, null, null, "�ܾ׹���_�ڵ���ǥ_�۾���ȣ");
	
	txtMAKE_COMP_CODE.value = sCompCode;
	txtMAKE_COMP_NAME.value = sCompName;
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMP_NAME.value = sCompName;
	
	txtSLIP_MAKE_DT_F.value = txtDT_F.value.replace(/-/gi,"");
	txtSLIP_MAKE_DT.value = txtDT_F.value.replace(/-/gi,"");
	txtSLIP_MAKE_SEQ.value = "";
	cboSLIP_KIND_TAG.value	= "B";
	cboSLIP_KIND_TAG.disabled = true;
	txtSLIP_MAKE_COMP_CODE.value = sCompCode;
	txtSLIP_MAKE_COMP_NAME.value = sCompName;

	txtSLIP_MAKE_DEPT_CODE.value = sDeptCode;
	txtSLIP_MAKE_DEPT_NAME.value = sDeptName;
	txtSLIP_INOUT_DEPT_CODE.value = sInout_DeptCode;
	txtSLIP_INOUT_DEPT_NAME.value = sInout_DeptName;
	// �ۼ���
	//txtSLIP_MAKE_PERS.value = sEmpno;
	//txtSLIP_MAKE_NAME.value = sName;
	
	txtSLIP_CHARGE_PERS.value	= sCHARGE_PERS;
	txtSLIP_CHARGE_PERS_NAME.value	= sCHARGE_PERS_NAME;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	
	//G_setReadOnlyCol(gridMAIN,"DEPT_CODE");
	//G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	
	G_setLovCol(gridMAIN,"TAX_COMP_CODE");
	G_setLovCol(gridMAIN,"TAX_COMP_NAME");
	
	//G_setReadOnlyCol(gridMAIN,"CLSE_ACC_ID");
	//G_setReadOnlyCol(gridMAIN,"ACC_ID");
	
	G_setLovCol(gridMAIN,"INPUT_DT_F");
	G_setLovCol(gridMAIN,"INPUT_DT_T");
	if(vWORK_SLIP_ID=="") CurWorkSlip();

	gridMAIN.focus();
}

function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("DT_F",txtDT_F.value.replace(/-/gi,""))
											+ D_P2("DT_T",txtDT_T.value.replace(/-/gi,""))
											+ D_P2("EXPR_DT_F",txtEXPR_DT_F.value.replace(/-/gi,""))
											+ D_P2("EXPR_DT_T",txtEXPR_DT_T.value.replace(/-/gi,""))
											+ D_P2("MAKE_COMP_CODE",txtMAKE_COMP_CODE.value)
											+ D_P2("MAKE_DEPT_CODE",txtMAKE_DEPT_CODE.value)
											+ D_P2("COMP_CODE",txtMAKE_COMP_CODE.value)
											+ D_P2("DEPT_CODE",txtMAKE_DEPT_CODE.value)
											+ D_P2("CUST_CODE",txtCUST_CODE.value);
	}
	else if (dataset == dsMAIN01)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN01")
											+ D_P2("DT_F",txtDT_F.value.replace(/-/gi,""))
											+ D_P2("DT_T",txtDT_T.value.replace(/-/gi,""))
											+ D_P2("EXPR_DT_F",txtEXPR_DT_F.value.replace(/-/gi,""))
											+ D_P2("EXPR_DT_T",txtEXPR_DT_T.value.replace(/-/gi,""))
											+ D_P2("MAKE_COMP_CODE",txtMAKE_COMP_CODE.value)
											+ D_P2("MAKE_DEPT_CODE",txtMAKE_DEPT_CODE.value)
											+ D_P2("COMP_CODE",txtMAKE_COMP_CODE.value)
											+ D_P2("DEPT_CODE",txtMAKE_DEPT_CODE.value)
											+ D_P2("CUST_CODE",txtCUST_CODE.value);
	}
	else if(dataset == dsMAKE_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAKE_SEQ")
											+ D_P2("MAKE_COMP_CODE",txtSLIP_MAKE_COMP_CODE.value)
											+ D_P2("MAKE_DT_TRANS",txtSLIP_MAKE_DT.value);
	}
	else if(dataset == dsDAY_CLOSE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","DAY_CLOSE")
											+ D_P2("COMP_CODE",vMAKE_COMP_CODE)
											+ D_P2("DEPT_CODE",vMAKE_DEPT_CODE)
											+ D_P2("CLSE_DAY",vMAKE_DT_TRANS);
	}
	else if(dataset == dsWORK_SLIP_IDSEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","WORK_SLIP_IDSEQ")
											+ D_P2("GET_TYPE",vGET_TYPE)
											+ D_P2("WORK_CODE",vWORK_CODE)
											+ D_P2("DEPT_CODE",sDeptCode);
	}
	else if(dataset == dsNEW_WORK_SLIP)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","NEW_WORK_SLIP")
											+ D_P2("WORK_SLIP_ID", vWORK_SLIP_ID)
											+ D_P2("WORK_SLIP_IDSEQ", vWORK_SLIP_IDSEQ)
											+ D_P2("WORK_CODE",vWORK_CODE)
											+ D_P2("DEPT_CODE",sDeptCode);
		//alert(dataset.DataID);
	}
	else if(dataset == dsAUTO_REMAIN_RESET_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","AUTO_REMAIN_RESET_SEQ");
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
function	focusControl(grid)
{
	window.clearInterval(liInterval);
	grid.focus();
}
function selectTab(index, totcount)
{
	// ���������� �̹��� ��ȯ �����Լ�
	if (!C_selectTab(index, totcount)) return;

	switch (index)
	{
		case 1:
			divTabPage1.style.display = "";
			divTabPage2.style.display = "none";

			btnSlipCreate.style.display = "";
			btnSlipDelete.style.display = "none";

			btnSubSelect.style.display = "";
			btnAllSelect.style.display = "";
			btnAllSelCancle.style.display = "";
			btnAllSelect01.style.display = "none";
			btnAllSelCancle01.style.display = "none";

			sTab = "1";
			liInterval = window.setInterval("focusControl(gridMAIN)", 1);
			break;
		case 2:
			divTabPage1.style.display = "none";
			divTabPage2.style.display = "";

			btnSlipCreate.style.display = "none";
			btnSlipDelete.style.display = "";

			btnSubSelect.style.display = "none";
			btnAllSelect.style.display = "none";
			btnAllSelCancle.style.display = "none";
			btnAllSelect01.style.display = "";
			btnAllSelCancle01.style.display = "";

			sTab = "2";
			liInterval = window.setInterval("focusControl(gridMAIN01)", 1);
			break;
	}

	if(!CheckCompCode()) return;
/*
	switch (index)
	{
		case 1:
			G_Load(dsMAIN);
			break;
		case 2:
			G_Load(dsMAIN01);
			break;
	}
*/
	//D_defaultLoad();
}
function NewWorkSlip() {
	
	if(sDeptCode == "") {
		C_msgOk("�α��� ������ �����ϴ�. �۾��� ������ �� �����ϴ�.");
		return;
	}
	vGET_TYPE = "NEW";
	G_Load(dsWORK_SLIP_IDSEQ, null);
	vWORK_SLIP_ID = dsWORK_SLIP_IDSEQ.NameString(1,"WORK_SLIP_ID");
	vWORK_SLIP_IDSEQ = dsWORK_SLIP_IDSEQ.NameString(1,"WORK_SLIP_IDSEQ");
	
	G_Load(dsNEW_WORK_SLIP, null);
	AccSearch();
}

function CurWorkSlip() {
	
	if(sDeptCode == "") {
		C_msgOk("�α��� ������ �����ϴ�. �۾��� ������ �� �����ϴ�.");
		return;
	}
	
	vGET_TYPE = "CUR";	
	G_Load(dsWORK_SLIP_IDSEQ, null);
	vWORK_SLIP_ID = dsWORK_SLIP_IDSEQ.NameString(1,"WORK_SLIP_ID");
	vWORK_SLIP_IDSEQ = dsWORK_SLIP_IDSEQ.NameString(1,"WORK_SLIP_IDSEQ");
	
	if(vWORK_SLIP_ID == "0") {
		NewWorkSlip();
		return;
	}
	AccSearch();
}

function AccSearch() {
	//alert(vWORK_CODE+"-"+vWORK_SLIP_ID+"-"+vWORK_SLIP_IDSEQ);
	ifrmOtherAccPage.AccSearch(vWORK_CODE, vWORK_SLIP_ID, vWORK_SLIP_IDSEQ);
	//ifrmOtherAccPage.AccReload();
}

function isAccUpdated() {
	if (ifrmOtherAccPage.dsSLIP_D.IsUpdated)
	{
		var	vRet	= C_msgYesNo("������������ �����Ǿ����ϴ�.<br>�����ϰ� �����Ͻðڽ��ϱ�?", "Ȯ��");
		if (vRet != "Y") return false;
		ifrmOtherAccPage.AccSaveNoMsg();
		
		// ���忡 �����ϸ�...
		if (ifrmOtherAccPage.dsSLIP_D.IsUpdated) return false;
	}
	return true;
}

function SetIfrmOtherAccPageAmt()
{
	if(dsMAIN.NameString(1,"ACC_REMAIN_POSITION") == "D") {
		ifrmOtherAccPage.dsSLIP_D.NameString(1,"DB_AMT") = dsMAIN.NameSum("INPUT_AMT",0,0);
		ifrmOtherAccPage.dsSLIP_D.NameString(1,"DB_AMT_D") = C_toNumberFormatString(dsMAIN.NameSum("INPUT_AMT",0,0));
	} else {
		ifrmOtherAccPage.dsSLIP_D.NameString(1,"CR_AMT") = dsMAIN.NameSum("INPUT_AMT",0,0);
		ifrmOtherAccPage.dsSLIP_D.NameString(1,"CR_AMT_D") = C_toNumberFormatString(dsMAIN.NameSum("INPUT_AMT",0,0));
	}
}

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	if(!CheckCompCode()) return;

	G_FocusDataset.ResetStatus();

	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	//D_defaultAdd();
	//dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_COMP_CODE") = txtMAKE_COMP_CODE.value;
	//dsMAIN.NameString(dsMAIN.RowPosition,"COMP_NAME") = txtMAKE_COMP_NAME.value;
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
	//D_defaultSave(dsMAIN);
}

// ���
function btncancel_onclick()
{
	//if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "SLIP_MAKE_DT")
	{
		txtSLIP_MAKE_DT.value = asDate.replace(/-/gi,"");
		if (txtSLIP_MAKE_DT_F.value == txtSLIP_MAKE_DT.value) return;
		txtSLIP_MAKE_SEQ.value = "";
	}
	else if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
	}
	else if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
	}
	else if (asCalendarID == "KEEP_DT")
	{
		txtKEEP_DT.value = asDate;
	}
	else if (asCalendarID == "EXPR_DT_F")
	{
		txtEXPR_DT_F.value = asDate;
	}
	else if (asCalendarID == "EXPR_DT_T")
	{
		txtEXPR_DT_T.value = asDate;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
	if(dataset == dsMAIN)
	{
	}
	else if(dataset == dsNEW_WORK_SLIP)
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

var lockOnColumnChanged = false;

function	OnColumnChanged(dataset, row, colid)
{
	if (dataset == dsMAIN)
	{

		if (colid == "INPUT_AMT")
		{
			if (dsMAIN.NameString(row,"INPUT_AMT") != "0")
			{
				if (parseFloat(dsMAIN.NameString(row,"REMAIN_AMT")) < parseFloat(dsMAIN.NameString(row,"INPUT_AMT")))
				{
					C_msgOk("�ܾ׺��� �����ݾ��� Ŭ �� �����ϴ�");
	
					dsMAIN.NameString(row,"INPUT_AMT") = "0";
					return;
				}
			}
			if(lockOnColumnChanged) return;
			SetIfrmOtherAccPageAmt();
		}
		if (colid == "CHK_CLS")
		{
			if(dsMAIN.NameString(row,"CHK_CLS") == "T" )
			{
				dsMAIN.NameString(row,"INPUT_AMT") = dsMAIN.NameString(row,"REMAIN_AMT");
			}
			else
			{
				dsMAIN.NameString(row,"INPUT_AMT") = "0";
			}
		}
	}
	else if (dataset == dsMAIN01)
	{
		if (colid == "CHK_CLS")
		{
			if (dsMAIN01.NameString(row,"KEEP_CLS") == "T")
			{
				dsMAIN01.NameString(row,"CHK_CLS") = "F";
			}
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsMAIN)
	{
		if(colid == "INPUT_DT_F" || colid == "INPUT_DT_T")
		{
		}
		else if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsMAIN)
	{
	}
}

function OnDuplicateColumn(dataset,grid,row,colid) {
	if(dataset == dsMAIN)
	{
		if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
			if(row>=2) {
				dsMAIN.NameString(row,"TAX_COMP_CODE") = dsMAIN.NameString(row-1,"TAX_COMP_CODE");
				dsMAIN.NameString(row,"TAX_COMP_NAME") = dsMAIN.NameString(row-1,"TAX_COMP_NAME");
			}
		}
	}
}

function OnDblClick(dataset, grid, row, colid) {
	if(dataset.NameString(row,"MAKE_COMP_CODE") == "") return;

	if(dataset == dsMAIN)
	{
		if(colid == 'INPUT_AMT') return;
		
		var pSLIP_ID        = dataset.NameString(row,"SLIP_ID");
		var pSLIP_IDSEQ     = dataset.NameString(row,"SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dataset.NameString(row,"MAKE_COMP_CODE");
		var pMAKE_DT 	     = dataset.NameString(row,"MAKE_DT").replace(/-/gi,"");
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
	else if(dataset == dsMAIN01)
	{
		if(colid == 'CHK_CLS') return;
		
		var pSLIP_ID        = dataset.NameString(row,"SLIP_ID");
		var pSLIP_IDSEQ     = dataset.NameString(row,"SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dataset.NameString(row,"MAKE_COMP_CODE");
		var pMAKE_DT 	     = dataset.NameString(row,"MAKE_DT").replace(/-/gi,"");
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

}

function OnSuccess(dataset, p_Trans) {
	if (p_Trans == trans)
	{
		//txtSLIP_MAKE_SEQ.value = "";
		btnquery_onclick();
	}
	else
	{
	}
}
// �̺�Ʈ����-------------------------------------------------------------------//
function	document_onKeyDown()
{
	if(event.altLeft && event.keyCode == 112)
	{
		//SetDefaultCheckDept();
	}
}

//���ǻ����
function	txtMAKE_COMP_CODE_onChange()
{
	gridMAIN.focus();
	btnquery_onclick();
}

function	CheckCompCode()
{
	if (C_isNull(txtMAKE_COMP_CODE.value))
	{
		C_msgOk("���� ������ڵ带 �����ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}

function txtMAKE_COMP_CODE_onblur()
{
	if (C_isNull(txtMAKE_COMP_CODE.value))
	{
		txtMAKE_COMP_NAME.value = "";
		return;
	}
	
	if (txtMAKE_COMP_CODE.value == '%')
	{
		txtMAKE_COMP_NAME.value = "��ü";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtMAKE_COMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtMAKE_COMP_CODE.value	= lrRet.get("COMP_CODE");
	txtMAKE_COMP_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnMAKE_COMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;

	txtMAKE_COMP_CODE.value	= lrRet.get("COMP_CODE");
	txtMAKE_COMP_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnDT_F_onClick()
{
	C_Calendar("DT_F", "D", txtDT_F.value);
	S_nextFocus(btnDT_F);
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

function btnEXPR_DT_F_onClick()
{
	C_Calendar("EXPR_DT_F", "D", txtEXPR_DT_F.value);
	S_nextFocus(btnEXPR_DT_F);
}

function btnEXPR_DT_T_onClick()
{
	C_Calendar("EXPR_DT_T", "D", txtEXPR_DT_T.value);
	S_nextFocus(btnEXPR_DT_T);
}

//���Ǻμ�
function txtMAKE_DEPT_CODE_onblur()
{
	if (C_isNull(txtMAKE_DEPT_CODE.value))
	{
		txtMAKE_DEPT_CODE.value = '';
		txtMAKE_DEPT_NAME.value = '';
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtMAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtMAKE_DEPT_NAME.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;

	txtMAKE_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtMAKE_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
	//G_Load(dsCLASS_CODE, null);
}

function btnMAKE_DEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtMAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtMAKE_DEPT_NAME.value);

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;

	txtMAKE_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtMAKE_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
	//G_Load(dsCLASS_CODE, null);
}

// �ͼӻ����
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMP_NAME.value = "";
		return;
	}
	
	if (txtCOMP_CODE.value == '%')
	{
		txtCOMP_NAME.value = "��ü";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMP_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMP_NAME.value	= lrRet.get("COMPANY_NAME");

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
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_NAME.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	//G_Load(dsCLASS_CODE, null);
}

function btnDEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_NAME.value);

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	//G_Load(dsCLASS_CODE, null);
}

//�ŷ�ó�ڵ�
function txtCUST_CODE_onblur()
{
	if (C_isNull(txtCUST_CODE.value))
	{
		txtCUST_CODE.value = '';
		txtCUST_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	txtCUST_CODE.value = lrRet.get("CUST_CODE");
	txtCUST_NAME.value = lrRet.get("CUST_NAME");
}

function btnCUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);

	if (C_isNull(txtCUST_CODE.value))
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"T");
	}

	if (lrRet == null) return;

	txtCUST_CODE.value = lrRet.get("CUST_CODE");
	txtCUST_NAME.value = lrRet.get("CUST_NAME");
}

function Input_Clear()
{	
	if (C_isNull(txtSLIP_MAKE_COMP_CODE.value))
	{
		txtSLIP_MAKE_SEQ.value = "";
		txtSLIP_MAKE_COMP_NAME.value = "";
		txtSLIP_MAKE_DEPT_CODE.value = "";
	}

	if (C_isNull(txtSLIP_MAKE_DEPT_CODE.value))
	{
		txtSLIP_MAKE_DEPT_NAME.value = "";
	}
	
}

// ���ǻ����
function btnSLIP_MAKE_COMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("WORK_CODE", vWORK_CODE);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE2", lrArgs,"T");
	
	if (lrRet == null) return;
	txtSLIP_MAKE_COMP_CODE.value	= "";
	Input_Clear();
	txtSLIP_MAKE_COMP_CODE.value	= lrRet.get("COMP_CODE");
	txtSLIP_MAKE_COMP_NAME.value	= lrRet.get("COMPANY_NAME");
	txtSLIP_CHARGE_PERS.value		= lrRet.get("CHARGE_PERS");
	txtSLIP_CHARGE_PERS_NAME.value	= lrRet.get("CHARGE_PERS_NAME");
}

//���Ǻμ�
function btnSLIP_MAKE_DEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtSLIP_MAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtSLIP_MAKE_COMP_CODE.value);

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;
	
	txtSLIP_MAKE_DEPT_CODE.value	= "";
	Input_Clear();

	txtSLIP_MAKE_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtSLIP_MAKE_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
	Input_Clear();
}

//�ⳳ�μ�
function btnSLIP_INOUT_DEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtMAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	//lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");
	lrRet = C_LOV_NEW("T_DEPT_CODE3", btnSLIP_INOUT_DEPT_CODE, lrArgs,"T");

	if (lrRet == null) return;
	
	txtSLIP_INOUT_DEPT_CODE.value	= "";
	Input_Clear();

	txtSLIP_INOUT_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtSLIP_INOUT_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
}

//�������
function btnSLIP_CHARGE_PERS_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtSLIP_MAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtSLIP_CHARGE_PERS.value);

	lrRet = C_LOV("Z_AUTHORITY_USER02", lrArgs,"T");

	if (lrRet == null) return;
	
	txtSLIP_CHARGE_PERS.value	= "";
	Input_Clear();

	txtSLIP_CHARGE_PERS.value	= lrRet.get("EMPNO");
	txtSLIP_CHARGE_PERS_NAME.value	= lrRet.get("NAME");
}



//��������
function txtSLIP_MAKE_DT_onblur()
{
	if (txtSLIP_MAKE_DT_F.value == txtSLIP_MAKE_DT.value) return;

	if (!S_isValidDate(txtSLIP_MAKE_DT.value))
	{
		C_msgOk(ERR_MSG);
		txtSLIP_MAKE_DT.focus();
		return;
	}
	
	txtSLIP_MAKE_SEQ.value = "";
}

function btnSLIP_MAKE_DT_onClick()
{
	txtSLIP_MAKE_DT_F.value = txtSLIP_MAKE_DT.value;
	
	C_Calendar("SLIP_MAKE_DT", "D", txtSLIP_MAKE_DT.value);
}

//����������
function txtSLIP_ACC_CODE_onblur()
{
	if (C_isNull(txtSLIP_ACC_CODE.value))
	{
		txtSLIP_ACC_CODE.value = '';
		txtSLIP_ACC_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtSLIP_ACC_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	txtSLIP_ACC_CODE.value = lrRet.get("ACC_CODE");
	txtSLIP_ACC_NAME.value = lrRet.get("ACC_NAME");
}

function btnSLIP_ACC_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtSLIP_ACC_CODE.value);

	if (C_isNull(txtSLIP_ACC_CODE.value))
	{
		lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_ACC_CODE1", lrArgs,"T");
	}
	
	if (lrRet == null) return;

	txtSLIP_ACC_CODE.value = lrRet.get("ACC_CODE");
	txtSLIP_ACC_NAME.value = lrRet.get("ACC_NAME");
}

// �����ڵ�
function txtSLIP_BANK_CODE_onblur()
{
	if (txtSLIP_BANK_CODE_F.value == txtSLIP_BANK_CODE.value) return;
	
	if (C_isNull(txtSLIP_BANK_CODE.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtSLIP_BANK_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_BANK_CODE1", lrArgs,"T");

	if (lrRet == null) {
		txtSLIP_BANK_CODE.value = txtSLIP_BANK_CODE_F.value;
		return;
	}

	if (txtSLIP_BANK_CODE_F.value == lrRet.get("BANK_CODE"))
	{
		return;
	}
	
	txtSLIP_BANK_CODE.value	= "";
	Input_Clear();
		
	txtSLIP_BANK_CODE.value	= lrRet.get("BANK_CODE");
	txtSLIP_BANK_NAME.value	= lrRet.get("BANK_NAME");
}

function btnSLIP_BANK_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_BANK_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	if (txtSLIP_BANK_CODE.value == lrRet.get("BANK_CODE"))
	{
		return;
	}
	txtSLIP_BANK_CODE.value	= "";
	Input_Clear();

	txtSLIP_BANK_CODE.value	= lrRet.get("BANK_CODE");
	txtSLIP_BANK_NAME.value	= lrRet.get("BANK_NAME");
}

//���¹�ȣ
function txtSLIP_ACCNO_onblur()
{
	if (txtSLIP_ACCNO_F.value == txtSLIP_ACCNO.value) return;
	
	if (C_isNull(txtSLIP_ACCNO.value))
	{
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null; 

	lrArgs.set("COMP_CODE", txtSLIP_MAKE_COMP_CODE.value);
	lrArgs.set("BANK_CODE", txtSLIP_BANK_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtSLIP_ACCNO.value);
	
	lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	if (C_isNull(txtSLIP_BANK_CODE.value))
	{
		txtSLIP_BANK_CODE.value	= lrRet.get("BANK_CODE");
		txtSLIP_BANK_NAME.value	= lrRet.get("BANK_NAME");
	}
	
	txtSLIP_ACCNO.value		= lrRet.get("ACCNO");
}

function btnSLIP_ACCNO_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtSLIP_MAKE_COMP_CODE.value);
	lrArgs.set("BANK_CODE", txtSLIP_BANK_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_ACCNO_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	if (C_isNull(txtSLIP_BANK_CODE.value))
	{
		txtSLIP_BANK_CODE.value	= lrRet.get("BANK_CODE");
		txtSLIP_BANK_NAME.value	= lrRet.get("BANK_NAME");
	}

	txtSLIP_ACCNO.value		= lrRet.get("ACCNO");
}

// ��ü����
function btnAllSelect_onClick()
{
	lockOnColumnChanged = true;
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		dsMAIN.NameString(i,"INPUT_AMT") = dsMAIN.NameString(i,"REMAIN_AMT");
		dsMAIN.NameString(i,"CHK_CLS") = "T";
	}
	lockOnColumnChanged = false;
	if(dsMAIN.CountRow == 0) return;
	
	SetIfrmOtherAccPageAmt();
}
function	btnSubSelect_onClick()
{
	lockOnColumnChanged = true;
	try
	{
		var		lsPAY_CON_BILL_DT = dsMAIN.nameString(dsMAIN.RowPosition,"PAY_CON_BILL_DT");
		for( var i = dsMAIN.RowPosition ;  i <= dsMAIN.CountRow ; ++ i)
		{
			var		lsPAY_CON_BILL_DT_Tmp = dsMAIN.nameString(i,"PAY_CON_BILL_DT");
			if(lsPAY_CON_BILL_DT != lsPAY_CON_BILL_DT_Tmp) break;
			dsMAIN.NameString(i,"INPUT_AMT") = dsMAIN.NameString(i,"REMAIN_AMT");
			dsMAIN.NameString(i,"CHK_CLS") = "T";
		}
	}
	catch(e)
	{
	}
	lockOnColumnChanged = false;
	SetIfrmOtherAccPageAmt();
}
// ��ü�������
function btnAllSelCancle_onClick()
{
	lockOnColumnChanged = true;
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		dsMAIN.NameString(i,"INPUT_AMT") = "0";
		dsMAIN.NameString(i,"CHK_CLS") = "F";
	}
	lockOnColumnChanged = false;
	if(dsMAIN.CountRow == 0) return;
	SetIfrmOtherAccPageAmt();
}

function LPad(strNum, nSize) {
	if(strNum.length>nSize) return strNum;
	
	var idx = 0;
	var nPad = nSize - (strNum.length);
	
	for(idx=0;idx<nPad;idx++) {
		strNum = "0"+strNum;
	}
	return strNum;
}

// ������ǥ����
function	btnSlipCreate_onClick()
{
	if(!isAccUpdated()) return;

	
	if(!chkDayClose(true)) return;
	
	if (txtSLIP_MAKE_DT.value == "")
	{
		C_msgOk("�ۼ����ڸ� �Է��Ͽ� �ֽʽÿ�.");
		txtSLIP_MAKE_DT.focus();
		return;
	}

	if (cboSLIP_KIND_TAG.value == "")
	{
		C_msgOk("��ǥ������ �Է��Ͽ� �ֽʽÿ�.");
		return;
	}

	if (txtSLIP_MAKE_COMP_CODE.value == "")
	{
		C_msgOk("����� �Է��Ͽ� �ֽʽÿ�.");
		return;
	}
	
	if (C_isNull(txtSLIP_MAKE_DEPT_CODE.value || txtSLIP_MAKE_DEPT_NAME.value))
	{
		C_msgOk("�ۼ��μ��� �Է��Ͽ� �ֽʽÿ�.");
		return;
	}
	
	if (C_isNull(txtSLIP_CHARGE_PERS.value || txtSLIP_CHARGE_PERS_NAME.value))
	{
		C_msgOk("��������� �Էµ��� �ʾҽ��ϴ�.<BR>*[��������>�ڵ���ǥ�ڵ�]���� �ڵ���ǥ�� ����� ��������� ��ϵƴ��� Ȯ�����ֽñ� �ٶ��ϴ�.");
		return;
	}
	
	if (C_isNull(txtSLIP_INOUT_DEPT_CODE.value || txtSLIP_INOUT_DEPT_NAME.value))
	{
		C_msgOk("�ⳳ�μ��� �Է��Ͽ� �ֽʽÿ�.");
		return;
	}
	/*
	if (C_isNull(txtSLIP_ACC_CODE.value || txtSLIP_ACC_NAME.value))
	{
		C_msgOk("�������� �Է��Ͽ� �ֽʽÿ�.");
		return;
	}
	if (txtSLIP_BANK_CODE.value == "")
	{
		C_msgOk("�����ڵ带 �Է��Ͽ� �ֽʽÿ�.");
		return;
	}
	if (txtSLIP_BANK_CODE.value != "" && txtSLIP_ACCNO.value == "")
	{
		C_msgOk("���¹�ȣ�� �Է��Ͽ� �ֽʽÿ�.");
		return;
	}
	*/
	
	var	strAMT_TAG = 0;
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		if (dsMAIN.NameString(i,"INPUT_AMT") != "0")
		{
			strAMT_TAG++;
		}
	}
	
	if (strAMT_TAG == 0)
	{
		C_msgOk("�����ݾ��� �Էµ� �׸��� �����ϴ�.");
		return;
	}
	G_Load(dsAUTO_REMAIN_RESET_SEQ, null);

	btnSLIP_MAKE_SLIPNO_onClick()
	
	trans.Parameters = "";
	trans.Parameters += "ACT=AUTO_REMAIN_RESET";
	trans.Parameters += ",AUTO_REMAIN_RESET_SEQ="+dsAUTO_REMAIN_RESET_SEQ.NameString(1,"AUTO_REMAIN_RESET_SEQ");
	trans.Parameters += ",SLIP_MAKE_SLIP_NO="+txtSLIP_MAKE_DT.value.substring(2) + cboSLIP_KIND_TAG.value + '' + txtSLIP_MAKE_COMP_CODE.value + '' + LPad(txtSLIP_MAKE_SEQ.value,4);	
	trans.Parameters += ",SLIP_MAKE_DT="+txtSLIP_MAKE_DT.value;
	trans.Parameters += ",SLIP_MAKE_SEQ="+LPad(txtSLIP_MAKE_SEQ.value,4);
	trans.Parameters += ",SLIP_KIND_TAG="+cboSLIP_KIND_TAG.value;
	trans.Parameters += ",SLIP_MAKE_COMP_CODE="+txtSLIP_MAKE_COMP_CODE.value;
	trans.Parameters += ",SLIP_MAKE_DEPT_CODE="+txtSLIP_MAKE_DEPT_CODE.value;
	trans.Parameters += ",SLIP_CHARGE_PERS="+txtSLIP_CHARGE_PERS.value;
	trans.Parameters += ",SLIP_INOUT_DEPT_CODE="+txtSLIP_INOUT_DEPT_CODE.value;
	trans.Parameters += ",WORK_SLIP_ID="+vWORK_SLIP_ID;
	trans.Parameters += ",WORK_SLIP_IDSEQ="+vWORK_SLIP_IDSEQ;
	
	//alert(trans.Parameters);
	
	G_saveDataMsg(dsMAIN);
	/*
	btnRetrieve_onClick();
	
	txtBANK_CODE.value = "";
	txtBANK_NAME.value = "";
	txtACCNO.value = "";
	txtSLIP_ID.value = "";
	*/
}

// ������ǥ����
function	btnSlipDelete_onClick()
{
	
	if(!chkDayClose(true)) return;
	
	var	strAMT_TAG = 0;
	for(i=1;i<=dsMAIN01.CountRow;i++)
	{
		if (dsMAIN01.NameString(i,"CHK_CLS") == "T")
		{
			strAMT_TAG++;
		}
	}
	
	if (strAMT_TAG == 0)
	{
		C_msgOk("���õ� ������ǥ�� �����ϴ�.");
		return;
	}
	
	trans.Parameters = "";
	trans.Parameters += "ACT=DELETE_REMAIN_RESET";
	
	//alert(trans.Parameters);
	
	G_saveDataMsg(dsMAIN01);
	/*
	btnRetrieve_onClick();
	
	txtBANK_CODE.value = "";
	txtBANK_NAME.value = "";
	txtACCNO.value = "";
	txtSLIP_ID.value = "";
	*/
}

//ȸ�⸶��
function chkDayClose(bMsgView)
{
	//var vMsg = "( ��ǥ��ȣ : "+dsMAIN.NameString(row,"MAKE_SLIPNO") + " )";
	var vMsg = "";
	vMAKE_COMP_CODE = txtSLIP_MAKE_COMP_CODE.value;
	vMAKE_DEPT_CODE = txtSLIP_MAKE_DEPT_CODE.value;
	vMAKE_DT_TRANS  = txtSLIP_MAKE_DT.value;
	G_Load(dsDAY_CLOSE, null);
	if(dsDAY_CLOSE.CountRow==0) {
		if(bMsgView) C_msgOk("�ش������� ����庰 ���������� ��ϵ��� �ʾҽ��ϴ�.<BR>"+vMsg, "Ȯ��");
		vAccClse = false;
		vMonClse = false;
		vDayClse = false;
		vDeptClse = false;
		return false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "ACC_CLSE_CLS") == "T")
	{
		if(bMsgView) C_msgOk("�ش����ڴ� ȸ�⸶���Ǿ����ϴ�.<BR>"+vMsg, "Ȯ��");
		vAccClse = true;
		return false;
	} else {
		vAccClse = false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "MON_CLSE_CLS") == "T")
	{
		if(bMsgView) C_msgOk("�ش����ڴ� �������Ǿ����ϴ�.<BR>"+vMsg, "Ȯ��");
		vMonClse = true;
		return false;
	} else {
		vMonClse = false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "DAY_CLSE_CLS") == "T")
	{
		if(bMsgView) C_msgOk("�ش����ڴ� �ϸ����Ǿ����ϴ�.<BR>"+vMsg, "Ȯ��");
		vDayClse = true;
		return false;
	} else {
		vDayClse = false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "DEPT_CLSE_CLS") == "T")
	{		
		if(bMsgView) C_msgOk(txtMAKE_DEPT_NAME.value+"�� ��ǥ�Է±Ⱓ�� ����Ǿ����ϴ�.<BR>"+vMsg+"<BR>* ��ǥ�Է°��ɱⰣ : ("+dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "INPUT_DT")+")", "Ȯ��");
		vDeptClse = true;
		return false;
	} else {
		vDeptClse = false;
	}
	
	return true;
}

function btnSLIP_MAKE_SLIPNO_onClick() {
	G_Load(dsMAKE_SEQ, null);
	txtSLIP_MAKE_SEQ.value = LPad(dsMAKE_SEQ.NameString(dsMAKE_SEQ.RowPosition, "MAKE_SEQ"),4);
}

// ��ü����
function btnAllSelect_onClick01()
{
	for(i=1;i<=dsMAIN01.CountRow;i++)
	{
		if(dsMAIN01.NameString(i,"KEEP_CLS") != "T") dsMAIN01.NameString(i,"CHK_CLS") = "T";
	}
}

// ��ü�������
function btnAllSelCancle_onClick01()
{
	for(i=1;i<=dsMAIN01.CountRow;i++)
	{
		if(dsMAIN01.NameString(i,"KEEP_CLS") != "T") dsMAIN01.NameString(i,"CHK_CLS") = "F";
	}
}