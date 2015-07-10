/**************************************************************************/
/* 1. �� �� �� �� id : t_WCustCodeR.js(�ŷ�ó�ڵ�)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-15)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "�ŷ�ó�ڵ�");
	G_addDataSet(dsCUST_SEQ, null, null, null, "�ŷ�ó����");
	G_addDataSet(dsCUST_CODE, null, null, null, "�ŷ�ó�ڵ�");
	G_addDataSet(dsCUST_ACCNO, trans, gridACCNO, null, "�ŷ�ó���ް���");
	G_addDataSet(dsPAY_STOP, trans, gridPAY_STOP, null, "�ŷ�ó��������");
	G_addDataSet(dsCUST_PAYSTOP_SEQ, null, null, null, "�ŷ�ó������������");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsACCT, null, null, null, "ACCT");
	G_addDataSet(dsBILL_VENDOR, null, null, null, "����������ü");
	
	

	G_addRel(dsMAIN, dsCUST_ACCNO);
	G_addRelCol(dsCUST_ACCNO, "CUST_SEQ", "CUST_SEQ");
	G_addRel(dsMAIN, dsPAY_STOP);
	G_addRelCol(dsPAY_STOP, "CUST_SEQ", "CUST_SEQ");

	gridACCNO.RejectEnterkeyOnPopupStyle = true;
	gridPAY_STOP.RejectEnterkeyOnPopupStyle = true;
	
	G_setLovCol(gridACCNO,"OUT_ACCNO");
	G_setLovCol(gridACCNO,"CLOSE_DT");
	gridMAIN.Focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("TRADE_CLS",cboTRADE_CLS.value)
											+ D_P2("ACCNO",txtACCNO.value)
											+ D_P2("SEARCH_CONDITION",txtSEARCH_CONDITION.value);
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
	else if(dataset == dsCUST_ACCNO)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CUST_ACCNO")
											+ D_P2("CUST_SEQ",dsMAIN.NameString(dsMAIN.RowPosition, "CUST_SEQ"));
	}
	else if(dataset == dsPAY_STOP)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","PAY_STOP")
											+ D_P2("CUST_SEQ",dsMAIN.NameString(dsMAIN.RowPosition, "CUST_SEQ"));
	}
	else if(dataset == dsCUST_PAYSTOP_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CUST_PAYSTOP_SEQ");
	}
	else if(dataset == dsACCT)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","ACCT")
											+ D_P2("COMP_CODE",sCompCode)
											+ D_P2("BANK_MAIN_CODE",dsCUST_ACCNO.NameString(dsCUST_ACCNO.RowPosition,"BANK_MAIN_CODE"))
											+ D_P2("ACCNO",dsCUST_ACCNO.NameString(dsCUST_ACCNO.RowPosition,"ACCNO"))
											+ D_P2("CUST_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"CUST_CODE"));
	}
	else if(dataset == dsBILL_VENDOR)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","BILL_VENDOR")
											+ D_P2("VAT_REGISTRATION_NUM",dsMAIN.NameString(dsMAIN.RowPosition,"CUST_CODE"));
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
	var r, re;                     //������ �����մϴ�.
   	var s = txtSEARCH_CONDITION.value;
  	 re = new RegExp("-","i");  //���Խ� ��ü�� ����ϴ�.
  	 r = s.match(re);               //���ڿ� s���� ��ġ�ϴ� �κ��� ã���ϴ�.
	if(r=='-')
	{
		C_msgOk("������(-) ���� ��ȸ�ϼ���");
		return false;	
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
//�μ�
function btnquery_prt_onclick()
{
	// ���α׷��� ��ȿ���˻� �߰�
				
	// ���� Check

       var  vTRADE_CLS = cboTRADE_CLS.value;

   	var reportFile ="";
	
   	reportFile ="r_t_000002";  

	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	
	if(vTRADE_CLS=='%')
	{
		vTRADE_CLS_NAME ='��ü';	
	}
	else if(vTRADE_CLS=='1')
	{
		vTRADE_CLS_NAME ='�����';	
	}
	else if(vTRADE_CLS=='2')
	{
		vTRADE_CLS_NAME ='����';	
	}
	else if(vTRADE_CLS=='3')
	{
		vTRADE_CLS_NAME ='��������';	
	}
	else if(vTRADE_CLS=='4')
	{
		vTRADE_CLS_NAME ='�����ȣ';	
	}
	else if(vTRADE_CLS=='5')
	{
		vTRADE_CLS_NAME ='�μ�';	
	}
	else if(vTRADE_CLS=='9')
	{
		vTRADE_CLS_NAME ='��Ÿ';	
	}

	strTemp += "P_TRADE_CLS__" + vTRADE_CLS;
	strTemp += "&&P_TRADE_CLS_NAME__" + vTRADE_CLS_NAME;

	frmList.PARAMETERS.value = strTemp;
	
	//if (!S_Submit(document.all)) return;
	frmList.submit();

	S_ObjectAllFormat(document.all);
	strTemp ="";
}
// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "PAY_STOPSTR_DT")
	{
		dsPAY_STOP.NameString(dsPAY_STOP.RowPosition,"PAY_STOPSTR_DT") = asDate;
	}
	else if (asCalendarID == "PAY_STOPEND_DT")
	{
		dsPAY_STOP.NameString(dsPAY_STOP.RowPosition,"PAY_STOPEND_DT") = asDate;
	}
	else if (asCalendarID == "CLOSE_DT")
	{
		dsCUST_ACCNO.NameString(dsCUST_ACCNO.RowPosition,"CLOSE_DT") = asDate;
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
		txtTRADE_CLS.value = cboTRADE_CLS.value;
		G_Load(dsCUST_SEQ, null);
		dsMAIN.NameValue(dsMAIN.RowPosition, "CUST_SEQ") = dsCUST_SEQ.NameValue(dsCUST_SEQ.RowPosition, "CUST_SEQ");
		dsMAIN.NameValue(dsMAIN.RowPosition, "GROUP_COMP_CLS") = "F";
		dsMAIN.NameValue(dsMAIN.RowPosition, "USE_CLS") = "T";
	}
	else if (dataset == dsCUST_ACCNO)
	{
		dsCUST_ACCNO.NameValue(row, "USE_TG") = "T";
	}
	else if (dataset == dsPAY_STOP)
	{
		G_Load(dsCUST_PAYSTOP_SEQ, null);
		dsPAY_STOP.NameValue(row, "PAY_STOP_SEQ") = "T";
		dsPAY_STOP.NameValue(row, "PAY_STOP_CLS") = "1";
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
	if (dataset == dsPAY_STOP)
	{
		var COL_DATA = dsPAY_STOP.NameString(row,colid);
		
		if(colid == "PAY_STOPSTR_DT")
		{
			if (C_isNull(dsPAY_STOP.NameString(row,"PAY_STOPEND_DT")))
			{
				if(dsPAY_STOP.NameString(row,"PAY_STOPSTR_DT").replace(/-/gi,"") > dsPAY_STOP.NameString(row,"PAY_STOPEND_DT").replace(/-/gi,""))
				{
					C_msgOk("�������� �����Ϻ��� Ů�ϴ�.", "Ȯ��");
					dsPAY_STOP.NameString(row,colid) = olddata;
					return;
				}
			}
			
			D_defaultDateProcessInGrid(dataset, row, colid, olddata, COL_DATA);
		}
		else if(colid == "PAY_STOPEND_DT")
		{
			if (C_isNull(dsPAY_STOP.NameString(row,"PAY_STOPEND_DT")))
			{
				if(dsPAY_STOP.NameString(row,"PAY_STOPSTR_DT").replace(/-/gi,"") > dsPAY_STOP.NameString(row,"PAY_STOPEND_DT").replace(/-/gi,""))
				{
					C_msgOk("�������� �����Ϻ��� Ů�ϴ�.", "Ȯ��");
					dsPAY_STOP.NameString(row,colid) = olddata;
					return;
				}
			}
			
			D_defaultDateProcessInGrid(dataset, row, colid, olddata, COL_DATA);
		}
		else if(colid=='DEPT_NAME')
		{
			if(C_isNull(dsPAY_STOP.NameString(row,"DEPT_NAME")))
			{
				dsCUST_ACCNO.NameString(row,"DEPT_CODE") = "";
				return;
			}
			
			var lrArgs = new C_Dictionary();
			lrArgs.set("SEARCH_CONDITION", dsPAY_STOP.NameString(row,"DEPT_NAME"));

			var		lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1",lrArgs, "T");

			if (lrRet != null)
			{
				dsPAY_STOP.NameString(row,"DEPT_CODE")	= lrRet.get("DEPT_CODE");
				dsPAY_STOP.NameString(row,"DEPT_NAME")	= lrRet.get("DEPT_NAME");
			}
		}
	}
	if (dataset == dsCUST_ACCNO)
	{
		var COL_DATA = dataset.NameString(row,colid);
		if(colid=='BANK_MAIN_NAME')
		{
			if(C_isNull(dsCUST_ACCNO.NameString(row,"BANK_MAIN_NAME")))
			{
				dsCUST_ACCNO.NameString(row,"BANK_MAIN_CODE") = "";
				return;
			}
			
			var lrArgs = new C_Dictionary();
			lrArgs.set("SEARCH_CONDITION", dsCUST_ACCNO.NameString(row,"BANK_MAIN_NAME"));

			var		lrRet = C_AutoLov(dsLOV,"T_BANK_MAIN",lrArgs, "T");

			if (lrRet != null)
			{
				dsCUST_ACCNO.NameString(row,"BANK_MAIN_CODE")	= lrRet.get("BANK_MAIN_CODE");
				dsCUST_ACCNO.NameString(row,"BANK_MAIN_NAME")	= lrRet.get("BANK_MAIN_NAME");
			}
		}
		else if(colid == "CLOSE_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata, COL_DATA);
		}
		else if(colid == "OUT_ACCNO")
		{
			var COL_DATA = dataset.NameString(row,colid);
			if(C_isNull(COL_DATA))
			{
				return;
			}
			var lrArgs = new C_Dictionary();
			
			lrArgs.set("COMP_CODE", "");
			lrArgs.set("BANK_CODE", "");
			lrArgs.set("ACCT_CLS", "");
			lrArgs.set("SEARCH_CONDITION", "");
			
			var lrRet = null;
	
			lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE1", lrArgs, "T");
	
			if (lrRet == null)
			{
				dataset.NameString(row,"OUT_ACCNO")	= olddata;
				return;
			}
			
			dataset.NameString(row,"OUT_ACCNO")	= lrRet.get("ACCNO");
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsCUST_ACCNO)
	{
		if(colid == "BANK_MAIN_NAME")
		{
			var lrArgs = new C_Dictionary();
			
			lrArgs.set("SEARCH_CONDITION", "");
			
			var lrRet = null;
	
			lrRet = C_LOV("T_BANK_MAIN", lrArgs, "F");
	
			if (lrRet == null) return;
			
			dsCUST_ACCNO.NameString(row,"BANK_MAIN_CODE")	= lrRet.get("BANK_MAIN_CODE");
			dsCUST_ACCNO.NameString(row,"BANK_MAIN_NAME")	= lrRet.get("BANK_MAIN_NAME");
		}
		if(colid == "CLOSE_DT")
		{
			C_Calendar("CLOSE_DT", "D", dsCUST_ACCNO.NameString(dsCUST_ACCNO.RowPosition,"CLOSE_DT"));
		}
		else if(colid == "OUT_ACCNO")
		{
			var lrArgs = new C_Dictionary();
			
			lrArgs.set("COMP_CODE", "");
			lrArgs.set("BANK_CODE", "");
			lrArgs.set("ACCT_CLS", "");
			lrArgs.set("SEARCH_CONDITION", "");
			
			var lrRet = null;
	
			lrRet = C_LOV("T_ACCNO_CODE1", lrArgs, "F");
	
			if (lrRet == null) return;
			
			dataset.NameString(row,"OUT_ACCNO")	= lrRet.get("ACCNO");
		}
	}
	else if(dataset == dsPAY_STOP)
	{
		if(colid == "PAY_STOPSTR_DT")
		{
			C_Calendar("PAY_STOPSTR_DT", "D", dsPAY_STOP.NameString(dsPAY_STOP.RowPosition,"PAY_STOPSTR_DT"));
		}
		else if(colid == "PAY_STOPEND_DT")
		{
			C_Calendar("PAY_STOPEND_DT", "D", dsPAY_STOP.NameString(dsPAY_STOP.RowPosition,"PAY_STOPEND_DT"));
		}
		else if(colid == "DEPT_NAME")
		{
			var lrArgs = new C_Dictionary();
			
			lrArgs.set("SEARCH_CONDITION", "");
			
			var lrRet = null;
	
			lrRet = C_LOV("T_DEPT_CODE1", lrArgs, "F");
	
			if (lrRet == null) return;
			
			dsPAY_STOP.NameString(row,"DEPT_CODE")	= lrRet.get("DEPT_CODE");
			dsPAY_STOP.NameString(row,"DEPT_NAME")	= lrRet.get("DEPT_NAME");
		}
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
function txtCUST_CODE_onBlur()
{
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
		}
		txtCUST_CODE.value = vCUST_CODE.substr(0, 3) + "-" + vCUST_CODE.substr(3, 2) + "-" + vCUST_CODE.substr(5, 5);
	}
	else if (txtTRADE_CLS.value == '2')
	{
		if (!C_isValidRegNo(txtCUST_CODE.value))
		{
			C_msgOk(ERR_MSG);
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
//���
function btnPreView_onClick()
{
	
	btnquery_prt_onclick();
}

function	document_onKeyDown()
{
	if(event.srcElement == txtSEARCH_CONDITION && event.keyCode == 13)
	{
		btnquery_onclick();
	}
	else if(event.srcElement == txtACCNO && event.keyCode == 13)
	{
		btnquery_onclick();
	}
}
function	btnSearchCashAccNo_onClick()
{
	if(dsCUST_ACCNO.RowPosition < 1)
	{
		C_msgOk("�ŷ�ó ���Ұ��¸� �����Ͻð� �۾��Ͻʽÿ�.");
		return;
	}
	if(C_isNull(dsCUST_ACCNO.NameString(dsCUST_ACCNO.RowPosition,"BANK_MAIN_CODE")))
	{
		C_msgOk("�ŷ�ó ���ް����� ������ �Է��� �� �۾��Ͻʽÿ�.");
		return;
	}
	if(C_isNull(dsCUST_ACCNO.NameString(dsCUST_ACCNO.RowPosition,"ACCNO")))
	{
		C_msgOk("�ŷ�ó ���ް����� ���¹�ȣ�� �Է��� �� �۾��Ͻʽÿ�.");
		return;
	}
	G_Load(dsACCT);
	if(dsACCT.CountRow < 1)
	{
		C_msgOk("������ ��ȸ�� �����߽��ϴ�.");
		return;
	}
	if(dsACCT.NameString(dsACCT.RowPosition,"ACCNO_OWNER") != dsCUST_ACCNO.NameString(dsCUST_ACCNO.RowPosition,"ACCNO_OWNER"))
	{
		C_msgOk("�����ָ��� ��ġ���� �ʽ��ϴ�.");
		C_msgOk(dsACCT.NameString(dsACCT.RowPosition,"ACCNO_OWNER"));
		return;
	}
	else
	{
		C_msgOk("�����ָ��� ��ġ�մϴ�.");
	}
}
function	btnSearchBillAccNo_onClick()
{
	if(dsCUST_ACCNO.RowPosition < 1)
	{
		C_msgOk("�ŷ�ó ���Ұ��¸� �����Ͻð� �۾��Ͻʽÿ�.");
		return;
	}
	if(C_isNull(dsCUST_ACCNO.NameString(dsCUST_ACCNO.RowPosition,"BANK_MAIN_CODE")))
	{
		C_msgOk("�ŷ�ó ���ް����� ������ �Է��� �� �۾��Ͻʽÿ�.");
		return;
	}
	if(C_isNull(dsCUST_ACCNO.NameString(dsCUST_ACCNO.RowPosition,"ACCNO")))
	{
		C_msgOk("�ŷ�ó ���ް����� ���¹�ȣ�� �Է��� �� �۾��Ͻʽÿ�.");
		return;
	}
	if(dsCUST_ACCNO.NameString(dsCUST_ACCNO.RowPosition,"ACCNO_CLS")!= '3')
	{
		C_msgOk("�����ڱ� ���¸� ���� �� �۾��Ͻʽÿ�.");
		return;
	}
	
	G_Load(dsBILL_VENDOR);
	if(dsBILL_VENDOR.CountRow < 1)
	{
		C_msgOk("�ش� �ŷ�ó�� ���ھ��� ������ü�� ��ϵǾ� �ִ� ��ü�� �ƴմϴ�.");
		return;
	}
	if(dsBILL_VENDOR.NameString(dsBILL_VENDOR.RowPosition,"BANK_CODE") != dsCUST_ACCNO.NameString(dsCUST_ACCNO.RowPosition,"BANK_MAIN_CODE"))
	{
		C_msgOk("�ŷ������� ��ġ���� �ʽ��ϴ�.");
		return;
	}
	if(dsBILL_VENDOR.NameString(dsBILL_VENDOR.RowPosition,"CONTRACT_GUBUN") == "C")
	{
		C_msgOk("���ھ��� ������ ������ ��ü�Դϴ�.");
		return;
	}

	C_msgOk("�������� ���ھ��� ������ü�Դϴ�.");
}
