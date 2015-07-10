/**************************************************************************/
/* 1. �� �� �� �� id : t_WFNpAmtGapViewR.jsp(���ݰ�꼭�̹�����Ȳ)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-05-15)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "���ݰ�꼭�̹�����Ȳ");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");

	txtCOMP_CODE.value    = sCompCode;
	txtCOMPANY_NAME.value = sCompName;


	
	G_setReadOnlyCol(gridMAIN,"MAKE_SLIPNO");
	G_setReadOnlyCol(gridMAIN,"NP_ITR_AMT");
	
	gridMAIN.focus();
	
	//G_Load(dsMAIN, null);
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		var			strYm02 = txtYM_T.value.replace(/-/g,"");
		var			strYm01 = addMonthsToYm(txtYM_T.value,-1).replace(/-/g,"");
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										+ D_P2("WORK_YM_TO",txtYM_T.value.replace(/-/g,""))
										+ D_P2("WORK_YM_01",strYm01)
										+ D_P2("WORK_YM_02",strYm02)
										+ D_P2("BASE_AMT",cboAmtUnit.value)
										+ D_P2("COMP_CODE",txtCOMP_CODE.value)
										+ D_P2("RECEIVE_TAG",txtRECEIVE_TAG.value)
										+ D_P2("DEPT_CODE",txtDEPT_CODE.value);
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
function	convYmToYmNumber(arYm)
{
	var			lsYearMonth = arYm.replace(/-/g,"");
	return (C_convSafeInt(lsYearMonth.substring(0,4)) * 12) + C_convSafeInt(lsYearMonth.substring(5,7));
}
function	convYmNumberToYm(arYmNumber)
{
	var		liYear = C_Floor(arYmNumber / 12,0);
	var		liMonth = arYmNumber - (liYear* 12);
	if(liMonth == 0)
	{
		liMonth = 12;
		liYear --;
	}
	return C_LPad(liYear.toString(),4,'0')+'-'+C_LPad(liMonth.toString(),2,'0');
}
function	addMonthsToYm(arYm,arMonths)
{
	return convYmNumberToYm(convYmToYmNumber(arYm) + arMonths);
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
function	CalcSumUp()
{
}

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
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
}

// ����
function btninsert_onclick()
{
}

// ����
function btndelete_onclick()
{
}

// ����
function btnsave_onclick()
{
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}
//�μ�
function btnquery_prt_onclick()
{
	// ���α׷��� ��ȿ���˻� �߰�
				
	// ���� Check
	var	vReceiveTag = "";
	var	vDeptCode = "";
	var reportFile ="";
	
	reportFile ="r_t_041029";  
	
	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	var			strYm02 = txtYM_T.value.replace(/-/g,"");
	var			strYm01 = addMonthsToYm(txtYM_T.value,-1).replace(/-/g,"");
	
	if(C_isNull(txtRECEIVE_TAG.value))
	{
		vReceiveTag = "%";
	}
	else
	{
		vReceiveTag = txtRECEIVE_TAG.value;
	}
	if(C_isNull(txtDEPT_CODE.value))
	{
		vDeptCode = "%";
	}
	else
	{
		vDeptCode = txtDEPT_CODE.value;
	}

	strTemp += "COMP_CODE__" + txtCOMP_CODE.value;
	strTemp += "&&RECEIVE_TAG__" + vReceiveTag;
	strTemp += "&&DEPT_CODE__" + vDeptCode;
	strTemp += "&&WORK_YM_TO__" + txtYM_T.value.replace(/-/g,"");
	strTemp += "&&WORK_YM_01__" + strYm01;
	strTemp += "&&WORK_YM_02__" + strYm02;
	strTemp += "&&BASE_AMT__" + cboAmtUnit.value;

	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "YM_T")
	{
		txtYM_T.value = asDate;
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
}

function OnRowDeleteBefore(dataset)
{
	return false;
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
function	OnDuplicateColumn(dataset,grid,row,colid)
{
}

// �̺�Ʈ����-------------------------------------------------------------------//

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

	if (lrRet == null) return;
	txtDEPT_CODE.value = "";
	txtDEPT_NAME.value = "";
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
}
function	txtRECEIVE_TAG_onblur()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	if(C_isNull(txtRECEIVE_TAG.value))
	{
		txtRECEIVE_TAG_NAME.value = "";
		return;
	}

	lrArgs.set("SEARCH_CONDITION", txtRECEIVE_TAG.value);

	lrRet = C_AutoLov(dsLOV,"T_RECEIVE_TAG", lrArgs,"T");

	if (lrRet == null) return;

	txtRECEIVE_TAG.value	= lrRet.get("CODE");
	txtRECEIVE_TAG_NAME.value	= lrRet.get("NAME");

	txtDEPT_CODE.value = "";
	txtDEPT_NAME.value = "";
}
function	btnRECEIVE_TAG_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_RECEIVE_TAG", lrArgs,"T");

	if (lrRet == null) return;

	txtRECEIVE_TAG.value	= lrRet.get("CODE");
	txtRECEIVE_TAG_NAME.value	= lrRet.get("NAME");

	txtDEPT_CODE.value = "";
	txtDEPT_NAME.value = "";
}
function txtDEPT_CODE_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("RECEIVE_TAG", txtRECEIVE_TAG.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE_PROJ01", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
}
function btnDEPT_CODE_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("RECEIVE_TAG", txtRECEIVE_TAG.value);

	lrRet = C_LOV("T_DEPT_CODE_PROJ01", lrArgs,"F");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
}
function btnBUDG_YYYY_MM_TO_onClick()
{
	C_Calendar("YM_T", "M", txtYM_T.value);
	
}
 
function btnPreView_onClick()
{
	btnquery_prt_onclick();
}
