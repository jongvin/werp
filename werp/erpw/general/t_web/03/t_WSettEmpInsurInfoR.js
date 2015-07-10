/**************************************************************************/
/* 1. �� �� �� �� id : t_WSettEmpInsurInfoR.jsp(�⵵�����������)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : �⵵�����������
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-23) 
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�Ա�ǥ���");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	
	
	G_setLovCol(gridMAIN,"GET_PERSON");
	G_setLovCol(gridMAIN,"NAME");
	
	
	G_setLovCol(gridMAIN,"IN_DT");
	G_setLovCol(gridMAIN,"OUT_DT");

	G_setLovCol(gridMAIN,"CUST_CODE");
	G_setLovCol(gridMAIN,"CUST_NAME");

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value);
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
	if(!CheckCompCode()) return;
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	D_defaultAdd();

}

// ����
function btninsert_onclick()
{
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
	/*
	if (asCalendarID == "IN_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"IN_DT") = asDate;
	}
	*/
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
	if(dataset == dsMAIN)
	{
		dataset.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
		
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
	if (dataset == dsMAIN)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			if(C_isNull(COL_DATA))
			{
				dataset.NameString(row,"CUST_SEQ") = "";
				dataset.NameString(row,"CUST_CODE") = "";
				dataset.NameString(row,"CUST_NAME") = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", COL_DATA);
		
			lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");
		
			if (lrRet == null)
			{
				dataset.NameString(row,colid) = olddata;
				return;
			}
			dataset.NameString(row,"CUST_SEQ") = lrRet.get("CUST_SEQ");
			dataset.NameString(row,"CUST_CODE") = lrRet.get("CUST_CODE");
			dataset.NameString(row,"CUST_NAME") = lrRet.get("CUST_NAME");
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
		
			if (lrRet == null) return;
			dataset.NameString(row,"CUST_SEQ") = lrRet.get("CUST_SEQ");
			dataset.NameString(row,"CUST_CODE") = lrRet.get("CUST_CODE");
			dataset.NameString(row,"CUST_NAME") = lrRet.get("CUST_NAME");
		}
	}
}

function OnDuplicateColumn(dataset,grid,row,colid)
{
	if(dataset == dsMAIN)
	{
		if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			if(row>=2) {
				dsMAIN.NameString(row,"CUST_SEQ") = dsMAIN.NameString(row-1,"CUST_SEQ");
				dsMAIN.NameString(row,"CUST_CODE") = dsMAIN.NameString(row-1,"CUST_CODE");
				dsMAIN.NameString(row,"CUST_NAME") = dsMAIN.NameString(row-1,"CUST_NAME");
			}
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

