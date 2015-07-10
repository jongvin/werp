/**************************************************************************/
/* 1. �� �� �� �� id : t_WBudgAllChangeR.jsp(�ϰ������������)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : �ϰ������������ ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-05)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�ϰ������������");
	G_addDataSet(dsALL_CHG_SEQ, null, null, sSelectPageName+D_P1("ACT","ALL_CHG_SEQ"), "�ϰ���������");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;
	
	G_setReadOnlyCol(gridMAIN,"ALL_CHG_SEQ");
	G_setReadOnlyCol(gridMAIN,"BUDG_APPLY_YM");
	G_setReadOnlyCol(gridMAIN,"CHG_DIV");
	
	gridMAIN.focus();
	
	D_defaultLoad();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		var strCOMP_CODE = txtCOMP_CODE.value;
		var strCLSE_ACC_ID = txtCLSE_ACC_ID.value;
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE", strCOMP_CODE)
									 + D_P2("CLSE_ACC_ID", strCLSE_ACC_ID);
	}
	
	else if(dataset == dsALL_CHG_SEQ)
	{
		var strCOMP_CODE  = txtCOMP_CODE.value;
		var strCLSE_ACC_ID = txtCLSE_ACC_ID.value;
		
		dataset.DataID = sSelectPageName + D_P1("ACT","ALL_CHG_SEQ")
									   + D_P2("COMP_CODE", strCOMP_CODE)
									   + D_P2("CLSE_ACC_ID", strCLSE_ACC_ID);
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
function getALL_CHG_SEQ()
{
	var arrRec = new Array();
	
	G_Load(dsALL_CHG_SEQ, null);
	arrRec[1] = dsALL_CHG_SEQ.NameString(dsALL_CHG_SEQ.RowPosition, "ALL_CHG_SEQ");
       arrRec[2] = dsMAIN.NameString(dsMAIN.RowPosition, "BUDG_APPLY_YM");
       arrRec[3] = txtCLSE_ACC_ID.value;
	return 	arrRec;
}
//�ϰ����꺯����, ���
function btnAllBudgAllChg(div, msg)
{
	if (div =='N') 
	{
		if(C_msgYesNo('������ �ϰ����꺯�� ��Ҹ� �����Ͻðڽ��ϱ�?','Ȯ��')=='Y')
		{
			dsMAIN.DeleteRow(dsMAIN.RowPosition);
			if(!G_saveData(dsMAIN)) 
			{
				G_Load(dsMAIN, null);
				return;
			}
			G_Load(dsMAIN, null);
			C_msgOk(msg + " " + "���������� ����Ǿ����ϴ�.");
		}
		else
		{
			return false;	
		}
	}
	
	if (div =='Y') 
	{
		var arrRtn = getALL_CHG_SEQ();
		
		var arrRtn2 = null;
	
		arrRtn2 = window.showModalDialog("t_PBudgAllChgRequestR.jsp", arrRtn, "center:yes; dialogWidth:245px; dialogHeight:245px; status:no; help:no; scroll:no");
	
		if(arrRtn2 == null) return;
		
		if(arrRtn2[0]=="TRUE")
		{
			
			G_addRow(dsMAIN);
			
			dsMAIN.NameValue(dsMAIN.RowPosition,"COMP_CODE")  		= txtCOMP_CODE.value;
			dsMAIN.NameValue(dsMAIN.RowPosition,"CLSE_ACC_ID") 		= txtCLSE_ACC_ID.value;
			dsMAIN.NameValue(dsMAIN.RowPosition,"ALL_CHG_SEQ") 		= arrRtn2[1];
			dsMAIN.NameValue(dsMAIN.RowPosition,"BUDG_APPLY_YM")  	= arrRtn2[2];
	
			if(!G_saveData(dsMAIN)) 
			{
				dsMAIN.DeleteRow(dsMAIN.RowPosition);
				return;
			}
			G_Load(dsMAIN, null);
			C_msgOk(msg + " " + "���������� ����Ǿ����ϴ�.");
			gridMAIN.focus();
		}
	}
}
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
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
	D_defaultAdd();
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
		var strCOMP_CODE = txtCOMP_CODE.value;
		var strCLSE_ACC_ID = txtCLSE_ACC_ID.value;
		dataset.NameValue(row,"COMP_CODE")  = strCOMP_CODE;
		dataset.NameValue(row,"CLSE_ACC_ID") = strCLSE_ACC_ID;
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
function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("CLSE_ACC_ID", txtCLSE_ACC_ID.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_BUDG_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	

	D_defaultLoad();
	
}
function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("CLSE_ACC_ID", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_BUDG_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
	D_defaultLoad();

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
//�ϰ����꺯����
function btnAllBudgAllChg_onClick()
{
	btnAllBudgAllChg('Y','�ϰ����꺯������ ');
}

//�ϰ����꺯�����
function btnAllBudgAllChgCancel_onClick()
{
	btnAllBudgAllChg('N','�ϰ����꺯�����');
}