/**************************************************************************/
/* 1. �� �� �� �� id : t_WBudgDeptMapR(�����û)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-30)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�μ����");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	
	//G_setReadOnlyCol(gridMAIN,"DEPT_CODE");
	//G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	
	G_setLovCol(gridMAIN,"TAX_COMP_CODE");
	G_setLovCol(gridMAIN,"TAX_COMP_NAME");
	
	//G_setReadOnlyCol(gridMAIN,"CLSE_ACC_ID");
	//G_setReadOnlyCol(gridMAIN,"ACC_ID");
	
	G_setLovCol(gridMAIN,"INPUT_DT_F");
	G_setLovCol(gridMAIN,"INPUT_DT_T");

	gridMAIN.focus();
}

function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("DT_F",txtDT_F.value.replace(/-/gi,""))
											+ D_P2("DT_T",txtDT_T.value.replace(/-/gi,""))
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("DEPT_CODE",txtDEPT_CODE.value)
											+ D_P2("CUST_CODE",txtCUST_CODE.value.replace(/-/gi,""))
											+ D_P2("ACC_CODE",txtACC_CODE.value);
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
function setChildClear(dataset,row) {
	var vACC_LVL = dataset.NameString(row,"ACC_LVL");
	var vACC_CODE = dataset.NameString(row,"ACC_CODE");

	var vSize = 0;

	if(vACC_LVL == "1") vSize = 1;
	else if(vACC_LVL == "2") vSize = 2;
	else if(vACC_LVL == "3") vSize = 3;
	else if(vACC_LVL == "4") vSize = 5;
	else if(vACC_LVL == "5") vSize = 7;
	else if(vACC_LVL == "6") vSize = 9;

	var vGrpAcc = vACC_CODE.substring(0,vSize);

	var vSubAcc = "";
	var i = 0;
	for(i=row+1;i<=dataset.CountRow;i++) {
		vSubAcc = dataset.NameString(i,"ACC_CODE").substring(0,vSize);
		if(vGrpAcc!=vSubAcc) return;
		dsMAIN.NameString(i,"CHK_CLS") = "F";
	}
}

function setParentClear(dataset,row) {
	var vCOMPUTER_ACC = dataset.NameString(row,"COMPUTER_ACC")
	var vIdx= dataset.NameValueRow("ACC_CODE", vCOMPUTER_ACC);
	if(vIdx == 0) return;

	var vACC_LVL = dataset.NameString(vIdx,"ACC_LVL");
	var vACC_CODE = dataset.NameString(vIdx,"ACC_CODE");

	//var vIdx= dataset.NameValueRow("COMPUTER_ACC", vACC_CODE);

	var vSize = 0;
	
	if(vACC_LVL == "1") vSize = 1;
	else if(vACC_LVL == "2") vSize = 2;
	else if(vACC_LVL == "3") vSize = 3;
	else if(vACC_LVL == "4") vSize = 5;
	else if(vACC_LVL == "5") vSize = 7;
	else if(vACC_LVL == "6") vSize = 9;

	var vGrpAcc = vACC_CODE.substring(0,vSize);
	var vSubAcc = "";
	var i = 0;
	for(i=vIdx+1;i<=dataset.CountRow;i++) {
		vSubAcc = dataset.NameString(i,"ACC_CODE").substring(0,vSize);
		if(vGrpAcc!=vSubAcc) break;
		if( dsMAIN.NameString(i,"CHK_CLS") == "T") return;
	}

	dsMAIN.NameString(vIdx,"CHK_CLS") = "F";
	setParentClear(dataset,vIdx);
}

function setChildCheck(dataset,row) {
	var vACC_LVL = dataset.NameString(row,"ACC_LVL");
	var vACC_CODE = dataset.NameString(row,"ACC_CODE");

	var vSize = 0;

	if(vACC_LVL == "1") vSize = 1;
	else if(vACC_LVL == "2") vSize = 2;
	else if(vACC_LVL == "3") vSize = 3;
	else if(vACC_LVL == "4") vSize = 5;
	else if(vACC_LVL == "5") vSize = 7;
	else if(vACC_LVL == "6") vSize = 9;

	var vGrpAcc = vACC_CODE.substring(0,vSize);

	var vSubAcc = "";
	var i = 0;
	for(i=row+1;i<=dataset.CountRow;i++) {
		vSubAcc = dataset.NameString(i,"ACC_CODE").substring(0,vSize);
		if(vGrpAcc!=vSubAcc) return;
		dsMAIN.NameString(i,"CHK_CLS") = "T";
	}
}

function setParentCheck(dataset,row) {
	var vCOMPUTER_ACC = dataset.NameString(row,"COMPUTER_ACC")
	var vIdx= dataset.NameValueRow("ACC_CODE", vCOMPUTER_ACC);
	if(vIdx == 0) return;

	dsMAIN.NameString(vIdx,"CHK_CLS") = "T";
	setParentCheck(dataset,vIdx);
}

//�˻�����üũ
function print_condition_check()
{
	if(dsMAIN.CountRow == 0)
	{
   		C_msgOk("����� ����� �����ϴ�.");
   		return false;
   	}
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		// ���õ� �׸��� ������
	} else {
		C_msgOk("���õ� �׸��� �����ϴ�.");
		return false;
	}
	return true;
}
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
//�μ�
function btnquery_prt_onclick()
{
	// ���α׷��� ��ȿ���˻� �߰�
				
	// ���� Check
	//if (!checkCommon()) return;
	if(!print_condition_check()) return;

	G_saveData(dsMAIN);

	btnAllSelCancle_onClick();
	dsMAIN.ResetStatus();
	//btnquery_onclick();

	var vCompCode  = txtCOMP_CODE.value;
	var vCompName  = txtCOMPANY_NAME.value;
	var vDeptCode  = (txtDEPT_CODE.value=="")?"%":txtDEPT_CODE.value;
	var vDeptName  = (txtDEPT_NAME.value=="")?"��ü":txtDEPT_NAME.value;
	var vCustCode  = (txtCUST_CODE.value=="")?"%":txtCUST_CODE.value;
	var vCustName  = (txtCUST_NAME.value=="")?"��ü":txtCUST_NAME.value;
   	var vDT_F   = txtDT_F.value;
   	var vDT_T   = txtDT_T.value;
   
	// ���� ���丮
   	var reportFile = sReportName;
   	
	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	// ���α׷��� �Ķ���� �߰�
	// �Ķ����1__��1&&�Ķ����2__��2&&....
	// ����
	//strTemp += "ProjCode__" + strProjCode + "&&";
	//strTemp += "ConsultSeq__" + strConsultSeq;

	strTemp += "pCOMP_CODE__" + vCompCode;
	strTemp += "&&pCOMP_NAME__" + vCompName;
	strTemp += "&&pDEPT_CODE__" + vDeptCode;
	strTemp += "&&pDEPT_NAME__" + vDeptName;
	strTemp += "&&pCUST_CODE__" + vCustCode.replace(/-/gi,"");
	strTemp += "&&pCUST_NAME__" + vCustName;
	strTemp  += "&&pDT_T__" + vDT_T.replace(/-/gi,"");
	strTemp += "&&pDT_F__" + vDT_F.replace(/-/gi,"");

	
	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}

// ��ȸ
function btnquery_onclick()
{
	dsMAIN.ResetStatus();
	if(!CheckCompCode()) return;
	D_defaultLoad();
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
	//D_defaultSave(dsMAIN);
}

// ���
function btncancel_onclick()
{
	//if (G_FocusObject != null) G_FocusObject.focus();
}

// ��ü����
function btnAllSelect_onClick()
{
	lockOnColumnChanged = true;
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		dsMAIN.NameString(i,"CHK_CLS") = "T";
	}
	lockOnColumnChanged = false;
	if(dsMAIN.CountRow == 0) return;
}

// ��ü�������
function btnAllSelCancle_onClick()
{
	lockOnColumnChanged = true;
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		dsMAIN.NameString(i,"CHK_CLS") = "F";
	}
	lockOnColumnChanged = false;
	if(dsMAIN.CountRow == 0) return;
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
	}
	else if (asCalendarID == "DT_T")
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

var lockOnColumnChanged = false;

function OnColumnChanged(dataset, row, colid)
{
	if( lockOnColumnChanged == true) return;
	if(dataset == dsMAIN)
	{
		if(colid == "CHK_CLS")
		{
			lockOnColumnChanged = true;
			if(dataset.NameString(row,"CHK_CLS") == "F")
			{
				// ���� ����>���� ���� Ŭ����
				setChildClear(dataset,row);
				setParentClear(dataset,row);
			} else {
				// ���� ����>���� ���� �V
				setChildCheck(dataset,row);
				setParentCheck(dataset,row);
			}
			lockOnColumnChanged = false;
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
	if(dataset == dsMAIN)
	{
		if(dataset.NameString(row,"CHK_CLS") == "F")
		{
			dsMAIN.NameString(row,"CHK_CLS") = "T";
		} else {
			dsMAIN.NameString(row,"CHK_CLS") = "F";
		}
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
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

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
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

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

//��������
function txtACC_CODE_onblur()
{
	if (C_isNull(txtACC_CODE.value))
	{
		txtACC_CODE.value = '';
		txtACC_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE_ALL", lrArgs,"T");

	if (lrRet == null) return;

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
}

function btnACC_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);

	if (C_isNull(txtACC_CODE.value))
	{
		lrRet = C_LOV("T_ACC_CODE_ALL", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_ACC_CODE_ALL", lrArgs,"T");
	}
	
	if (lrRet == null) return;

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
}