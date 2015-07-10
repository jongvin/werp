/**************************************************************************/
/* 1. �� �� �� �� id : t_WWorkCodeR.js(�ڵ���ǥ�ڵ���)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-18)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsLOV,  null,   null, null, "LOV");

	G_addDataSet(dsMAIN,  trans,   gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "���������ڵ�");
	G_addDataSet(dsSUB01, trans,  gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "�μ�/����");

	//txtCOMP_CODE.value = sCompCode;
	//txtCOMPANY_NAME.value = sCompName;
	
	G_addRel(dsMAIN,dsSUB01);
	//G_addRelCol(dsSUB01,"DIV_COMP_CODE","DIV_COMP_CODE");
	G_addRelCol(dsSUB01,"SUM_TAR_CODE","SUM_TAR_CODE");

	
	G_setLovCol(gridSUB01,"ACC_CODE");

	//G_setReadOnlyCol(gridSUB01,"ACC_NAME");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridMAIN.TabToss = false;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridSUB01.TabToss = false;


	gridMAIN.focus();
	btnquery_onclick();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("SUM_TAR_CODE",dsMAIN.NameString(dsMAIN.RowPosition, "SUM_TAR_CODE"));
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
	if(G_FocusDataset==dsMAIN) {
		//if(!CheckCompCode()) return;
		D_defaultAdd();
	} else if(G_FocusDataset==dsSUB01) {
		if(dsMAIN.CountRow==0) {
			C_msgOk("���������ڵ带 ���� �����ϼ���.", "Ȯ��");
			return;
		}
		var lrArgs = new C_Dictionary();
		var lrRet = null;

		lrArgs.set("SUM_TAR_CODE", dsMAIN.NameValue(dsMAIN.RowPosition,"SUM_TAR_CODE"));
		lrArgs.set("COME_CODE", sCompCode);
		lrArgs.set("COST_DEPT_KND_TAG", 'B');
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV_NEW("T_DEPT_CODE8", null, lrArgs, "T", "T");
		
		if (lrRet == null) return;

		var idx = 0;
		for (idx = 0; idx < lrRet.length; idx++)
		{
			lrArgs = lrRet[idx];
			//D_defaultAdd();
			G_addRow(dsSUB01);
			dsSUB01.NameString(dsSUB01.RowPosition, "DEPT_CODE") = lrArgs.get("DEPT_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition, "DEPT_NAME") = lrArgs.get("DEPT_NAME");
		}
	}
}

// ����
function btninsert_onclick()
{
	if(G_FocusDataset==dsMAIN) {
		//if(!CheckCompCode()) return;
		D_defaultInsert();
	} else if(G_FocusDataset==dsSUB01) {
		if(dsMAIN.CountRow==0) {
			C_msgOk("���������ڵ带 ���� �����ϼ���.", "Ȯ��");
			return;
		}
		var lrArgs = new C_Dictionary();
		var lrRet = null;

		lrArgs.set("SUM_TAR_CODE", dsMAIN.NameValue(dsMAIN.RowPosition,"SUM_TAR_CODE"));
		lrArgs.set("COME_CODE", sCompCode);
		lrArgs.set("COST_DEPT_KND_TAG", 'B');
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV_NEW("T_DEPT_CODE8", null, lrArgs, "T", "T");
		
		if (lrRet == null) return;

		var idx = 0;
		for (idx = 0; idx < lrRet.length; idx++)
		{
			lrArgs = lrRet[idx];
			//D_defaultAdd();
			G_addRow(dsSUB01);
			dsSUB01.NameString(dsSUB01.RowPosition, "DEPT_CODE") = lrArgs.get("DEPT_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition, "DEPT_NAME") = lrArgs.get("DEPT_NAME");
		}
	}
}

// ����
function btndelete_onclick()
{
	if(G_FocusDataset==dsMAIN) {
		D_defaultDelete();
	} else if(G_FocusDataset==dsSUB01) {
		//dsSUB01.DeleteMarked();
		G_MultiDeleteRow(dsSUB01);
	}
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
}


function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	if (dataset == dsMAIN)
	{
	}
	else if(dataset == dsSUB01)
	{
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	var idx = 0;
	if (dataset == dsMAIN)
	{
		//dsMAIN.NameString(dsMAIN.RowPosition, "DIV_COMP_CODE") = txtCOMP_CODE.value;
		//dsMAIN.NameString(dsMAIN.RowPosition, "USE_TAG") = "T";
		//dsMAIN.NameString(dsMAIN.RowPosition, "USE_TAG") = "F";
	}
	else if(dataset == dsSUB01)
	{
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
	}
	else if(dataset == dsSUB01)
	{
		if (colid == "ACC_CODE")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dsMAIN.NameValue(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
			dsMAIN.NameValue(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
			dataset.NameValue(row,"SUMMARY_CODE")	= "";
			dataset.NameValue(row,"SUMMARY1") = "";
		}
		
		else if (colid == "SUMMARY_CODE")
		{
			//if(!chkAccCode()) return false;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("ACC_CODE", dataset.NameValue(row,"ACC_CODE"));
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_SUMMARY_CODE", lrArgs,"T");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row,"SUMMARY_CODE")	= lrRet.get("SUMMARY_CODE");
			dataset.NameValue(row,"SUMMARY1")	= lrRet.get("SUMMARY_NAME");
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsSUB01)
	{
		if (colid == "ACC_CODE")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
			dataset.NameValue(row,"SUMMARY_CODE")	= "";
			dataset.NameValue(row,"SUMMARY1") = "";
		}
		
		else if (colid == "SUMMARY_CODE")
		{
			//if(!chkAccCode()) return false;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("ACC_CODE", dataset.NameValue(row,"ACC_CODE"));
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_SUMMARY_CODE", lrArgs,"T");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row,"SUMMARY_CODE")	= lrRet.get("SUMMARY_CODE");
			dataset.NameValue(row,"SUMMARY1")	= lrRet.get("SUMMARY_NAME");
		}
	}

}

function OnDuplicateColumn(dataset,grid,row,colid) {
	if(dataset == dsMAIN)
	{
		if(colid == "CHARGE_PERS" || colid == "CHARGE_PERS_NAME")
		{
			if(row>=2) {
				dsMAIN.NameString(row,"CHARGE_PERS") = dsMAIN.NameString(row-1,"CHARGE_PERS");
				dsMAIN.NameString(row,"CHARGE_PERS_NAME") = dsMAIN.NameString(row-1,"CHARGE_PERS_NAME");
			}
		}
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
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