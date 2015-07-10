/**************************************************************************/
/* 1. �� �� �� �� id : t_WFBCardUseR.jsp(����ī���̿볻�����)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ����ī���̿볻�����
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-22)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "����ī��û������");
	G_addDataSet(dsCOPY, null, null, sSelectPageName+D_P1("ACT","COPY"), "����store");
	G_addDataSet(dsLOV , null, null, null, "LOV");

	txtDATE_FROM.value = sDTF;

	G_setReadOnlyCol(gridMAIN,"CARDNUMBER");
	G_setReadOnlyCol(gridMAIN,"EMPNAME");
	G_setReadOnlyCol(gridMAIN,"TOTALSUM");
	G_setReadOnlyCol(gridMAIN,"COMPANYSUM");
	G_setReadOnlyCol(gridMAIN,"PERSONSUM");
	G_setReadOnlyCol(gridMAIN,"AdjustStatus");
	G_setReadOnlyCol(gridMAIN,"Adjust");
	G_setReadOnlyCol(gridMAIN,"AccNo");
	G_setReadOnlyCol(gridMAIN,"Bank_Main_Code");
	G_setReadOnlyCol(gridMAIN,"Bank_Main_Name");
	G_setReadOnlyCol(gridMAIN,"SLIP");
	G_setReadOnlyCol(gridMAIN,"ADJUSTFinishDateTime");
	G_setReadOnlyCol(gridMAIN,"AccountingConfirmDate");
	G_setReadOnlyCol(gridMAIN,"CHARGEDATE");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridMAIN.TabToss = false;

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("CompCode",txtCOMP_CODE.value)
										 + D_P2("ADJUSTYEARMONTH",txtDATE_FROM.value.replace(/-/g,''))
										 + D_P2("DEPT_CODE",sDeptCode)
										 + D_P2("CARDNUMBER",C_Trim(txtCARD_CODE.value));
	}
	else if (dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
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
	return true;
}

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	G_Load(dsMAIN);
	SUM_SET_onblur();
}

// �߰�
function btnadd_onclick()
{
	//D_defaultAdd();
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
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "DATE_FROM")
	{
		txtDATE_FROM.value = asDate;
	}
}

function OnRowInsertBefore(dataset)
{
	return false;
}
function OnRowInserted(dataset, row)
{
}
function OnExit(dataset, grid, row, colid, olddata)
{

}

function OnPopup(dataset, grid, row, colid, data)
{

}

// �̺�Ʈ����-------------------------------------------------------------------//

function btnDATE_FROM_onClick()
{
	C_Calendar("DATE_FROM", "M", txtDATE_FROM.value);
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMP_NAME.value	= lrRet.get("COMPANY_NAME");
}
function btnCARD_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("DEPT_CODE", sDeptCode);
	lrArgs.set("CARDNUMBER", "");
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_ACC_CREDCARD4", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCARD_CODE.value	= lrRet.get("CARDNUMBER");
	txtCARD_NAME.value	= lrRet.get("NAME");
}
function txtCARD_CODE_onblur()
{
	if (C_isNull(txtCARD_CODE.value))
	{
		txtCARD_CODE.value = '';
		txtCARD_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("DEPT_CODE", sDeptCode);
	lrArgs.set("CARDNUMBER", txtCARD_CODE.value);
	lrArgs.set("SEARCH_CONDITION","" );

	lrRet = C_AutoLov(dsLOV,"T_ACC_CREDCARD4", lrArgs,"T");

	if (lrRet == null) 
	{
		txtCARD_CODE.value 	= "";
		txtCARD_NAME.value 	= "";
	}	
	else
	{	
		txtCARD_CODE.value 	= lrRet.get("CARDNUMBER");
		txtCARD_NAME.value 	= lrRet.get("NAME");
	}	
}
//�հ谪setting
function SUM_SET_onblur()
{
 	var i = 0;
 	var dbSum_ALL    = dsMAIN.NameSum("TOTALSUM",0,0); 
 	var dbSum_NON    = dsMAIN.NameSum("COMPANYSUM",0,0);
 	var dbSum_PERSON = dsMAIN.NameSum("PERSONSUM",0,0);
	
	txtTOTAL_SUM.value = C_toNumberFormatString(dbSum_ALL,false) ;
	txtNOUSE_SUM.value = C_toNumberFormatString(dbSum_NON,false);
	txtPERSON_SUM.value = C_toNumberFormatString(dbSum_PERSON,false);
}
function btnSELECT_ACC_onClick()
{
	var vRow = dsMAIN.RowPosition;
	if ( vRow == 0 ) return ;
	if ( C_isNull(dsMAIN.NameString(vRow,"SLIP_ID"))|| dsMAIN.NameString(vRow,"SLIP_ID")== 0 ) return ;
	
	var pSLIP_ID        = dsMAIN.NameString(vRow,"SLIP_ID");
	var pSLIP_IDSEQ     = dsMAIN.NameString(vRow,"SLIP_IDSEQ");
	var pMAKE_COMP_CODE = txtCOMP_CODE.value;
	var pMAKE_DT 	      = dsMAIN.NameString(vRow,"MAKE_DT").replace(/-/gi,"");
	var pMAKE_SEQ     	= dsMAIN.NameString(vRow,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsMAIN.NameString(vRow,"SLIP_KIND_TAG");
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
//���
function btnCARD_PRINT_onClick()
{
	var		lnCnt = dsMAIN.CountRow;
	if(lnCnt == 0) return;
  
  var vDATE_FROM = txtDATE_FROM.value.replace(/-/g,'');  
	var vcard_code = txtCARD_CODE.value;
	var reportFile = "r_t_110009.rpt";
	
	frmList.EXPORT_TAG.value ='W';
	frmList.RUN_TAG.value = '1';
	frmList.REQUEST_NAME.value = '����ī�����긮��Ʈ';
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile;
	
	var strTemp = "";
	if ( C_isNull(txtCARD_CODE.value) ) vcard_code = '%';
	
	
	strTemp  = "P_COMP_CODE__" + txtCOMP_CODE.value;
	strTemp += "&&P_COMP_NAME__" + txtCOMP_NAME.value;
	strTemp += "&&P_YEAR_MONTH__" + vDATE_FROM;
	strTemp += "&&P_CARDNUMBER__" + vcard_code;
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";	
}
