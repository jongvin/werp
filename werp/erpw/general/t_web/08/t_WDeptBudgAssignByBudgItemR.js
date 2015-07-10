/**************************************************************************/
/* 1. �� �� �� �� id : t_WDeptBudgAssignByDeptR(�μ��������μ���)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-15)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			sBudgCodeNo = "";
var			sBudgItemCode = "";
var			sBudgItemName = "";
var			sBudgItemFullPath = "";
var			bNowCalc = false;
var			sConfirm = "";
function Initialize()
{
	G_addDataSet(dsMASTER, trans, gridMASTER, null, "�μ����",null,null,true);
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "�μ����� ���",null,null,true);
	G_addDataSet(dsSUB01, trans, gridSUB01, null, "����������");
	G_addDataSet(dsBUDG_ITEM, null, null, null, "�μ����� ��� ��������");
	
	
	G_addDataSet(dsCOPY,transCopy,null,null,"����");
	G_addDataSet(dsDVD_MONTHS,transDvd,null,null,"�ϰ���������");
	G_addDataSet(dsCONFIRM,transConfirm,null,null,"����Ȯ�����");
	G_addDataSet(dsCONFIRM_ALL,transConfirmAll,null,null,"���μ�����Ȯ�����");
	G_addDataSet(dsDEPT_ALL,transDeptAll,null,null,"�ϰ��μ����");
	G_addDataSet(dsBUDG_ITEM_ALL,transBudgItemAll,null,null,"�μ����ϰ��׸���");
	
	G_addDataSet(dsITEM_COST, transItemCost, null,null, "�ܰ�����");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	G_addRel(dsMASTER,dsMAIN);
	G_addRelCol(dsMAIN,"BUDG_CODE_NO","BUDG_CODE_NO");

	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB01,"CLSE_ACC_ID","CLSE_ACC_ID");
	G_addRelCol(dsSUB01,"DEPT_CODE","DEPT_CODE");
	G_addRelCol(dsSUB01,"BUDG_CODE_NO","BUDG_CODE_NO");
	G_addRelCol(dsSUB01,"CHG_SEQ","CHG_SEQ");
	G_addRelCol(dsSUB01,"RESERVED_SEQ","RESERVED_SEQ");
	G_setLovCol(gridSUB01,"BUDG_YM");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;
	txtMAKE_DEPT_CODE.value = sDeptCode;
	txtMAKE_DEPT_NAME.value = sDeptName;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;
	gridMASTER.focus();
	
	G_setReadOnlyCol(gridMASTER,"FULL_PATH");
	G_setReadOnlyCol(gridMASTER,"BUDG_ITEM_REQ_AMT_SUM");
	G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"BUDG_ITEM_REQ_AMT");
	//G_setReadOnlyCol(gridMASTER,"BUDG_ITEM_ASSIGN_AMT_SUM");

	G_setReadOnlyCol(gridSUB01,"BUDG_YM");
	
	
	//G_Load(dsMASTER);
	
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMASTER)	//���μ��������׸� ��������
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MASTER")
										+ D_P2("COMP_CODE", txtCOMP_CODE.value)
										+ D_P2("CLSE_ACC_ID", txtCLSE_ACC_ID.value)
										+ D_P2("RESERVED_SEQ", "1")
										+ D_P2("CHG_SEQ","0")
										+ D_P2("MAKE_DEPT",txtMAKE_DEPT_CODE.value);
										
											
	}
	else if (dataset == dsMAIN)	//�μ���� ��������
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE", txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID", txtCLSE_ACC_ID.value)
											+ D_P2("BUDG_CODE_NO", dsMASTER.NameString(dsMASTER.RowPosition,"BUDG_CODE_NO"))
											+ D_P2("CHG_SEQ","0");
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("COMP_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE"))
											+ D_P2("CLSE_ACC_ID",dsMAIN.NameString(dsMAIN.RowPosition,"CLSE_ACC_ID"))
											+ D_P2("DEPT_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"DEPT_CODE"))
											+ D_P2("CHG_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"CHG_SEQ"))
											+ D_P2("RESERVED_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"RESERVED_SEQ"))
											+ D_P2("BUDG_CODE_NO",dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_CODE_NO"));
	}
	else if(dataset == dsBUDG_ITEM)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","BUDG_ITEM")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
											+ D_P2("CHG_SEQ","0")
											+ D_P2("BUDG_CODE_NO",sBudgCodeNo);
	}
	else if(dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","COPY");
	}
	else if(dataset == dsITEM_COST)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","ITEM_COST");
	}
	else if(dataset == dsDVD_MONTHS)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","DVD_MONTHS");
	}
	else if(dataset == dsCONFIRM)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CONFIRM");
	}
	else if(dataset == dsCONFIRM_ALL)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CONFIRM_ALL");
	}
	else if(dataset == dsDEPT_ALL)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","DEPT_ALL");
	}
	else if(dataset == dsBUDG_ITEM_ALL)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","BUDG_ITEM_ALL");
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
function	dvdMonth()
{
	
	if(!checkConditions()) return;
	if(!D_checkIsLoadedInternal(dsSUB01)) return ;
	if(!D_checkMasterRowExistsInternal(dsSUB01,"��������")) return ;
	var		lsYearMonth = txtCLSE_ACC_ID.value + "-01";
	var		ldReqAmt = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_REQ_AMT"));
	//var		ldAssignAmt = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_ASSIGN_AMT"));
	var		ldMonthReqAmt = Math.floor(ldReqAmt / 12);
	//var		ldMonthAssignAmt = Math.floor(ldAssignAmt /  12);
	var		ldReqTotal = 0;
	var		ldAssignTotal = 0;
	
	for(var i = 0 ; i < 12 ; ++ i)
	{
		var		lsYm = addMonthsString(lsYearMonth,i);
		var		liRow = dsSUB01.NameValueRow("BUDG_YM",lsYm);
		if(liRow == 0) //���ٸ�
		{
			G_addRow(dsSUB01);
			liRow = dsSUB01.RowPosition;
			dsSUB01.NameString(liRow,"BUDG_YM") = lsYm;
		}
		if(i == 11)
		{
			ldMonthReqAmt = ldReqAmt - ldReqTotal;
			//ldMonthAssignAmt = ldAssignAmt - ldAssignTotal;
		}
		dsSUB01.NameString(liRow,"BUDG_MONTH_REQ_AMT") = ldMonthReqAmt;
		//dsSUB01.NameString(liRow,"BUDG_MONTH_ASSIGN_AMT") = ldMonthAssignAmt;
		ldReqTotal += ldMonthReqAmt;
		//ldAssignTotal += ldMonthAssignAmt;
	}
}
function	reCalcSum1()
{
	//if(!chkNumber.checked) return;
	
	if(bNowCalc) return;
	
	dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_REQ_AMT") = dsSUB01.NameSum("BUDG_MONTH_REQ_AMT",0,0);
		
}
function	reCalcSum2()
{
	//if(!chkNumber.checked) return;
	
	if(bNowCalc) return;
	
	//dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_ASSIGN_AMT") = dsSUB01.NameSum("BUDG_MONTH_ASSIGN_AMT",0,0);
	
}
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
function	monthToNumber(asMonth)
{
	if(asMonth.substr(0,1) == "0")
	{
		return parseInt(asMonth.substr(1,1));
	}
	else 
	{
		return parseInt(asMonth);
	}
}
function	numberToMonth(aiMonth)
{
	if(aiMonth > 0 && aiMonth < 10)
	{
		return "0"+aiMonth.toString();
	}
	else
	{
		return aiMonth.toString();
	}
}
function	addMonthsString(asYmValue,aNumber)
{
	var	lsYm = asYmValue.replace(/-/g, "");
	var	liYear = parseInt(lsYm.substr(0,4));
	var	liMonth = monthToNumber(lsYm.substr(4,2));
	var	liTotalMonths = liYear * 12 + liMonth + aNumber;
	liMonth = liTotalMonths % 12 == 0 ? 12 : liTotalMonths % 12 ;
	liYear = liMonth == 12 ? Math.floor(liTotalMonths / 12) - 1 : Math.floor(liTotalMonths / 12);
	return liYear.toString() + "-" + numberToMonth(liMonth);
}
function	confirmDept(asTag)
{
	sConfirm = asTag;
	G_Load(dsCONFIRM);
	dsCONFIRM.NameString(dsCONFIRM.RowPosition,"COMP_CODE")   = dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE");
	dsCONFIRM.NameString(dsCONFIRM.RowPosition,"CLSE_ACC_ID") = dsMASTER.NameString(dsMASTER.RowPosition,"CLSE_ACC_ID");
	dsCONFIRM.NameString(dsCONFIRM.RowPosition,"DEPT_CODE")    = dsMASTER.NameString(dsMASTER.RowPosition,"DEPT_CODE");
	dsCONFIRM.NameString(dsCONFIRM.RowPosition,"CHG_SEQ") 	      = dsMASTER.NameString(dsMASTER.RowPosition,"CHG_SEQ");
	dsCONFIRM.NameString(dsCONFIRM.RowPosition,"CONFIRM_TAG") 	      = sConfirm;
	
	transConfirm.Parameters = "ACT=CONFIRM";
	if(!G_saveData(dsCONFIRM)) return;
	dsMASTER.NameString(dsMASTER.RowPosition,"CONFIRM_TAG") = sConfirm;
	G_saveData(dsMASTER);
	if(asTag == "T")
	{
		C_msgOk("Ȯ���� ���������� ����Ǿ����ϴ�.");
	}
	else
	{
		C_msgOk("Ȯ����Ұ� ���������� ����Ǿ����ϴ�.");
	}
}

function	updateConfirm()
{
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var ret = C_msgYesNo("�� �۾��� ���ؼ��� ���� ������ �ϼž� �մϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return false;
		}
		else if(ret == "N")
		{
			return false;
		}
	}
	return true;
}
function addDeptAll()
{
	G_Load(dsDEPT_ALL);
	dsDEPT_ALL.NameString(dsDEPT_ALL.RowPosition,"COMP_CODE")      =  txtCOMP_CODE.value;
	dsDEPT_ALL.NameString(dsDEPT_ALL.RowPosition,"CLSE_ACC_ID")    =  txtCLSE_ACC_ID.value;
	dsDEPT_ALL.NameString(dsDEPT_ALL.RowPosition,"CHG_SEQ") 	  = "0";
	
	transDeptAll.Parameters = "ACT=DEPT_ALL";
	if(!G_saveData(dsDEPT_ALL))return;
	C_msgOk("��� �����û�μ��� ��ϵǾ����ϴ�.");
	G_Load(dsMASTER);
}
function addBudgItemAll() 
{
	G_Load(dsBUDG_ITEM_ALL);
	
	for(var i = 1 ; i <= dsMASTER.CountRow ; ++i)
	{
		if (dsMASTER.RowMark(i) =="1")
		{
			dsBUDG_ITEM_ALL.AddRow();
			dsBUDG_ITEM_ALL.NameString(dsBUDG_ITEM_ALL.RowPosition,"COMP_CODE")      	=  txtCOMP_CODE.value;
			dsBUDG_ITEM_ALL.NameString(dsBUDG_ITEM_ALL.RowPosition,"CLSE_ACC_ID")    	=  txtCLSE_ACC_ID.value;
			dsBUDG_ITEM_ALL.NameString(dsBUDG_ITEM_ALL.RowPosition,"CHG_SEQ") 	       = "0";
			dsBUDG_ITEM_ALL.NameString(dsBUDG_ITEM_ALL.RowPosition,"BUDG_CODE_NO")   =  dsMASTER.NameString(dsMASTER.RowPosition, "BUDG_CODE_NO");
		}
	}	


	transBudgItemAll.Parameters = "ACT=BUDG_ITEM_ALL";
	if(!G_saveData(dsBUDG_ITEM_ALL))return;
	C_msgOk("�μ��� �����׸���  ��ϵǾ����ϴ�.");
	G_Load(dsMAIN);
}
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	if(!checkConditions()) return;
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	if(!checkConditions()) return;
	
	if(G_FocusDataset == dsMASTER)
	{
		D_defaultAdd();		
	}
	else if(G_FocusDataset == dsMAIN)
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
	
		lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV("T_BUDG_DEPT_CODE2", lrArgs,"T");
		
		if (lrRet == null) return;
		D_defaultAdd(dsMAIN);
		dsMAIN.NameValue(dsMAIN.RowPosition, "DEPT_CODE")	       = lrRet.get("DEPT_CODE");
		dsMAIN.NameValue(dsMAIN.RowPosition, "DEPT_NAME")	       = lrRet.get("DEPT_NAME");
		btnDvdMonths_onClick();
		
	}
	if(G_FocusDataset == dsSUB01)
	{
		//D_defaultAdd();
	}
	
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
	D_defaultSave();
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "BUDG_YM")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"BUDG_YM") = asDate;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
	if(dataset == dsSUB01)
	{
		if(dsMASTER.NameValue(dsMASTER.RowPosition, "ITEM_NO") == 0) 
		{
			//gridSUB01.Editable ="true";	
		}
		else
		{
			//gridSUB01.Editable ="false";
		}	
	}
}
function OnRowInsertBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		if(C_isNull(txtCOMP_CODE.value)) return false;
		if(C_isNull(txtCLSE_ACC_ID.value)) return false;
	}
	
	return true;
}

function OnRowInserted(dataset, row)
{
	if(row < 1) return;

	if(dataset == dsMASTER)
	{
		dataset.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
		dataset.NameString(row,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
		
	}
	else if(dataset == dsMAIN)
	{
		dataset.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
		dataset.NameString(row,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
		dataset.NameString(row,"BUDG_CODE_NO") = dsMASTER.NameValue(dsMASTER.RowPosition, "BUDG_CODE_NO");

		dataset.NameString(row, "CHG_SEQ") = "0";
		dsMAIN.NameString(row, "RESERVED_SEQ") = "1";
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
	if(dataset == dsSUB01)
	{
		if(colid == "BUDG_MONTH_REQ_AMT")
		{
			//dsSUB01.NameValue(dsSUB01.RowPosition, "BUDG_MONTH_ASSIGN_AMT") =  dsSUB01.NameValue(dsSUB01.RowPosition, "BUDG_MONTH_REQ_AMT"); 
			reCalcSum1();
			reCalcSum2();
		}
	}

}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(grid == gridSUB01)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "BUDG_YM")
		{
			D_defaultYmProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
		
		grid.focus();
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(colid == "BUDG_YM")
	{
		C_Calendar("BUDG_YM", "M", dataset.NameString(dataset.RowPosition,colid));
	}
}
function OnPostBefore(dataset, trans)
{
	if(dataset == dsMAIN || dataset == dsSUB01)
	{
		if(dsSUB01.CountRow > 0)	//�����ݾ׿� �ڷᰡ �ִ� ��츸 ����--> �� ������ �ƹ� �ڷᵵ ���� ���� �����Ѵ�.
		{
			var	ldMain = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_REQ_AMT"));
			var	ldSubSum = dsSUB01.NameSum("BUDG_MONTH_REQ_AMT",0,0);
			if(ldSubSum != ldMain)
			{
				C_msgOk("��û�ݾװ� ���� ���� �ݾ��� �հ谡 �ٸ��ϴ�.");
				return;
			}
		}
	}
	return true;
}

// �̺�Ʈ����-------------------------------------------------------------------//

function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	dsMAIN.ClearData();
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
	G_Load(dsMASTER);
	
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
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	txtMAKE_DEPT_CODE.value = "";
	txtMAKE_DEPT_NAME.value = "";
	dsMAIN.ClearData();
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
	G_Load(dsMASTER);
	
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
function	btnAssignMonths_onClick()
{
	if(!checkConditions()) return;
	if(!D_checkIsLoadedInternal(dsSUB01)) return ;
	if(!D_checkMasterRowExistsInternal(dsSUB01,"�ϰ�����")) return ;
	//for(var i = 1 ; i <= dsSUB01.CountRow ; ++i)
	//{
		//dsSUB01.NameString(i,"BUDG_MONTH_ASSIGN_AMT") = dsSUB01.NameString(i,"BUDG_MONTH_REQ_AMT");
	//}
	//dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_ASSIGN_AMT") = dsSUB01.NameSum("BUDG_MONTH_ASSIGN_AMT",0,0);
}
function	btnCopyPrev_onClick()
{
	if(!checkConditions()) return;
	if(!updateConfirm()) return;
	G_Load(dsCOPY);
	dsCOPY.NameString(dsCOPY.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsCOPY.NameString(dsCOPY.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	//dsCOPY.NameString(dsCOPY.RowPosition,"DEPT_CODE") = txtDEPT_CODE.value;
	transCopy.Parameters = "ACT=COPY";
	if(!G_saveData(dsCOPY))return;
	C_msgOk("���簡 ���������� ����Ǿ����ϴ�.");
	G_Load(dsMASTER);
}
function	btnAssignAll_onClick()
{
	if(!checkConditions()) return;
	if(!updateConfirm()) return;
	G_Load(dsDVD_MONTHS);
	dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"COMP_CODE") = dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE");
	dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"CLSE_ACC_ID") = dsMASTER.NameString(dsMASTER.RowPosition,"CLSE_ACC_ID");
	dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"DEPT_CODE") = dsMASTER.NameString(dsMASTER.RowPosition,"DEPT_CODE");
	dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"CHG_SEQ") = dsMASTER.NameString(dsMASTER.RowPosition,"CHG_SEQ");

	transDvd.Parameters = "ACT=DVD";

	if(!G_saveData(dsDVD_MONTHS))return;
	C_msgOk("������ ���������� ����Ǿ����ϴ�.");
	G_Load(dsMAIN);
}

function	btnDvdMonths_onClick()
{
	bNowCalc = true;
	try
	{
		dvdMonth();
	}
	catch(e)
	{
	}
	bNowCalc = false;
}
function	btnConfirmDept_onClick()
{
	if(!checkConditions()) return;
	if(!updateConfirm()) return;
	if(dsMASTER.NameString(dsMASTER.RowPosition,"CONFIRM_TAG") == "T")
	{
		C_msgOk("�̹� Ȯ���Ǿ� �ֽ��ϴ�.");
		return;
	}
	confirmDept("T");
}
function	btnCancelDept_onClick()
{
	if(!checkConditions()) return;
	if(!updateConfirm()) return;
	if(dsMASTER.NameString(dsMASTER.RowPosition,"CONFIRM_TAG") != "T")
	{
		C_msgOk("Ȯ���Ǿ� ���� �ʽ��ϴ�.");
		return;
	}
	confirmDept("F");
}
function	btnConfirmAll_onClick()
{
	if(!checkConditions()) return;
	if(!updateConfirm()) return;
	confirmAll("T");
}
function	btnCancelAll_onClick()
{
	if(!checkConditions()) return;
	if(!updateConfirm()) return;
	confirmAll("F");
}
function	btnAddDeptAll_onClick()
{
	if(!checkConditions()) return;
	addDeptAll();
}
function btnAddBudgItemAll()
{
	if(!checkConditions()) return;
	addBudgItemAll();
}
function	btnDvdAllMonth_onClick()
{
	if(!checkConditions()) return;
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var ret = C_msgYesNo("�� �۾��� ���ؼ��� ���� ������ �ϼž� �մϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return ;
		}
		else if(ret == "N")
		{
			return ;
		}
	}
	G_Load(dsDVD_MONTHS);
	for(var i = 1 ; i <= dsDVD_MONTHS.CountRow ; ++i)
	{
		if (dsDVD_MONTHS.RowMark(i) =="1")
		{
			dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
			dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
			dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"DEPT_CODE") = dsMAIN.NameString(dsMAIN.RowPosition,"DEPT_CODE");
			dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"CHG_SEQ") = "0";
		}
	}

	transDvd.Parameters = "ACT=DVD";

	if(!G_saveData(dsDVD_MONTHS))return;
	C_msgOk("������ ���������� ����Ǿ����ϴ�.");
	G_Load(dsMAIN);
}
function btnGetFromItemCost()
{
	G_Load(dsITEM_COST);
	
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"COMP_CODE") 		= txtCOMP_CODE.value;
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"CLSE_ACC_ID") 	= txtCLSE_ACC_ID.value;
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"BUDG_CODE_NO")   = dsMASTER.NameString(dsMASTER.RowPosition,"BUDG_CODE_NO");
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"CHG_SEQ") = "0";

	
	transItemCost.Parameters = "ACT=ITEM_COST";

	if(!G_saveData(dsITEM_COST))return;
	C_msgOk("�ܰ�������  ���������� ����Ǿ����ϴ�.");
	G_Load(dsMASTER);
}

