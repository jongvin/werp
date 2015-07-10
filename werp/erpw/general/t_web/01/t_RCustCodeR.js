/**************************************************************************/
/* 1. �� �� �� �� id : t_WCustCodeR.js(�ŷ�ó�ڵ�)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-15)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

var opnrArgs = window.dialogArguments;

function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "�ŷ�ó�ڵ�");
	G_addDataSet(dsCUST_SEQ, null, null, null, "�ŷ�ó����");
	G_addDataSet(dsCUST_CODE, null, null, null, "�ŷ�ó�ڵ�");
	G_addDataSet(dsLOV, null, null, null, "LOV");

	if(opnrArgs.get("CUST_CODE")!="") {
		txtCUST_NAME_S.value = opnrArgs.get("CUST_CODE");
		gridMAIN.Focus();
		btnquery_onclick(); 
	} else {
		txtCUST_NAME_S.value = "�����̰���������";
		gridMAIN.Focus();
		btnquery_onclick(); 
		txtCUST_NAME_S.value = "";
	}
	gridMAIN.Focus();

	if (sSlip_Trans_Cls != "T") {
		document.all.btnDELETE.style.display = "none";
	}
}

function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("TRADE_CLS",cboTRADE_CLS.value)
											+ D_P2("CUST_NAME",txtCUST_NAME_S.value.replace(/-/g, ""));
	}
	else if(dataset == dsCUST_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CUST_SEQ");
	}
	else if(dataset == dsCUST_CODE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CUST_CODE")
											+ D_P2("CUST_NAME",txtCUST_CODE.value.replace(/-/gi,""));
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
	if(txtCUST_NAME_S.value.length<2) {
		C_msgOk("�˻������� 2�����̻� �Է��ϼ���.", "Ȯ��");
		return;
	}
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
	if ((G_FocusDataset == dsCUST_ACCNO) && (dsCUST_ACCNO.NameString(dsCUST_ACCNO.Rowposition,"SEQ") == "0"))
	{
		dsCUST_ACCNO.NameString(dsCUST_ACCNO.Rowposition,"SEQ") = parseInt(dsCUST_ACCNO.NameMax("SEQ",0,0))+1;
	}
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
	if ((G_FocusDataset == dsCUST_ACCNO) && (dsCUST_ACCNO.NameString(dsCUST_ACCNO.Rowposition,"SEQ") == "0"))
	{
		dsCUST_ACCNO.NameString(dsCUST_ACCNO.Rowposition,"SEQ") = parseInt(dsCUST_ACCNO.NameMax("SEQ",0,0))+1;
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
		txtTRADE_CLS.value = cboTRADE_CLS.value;
		G_Load(dsCUST_SEQ, null);
		dsMAIN.NameValue(dsMAIN.RowPosition, "CUST_SEQ") = dsCUST_SEQ.NameValue(dsCUST_SEQ.RowPosition, "CUST_SEQ");
		dsMAIN.NameValue(dsMAIN.RowPosition, "GROUP_COMP_CLS") = "F";
		dsMAIN.NameValue(dsMAIN.RowPosition, "USE_CLS") = "T";
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

function OnDblClick(dataset, grid, row, colid){
	if (dataset == dsMAIN)
	{
		btnselect_onclick();
	}
}

function document_onKeyDown(){
	if(event.keyCode==68) {
		C_msgError(G_FocusDataset.ExportData(1, G_FocusDataset.CountRow, true),"Ȯ��")
	}
	else if(event.keyCode==13) {
		if(gridMAIN.FocusState) {
			btnselect_onclick();
		} else if(event.srcElement.id == "txtCUST_NAME_S") {
			btnquery_onclick();
		}
	}
	else if(event.keyCode==27) {
		btnCANCEL_onclick();
	}
	else if (event.ctrlLeft == true && event.shiftLeft == true && event.keyCode == 83)
	{

	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
function txtCUST_CODE_onBlur()
{
	if (dsMAIN.CountRow == 0)
	{
		C_msgOk("���� �߰��� �����ϰ� �Է��ϼž� �մϴ�..", "Ȯ��");
		return;
	}

	if(C_isNull(txtCUST_CODE.value))
	{
		txtCUST_NAME.value = "";
		return;
	}
	
	if (txtCUST_CODE_F.value == txtCUST_CODE.value) return;
	
	G_Load(dsCUST_CODE, null)
	
	if (dsCUST_CODE.CountRow != 0)
	{
		if(C_msgYesNo("�Է��Ͻ� �ŷ�ó�ڵ�� ���� �ŷ�ó�ڵ尡 �̹� �����մϴ�.<br><br>�׷��� ����Ͻðڽ��ϱ�?","Ȯ��") == "N")
		{
			return;
		}
	}
	
	var vCUST_CODE = txtCUST_CODE.value.replace(/-/g, "");
	
	if (txtTRADE_CLS.value == '1')
	{
		if (!C_isValidCustNo(txtCUST_CODE.value))
		{
			C_msgOk(ERR_MSG);
			txtCUST_CODE.focus();
			txtCUST_CODE.value = "";
			return;
		}
		txtCUST_CODE.value = vCUST_CODE.substr(0, 3) + "-" + vCUST_CODE.substr(3, 2) + "-" + vCUST_CODE.substr(5, 5);
	}
	else if (txtTRADE_CLS.value == '2')
	{
		if (!C_isValidRegNo(txtCUST_CODE.value))
		{
			C_msgOk(ERR_MSG);
			txtCUST_CODE.focus();
			txtCUST_CODE.value = "";
			return;
		}
		txtCUST_CODE.value = vCUST_CODE.substr(0, 6) + "-" + vCUST_CODE.substr(6, 7);
	}
	
	if (C_isNull(txtREPRESENT_CUST_CODE.value))
	{
		txtREPRESENT_CUST_SEQ.value		= txtCUST_SEQ.value;
		txtREPRESENT_CUST_CODE.value	= txtCUST_CODE.value;
		txtREPRESENT_CUST_NAME.value	= txtCUST_NAME.value;
	}
}

function txtCUST_NAME_onBlur()
{
	if (txtCUST_NAME_F.value == txtCUST_NAME.value) return;
	
	if (C_isNull(txtREPRESENT_CUST_NAME.value))
	{
		txtREPRESENT_CUST_SEQ.value		= txtCUST_SEQ.value;
		txtREPRESENT_CUST_CODE.value	= txtCUST_CODE.value;
		txtREPRESENT_CUST_NAME.value	= txtCUST_NAME.value;
	}
}

function txtZIPCODE_onBlur()
{
	if(C_isNull(txtZIPCODE.value))
	{
		txtADDR1.value = "";
		return;
	}
	
	if (txtZIPCODE_F.value == txtZIPCODE.value) return;
	
	var lrArgs = new C_Dictionary();
	lrArgs.set("SEARCH_CONDITION", txtZIPCODE.value);

	var		lrRet = C_AutoLov(dsLOV,"T_ZIP_CODE",lrArgs, "T");

	if (lrRet == null) return;

	txtZIPCODE.value	= lrRet.get("MASKED_ZIPCODE");
	txtADDR1.value		= lrRet.get("AREA_NAME");
	txtADDR2.focus();
}

function btnZIPCODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtZIPCODE.value);

	lrRet = C_LOV("T_ZIP_CODE", lrArgs,"F");
	
	if (lrRet == null) return;

	txtZIPCODE.value	= lrRet.get("MASKED_ZIPCODE");
	txtADDR1.value		= lrRet.get("AREA_NAME");
	txtADDR2.focus();
}

function btnREPRESENT_CUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtREPRESENT_CUST_CODE.value);

	lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtREPRESENT_CUST_SEQ.value		= lrRet.get("CUST_SEQ");
	txtREPRESENT_CUST_CODE.value	= lrRet.get("CUST_CODE");
	txtREPRESENT_CUST_NAME.value	= lrRet.get("CUST_NAME");
	cboTRADE_CLS.focus();
}

function	btnCANCEL_onclick()
{
	window.close();
}
function btnselect_onclick()
{
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		C_msgOk("���� �ŷ�ó �������Դϴ�.<br>�����ϰ� �����ϼ���.", "Ȯ��");
		return;
	}
	
	var selIndex = dsMAIN.RowPosition;
	if(selIndex <= 0)
	{
		C_msgOk("������ �׸��� �����ϴ�. �ŷ�ó�� �����Ͽ� �ֽʽÿ�.", "Ȯ��");
		return;
	}
	
	var obj = new Object();

	obj.CUST_SEQ = dsMAIN.NameString(dsMAIN.RowPosition, "CUST_SEQ");
	obj.CUST_CODE = dsMAIN.NameString(dsMAIN.RowPosition, "CUST_CODE");
	obj.CUST_NAME = dsMAIN.NameString(dsMAIN.RowPosition, "CUST_NAME");
	
	window.returnValue = obj;
	window.close();
}