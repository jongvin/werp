/**************************************************************************/
/* 1. �� �� �� �� id : t_WCardCodeR(�ſ�ī�����)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2003-02-01)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "�ſ�ī���ȣ���");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "�ſ�ī���̷¤�");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsCARD_SEQ, null, null, null, "�ſ�ī���ȣ");

	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"CARD_SEQ","CARD_SEQ");	

	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;

	gridMAIN.TabToss = false;
	gridSUB01.TabToss = false;
	
	G_setLovCol(gridSUB01,"CARDOWNEREMPNO");
	G_setLovCol(gridSUB01,"CARDSUBSTITUTEEMPNO");
	G_setLovCol(gridSUB01,"CARDOWNEREMPNAME");
	G_setLovCol(gridSUB01,"CARDSUBSTITUTEEMPNAME");


	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("CODE_CLASS",cboCODE_CLASS.value)
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CARD_CLS",cboCARD_CLS.value)
											+ D_P2("SEARCH_CONDITION",txtSEARCH_CONDITION.value);
	}
	else if(dataset == dsCARD_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CARD_SEQ");
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("CARD_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"CARD_SEQ"));
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
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("���� ������ڵ带 �����ϼ���.", "Ȯ��");
		return;
	}
	
	D_defaultAdd();
}

// ����
function btninsert_onclick()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("���� ������ڵ带 �����ϼ���.", "Ȯ��");
		return;
	}
	
	D_defaultInsert();
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
	if (asCalendarID == "EXPR_MONTH")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"EXPR_MONTH") = asDate;
	}
	else if(asCalendarID == "UNUSED_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"UNUSED_DT") = asDate;
	}
	else if(asCalendarID == "USESTARTDATE")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"USESTARTDATE") = asDate;
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
	if(row < 1) return;

	if(dataset == dsMAIN)
	{
		dsMAIN.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
		dsMAIN.NameString(row,"USE_TG") = "T";
		dsMAIN.NameString(row, "CARD_CLS") = cboCARD_CLS.value == "%" ? "1":cboCARD_CLS.value;
		G_Load(dsCARD_SEQ);
		dsMAIN.NameString(row,"CARD_SEQ") = dsCARD_SEQ.NameString(dsCARD_SEQ.RowPosition,"CARD_SEQ");
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
	if (dataset == dsMAIN)
	{
		if(colid=='USE_TG')
		{
			if(dataset.NameString(row,colid) == "T")
			{
				dataset.NameString(row,"UNUSED_DT") = "";
			}
			else
			{
				dataset.NameString(row,"UNUSED_DT") = sDTT;
			}
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(grid == gridMAIN)
	{
		var		COL_DATA;
		COL_DATA = dsMAIN.NameString(row,colid);
		if(colid == "EXPR_MONTH")
		{
			D_defaultYmProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
		else if(colid == "CARDNO")
		{
			dsMAIN.NameString(row,colid) = maskCARDNO(COL_DATA);
		}
		else if(colid == "UNUSED_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
		gridMAIN.focus();
	}
	else if(grid == gridSUB01)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "USESTARTDATE")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
		else if (colid == "CARDOWNEREMPNO" || colid == "CARDOWNEREMPNAME")
		{
			//�������
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("COMP_CODE", "");
			lrArgs.set("SEARCH_CONDITION", dataset.NameString(row,colid));
			
			lrRet = C_AutoLov(dsLOV,"Z_AUTHORITY_USER01", lrArgs,"T");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row,"CARDOWNEREMPNO") = lrRet.get("EMPNO");
			dataset.NameValue(row,"CARDOWNEREMPNAME") = lrRet.get("NAME");
		}
		else if (colid == "CARDSUBSTITUTEEMPNO" || colid == "CARDSUBSTITUTEEMPNAME")
		{
			//�������
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("COMP_CODE", "");
			lrArgs.set("SEARCH_CONDITION", dataset.NameString(row,colid));
			
			lrRet = C_AutoLov(dsLOV,"Z_AUTHORITY_USER01", lrArgs,"T");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row,"CARDSUBSTITUTEEMPNO") = lrRet.get("EMPNO");
			dataset.NameValue(row,"CARDSUBSTITUTEEMPNAME") = lrRet.get("NAME");
		}
	}
}
		


function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsMAIN)
	{
		if(colid == "BANK_MAIN_NAME")
		{
			var lrArgs = new C_Dictionary();
			
			lrArgs.set("SEARCH_CONDITION", "");
			
			var lrRet = null;
	
			lrRet = C_LOV("T_BANK_MAIN_CARD", lrArgs, "F");
	
			if (lrRet == null) return;
			
			dsMAIN.NameString(row,"BANK_MAIN_CODE")	= lrRet.get("BANK_MAIN_CODE");
			dsMAIN.NameString(row,"BANK_MAIN_NAME")	= lrRet.get("BANK_MAIN_NAME");
		}
		else if(colid == "BANK_NAME")
		{
			var lrArgs = new C_Dictionary();
			
			lrArgs.set("SEARCH_CONDITION", "");
			
			var lrRet = null;
	
			lrRet = C_LOV("T_BANK_CODE1", lrArgs, "F");
	
			if (lrRet == null) return;

			dsMAIN.NameString(row,"BANK_CODE")	= lrRet.get("BANK_CODE");
			dsMAIN.NameString(row,"BANK_NAME")	= lrRet.get("BANK_NAME");
		}
		else if(colid == "ACCNO")
		{
			if (C_isNull(dsMAIN.NameString(row,"BANK_CODE")))
			{
				C_msgOk("���� ���������� �Է��ϼ���.");
				return;
			}
			
			var lrArgs = new C_Dictionary();
			
			lrArgs.set("COMP_CODE", dsMAIN.NameString(row,"COMP_CODE"));
			lrArgs.set("BANK_CODE", dsMAIN.NameString(row,"BANK_CODE"));
			lrArgs.set("SEARCH_CONDITION", "");
			
			var lrRet = null;
	
			lrRet = C_LOV("T_ACCNO_CODE1", lrArgs, "F");
	
			if (lrRet == null) return;

			dsMAIN.NameString(row,"ACCNO")	= lrRet.get("ACCNO");
		}
		else if(colid == "EXPR_MONTH")
		{
			C_Calendar("EXPR_MONTH", "M", dsMAIN.NameString(dsMAIN.RowPosition,"EXPR_MONTH"));
		}
		else if(colid == "UNUSED_DT")
		{
			C_Calendar("UNUSED_DT", "D", dsMAIN.NameString(dsMAIN.RowPosition,"UNUSED_DT"));
		}
	}
	else if(dataset == dsSUB01)
	{
		if(colid == "USESTARTDATE")
		{
			C_Calendar("USESTARTDATE", "D", dsSUB01.NameString(dsSUB01.RowPosition,"USESTARTDATE"));
		}
		else if (colid == "CARDOWNEREMPNO" || colid == "CARDOWNEREMPNAME")
		{
			//�������
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("COMP_CODE", "");
			lrArgs.set("SEARCH_CONDITION", "");
			
			lrRet = C_LOV("Z_AUTHORITY_USER01", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row,"CARDOWNEREMPNO") = lrRet.get("EMPNO");
			dataset.NameValue(row,"CARDOWNEREMPNAME") = lrRet.get("NAME");
		}
		else if (colid == "CARDSUBSTITUTEEMPNO" || colid == "CARDSUBSTITUTEEMPNAME")
		{
			//�������
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("COMP_CODE", "");
			lrArgs.set("SEARCH_CONDITION", "");
			
			lrRet = C_LOV("Z_AUTHORITY_USER01", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row,"CARDSUBSTITUTEEMPNO") = lrRet.get("EMPNO");
			dataset.NameValue(row,"CARDSUBSTITUTEEMPNAME") = lrRet.get("NAME");
		}
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//

function	maskCARDNO(asCARDNO)
{
	var	lsUMask = asCARDNO.toString().replace(/-/g, "");
	
	if (C_isNull(lsUMask)) return;

	if (!C_isNum(lsUMask))
	{
		C_msgOk("�߸��� ī���ȣ�Դϴ�.");
		return;
	}
	return asCARDNO;
}

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
	D_defaultLoad();
	cboCODE_CLASS.focus();
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
	D_defaultLoad();
	cboCODE_CLASS.focus();
}