/**************************************************************************/
/* 1. �� �� �� �� id : t_WBudgChgRequestR.js(���꺯���û)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : ���꺯���û��� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-20)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�����û����");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "��������", null, null, true);
	G_addDataSet(dsSUB02, trans, gridSUB02, sSelectPageName+D_P1("ACT","SUB02"), "���������û����"); 
	
	G_addDataSet(dsCHG_SEQ, null, null, null, "���꺯������");
	G_addDataSet(dsSEQ, null, null, null, "����");
	G_addDataSet(dsCHANGE_CANCEL, transChangeCancel, null,null, "���꺯�����");
	G_addDataSet(dsREQUEST_FINISH, transRequestFinish, null,null, "��û�Ϸ�");
	G_addDataSet(dsREQUEST_FINISH_CANCEL, transRequestFinishCancel, null,null, "��û�Ϸ����");
	G_addDataSet(dsREASON_NO, null, null,null, "��������");
	G_addDataSet(dsLOV, null, null,null, "LOV");
	G_addDataSet(dsOLD_BUDG, null, null,null, "��������");
	
	
	G_addDataSet(dsCONFIRM, transConfirm, null,null, "Ȯ��ó��");
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB01,"CLSE_ACC_ID","CLSE_ACC_ID");
	G_addRelCol(dsSUB01,"DEPT_CODE","DEPT_CODE");
	
	G_addRel(dsSUB01,dsSUB02);
	G_addRelCol(dsSUB02,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB02,"CLSE_ACC_ID","CLSE_ACC_ID");
	G_addRelCol(dsSUB02,"DEPT_CODE","DEPT_CODE");
	G_addRelCol(dsSUB02,"BUDG_CODE_NO","BUDG_CODE_NO");
	G_addRelCol(dsSUB02,"CHG_SEQ","CHG_SEQ");
	G_addRelCol(dsSUB02,"RESERVED_SEQ","RESERVED_SEQ");
	G_addRelCol(dsSUB02,"BUDG_YM","BUDG_YM");
	G_addRelCol(dsSUB02,"SEQ","SEQ");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtDEPT_CODE.value = sDeptCode;
	txtDEPT_NAME.value = sDeptName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;
	
	//G_Load(dsMAIN,null);
	gridMAIN.focus();
	
	G_setReadOnlyCol(gridMAIN,"CHG_SEQ");
	G_setReadOnlyCol(gridMAIN,"BUDG_APPLY_YM");
	G_setReadOnlyCol(gridMAIN,"REQUEST_TAG");
	G_setReadOnlyCol(gridMAIN,"CONFIRM_TAG"); 
	G_setReadOnlyCol(gridMAIN,"DIV_NAME"); 
	
	G_setReadOnlyCol(gridSUB01,"CHG_AMT");
	G_setReadOnlyCol(gridSUB01,"FULL_PATH");
	G_setReadOnlyCol(gridSUB01,"BUDG_MONTH_REQ_AMT");
	G_setReadOnlyCol(gridSUB01,"BUDG_MONTH_ASSIGN_AMT");
	G_setReadOnlyCol(gridSUB01,"CONFIRM_KIND_NAME"); 
	
	G_setReadOnlyCol(gridSUB02,"BUDG_MONTH_REQ_AMT");
	G_setReadOnlyCol(gridSUB02,"BUDG_MONTH_ASSIGN_AMT");
	//G_setReadOnlyCol(gridSUB02,"R_BUDG_YM");
	
	G_setLovCol(gridSUB01,"BUDG_CODE_NAME");
	G_setLovCol(gridSUB01,"BUDG_YM");
	
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE",txtCOMP_CODE.value)
									 + D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
									 + D_P2("DEPT_CODE",txtDEPT_CODE.value);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("COMP_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE"))
										 + D_P2("CLSE_ACC_ID",dsMAIN.NameString(dsMAIN.RowPosition,"CLSE_ACC_ID"))
										 + D_P2("DEPT_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"DEPT_CODE"))
										 + D_P2("CHG_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"CHG_SEQ"))
										 + D_P2("RESERVED_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"RESERVED_SEQ"))
										 + D_P2("BUDG_CODE_NO",dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_CODE_NO"));
	}
	else if(dataset == dsSUB02)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB02")
									+ D_P2("COMP_CODE",txtCOMP_CODE.value)
									 + D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
									 + D_P2("DEPT_CODE",txtDEPT_CODE.value)
									 + D_P2("CHG_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"CHG_SEQ"))
									 + D_P2("RESERVED_SEQ",dsSUB01.NameString(dsSUB01.RowPosition,"RESERVED_SEQ"))
									 + D_P2("BUDG_CODE_NO",dsSUB01.NameString(dsSUB01.RowPosition,"BUDG_CODE_NO"))
									 + D_P2("BUDG_YM",dsSUB01.NameString(dsSUB01.RowPosition,"BUDG_YM"))
									 + D_P2("SEQ",dsSUB01.NameString(dsSUB01.RowPosition,"SEQ"));
	}
	else if(dataset == dsREASON_NO) 
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","REASON_NO");
									
	}
	else if(dataset == dsCHG_SEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CHG_SEQ")
									 + D_P2("COMP_CODE",txtCOMP_CODE.value)
									 + D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
									 + D_P2("DEPT_CODE",txtDEPT_CODE.value);
	}
	else if(dataset == dsCONFIRM) 
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CONFIRM");
									
	}
	else if(dataset == dsSEQ) 
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SEQ");
									
	}
	else if(dataset == dsCHANGE_CANCEL) 
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CHANGE_CANCEL");
									
	}
	else if(dataset == dsREQUEST_FINISH) 
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","REQUEST_FINISH");
									
	}
	else if(dataset == dsREQUEST_FINISH_CANCEL) 
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","REQUEST_FINISH_CANCEL");
									
	}
	else if(dataset == dsOLD_BUDG)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","OLD_BUDG")
									 + D_P2("COMP_CODE",dsSUB01.NameString(dsSUB01.RowPosition,"COMP_CODE"))
									 + D_P2("CLSE_ACC_ID",dsSUB01.NameString(dsSUB01.RowPosition,"CLSE_ACC_ID"))
									 + D_P2("DEPT_CODE",dsSUB01.NameString(dsSUB01.RowPosition,"DEPT_CODE"))
									 + D_P2("BUDG_CODE_NO",dsSUB01.NameString(dsSUB01.RowPosition,"BUDG_CODE_NO"))
									 + D_P2("BUDG_YM",C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"BUDG_YM"))?"":dsSUB01.NameString(dsSUB01.RowPosition,"BUDG_YM")+"-01");
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

function	chkTopCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("���� ������ڵ带 �����ϼ���.", "Ȯ��");
		return false;
	}
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("���� ȸ�⸦ �����ϼ���.", "Ȯ��");
		return false;
	}
	if (C_isNull(txtDEPT_CODE.value))
	{
		C_msgOk("���� �μ��� �����ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}
function	getDefaultData()
{
	G_Load(dsOLD_BUDG);
	if(dsOLD_BUDG.CountRow > 0 )
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"BUDG_MONTH_REQ_AMT") = dsOLD_BUDG.NameString(dsOLD_BUDG.RowPosition,"BUDG_MONTH_ASSIGN_AMT");
	}
	else
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"BUDG_MONTH_REQ_AMT") = 0;
	}
	calcBudgAmt();
}
function	calcBudgAmt()
{
	dsSUB01.NameString(dsSUB01.RowPosition,"BUDG_MONTH_ASSIGN_AMT") = C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"BUDG_MONTH_REQ_AMT")) + 
				C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"CHG_AMT"));
}
function	calcChgAmt()
{
	dsSUB01.NameValue(dsSUB01.RowPosition,"CHG_AMT") =  dsSUB02.NameSum("CHG_AMT",0,0);
	calcBudgAmt();
}
function getCOMPANY_CODE()
{
	var arrRec = new Array();

	arrRec[1] = txtCOMP_CODE.value;
	arrRec[2] = txtCLSE_ACC_ID.value;
	arrRec[3] = txtDEPT_CODE.value;
	
	return 	arrRec;
}

function getCHG_SEQ()
{
	var arrRec = new Array();
	
	G_Load(dsCHG_SEQ, null);
	arrRec[1] = dsCHG_SEQ.NameString(dsCHG_SEQ.RowPosition, "CHG_SEQ");

	return 	arrRec;
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
	D_defaultSave();
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}
//Ȯ��ó��
function budgChgRequestConfirm(CONFIRM_TAG, MSG)
{
	
	if(CONFIRM_TAG =='F')
	{
		if(dsMAIN.NameValue(dsMAIN.RowPosition, "DIV")=='A')
		{
			C_msgOk( "�ϰ� ������� Ȯ�� ��Ҹ� �� �� �����ϴ�.");
			return;
		}	
	}
	
	if(dsSUB01.CountRow < 1)
	{
		C_msgOk( "�߰� ��û�� �����ϴ�");
		return;
	}
	
	G_Load(dsCONFIRM);
	dsCONFIRM.NameString(dsCONFIRM.RowPosition,"COMP_CODE")  		= txtCOMP_CODE.value;
	dsCONFIRM.NameString(dsCONFIRM.RowPosition,"CLSE_ACC_ID") 	= txtCLSE_ACC_ID.value;
	dsCONFIRM.NameString(dsCONFIRM.RowPosition,"CHG_SEQ")      		= dsMAIN.NameString(dsMAIN.RowPosition, "CHG_SEQ");
	dsCONFIRM.NameString(dsCONFIRM.RowPosition,"DEPT_CODE")  		= dsMAIN.NameString(dsMAIN.RowPosition, "DEPT_CODE");
	dsCONFIRM.NameString(dsCONFIRM.RowPosition,"CONFIRM_TAG") 	= CONFIRM_TAG;
	
	//alert(dsCONFIRM_TAG.NameString(dsCONFIRM_TAG.RowPosition,"COMP_CODE"));

	transConfirm.Parameters = "ACT=CONFIRM";

	if(!G_saveData(dsCONFIRM)) return;
	
	G_Load(dsMAIN, null);
	C_msgOk( MSG +  " ���������� ����Ǿ����ϴ�.");
	gridMAIN.focus();
}
// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "BUDG_YM")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"BUDG_YM") = asDate;
		getDefaultData();
	}
}


function OnLoadCompleted(dataset, rowcnt)
{
	
}

function OnRowInsertBefore(dataset)
{
	if (dataset == dsSUB01)
	{
		var strCONFIRM_TAG = dsMAIN.NameValue(dsMAIN.RowPosition, "CONFIRM_TAG");
		var strREQUEST_TAG =  dsMAIN.NameValue(dsMAIN.RowPosition, "REQUEST_TAG");
		
		if (strCONFIRM_TAG == 'T')
		{
			C_msgOk('Ȯ���Ǿ� �߰��� �� �����ϴ�');
			return false;
		}
		
	}
	if (dataset == dsSUB02)
	{
		var strCONFIRM_TAG = dsMAIN.NameValue(dsMAIN.RowPosition, "CONFIRM_TAG");
		var strREQUEST_TAG =  dsMAIN.NameValue(dsMAIN.RowPosition, "REQUEST_TAG");
		
		if (strCONFIRM_TAG == 'T')
		{
			C_msgOk('Ȯ���Ǿ� �߰��� �� �����ϴ�');
			return false;
		}
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	if (dataset == dsMAIN)
	{
		dataset.NameValue(row,"COMP_CODE") = txtCOMP_CODE.value;
		dataset.NameValue(row,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
		dataset.NameValue(row,"DEPT_CODE")  = txtDEPT_CODE.value;
		dataset.NameValue(row,"CONFIRM_TAG")  = 'F';
		dataset.NameValue(row,"REQUEST_TAG")  = 'F';
	}
	
	if (dataset == dsSUB01)
	{
		G_Load(dsSEQ, null);
		dataset.NameValue(row,"COMP_CODE") = txtCOMP_CODE.value;
		dataset.NameValue(row,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
		dataset.NameValue(row,"DEPT_CODE")  = txtDEPT_CODE.value;
		dataset.NameValue(row,"CHG_SEQ")  = dsMAIN.NameValue(dsMAIN.RowPosition,"CHG_SEQ");
		dataset.NameString(row, "REASON_CODE") = "1";	
		dataset.NameString(row, "CONFIRM_KIND_NAME") = "����";
		dataset.NameString(row, "CONFIRM_KIND") = "1";
		dataset.NameString(row, "SEQ") = dsSEQ.NameValue(dsSEQ.RowPosition, "SEQ");
		dataset.NameString(row, "RESERVED_SEQ") = "1";
	}
	
	if (dataset == dsSUB02)
	{
		G_Load(dsREASON_NO, null);
		dataset.NameString(row, "REASON_NO") = dsREASON_NO.NameString(dsREASON_NO.RowPosition, "REASON_NO");
		
		if (dsSUB01.NameValue(dsSUB01.RowPosition,"REASON_CODE") == "4")
		{	
			dataset.NameValue(row,"R_COMP_CODE") = txtCOMP_CODE.value;
			dataset.NameValue(row,"R_CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
			dataset.NameValue(row,"R_DEPT_CODE")  = txtDEPT_CODE.value;
			dataset.NameValue(row,"R_CHG_SEQ")  = dsMAIN.NameValue(dsMAIN.RowPosition,"CHG_SEQ");
			dataset.NameValue(row,"R_BUDG_CODE_NO")  = dsSUB01.NameValue(dsSUB01.RowPosition,"BUDG_CODE_NO");
			dataset.NameValue(row,"R_RESERVED_SEQ")  = dsSUB01.NameValue(dsSUB01.RowPosition,"RESERVED_SEQ");
		}
		
	}
}

function OnRowDeleteBefore(dataset)
{
	if ( dataset = dsSUB02)
	{			
	}
	else if(dataset = dsSUB01)
	{
		dsSUB02.ClearData();
	}
	
	return true;
}

function OnRowDeleted(dataset, row)
{
	if ( dataset = dsSUB02)
	{
		calcChgAmt();
	}
}

function OnColumnChanged(dataset, row, colid)
{
	if ( dataset == dsSUB02 && colid == "CHG_AMT")
	{
		calcChgAmt();
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsSUB01)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "BUDG_YM")
		{
			D_defaultYmProcessInGrid(dataset, row, colid, olddata,COL_DATA);
			getDefaultData();
		}
		else if(colid == "BUDG_CODE_NAME")
		{
			if(olddata == COL_DATA) return;
			if(C_isNull(COL_DATA))
			{
				dataset.NameValue(row,"FULL_PATH")	= "";
				dataset.NameValue(row,"BUDG_CODE_NAME")	= "";
				dataset.NameValue(row,"BUDG_CODE_NO")	= "";
				getDefaultData();
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
			lrArgs.set("SEARCH_CONDITION", COL_DATA);
		
			lrRet = C_AutoLov(dsLOV,"T_BUDG_ITEM_SEARCH01", lrArgs,"T");
			if (lrRet != null)
			{
				if(row > 0)
				{
					dataset.NameValue(row,"FULL_PATH")	= lrRet.get("FULL_PATH");
					dataset.NameValue(row,"BUDG_CODE_NAME")	= lrRet.get("BUDG_CODE_NAME");
					dataset.NameValue(row,"BUDG_CODE_NO")	= lrRet.get("BUDG_CODE_NO");
					getDefaultData();
				}
			}
			else
			{
				dataset.NameString(row,colid) = olddata;
			}
		}
	}
	if ( dataset== dsSUB02)
	{	
		if ( colid =="R_BUDG_YM")
		{
			if ( dataset.NameValue(dataset.RowPosition,"R_BUDG_YM")=="")
			{
				dataset.NameValue(dataset.RowPosition,"BUDG_MONTH_REQ_AMT")=="";
			}	
		}
		else if ( colid =="CHG_AMT")
		{
			if ( dsSUB01.NameValue(dsSUB01.RowPosition,"REASON_CODE")==4)
			{
				if ( dataset.NameValue(dataset.RowPosition,"R_BUDG_YM")=="")
				{
					C_msgOk("��õ������� �Է��ϼ���");
					dataset.NameValue(row,"CHG_AMT") = 0;
					return false;
				}
				if ( dataset.NameValue(row,"BUDG_MONTH_REQ_AMT") > 0 && (dataset.NameValue(row,"BUDG_MONTH_REQ_AMT") < dataset.NameValue(row,"CHG_AMT")))
				{
					C_msgOk("����ݾ��� ��õ��û�ݾ��� �ʰ��� �� �����ϴ�.");
					dataset.NameValue(row,"CHG_AMT") = 0;
					return false;
				}
			}
			
			dsSUB01.NameValue(dsSUB01.RowPosition,"BUDG_MONTH_ASSIGN_AMT") = dsSUB01.NameValue(dsSUB01.RowPosition,"BUDG_MONTH_ASSIGN_AMT")  - dsSUB01.NameValue(dsSUB01.RowPosition,"CHG_AMT") + dsSUB02.NameSum("CHG_AMT",0,0);
			dsSUB01.NameValue(dsSUB01.RowPosition,"CHG_AMT") =  dsSUB02.NameSum("CHG_AMT",0,0);
			//dsSUB01.NameValue(dsSUB01.RowPosition,"BUDG_MONTH_ASSIGN_AMT") =dsSUB01.NameSum	("CHG_AMT",0,0);
			
		}
		
	}
}
function OnPostBefore(dataset, trans)
{
	if ( dataset== dsSUB02)
	{	
		if ( dataset.NameValue(dataset.RowPosition,"CHG_AMT")==0)
		{
			C_msgOk("����ݾ��� �Է��ϼ���");
			return false;
		}
	}
	return true;
}
function OnPopup(dataset, grid, row, colid, data)
{
	if ( dataset ==dsSUB01)
	{
		if(colid == "BUDG_YM")
		{
			C_Calendar("BUDG_YM", "M", dataset.NameString(dataset.RowPosition,colid));
			return;
		}
		else if(colid == "BUDG_CODE_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_BUDG_ITEM_SEARCH01", lrArgs,"F");
			if (lrRet != null)
			{
				dataset.NameValue(row,"FULL_PATH")	= lrRet.get("FULL_PATH");
				dataset.NameValue(row,"BUDG_CODE_NAME")	= lrRet.get("BUDG_CODE_NAME");
				dataset.NameValue(row,"BUDG_CODE_NO")	= lrRet.get("BUDG_CODE_NO");
				getDefaultData();
			}
		}
	}
	
	if ( dataset ==dsSUB02)
	{
		
		if(!CheckCompCode()) return;
		if (dsSUB01.NameValue(dsSUB01.RowPosition,"REASON_CODE") != "4")
		{
			C_msgOk("�����̿��ø� �Է��ϼ���");
			return;
		}
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("1COMP_CODE", txtCOMP_CODE.value);
		lrArgs.set("2COMP_CODE", txtCOMP_CODE.value);
		lrArgs.set("3COMP_CODE", txtCOMP_CODE.value);
		lrArgs.set("CLSE_ACC_ID", txtCLSE_ACC_ID.value);
		lrArgs.set("DEPT_CODE", txtDEPT_CODE.value);
		lrArgs.set("CHG_SEQ", dsMAIN.NameValue(dsMAIN.RowPosition,"CHG_SEQ"));
		//lrArgs.set("BUDG_YM", getYearMonth("-"));
		//lrArgs.set("BUDG_YM", "2005-10");
		lrArgs.set("SEARCH_CONDITION", "");
		
		//��������˻�
		//lrRet = C_LOV("T_BUDG_DEPT_CODE3", lrArgs,"T");//��翹����ȸ
		lrRet = C_LOV("T_BUDG_CODE3", lrArgs,"F");//����������ȸ
		
		if (lrRet == null) return;
		var strR_BUDG_YM = lrRet.get("BUDG_YM");
		if ( strR_BUDG_YM ==  dsSUB01.NameValue(dsSUB01.RowPosition,"BUDG_YM"))
		{
				C_msgOk("��õ���� ���濹������� ũ�� �����ϼ���");
				dataset.NameValue(row,"R_COMP_CODE") = "";
				dataset.NameValue(row,"R_CLSE_ACC_ID") = "";
				dataset.NameValue(row,"R_DEPT_CODE")  = "";
				dataset.NameValue(row,"R_CHG_SEQ")  = "";
				dataset.NameValue(row,"R_BUDG_CODE_NO")  = "";
				dataset.NameValue(row,"R_RESERVED_SEQ")  = "";
				dataset.NameValue(row,"R_BUDG_YM")	= "";
				return false;
		}	
		dataset.NameValue(row,"BUDG_MONTH_REQ_AMT")		= lrRet.get("BUDG_MONTH_REQ_AMT");
		dataset.NameValue(row,"R_BUDG_YM")					= lrRet.get("BUDG_YM");
		
	}
}
function OnClick(dataset, grid, row, colid)
{
	
}
// �̺�Ʈ����-------------------------------------------------------------------//
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		//dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtDEPT_CODE.value = "";
	txtDEPT_NAME.value = "";
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	//dsMAIN.ClearData();
}
function txtDEPT_CODE_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_NAME.value = "";
		//dsMAIN.ClearData();
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
	
}
function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value = "";
		//dsMAIN.ClearData();
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
	txtDEPT_CODE.value = "";
	txtDEPT_NAME.value = "";
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";

}
function btnDEPT_CODE_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_DEPT_CODE4", lrArgs,"F");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	

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

//���꺯���û
function 	btnBudgChgRequest_onClick()
{
	if(!chkTopCondition()) return;
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var ret = C_msgYesNo("�� �۾��� ���ؼ��� ���� ������ �ϼž� �մϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return ;
		}
		else if(ret == "N")
		{
			return false;
		}
	}
	
	var arrRtn = getCHG_SEQ();
	if( arrRtn[1] == -1)
	{
		C_msgOk("���ʿ����� ��ϵ��� �ʾ�  �����û�� �Ұ����մϴ�");
		return false; 	
	}
	if(dsMAIN.CountRow > 0 && dsMAIN.NameString(dsMAIN.CountRow,"CONFIRM_TAG")!= "T" )
	{
		C_msgOk("�� ��ϵ� ���� ��û�� ��Ȯ���Ǿ� �߰����� ���� ��û�� �Ұ��� �մϴ�.");
		return false; 	
	}
	var arrRtn2 = null;

	arrRtn2 = window.showModalDialog("t_PBudgChgRequestR.jsp", arrRtn, "center:yes; dialogWidth:245px; dialogHeight:255px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
	
	if(arrRtn2[0]=="TRUE")
	{
		
		G_addRow(dsMAIN);
		
		dsMAIN.NameValue(dsMAIN.RowPosition,"CHG_SEQ") 			= arrRtn2[1];
		dsMAIN.NameValue(dsMAIN.RowPosition,"BUDG_APPLY_YM2")  	= arrRtn2[2] +'-01';

		//gridMAIN.focus();
	}
	
	if(!G_saveData(dsMAIN)) return;
	
	G_Load(dsMAIN, null);
	C_msgOk("���꺯���û��  ���������� ����Ǿ����ϴ�.");
}

//���꺯���û���
function 	btnBudgChgRequestCancel_onClick()
{
	if(dsMAIN.RowPosition < 1) return;
	var		lsMsg = C_msgYesNo("���� ���õ� �߰����� ��û���� ����Ͻðڽ��ϱ�?");
	if(lsMsg == "N") return;
	G_Load(dsCHANGE_CANCEL);
	dsCHANGE_CANCEL.NameString(dsCHANGE_CANCEL.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsCHANGE_CANCEL.NameString(dsCHANGE_CANCEL.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsCHANGE_CANCEL.NameString(dsCHANGE_CANCEL.RowPosition,"CHG_SEQ") = dsMAIN.NameString(dsMAIN.RowPosition, "CHG_SEQ");
	dsCHANGE_CANCEL.NameString(dsCHANGE_CANCEL.RowPosition,"DEPT_CODE") = txtDEPT_CODE.value;
	
	transChangeCancel.Parameters = "ACT=CHANGE_CANCEL";
	
	if(!G_saveData(dsCHANGE_CANCEL))return;
	
	G_Load(dsMAIN, null);
	C_msgOk("���꺯����Ұ� ���������� ����Ǿ����ϴ�.");
	gridMAIN.focus();
}

//��û�Ϸ�
/*<input id="btnBudgChgRequestFinish" type="button" class="img_btn4_1" value="��û�Ϸ�" onclick="btnBudgChgRequestFinish_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">*/
/*<input id="btnBudgChgRequestFinishCancel" type="button" class="img_btn6_1" value="��û�Ϸ����" onclick="btnBudgChgRequestFinishCancel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">*/
function 	btnBudgChgRequestFinish_onClick()
{
	G_Load(dsREQUEST_FINISH);
	dsREQUEST_FINISH.NameString(dsREQUEST_FINISH.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsREQUEST_FINISH.NameString(dsREQUEST_FINISH.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsREQUEST_FINISH.NameString(dsREQUEST_FINISH.RowPosition,"CHG_SEQ") = dsMAIN.NameString(dsMAIN.RowPosition, "CHG_SEQ");
	dsREQUEST_FINISH.NameString(dsREQUEST_FINISH.RowPosition,"DEPT_CODE") = txtDEPT_CODE.value;
	dsREQUEST_FINISH.NameString(dsREQUEST_FINISH.RowPosition,"REQUEST_TAG") = "T";
	
	transRequestFinish.Parameters = "ACT=REQUEST_FINISH";
	
	if(!G_saveData(dsREQUEST_FINISH)) return;
	
	G_Load(dsMAIN, null);
	C_msgOk("��û�Ϸᰡ ���������� ����Ǿ����ϴ�.");
	gridMAIN.focus();
}
//��û�Ϸ����
function 	btnBudgChgRequestFinishCancel_onClick()
{
	G_Load(dsREQUEST_FINISH_CANCEL);
	dsREQUEST_FINISH_CANCEL.NameString(dsREQUEST_FINISH_CANCEL.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsREQUEST_FINISH_CANCEL.NameString(dsREQUEST_FINISH_CANCEL.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsREQUEST_FINISH_CANCEL.NameString(dsREQUEST_FINISH_CANCEL.RowPosition,"CHG_SEQ") = dsMAIN.NameString(dsMAIN.RowPosition, "CHG_SEQ");
	dsREQUEST_FINISH_CANCEL.NameString(dsREQUEST_FINISH_CANCEL.RowPosition,"DEPT_CODE") = txtDEPT_CODE.value;
	dsREQUEST_FINISH_CANCEL.NameString(dsREQUEST_FINISH_CANCEL.RowPosition,"REQUEST_TAG") = "F";
	
	transRequestFinishCancel.Parameters = "ACT=REQUEST_FINISH_CANCEL";
	
	if(!G_saveData(dsREQUEST_FINISH_CANCEL))return;
	
	G_Load(dsMAIN, null);
	C_msgOk("��û�Ϸ���Ұ� ���������� ����Ǿ����ϴ�.");
	gridMAIN.focus();
}

//���꺯��Ȯ��
function 	btnBudgChgRequestConfirm_onClick()
{
	budgChgRequestConfirm("T", "���꺯��Ȯ����");
}
//���꺯��Ȯ�����
function 	btnBudgChgRequestConfirmCancel_onClick()
{
	budgChgRequestConfirm("F", "���꺯��Ȯ����Ұ�");
}