/**************************************************************************/
/* 1. �� �� �� �� id     : t_WBudgCloseR.js(��û�������)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  ��     : ��û������� 
/* 4. ��  ��  ��  ��     : ����� �ۼ�(2005-12-13)
/* 5. ����  ���α׷�  : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�����û����");
	G_addDataSet(dsMAKE_DT, null, null, null, "����");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsCLSE_REQ_ALL, transClseReqAll, null, null, "�����μ��ϰ����");
	G_addDataSet(dsCLSE_REQ_ALL_CANCEL, transClseReqAllCancel, null, null, "�����μ��ϰ�������");
	G_addDataSet(dsCLSE, transClse, null, null, "����");
	G_addDataSet(dsCLSE_ALL, transClseAll, null, null, "�ϰ�����");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;
	
	G_setReadOnlyCol(gridMAIN,"COMP_CODE");
	G_setReadOnlyCol(gridMAIN,"COMPANY_NAME");
	G_setReadOnlyCol(gridMAIN,"CLSE_ACC_ID");
	G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"REQ_CLSE_CLS");
	
	G_Load(dsMAIN,null);
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		var strCOMP_CODE = txtCOMP_CODE.value;
		var strDEPT_CODE =  txtDEPT_CODE.value;
		var strCLSE_ACC_ID = txtCLSE_ACC_ID.value;
		
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									   + D_P2("COMP_CODE", strCOMP_CODE)
									   + D_P2("DEPT_CODE", strDEPT_CODE)
									   + D_P2("CLSE_ACC_ID", strCLSE_ACC_ID);
	}
	
	else if(dataset == dsMAKE_DT)
	{
		var strCOMP_CODE = txtCOMP_CODE.value;
		var strCLSE_ACC_ID = txtCLSE_ACC_ID.value;
		
		dataset.DataID = sSelectPageName + D_P1("ACT","MAKE_DT")
									   + D_P2("COMP_CODE", strCOMP_CODE)
									   + D_P2("CLSE_ACC_ID", strCLSE_ACC_ID);
	}
	else if(dataset == dsCLSE_REQ_ALL)
	{
 
		dataset.DataID = sSelectPageName + D_P1("ACT","CLSE_REQ_ALL");
									
	}
	else if(dataset == dsCLSE_REQ_ALL_CANCEL)
	{
 
		dataset.DataID = sSelectPageName + D_P1("ACT","CLSE_REQ_ALL_CANCEL");
									
	}
	else if(dataset == dsCLSE)
	{
 
		dataset.DataID = sSelectPageName + D_P1("ACT","CLSE");
									
	}
	else if(dataset == dsCLSE_ALL)
	{
 
		dataset.DataID = sSelectPageName + D_P1("ACT","CLSE_ALL");
									
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
function	checkConditions()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("���� ������ڵ带 �����ϼ���.", "Ȯ��");
		return false;
	}

	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("���� ȸ�⸦ �����ϼ���.", "Ȯ��");
		return false;
	}
	return true;
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
	if(!checkConditions()) return;
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
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "REQ_CLSE_DT")
	{
		dsMAIN.NameValue(dsMAIN.RowPosition,"REQ_CLSE_DT") = asDate;
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
	if ( dataset == dsMAIN)
	{
		dataset.NameValue(row,"COMP_CODE") 	    =txtCOMP_CODE.value;
		dataset.NameValue(row,"COMPANY_NAME")   =  txtCOMPANY_NAME.value;	
		dataset.NameValue(row,"CLSE_ACC_ID")	   =txtCLSE_ACC_ID.value;
		dataset.NameValue(row,"REQ_CLSE_CLS")	   ="T";
		dataset.NameString(row,"REQ_CLSE_DT") = vDate; 
	}
}

function OnRowDeleteBefore(dataset)
{
	return true;
}

function OnRowDeleted(dataset, row)
{
}
function OnPostBefore(dataset, trans)
{
	if ( dataset == dsMAIN)
	{
		G_Load(dsMAKE_DT,null);
		if(parseInt(dsMAKE_DT.NameValue(dsMAKE_DT.RowPosition,"MAKE_DT_F")) >parseInt(dsMAIN.NameValue(dsMAIN.RowPosition, "REQ_CLSE_DT").toString().replace(/-/g, ""))
		  || parseInt(dsMAKE_DT.NameValue(dsMAKE_DT.RowPosition,"MAKE_DT_T")) <parseInt(dsMAIN.NameValue(dsMAIN.RowPosition, "REQ_CLSE_DT").toString().replace(/-/g, "")))
		{
			C_msgOk("�������� ���Ⱓ�ȿ��� �����ؾ� �մϴ�");
			return false;	
		}
	}
	return true;
}
function OnColumnChanged(dataset, row, colid)
{
	if (dataset == dsMAIN)
	{
		if(colid == "REQ_CLSE_CLS")
		{
			if(dsMAIN.NameString(row,"REQ_CLSE_CLS")=="F")
			{
				dsMAIN.NameString(row,"REQ_CLSE_DT") = ""; 
			}
			else
			{
				dsMAIN.NameString(row,"REQ_CLSE_DT") = vDate;
			}
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
	if ( dataset == dsMAIN)
	{
		if ( colid =="COMP_CODE")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_COMP_CODE1", lrArgs,"T");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row,"COMP_CODE") = lrRet.get("COMP_CODE");
			dataset.NameValue(row,"COMPANY_NAME") =  lrRet.get("COMPANY_NAME");
		}
		else if ( colid == "DEPT_CODE")
		{
			if(!CheckCompCode()) return;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
			lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
		
			lrRet = C_LOV("T_BUDG_DEPT_CODE2", lrArgs,"T");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row,"DEPT_CODE")	= lrRet.get("DEPT_CODE");
			dataset.NameValue(row,"DEPT_NAME")	= lrRet.get("DEPT_NAME");
			
		}
		else if ( colid == "REQ_CLSE_DT")
		{
			C_Calendar("REQ_CLSE_DT", "D", dsMAIN.NameValue(dsMAIN.RowPosition,"REQ_CLSE_DT"));
		}
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
function txtDEPT_CODE_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_NAME.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE4", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		dsMAIN.ClearData();
	}
	else
	{
		D_defaultLoad();
	}
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
	
	if(C_isNull(txtDEPT_CODE.value))
	{
		dsMAIN.ClearData();
	}
	else
	{
		D_defaultLoad();
	}
}
function btnDEPT_CODE_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_BUDG_DEPT_CODE2", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	
	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		dsMAIN.ClearData();
	}
	else
	{
		D_defaultLoad();
	}
}
function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("CLSE_ACC_ID", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_BUDG_YEAR", lrArgs,"F");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
	if(C_isNull(txtDEPT_CODE.value))
	{
		dsMAIN.ClearData();
	}
	else
	{
		D_defaultLoad();
	}
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
function checkRowCnt()
{
	if ( dsMAIN.CountRow <1)
	{
		C_msgOk("ó���� ����� �������� �ʽ��ϴ�.", "Ȯ��");
		return false;
	}
	return true;
}
//�����μ��ϰ����
function btnInsertClseReqAll_onClick()
{
	
	var arrRec = new Array(3);
	
	G_Load(dsMAKE_DT,null);
	arrRec[0] = dsMAKE_DT.NameValue(dsMAKE_DT.RowPosition,"MAKE_DT_F");
       arrRec[1] = dsMAKE_DT.NameValue(dsMAKE_DT.RowPosition,"MAKE_DT_T");
       
	var arrRtn2 = null;

	arrRtn2 = window.showModalDialog("t_PBudgCloseR.jsp", arrRec, "center:yes; dialogWidth:300px; dialogHeight:300px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
	
	if(arrRtn2[0]=="TRUE")
	{
		
		G_Load(dsCLSE_REQ_ALL);
 
		dsCLSE_REQ_ALL.NameString(dsCLSE_REQ_ALL.RowPosition,"REQ_CLSE_DT") 	= arrRtn2[1];
		
		dsCLSE_REQ_ALL.NameString(dsCLSE_REQ_ALL.RowPosition,"COMP_CODE")      =  txtCOMP_CODE.value;
		dsCLSE_REQ_ALL.NameString(dsCLSE_REQ_ALL.RowPosition,"CLSE_ACC_ID")     =  txtCLSE_ACC_ID.value;
		
		transClseReqAll.Parameters = "ACT=CLSE_REQ_ALL";
		if(!G_saveData(dsCLSE_REQ_ALL)) return;
		C_msgOk("��� ������û  �ϰ������ ���� ó���Ǿ����ϴ�.");
		
	}
	G_Load(dsMAIN, null);
}
//�����μ��ϰ�������
function btnInsertClseReqAllCancel_onClick()
{
	
	G_Load(dsCLSE_REQ_ALL_CANCEL);
 
	dsCLSE_REQ_ALL_CANCEL.NameString(dsCLSE_REQ_ALL_CANCEL.RowPosition,"COMP_CODE")      =  txtCOMP_CODE.value;
	dsCLSE_REQ_ALL_CANCEL.NameString(dsCLSE_REQ_ALL_CANCEL.RowPosition,"CLSE_ACC_ID")     =  txtCLSE_ACC_ID.value;
		
	transClseReqAllCancel.Parameters = "ACT=CLSE_REQ_ALL_CANCEL";
	if(!G_saveData(dsCLSE_REQ_ALL_CANCEL)) return;
	C_msgOk("��� ������û  �ϰ���� ��Ұ�  ���� ó���Ǿ����ϴ�.");
		
	G_Load(dsMAIN, null);
}
//����ó��/���
function clseProcess(div,msg)
{
	if(!checkRowCnt()) return;
	if(C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("������� �����ϼ���");
		return;	
	}
	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("ȸ�⸦ �����ϼ���");
		return;	
	}
	if(C_isNull(dsMAIN.NameValue(dsMAIN.RowPosition, "DEPT_CODE")))
	{
		C_msgOk("�μ��� �Է��ϼ���");
		return;	
	}
	if (div =="T")
	{
		if(C_isNull(dsMAIN.NameValue(dsMAIN.RowPosition, "REQ_CLSE_DT")))
		{
			C_msgOk("��û��������  �Է��ϼ���");
			return;	
		}
	}
	G_Load(dsCLSE);
	dsCLSE.NameString(dsCLSE.RowPosition,"COMP_CODE")       =  txtCOMP_CODE.value;
	dsCLSE.NameString(dsCLSE.RowPosition,"CLSE_ACC_ID")     	=  txtCLSE_ACC_ID.value;
	dsCLSE.NameString(dsCLSE.RowPosition,"DEPT_CODE")     	=  dsMAIN.NameValue(dsMAIN.RowPosition, "DEPT_CODE");
	dsCLSE.NameString(dsCLSE.RowPosition,"REQ_CLSE_DT") 	=  dsMAIN.NameValue(dsMAIN.RowPosition, "REQ_CLSE_DT");
	if (div =="T")
	{
		dsCLSE.NameString(dsCLSE.RowPosition,"REQ_CLSE_CLS")	=  "T";
	}
	else if (div =="F")
	{
		dsCLSE.NameString(dsCLSE.RowPosition,"REQ_CLSE_CLS")	=  "F";
	}
	
	transClse.Parameters = "ACT=CLSE";
	if(!G_saveData(dsCLSE)) return;
	
	C_msgOk(msg + "  ���� ó���Ǿ����ϴ�.");
	
	G_Load(dsMAIN, null);
}
//�ϰ�����/���ó��
function clseAllProcess(div, msg)
{
	if(!checkRowCnt()) return;
	if(C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("������� �����ϼ���");
		return;	
	}
	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("ȸ�⸦ �����ϼ���");
		return;	
	}
	
	var arrRec = new Array(3);
	
	G_Load(dsMAKE_DT,null);
	arrRec[0] = dsMAKE_DT.NameValue(dsMAKE_DT.RowPosition,"MAKE_DT_F");
       arrRec[1] = dsMAKE_DT.NameValue(dsMAKE_DT.RowPosition,"MAKE_DT_T");
       
       G_Load(dsCLSE_ALL);
	var arrRtn2 = null;
	if (div =="T")
	{
		arrRtn2 = window.showModalDialog("t_PBudgCloseR.jsp", arrRec, "center:yes; dialogWidth:300px; dialogHeight:270px; status:no; help:no; scroll:no");
	
		if(arrRtn2 == null) return;
		if(arrRtn2[0]=="TRUE")
		{
			dsCLSE_ALL.NameString(dsCLSE_ALL.RowPosition,"REQ_CLSE_DT")    = arrRtn2[1];
		}
	}
	else
	{
		dsCLSE_ALL.NameString(dsCLSE_ALL.RowPosition,"REQ_CLSE_DT")    = "";
	}	
	
 		
	dsCLSE_ALL.NameString(dsCLSE_ALL.RowPosition,"COMP_CODE")      =  txtCOMP_CODE.value;
	dsCLSE_ALL.NameString(dsCLSE_ALL.RowPosition,"CLSE_ACC_ID")     =  txtCLSE_ACC_ID.value;
	
	if (div =="T")
	{
		dsCLSE_ALL.NameString(dsCLSE_ALL.RowPosition,"REQ_CLSE_CLS")	=  "T";
	}
	else if (div =="F")
	{
		dsCLSE_ALL.NameString(dsCLSE_ALL.RowPosition,"REQ_CLSE_CLS")	=  "F";
	}
	
	transClseAll.Parameters = "ACT=CLSE_ALL";
	if(!G_saveData(dsCLSE_ALL)) return;
	C_msgOk(msg + "  ���� ó���Ǿ����ϴ�.");
		
	
	G_Load(dsMAIN, null);
}
//����
function btnClse_onClick()
{
	clseProcess("T","������");
}
//�������
function btnClseCancel_onClick()
{
	clseProcess("F","������Ұ�");
}

//�ϰ�����
function btnClseAll_onClick()
{
	clseAllProcess("T", "�ϰ�������");
}
//�ϰ��������
function btnClseAllCancel_onClick()
{
	clseAllProcess("F", "�ϰ����� ��Ұ�");
}