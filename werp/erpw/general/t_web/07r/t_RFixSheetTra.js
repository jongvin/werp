/**************************************************************************/
/* 1. �� �� �� �� id : t_RFixSheetTra.js(�����ڻ�������(���))
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : �����ڻ�������(���)
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-02)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, null, sSelectPageName+D_P1("ACT","MAIN"), "�����ڻ����");
	G_addDataSet(dsASSETCLS, null, null, sSelectPageName+D_P1("ACT","ASSET_CLS_CODE"), "�ڻ�����");

	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtINCREDU_DT_FROM.value = vDate;
	txtINCREDU_DT_TO.value = vDate;
	G_Load(dsASSETCLS, null);
	
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("ASSET_CLS_CODE",dsASSETCLS.NameString(dsASSETCLS.RowPosition,"ASSET_CLS_CODE"))
									 + D_P2("ITEM_CODE",txtITEM_CODE.value)
									 + D_P2("ITEM_NM_CODE", txtITEM_NM_CODE.value)
									 + D_P2("DEPREC_FINISH",dsDEPREC_FINISH.NameString(dsDEPREC_FINISH.RowPosition,"CODE_LIST_ID"));
	}
	else if(dataset == dsASSETCLS)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ASSET_CLS_CODE");
										
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
//�μ�
function btnquery_prt_onclick()                      
//------------------------------------------------------------------------
{
     
   	var reportFile ="r_t_070009";
  	
   	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	//alert(frmList.REPORT_FILE_NAME.value);
	// ���α׷��� �Ķ���� �߰�
	// �Ķ����1__��1&&�Ķ����2__��2&&....
	// ����
	
	strITEM_CODE = txtITEM_CODE.value;
	strITEM_NM_CODE	= txtITEM_NM_CODE.value;
	strDEPT_CODE = txtDEPT_CODE.value
	
	if ( strITEM_CODE=="")
	{
		strITEM_CODE="%";
	}
	if ( strITEM_NM_CODE=="")
	{
		strITEM_NM_CODE="%";
	}
	if ( strDEPT_CODE=="")
	{
		strDEPT_CODE="%";
	}
	
	
	strTemp += "CompCode__" + txtCOMP_CODE.value + "&&";
	strTemp += "AssetClsCode__" + dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE") + "&&";
	strTemp += "ItemCode__" + strITEM_CODE  + "&&";
	strTemp += "ItemNmCode__" +  strITEM_NM_CODE + "&&";
	strTemp += "DeptCode__" +  strDEPT_CODE + "&&";
	strTemp += "IncreduDtFrom__" + txtINCREDU_DT_FROM.value + "&&";
	strTemp += "IncreduDtTo__" + txtINCREDU_DT_TO.value + "&&";
	strTemp += "FixedCls__" + cboFIXED_CLS.value;
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	//strTemp ="";
}


//��ȸ�� üũ
function checkCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("������� �����ϼ���.", "Ȯ��");
		return;
	}
	
	if (C_isNull(txtINCREDU_DT_FROM.value))
	{
		C_msgOk("�������� �Է��ϼ���", "Ȯ��");
		return;
	}
	if (C_isNull(INCREDU_DT_TO.value))
	{
		C_msgOk("�������� �Է��ϼ���", "Ȯ��");
		return;
	}
	return true;
}
//��ü ���� ����
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//


// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "INCREDU_DT_FROM")
	{
		txtINCREDU_DT_FROM.value = asDate;
	}
	if (asCalendarID == "INCREDU_DT_TO")
	{
		txtINCREDU_DT_TO.value = asDate;
	}
	
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
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}
//ǰ���ڵ�
function txtITEM_CODE_onblur()
{
	if (C_isNull(txtITEM_CODE.value))
	{
		txtITEM_NAME.value = "";
		return;
	}
	if (txtITEM_CODE.value == '%')
	{
		return false;
	}
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_AutoLov(dsLOV,"T_FIX_ITEM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtITEM_CODE.value	= lrRet.get("ITEM_CODE");
	txtITEM_NAME.value	= lrRet.get("ITEM_NAME");
	chkTotal02.disabled=false;
}

function btnITEM_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtITEM_CODE.value	= lrRet.get("ITEM_CODE");
	txtITEM_NAME.value	= lrRet.get("ITEM_NAME");
	chkTotal02.disabled=false;
}
//ǰ���ڵ�
function txtITEM_NM_CODE_onblur()
{

	if (C_isNull(txtITEM_NM_CODE.value) || txtITEM_NM_CODE.value=='%')
	{
		if (C_isNull(txtITEM_CODE.value))
		{
			C_msgOk("ǰ�񱸺��� ���� �����ϼ���.");
			return;
		}
	}
	
	if (C_isNull(txtITEM_NM_CODE.value))
	{
		txtITEM_NM_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtITEM_NM_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_FIX_ITEM_NM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtITEM_NM_CODE.value	= lrRet.get("ITEM_NM_CODE");
	txtITEM_NM_NAME.value	= lrRet.get("ITEM_NM_NAME");
}

function btnITEM_NM_CODE_onClick()
{
	if (txtITEM_CODE.value == "")
	{
		C_msgOk("ǰ�񱸺��� ���� �����ϼ���.");
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_NM_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtITEM_NM_CODE.value	= lrRet.get("ITEM_NM_CODE");
	txtITEM_NM_NAME.value	= lrRet.get("ITEM_NM_NAME");
}//���Ѿ��� �μ�����(�������)

function btnINCREDU_DT_FROM_onClick()
{
	C_Calendar("INCREDU_DT_FROM", "D", txtINCREDU_DT_FROM.value);
	S_nextFocus(btnINCREDU_DT_FROM);
}

function btnINCREDU_DT_TO_onClick()
{
	C_Calendar("INCREDU_DT_TO", "D", txtINCREDU_DT_TO.value);
	S_nextFocus(btnINCREDU_DT_TO);
}

