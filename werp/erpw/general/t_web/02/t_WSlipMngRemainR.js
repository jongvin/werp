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
											+ D_P2("CUST_SEQ",txtCUST_SEQ.value)
											+ D_P2("ACC_CODE",txtACC_CODE.value)
											+ D_P2("BANK_CODE",txtBANK_CODE.value)
											+ D_P2("DEPT_MNG",(chkDEPT_CODE.checked)?'T':'F')
											+ D_P2("CUST_CODE_MNG",(chkCUST_CODE.checked)?'T':'F')
											+ D_P2("LOAN_MNG",(chkBANK_CODE.checked)?'T':'F')
											+ D_P2("MNG_TG_CHAR1",(chkMNG_TG_CHAR1.checked)?'T':'F')
											+ D_P2("MNG_TG_CHAR2",(chkMNG_TG_CHAR2.checked)?'T':'F')
											+ D_P2("MNG_TG_CHAR3",(chkMNG_TG_CHAR3.checked)?'T':'F')
											+ D_P2("MNG_TG_CHAR4",(chkMNG_TG_CHAR4.checked)?'T':'F')
											+ D_P2("MNG_TG_NUM1",(chkMNG_TG_NUM1.checked)?'T':'F')
											+ D_P2("MNG_TG_NUM2",(chkMNG_TG_NUM2.checked)?'T':'F')
											+ D_P2("MNG_TG_NUM3",(chkMNG_TG_NUM3.checked)?'T':'F')
											+ D_P2("MNG_TG_NUM4",(chkMNG_TG_NUM4.checked)?'T':'F')
											+ D_P2("MNG_TG_DT1",(chkMNG_TG_DT1.checked)?'T':'F')
											+ D_P2("MNG_TG_DT2",(chkMNG_TG_DT2.checked)?'T':'F')
											+ D_P2("MNG_TG_DT3",(chkMNG_TG_DT3.checked)?'T':'F')
											+ D_P2("MNG_TG_DT4",(chkMNG_TG_DT4.checked)?'T':'F');
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
	//if(!CheckCompCode()) return;
	if (txtACC_CODE.value == "")
	{
		C_msgOk("���������� �Է��ϼ���.", "Ȯ��");
		return;
	}
	
    var vGRIDDEPT  = "";
    var vGRIDCUST  = "";
    var vGRIDBANK  = "";
    var vGRIDITEM_CHAR1 = "";
	var vGRIDITEM_CHAR2 = "";
	var vGRIDITEM_CHAR3 = "";
	var vGRIDITEM_CHAR4 = "";
    var vGRIDITEM_NUM1 = "";
	var vGRIDITEM_NUM2 = "";
	var vGRIDITEM_NUM3 = "";
	var vGRIDITEM_NUM4 = "";
    var vGRIDITEM_DT1 = "";
	var vGRIDITEM_DT2 = "";
	var vGRIDITEM_DT3 = "";
	var vGRIDITEM_DT4 = "";
	if(chkDEPT_CODE.checked)
	{
	    vGRIDDEPT   = "<C> Name=�ͼӺμ�     ID=DEPT_CODE Align=Center Width=60 Edit='none'</C> ";
	    vGRIDDEPT  += "<C> Name=�μ���       ID=DEPT_NAME Align=Left Width=160 Edit='none'</C> ";
	}
	if(chkCUST_CODE.checked)
	{
	    vGRIDCUST   = "<C> Name=�ŷ�ó�ڵ�   ID=CUST_CODE Align=Left Width=110 Edit='none'</C> ";
		vGRIDCUST  += "<C> Name=�ŷ�ó�� 	   ID=CUST_NAME Align=Left Width=140 Edit='none'</C> ";
	}
	if(chkBANK_CODE.checked)
	{
	    vGRIDBANK   = "<C> Name=�����ڵ�     ID=BANK_CODE Align=Center Width=60 Edit='none'</C> ";
		vGRIDBANK  += "<C> Name=����� 	   ID=BANK_NAME Align=Left Width=140 Edit='none'</C> ";
	}
	
	if(chkMNG_TG_CHAR1.checked)
	{
		vGRIDITEM_CHAR1 = "<C> Name='"+txtMNG_NAME_CHAR1.value+"' ID=MNG_ITEM_CHAR1 Align=Left Width=120 Edit='none' show={IF("+txtMNG_ITEM_CHAR1.value+"='','false','true')}</C> "
	}
	
	if(chkMNG_TG_CHAR2.checked)
	{
	   vGRIDITEM_CHAR2 = "<C> Name='"+txtMNG_NAME_CHAR2.value+"' ID=MNG_ITEM_CHAR2 Align=Left Width=120 Edit='none' show={IF("+txtMNG_ITEM_CHAR2.value+"='','false','true')}</C> "
	}
	
	if(chkMNG_TG_CHAR3.checked)
	{
		vGRIDITEM_CHAR3 = "<C> Name='"+txtMNG_NAME_CHAR3.value+"' ID=MNG_ITEM_CHAR3 Align=Left Width=120 Edit='none' show={IF("+txtMNG_ITEM_CHAR3.value+"='','false','true')}</C> "
	}
	
	if(chkMNG_TG_CHAR4.checked)
	{
		vGRIDITEM_CHAR4 = "<C> Name='"+txtMNG_NAME_CHAR4.value+"' ID=MNG_ITEM_CHAR4 Align=Left Width=120 Edit='none' show={IF("+txtMNG_ITEM_CHAR4.value+"='','false','true')}</C> "
	}
	
	if(chkMNG_TG_NUM1.checked)
	{
		vGRIDITEM_NUM1 = "<C> Name='"+txtMNG_NAME_NUM1.value+"' ID=MNG_ITEM_NUM1 Align=Left Width=120 Edit='none' show={IF("+txtMNG_ITEM_NUM1.value+"='','false','true')}</C> "
	}
	
	if(chkMNG_TG_NUM2.checked)
	{
	   vGRIDITEM_NUM2 = "<C> Name='"+txtMNG_NAME_NUM2.value+"' ID=MNG_ITEM_NUM2 Align=Left Width=120 Edit='none' show={IF("+txtMNG_ITEM_NUM2.value+"='','false','true')}</C> "
	}
	
	if(chkMNG_TG_NUM3.checked)
	{
		vGRIDITEM_NUM3 = "<C> Name='"+txtMNG_NAME_NUM3.value+"' ID=MNG_ITEM_NUM3 Align=Left Width=120 Edit='none' show={IF("+txtMNG_ITEM_NUM3.value+"='','false','true')}</C> "
	}
	
	if(chkMNG_TG_NUM4.checked)
	{
		vGRIDITEM_NUM4 = "<C> Name='"+txtMNG_NAME_NUM4.value+"' ID=MNG_ITEM_NUM4 Align=Left Width=120 Edit='none' show={IF("+txtMNG_ITEM_NUM4.value+"='','false','true')}</C> "
	}

	if(chkMNG_TG_DT1.checked)
	{
		vGRIDITEM_DT1 = "<C> Name='"+txtMNG_NAME_DT1.value+"' ID=MNG_ITEM_DT1 Align=Left Width=120 Edit='none' show={IF("+txtMNG_ITEM_DT1.value+"='','false','true')}</C> "
	}
	
	if(chkMNG_TG_DT2.checked)
	{
	   vGRIDITEM_DT2 = "<C> Name='"+txtMNG_NAME_DT2.value+"' ID=MNG_ITEM_DT2 Align=Left Width=120 Edit='none' show={IF("+txtMNG_ITEM_DT2.value+"='','false','true')}</C> "
	}
	
	if(chkMNG_TG_DT3.checked)
	{
		vGRIDITEM_DT3 = "<C> Name='"+txtMNG_NAME_DT3.value+"' ID=MNG_ITEM_DT3 Align=Left Width=120 Edit='none' show={IF("+txtMNG_ITEM_DT3.value+"='','false','true')}</C> "
	}
	
	if(chkMNG_TG_DT4.checked)
	{
		vGRIDITEM_DT4 = "<C> Name='"+txtMNG_NAME_DT4.value+"' ID=MNG_ITEM_DT4 Align=Left Width=120 Edit='none' show={IF("+txtMNG_ITEM_DT4.value+"='','false','true')}</C> "
	}

	
	gridMAIN.Format  = vGRIDDEPT;
	gridMAIN.Format += vGRIDCUST;
	gridMAIN.Format += vGRIDBANK;
	gridMAIN.Format += vGRIDITEM_CHAR1;
	gridMAIN.Format += vGRIDITEM_CHAR2;
	gridMAIN.Format += vGRIDITEM_CHAR3;
	gridMAIN.Format += vGRIDITEM_CHAR4;
	gridMAIN.Format += vGRIDITEM_NUM1;
	gridMAIN.Format += vGRIDITEM_NUM2;
	gridMAIN.Format += vGRIDITEM_NUM3;
	gridMAIN.Format += vGRIDITEM_NUM4;
	gridMAIN.Format += vGRIDITEM_DT1;
	gridMAIN.Format += vGRIDITEM_DT2;
	gridMAIN.Format += vGRIDITEM_DT3;
	gridMAIN.Format += vGRIDITEM_DT4;

	gridMAIN.Format += "<C> Name=���� 		ID=DB_AMT      Align=Right SumBgColor=#FFCCCC BgColor=#FFECEC Width=150 Edit='none' SumText=@sum</C> ";
	gridMAIN.Format += "<C> Name=�뺯 		ID=CR_AMT      Align=Right SumBgColor=#CEEEFF BgColor=#E0F4FF Width=150 Edit='none' SumText=@sum</C> ";


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

function	OnColumnChanged(dataset, row, colid)
{
	if(dataset == dsMAIN)
	{
		if(colid == "CHK_CLS")
		{
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
		/*
		if(dataset.NameString(row,"MAKE_COMP_CODE") == "")
		{
			C_msgOk("��ü�����׸��� ��ǥ��ȸ�� �� �� �����ϴ�.", "Ȯ��");
			return;
		}
		var pSLIP_ID        = dataset.NameString(row,"SLIP_ID");
		var pSLIP_IDSEQ     = dataset.NameString(row,"SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dataset.NameString(row,"MAKE_COMP_CODE");
		var pMAKE_DT 	     = dataset.NameString(row,"MAKE_DT");
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
		*/
		var lrArgs = new Array();
		var lsURL = "./t_WSlipMngRemainDetailR.jsp";
		lrArgs.opener          = window;
		//lrArgs.SLIP_ID        = pSLIP_ID;
	
		var lrRet = null;
		lrRet = window.showModalDialog(lsURL,lrArgs,"center:yes; dialogWidth:904px; dialogHeight:430px; status:no; help:no; scroll:no") ;

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
		txtCUST_SEQ.value = '';
		txtCUST_CODE.value = '';
		txtCUST_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	txtCUST_SEQ.value = lrRet.get("CUST_SEQ");
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

	txtCUST_SEQ.value = lrRet.get("CUST_SEQ");
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
		txtACC_CODE.value = '';
		txtACC_NAME.value = '';
		txtCUST_CODE_MNG.value = '';
		txtLOAN_MNG.value = '';
		txtACC_LVL.value  = '';
		txtFUND_INPUT_CLS.value = '';
		CheckBox_Control();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE_ALL", lrArgs,"T");

	if (lrRet == null) return;

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
	txtCUST_CODE_MNG.value       = lrRet.get("CUST_CODE_MNG");
	txtLOAN_MNG.value       = lrRet.get("LOAN_NO_MNG");
	txtACC_LVL.value        = lrRet.get("ACC_LVL");
	txtFUND_INPUT_CLS.value = lrRet.get("FUND_INPUT_CLS");
	
	if (txtFUND_INPUT_CLS.value == 'T')
	{
		txtMNG_ITEM_CHAR1.value      = lrRet.get("MNG_TG_CHAR1");
		txtMNG_ITEM_CHAR2.value      = lrRet.get("MNG_TG_CHAR2");
		txtMNG_ITEM_CHAR3.value      = lrRet.get("MNG_TG_CHAR3");
		txtMNG_ITEM_CHAR4.value      = lrRet.get("MNG_TG_CHAR4");
		txtMNG_NAME_CHAR1.value      = lrRet.get("MNG_NAME_CHAR1");
		txtMNG_NAME_CHAR2.value      = lrRet.get("MNG_NAME_CHAR2");
		txtMNG_NAME_CHAR3.value      = lrRet.get("MNG_NAME_CHAR3");
		txtMNG_NAME_CHAR4.value      = lrRet.get("MNG_NAME_CHAR4");

		txtMNG_ITEM_NUM1.value      = lrRet.get("MNG_TG_NUM1");
		txtMNG_ITEM_NUM2.value      = lrRet.get("MNG_TG_NUM2");
		txtMNG_ITEM_NUM3.value      = lrRet.get("MNG_TG_NUM3");
		txtMNG_ITEM_NUM4.value      = lrRet.get("MNG_TG_NUM4");
		txtMNG_NAME_NUM1.value      = lrRet.get("MNG_NAME_NUM1");
		txtMNG_NAME_NUM2.value      = lrRet.get("MNG_NAME_NUM2");
		txtMNG_NAME_NUM3.value      = lrRet.get("MNG_NAME_NUM3");
		txtMNG_NAME_NUM4.value      = lrRet.get("MNG_NAME_NUM4");

		txtMNG_ITEM_DT1.value      = lrRet.get("MNG_TG_DT1");
		txtMNG_ITEM_DT2.value      = lrRet.get("MNG_TG_DT2");
		txtMNG_ITEM_DT3.value      = lrRet.get("MNG_TG_DT3");
		txtMNG_ITEM_DT4.value      = lrRet.get("MNG_TG_DT4");
		txtMNG_NAME_DT1.value      = lrRet.get("MNG_NAME_DT1");
		txtMNG_NAME_DT2.value      = lrRet.get("MNG_NAME_DT2");
		txtMNG_NAME_DT3.value      = lrRet.get("MNG_NAME_DT3");
		txtMNG_NAME_DT4.value      = lrRet.get("MNG_NAME_DT4");

	}
	
	CheckBox_Control();

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
	txtCUST_CODE_MNG.value       = lrRet.get("CUST_CODE_MNG");
	txtLOAN_MNG.value       = lrRet.get("LOAN_NO_MNG");
	txtACC_LVL.value        = lrRet.get("ACC_LVL");
	txtFUND_INPUT_CLS.value = lrRet.get("FUND_INPUT_CLS");
	
	if (txtFUND_INPUT_CLS.value == 'T')
	{
		txtMNG_ITEM_CHAR1.value      = lrRet.get("MNG_TG_CHAR1");
		txtMNG_ITEM_CHAR2.value      = lrRet.get("MNG_TG_CHAR2");
		txtMNG_ITEM_CHAR3.value      = lrRet.get("MNG_TG_CHAR3");
		txtMNG_ITEM_CHAR4.value      = lrRet.get("MNG_TG_CHAR4");
		txtMNG_NAME_CHAR1.value      = lrRet.get("MNG_NAME_CHAR1");
		txtMNG_NAME_CHAR2.value      = lrRet.get("MNG_NAME_CHAR2");
		txtMNG_NAME_CHAR3.value      = lrRet.get("MNG_NAME_CHAR3");
		txtMNG_NAME_CHAR4.value      = lrRet.get("MNG_NAME_CHAR4");

		txtMNG_ITEM_NUM1.value      = lrRet.get("MNG_TG_NUM1");
		txtMNG_ITEM_NUM2.value      = lrRet.get("MNG_TG_NUM2");
		txtMNG_ITEM_NUM3.value      = lrRet.get("MNG_TG_NUM3");
		txtMNG_ITEM_NUM4.value      = lrRet.get("MNG_TG_NUM4");
		txtMNG_NAME_NUM1.value      = lrRet.get("MNG_NAME_NUM1");
		txtMNG_NAME_NUM2.value      = lrRet.get("MNG_NAME_NUM2");
		txtMNG_NAME_NUM3.value      = lrRet.get("MNG_NAME_NUM3");
		txtMNG_NAME_NUM4.value      = lrRet.get("MNG_NAME_NUM4");

		txtMNG_ITEM_DT1.value      = lrRet.get("MNG_TG_DT1");
		txtMNG_ITEM_DT2.value      = lrRet.get("MNG_TG_DT2");
		txtMNG_ITEM_DT3.value      = lrRet.get("MNG_TG_DT3");
		txtMNG_ITEM_DT4.value      = lrRet.get("MNG_TG_DT4");
		txtMNG_NAME_DT1.value      = lrRet.get("MNG_NAME_DT1");
		txtMNG_NAME_DT2.value      = lrRet.get("MNG_NAME_DT2");
		txtMNG_NAME_DT3.value      = lrRet.get("MNG_NAME_DT3");
		txtMNG_NAME_DT4.value      = lrRet.get("MNG_NAME_DT4");

	}
	
	CheckBox_Control();
}

function CheckBox_Control()
{
	chkDEPT_CODE.checked    = false;
	chkCUST_CODE.checked    = false;
    chkBANK_CODE.checked    = false;
    
    chkMNG_TG_CHAR1.checked = false;
    chkMNG_TG_CHAR2.checked = false;
    chkMNG_TG_CHAR3.checked = false;
    chkMNG_TG_CHAR4.checked = false;
    
    chkMNG_TG_NUM1.checked = false;
    chkMNG_TG_NUM2.checked = false;
    chkMNG_TG_NUM3.checked = false;
    chkMNG_TG_NUM4.checked = false;
    
    chkMNG_TG_DT1.checked = false;
    chkMNG_TG_DT2.checked = false;
    chkMNG_TG_DT3.checked = false;
    chkMNG_TG_DT4.checked = false;
    
	if (txtFUND_INPUT_CLS.value == "T")
	{
	    if(txtCUST_CODE_MNG.value == "T") {
			document.all.chkCUST_CODE.disabled	= false;
		} 
		else
		{
		   document.all.chkCUST_CODE.disabled	= true;
		}
		if(txtLOAN_MNG.value == "T")
		{
			document.all.chkBANK_CODE.disabled	= false;
		}
		else
		{
		   document.all.chkBANK_CODE.disabled	= true;
		}
		
		
		if(txtMNG_NAME_CHAR1.value == "")
		{
			document.all.chkMNG_TG_CHAR1.disabled	= true;
		}
		else
		{
		   document.all.chkMNG_TG_CHAR1.disabled	= false;
		}
		if(txtMNG_NAME_CHAR2.value == "")
		{
		   document.all.chkMNG_TG_CHAR2.disabled	= true;
		}
		else
		{
		   document.all.chkMNG_TG_CHAR2.disabled	= false;
		}
		if(txtMNG_NAME_CHAR3.value == "")
		{
			document.all.chkMNG_TG_CHAR3.disabled	= true;
		}
		else
		{
		   document.all.chkMNG_TG_CHAR3.disabled	= false;
		}
		if(txtMNG_NAME_CHAR4.value == "") {
			document.all.chkMNG_TG_CHAR4.disabled	= true;
		}
		else
		{
		   document.all.chkMNG_TG_CHAR4.disabled	= false;
		}

		if(txtMNG_NAME_NUM1.value == "")
		{
			document.all.chkMNG_TG_NUM1.disabled	= true;
		}
		else
		{
		   document.all.chkMNG_TG_NUM1.disabled	= false;
		}
		if(txtMNG_NAME_NUM2.value == "")
		{
		   document.all.chkMNG_TG_NUM2.disabled	= true;
		}
		else
		{
		   document.all.chkMNG_TG_NUM2.disabled	= false;
		}
		if(txtMNG_NAME_NUM3.value == "")
		{
			document.all.chkMNG_TG_NUM3.disabled	= true;
		}
		else
		{
		   document.all.chkMNG_TG_NUM3.disabled	= false;
		}
		if(txtMNG_NAME_NUM4.value == "") {
			document.all.chkMNG_TG_NUM4.disabled	= true;
		}
		else
		{
		   document.all.chkMNG_TG_NUM4.disabled	= false;
		}

		if(txtMNG_NAME_DT1.value == "")
		{
			document.all.chkMNG_TG_DT1.disabled	= true;
		}
		else
		{
		   document.all.chkMNG_TG_DT1.disabled	= false;
		}
		if(txtMNG_NAME_DT2.value == "")
		{
		   document.all.chkMNG_TG_DT2.disabled	= true;
		}
		else
		{
		   document.all.chkMNG_TG_DT2.disabled	= false;
		}
		if(txtMNG_NAME_DT3.value == "")
		{
			document.all.chkMNG_TG_DT3.disabled	= true;
		}
		else
		{
		   document.all.chkMNG_TG_DT3.disabled	= false;
		}
		if(txtMNG_NAME_DT4.value == "") {
			document.all.chkMNG_TG_DT4.disabled	= true;
		}
		else
		{
		   document.all.chkMNG_TG_DT4.disabled	= false;
		}

	}
	else {
		txtMNG_ITEM_CHAR1.value      = "T";
		txtMNG_ITEM_CHAR2.value      = "T";
		txtMNG_ITEM_CHAR3.value      = "T";
		txtMNG_ITEM_CHAR4.value      = "T";
		txtMNG_NAME_CHAR1.value      = "�����׸�-����1";
		txtMNG_NAME_CHAR2.value      = "�����׸�-����2";
		txtMNG_NAME_CHAR3.value      = "�����׸�-����3";
		txtMNG_NAME_CHAR4.value      = "�����׸�-����4";

		txtMNG_ITEM_NUM1.value      = "T";
		txtMNG_ITEM_NUM2.value      = "T";
		txtMNG_ITEM_NUM3.value      = "T";
		txtMNG_ITEM_NUM4.value      = "T";
		txtMNG_NAME_NUM1.value      = "�����׸�-����1";
		txtMNG_NAME_NUM2.value      = "�����׸�-����2";
		txtMNG_NAME_NUM3.value      = "�����׸�-����3";
		txtMNG_NAME_NUM4.value      = "�����׸�-����4";

		txtMNG_ITEM_DT1.value      = "T";
		txtMNG_ITEM_DT2.value      = "T";
		txtMNG_ITEM_DT3.value      = "T";
		txtMNG_ITEM_DT4.value      = "T";
		txtMNG_NAME_DT1.value      = "�����׸�-��¥1";
		txtMNG_NAME_DT2.value      = "�����׸�-��¥2";
		txtMNG_NAME_DT3.value      = "�����׸�-��¥3";
		txtMNG_NAME_DT4.value      = "�����׸�-��¥4";
		
		chkCUST_CODE.disabled    = false;
	    chkBANK_CODE.disabled    = false;
	    
	    chkMNG_TG_CHAR1.disabled = false;
	    chkMNG_TG_CHAR2.disabled = false;
	    chkMNG_TG_CHAR3.disabled = false;
	    chkMNG_TG_CHAR4.disabled = false;
	    
	    chkMNG_TG_NUM1.disabled = false;
	    chkMNG_TG_NUM2.disabled = false;
	    chkMNG_TG_NUM3.disabled = false;
	    chkMNG_TG_NUM4.disabled = false;
	    
	    chkMNG_TG_DT1.disabled = false;
	    chkMNG_TG_DT2.disabled = false;
	    chkMNG_TG_DT3.disabled = false;
	    chkMNG_TG_DT4.disabled = false;
	}

}
//�������
function txtBANK_CODE_onblur()
{
	if (txtBANK_CODE.value == "")
	{
		txtBANK_NAME.value = "";
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtBANK_CODE.value);

	var		lrRet = C_AutoLov(dsLOV,"T_BANK_CODE1",lrArgs,"T");

	if (lrRet != null)
	{
		txtBANK_CODE.value	= lrRet.get("BANK_CODE");
		txtBANK_NAME.value	= lrRet.get("BANK_NAME");
	}
}

function btnBANK_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtBANK_CODE.value);

	lrRet = C_LOV("T_BANK_CODE1", lrArgs,"T");

	if (lrRet != null)
	{
		txtBANK_CODE.value	= lrRet.get("BANK_CODE");
		txtBANK_NAME.value	= lrRet.get("BANK_NAME");
	}
}