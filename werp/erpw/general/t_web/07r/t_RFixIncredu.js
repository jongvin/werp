/**************************************************************************/
/* 1. �� �� �� �� id : t_WFixSheetR.js(�����ڻ������)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : �����ڻ������ 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-17)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	
	//G_addDataSet(dsASSETCLS, null, null, sSelectPageName+D_P1("ACT","ASSET_CLS_CODE"), "�ڻ�����");

	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","FIX_ASSET_NO"), "LOV");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtINCREDU_DT_FROM.value = vDate;
	txtINCREDU_DT_TO.value = vDate;
	//G_Load(dsASSETCLS, null);
	
}
function OnLoadBefore(dataset)
{
	
	
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
       if(!checkCondition()) return;
   	var reportFile ="r_t_070005";
  	
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
	

	
	strTemp += "CompCode__" + txtCOMP_CODE.value + "&&";
	strTemp += "IncreduCls__" + cboINCREDU_CLS.value  + "&&";
	strTemp += "IncreduDtFrom__" +  txtINCREDU_DT_FROM.value + "&&";
	strTemp += "IncreduDtTo__" + txtINCREDU_DT_TO.value;
	
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	//strTemp ="";
}

//��ü ���� ����
function	chkTotal01_onclick()
{
	
	if(chkTotal01.checked)
	{
		txtACC_CODE.value ="%";
		txtACC_NAME.value ="";
		txtACC_CODE.readOnly=true;
		txtACC_CODE.style.backgroundColor = "#EFEFEF";
		btnACC_CODE.disabled  = true;

	}
else
	{
		txtACC_CODE.readOnly=false;
		txtACC_CODE.style.backgroundColor = "#ffffff";
		btnACC_CODE.disabled = false;

	}
}


//��ȸ�� üũ
function checkCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("�������  �����Ͻʽÿ�.", "Ȯ��");
		return;
	}
	
	if (C_isNull(txtINCREDU_DT_FROM.value))
	{
		C_msgOk("�������� �Է��ϼ���", "Ȯ��");
		return;
	}
	if (C_isNull(txtINCREDU_DT_TO.value))
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
	else if (asCalendarID == "INCREDU_DT_TO")
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

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}
//�����ڵ�
function txtACC_CODE_onblur()
{
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	
	lrArgs.set("SEARCH_CONDITION", "txtACC_CODE.value");

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtACC_CODE.value	= lrRet.get("ACC_CODE");
	txtACC_NAME.value	= lrRet.get("ACC_NAME");
}

function btnACC_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_ACC_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtACC_CODE.value	= lrRet.get("ACC_CODE");
	txtACC_NAME.value	= lrRet.get("ACC_NAME");
}


function btnITEM_NM_CODE_onClick()
{
	if (txtITEM_CODE.value == "")
	{
		C_msgOk("ǰ���ڵ带 ������ �Է��Ͻʽÿ�.");
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_NM_CODE1", lrArgs,"T");
	
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
