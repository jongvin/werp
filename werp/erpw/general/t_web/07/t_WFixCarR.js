/**************************************************************************/
/* 1. �� �� �� �� id : t_WFixCarR.js(�����ڻ��������)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : �����ڻ�������� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-17)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�����ڻ����");
	
	G_addDataSet(dsDEPREC_FINISH, null, null, sSelectPageName+D_P1("ACT","DEPREC_FINISH"), "�󰢿Ϸᱸ��");

	
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	
	Value_Readonly(true);
	G_setReadOnlyCol(gridMAIN,"ASSET_MNG_NO");
	G_setReadOnlyCol(gridMAIN,"ASSET_NAME");
	G_setReadOnlyCol(gridMAIN,"DEPREC_FINISH_NAME");
	G_setReadOnlyCol(gridMAIN,"CAR_NO");
	G_setReadOnlyCol(gridMAIN,"CAR_BODY_NO");
	G_setReadOnlyCol(gridMAIN,"CAR_YEAR");
	gridMAIN.focus();
	
	G_Load(dsDEPREC_FINISH, null);
	
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("ASSET_CLS_CODE",strAssetClsCode)
									 + D_P2("ITEM_CODE",txtITEM_CODE.value)
									 + D_P2("ITEM_NM_CODE", txtITEM_NM_CODE.value)
									 + D_P2("DEPREC_FINISH",dsDEPREC_FINISH.NameString(dsDEPREC_FINISH.RowPosition,"CODE_LIST_ID"));
	}
	
	else if(dataset == dsDEPREC_FINISH)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DEPREC_FINISH");
										
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
function	Value_Readonly(abTag)
{
	document.all.txtCAR_NO.readOnly			= abTag;
	document.all.txtCAR_BODY_NO.readOnly	= abTag;
	document.all.txtCAR_YEAR.readOnly		= abTag;
	document.all.txtCAR_LENGTH.readOnly		= abTag;
	document.all.txtCAR_HEIGHT.readOnly		= abTag;
	document.all.txtCAR_WEIGHT.readOnly		= abTag;
	document.all.txtCAR_CC.readOnly			= abTag;
	document.all.txtCAR_CYLINDER.readOnly	= abTag;
	document.all.txtCAR_FORM_NO.readOnly	= abTag;
	document.all.txtCAR_OIL.readOnly			= abTag;
	document.all.txtCAR_USE.readOnly			= abTag;
	document.all.txtCAR_USER.readOnly		= abTag;
	document.all.txtREGULAR_CHECK_START.readOnly	= abTag;
	document.all.txtREGULAR_CHECK_END.readOnly		= abTag;
	document.all.txtGET_TAX.readOnly	= abTag;
	document.all.txtREG_TAX.readOnly			= abTag;
	document.all.txtVAT_TAX.readOnly		= abTag;
	document.all.txtINSURANCE_START.readOnly	= abTag;
	document.all.txtINSURANCE_END.readOnly	= abTag;
	
	document.all.btnREGULAR_CHECK_START.disabled= abTag;
	document.all.btnREGULAR_CHECK_END.disabled	= abTag;
	document.all.btnINSURANCE_START.disabled		= abTag;
	document.all.btnINSURANCE_END.disabled		= abTag;
	


}
function chkInputItem()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("�������  �����Ͻʽÿ�.", "Ȯ��");
		return;
	}
	
	//��¥ ��ȿ��üũ
	if ( !C_isNull(txtREGULAR_CHECK_START.value))
	{
		strReChSt = txtREGULAR_CHECK_START.value.replace(/-/gi,"");
		strReChEn= txtREGULAR_CHECK_END.value.replace(/-/gi,"");

		if (parseInt(strReChSt) > parseInt(strReChEn))
		{
			C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
			txtREGULAR_CHECK_START.value = olddata1;
			txtREGULAR_CHECK_START.focus();
			return;
		}
	}
	
	if ( !C_isNull(txtREGULAR_CHECK_END.value))
	{
		strReChSt = txtREGULAR_CHECK_START.value.replace(/-/gi,"");
		strReChEn= txtREGULAR_CHECK_END.value.replace(/-/gi,"");

		if (parseInt(strReChSt) > parseInt(strReChEn))
		{
			C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
			txtREGULAR_CHECK_END.value = olddata2;
			txtREGULAR_CHECK_END.focus();
			return;
		}
	}
	
	if ( !C_isNull(txtINSURANCE_START.value))
	{
		strInsuSt   = txtINSURANCE_START.value.replace(/-/gi,"");
		strInsuEn	 = txtINSURANCE_END.value.replace(/-/gi,"");

		if (parseInt(strInsuSt) > parseInt(strInsuEn))
		{
			C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
			txtINSURANCE_START.value = olddata3;
			txtINSURANCE_START.focus();
			return;
		}
	}	
	
	if ( !C_isNull(txtINSURANCE_END.value))
	{
		strInsuSt   = txtINSURANCE_START.value.replace(/-/gi,"");
		strInsuEn	 = txtINSURANCE_END.value.replace(/-/gi,"");

		if (parseInt(strInsuSt) > parseInt(strInsuEn))
		{
			C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
			txtINSURANCE_END.value = olddata4;
			txtINSURANCE_END.focus();
			return;
		}
	}			
	
	if (C_isNull(txtITEM_CODE.value))
	{
		C_msgOk("ǰ�񱸺��� �����Ͻʽÿ�.", "Ȯ��");
		return;
	}
	
	if (C_isNull(txtITEM_NM_CODE.value))
	{
		C_msgOk("ǰ������  �����Ͻʽÿ�.", "Ȯ��");
		return;
	}
	return true;	
}



//��ȸ�� üũ
function checkCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("������� �����ϼ���.", "Ȯ��");
		return;
	}
	
	return true;
}
//��ü ���� ����
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	if(!checkCondition()) return;
	Value_Readonly(false);
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	//��ȸ����üũ
	if(!G_isLoaded("dsMAIN"))
	{
		C_msgOk("���� ��ȸ�� �����ϼ���");
		return;
	}
	if (!chkInputItem()) return;
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("ASSET_CLS_CODE", strAssetClsCode);
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("ITEM_NM_CODE", txtITEM_NM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_SHEET1", lrArgs,"F");
	
	if (lrRet == null) return;

	strAssetName		 = lrRet.get("ASSET_NAME");
	strAssetMngNo		 = lrRet.get("ASSET_MNG_NO");
	strDeprecFinishName = lrRet.get("DEPREC_FINISH_NAME");
	strFixAssetSeq		 =  lrRet.get("FIX_ASSET_SEQ");
	D_defaultAdd();
}

// ����
function btninsert_onclick()
{
	btnadd_onclick();
}

// ����
function btndelete_onclick()
{
	D_defaultDelete();
}

// ����
function btnsave_onclick()
{	
	
	//if(!chkInputItem()) return;
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
	 if (asCalendarID == "REGULAR_CHECK_START")
	{
		txtREGULAR_CHECK_START.value = asDate;
	}
	else if (asCalendarID == "REGULAR_CHECK_END")
	{
		txtREGULAR_CHECK_END.value = asDate;
	}
	else if (asCalendarID == "INSURANCE_START")
	{
		txtINSURANCE_START.value = asDate;
	}
	else if (asCalendarID == "INSURANCE_END")
	{
		txtINSURANCE_END.value = asDate;
	}
}


function OnLoadCompleted(dataset, rowcnt)
{
	if ( dataset == dsMAIN)
	{
		olddata1 = txtREGULAR_CHECK_START.value;
		olddata2 = txtREGULAR_CHECK_END.value;
		olddata3 = txtINSURANCE_START.value;
		olddata4 = txtINSURANCE_END.value;
	}
}

function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
	
	
	if ( dataset == dsMAIN)
	{
		dataset.NameValue(row, "ASSET_MNG_NO") = strAssetMngNo;
		dataset.NameValue(row, "ASSET_NAME") = strAssetName;
		dataset.NameValue(row, "DEPREC_FINISH_NAME") = strDeprecFinishName;
		dataset.NameString(row,"FIX_ASSET_SEQ") 	= strFixAssetSeq;	
	}
	
	gridMAIN.focus();
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
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("ASSET_CLS_CODE", strAssetClsCode);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_AutoLov(dsLOV,"T_FIX_ITEM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtITEM_CODE.value	= lrRet.get("ITEM_CODE");
	txtITEM_NAME.value	= lrRet.get("ITEM_NAME");
}

function btnITEM_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", strAssetClsCode);
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtITEM_CODE.value	= lrRet.get("ITEM_CODE");
	txtITEM_NAME.value	= lrRet.get("ITEM_NAME");
}
//ǰ���ڵ�
function txtITEM_NM_CODE_onblur()
{

	if (!C_isNull(txtITEM_NM_CODE.value))
	{
		if (C_isNull(txtITEM_CODE.value))
		{
			C_msgOk("ǰ�񱸺���  ���� �����ϼ���.");
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
	
	lrArgs.set("ASSET_CLS_CODE", strAssetClsCode);
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

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
	
	lrArgs.set("ASSET_CLS_CODE", strAssetClsCode);
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_NM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtITEM_NM_CODE.value	= lrRet.get("ITEM_NM_CODE");
	txtITEM_NM_NAME.value	= lrRet.get("ITEM_NM_NAME");
}//���Ѿ��� �μ�����(�������)
function btnREGULAR_CHECK_START_onClick()
{
	C_Calendar("REGULAR_CHECK_START", "D", txtREGULAR_CHECK_START.value);
}

function btnREGULAR_CHECK_END_onClick()
{
	C_Calendar("REGULAR_CHECK_END", "D", txtREGULAR_CHECK_END.value);
}
function btnINSURANCE_START_onClick()
{
	C_Calendar("INSURANCE_START", "D", txtINSURANCE_START.value);
}

function btnINSURANCE_END_onClick()
{
	C_Calendar("INSURANCE_END", "D", txtINSURANCE_END.value);
}

