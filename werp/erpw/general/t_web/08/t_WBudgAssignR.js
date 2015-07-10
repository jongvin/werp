/**************************************************************************/
/* 1. �� �� �� �� id : t_WBudgAssignR(�������)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-01)
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
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	G_addRel(dsMASTER,dsMAIN);
	G_addRelCol(dsMAIN,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsMAIN,"CLSE_ACC_ID","CLSE_ACC_ID");
	G_addRelCol(dsMAIN,"DEPT_CODE","DEPT_CODE");
	G_addRelCol(dsMAIN,"CHG_SEQ","CHG_SEQ");

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

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;
	
	gridMASTER.focus();
	
	G_setReadOnlyCol(gridMASTER,"DEPT_NAME");	
	G_setReadOnlyCol(gridMAIN,"BUDG_ITEM_CODE");
	G_setReadOnlyCol(gridMAIN,"BUDG_CODE_NAME");
	G_setReadOnlyCol(gridMAIN,"FULL_PATH");
	G_setReadOnlyCol(gridMAIN,"BUDG_ITEM_REQ_AMT");
	G_setReadOnlyCol(gridMAIN,"BUDG_ITEM_ASSIGN_AMT");
	G_setReadOnlyCol(gridMAIN,"DIFF_AMT");
	
	G_setReadOnlyCol(gridSUB01,"BUDG_YM");
	G_setReadOnlyCol(gridSUB01,"BUDG_MONTH_REQ_AMT"); 
	
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMASTER)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MASTER")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
											+ D_P2("CHG_SEQ","0");
	}
	else if (dataset == dsMAIN)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE"))
											+ D_P2("CLSE_ACC_ID",dsMASTER.NameString(dsMASTER.RowPosition,"CLSE_ACC_ID"))
											+ D_P2("DEPT_CODE",dsMASTER.NameString(dsMASTER.RowPosition,"DEPT_CODE"))
											+ D_P2("CHG_SEQ",dsMASTER.NameString(dsMASTER.RowPosition,"CHG_SEQ"));
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
	if(dsSUB01.CountRow < 1) return;
	var		lsYearMonth = txtCLSE_ACC_ID.value + "-01";
	var		ldReqAmt = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_ASSIGN_AMT"));
	var		ldMonthReqAmt = Math.floor(ldReqAmt / dsSUB01.CountRow);
	var		ldReqTotal = 0;
	
	for(var i = 1 ; i <= dsSUB01.CountRow ; ++ i)
	{
		if(i == dsSUB01.CountRow)
		{
			ldMonthReqAmt = ldReqAmt - ldReqTotal;
		}
		dsSUB01.NameString(i,"BUDG_MONTH_ASSIGN_AMT") = ldMonthReqAmt;
		ldReqTotal += ldMonthReqAmt;
	}
}
function	reCalcSum()
{
	//if(!chkNumber.checked) return;
	if(bNowCalc) return;
	dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_ASSIGN_AMT") = dsSUB01.NameSum("BUDG_MONTH_ASSIGN_AMT",0,0);
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
	dsCONFIRM.NameString(dsCONFIRM.RowPosition,"COMP_CODE") = dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE");
	dsCONFIRM.NameString(dsCONFIRM.RowPosition,"CLSE_ACC_ID") = dsMASTER.NameString(dsMASTER.RowPosition,"CLSE_ACC_ID");
	dsCONFIRM.NameString(dsCONFIRM.RowPosition,"DEPT_CODE") = dsMASTER.NameString(dsMASTER.RowPosition,"DEPT_CODE");
	dsCONFIRM.NameString(dsCONFIRM.RowPosition,"CHG_SEQ") = dsMASTER.NameString(dsMASTER.RowPosition,"CHG_SEQ");
	dsCONFIRM.NameString(dsCONFIRM.RowPosition,"CONFIRM_TAG") = sConfirm;
	 
	transConfirm.Parameters = "ACT=CONFIRM";
	 
	if(!G_saveData(dsCONFIRM))return;
	 
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
function	confirmAll(asTag)
{
	sConfirm = asTag;
	G_Load(dsCONFIRM_ALL);
	dsCONFIRM_ALL.NameString(dsCONFIRM_ALL.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsCONFIRM_ALL.NameString(dsCONFIRM_ALL.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsCONFIRM_ALL.NameString(dsCONFIRM_ALL.RowPosition,"CHG_SEQ") = "0";
	dsCONFIRM_ALL.NameString(dsCONFIRM_ALL.RowPosition,"CONFIRM_TAG") = sConfirm;
	
	transConfirmAll.Parameters = "ACT=CONFIRM_ALL";
	if(!G_saveData(dsCONFIRM_ALL))return;
	G_Load(dsMASTER);
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
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	checkConditions();
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	if(!checkConditions()) return;
	if(!D_checkSelectDataset("�߰�")) return ;
	if(!D_checkIsLoaded()) return ;
	if(!D_checkWriteEnable()) return ;
	if(!D_checkMasterRowExists("�߰�")) return ;

	if(G_FocusDataset == dsMAIN)
	{
		if (G_FocusDataset.IsUpdated || G_isChanged(G_FocusDataset.id))
		{
			var ret = C_msgYesNo("�� �۾��� ���ؼ��� ���� ������ �ϼž� �մϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");
	
			if (ret == "Y")
			{
				if(!G_saveAllData(G_FocusDataset)) return ;
			}
			else if(ret == "N")
			{
				return ;
			}
		}


		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("MAKE_DEPT_CLS", "");
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV("T_BUDG_ITEM_SEARCH", lrArgs,"T");
		
		if (lrRet == null) return;
		var		sIsLeaf = lrRet.get("IS_LEAF");
		if(sIsLeaf == "F")
		{
			var		lsYn = C_msgYesNo("�ش��׸��� ������ �׸��� �ƴմϴ�.<br> �ش� �׸��� ��� ������ �׸��� �ϰ� �߰��Ͻðڽ��ϱ�?","����");
			if(lsYn == "N") return;
			sBudgCodeNo = lrRet.get("BUDG_CODE_NO");
			G_Load(dsBUDG_ITEM);
			G_ChildRetrieveOff(dsMAIN);
			try
			{
				for(var i = 1 ; i <= dsBUDG_ITEM.CountRow ; ++i)
				{
						G_addRow(dsMAIN);
						dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_CODE_NO") = dsBUDG_ITEM.NameString(i,"BUDG_CODE_NO");
						dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_CODE") = dsBUDG_ITEM.NameString(i,"BUDG_ITEM_CODE");
						dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_CODE_NAME") = dsBUDG_ITEM.NameString(i,"BUDG_CODE_NAME");
						dsMAIN.NameString(dsMAIN.RowPosition,"FULL_PATH") = dsBUDG_ITEM.NameString(i,"FULL_PATH");
				}
			}
			catch(e)
			{
			}
			G_ChildRetrieveOn(dsMAIN);
			G_Load(dsSUB01);
		}
		else
		{
			G_addRow(dsMAIN);
			dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_CODE_NO") = lrRet.get("BUDG_CODE_NO");
			dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_CODE") = lrRet.get("BUDG_ITEM_CODE");
			dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_CODE_NAME") = lrRet.get("BUDG_CODE_NAME");
			dsMAIN.NameString(dsMAIN.RowPosition,"FULL_PATH") = lrRet.get("FULL_PATH");
		}
	}
	else
	{
		D_defaultAdd();
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
	if (asCalendarID == "BUDG_YM")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"BUDG_YM") = asDate;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
}
function OnRowInsertBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		if(C_isNull(txtCOMP_CODE.value)) return false;
		if(C_isNull(txtCLSE_ACC_ID.value)) return false;
	}
	else if(dataset == dsSUB01)
	{
		if (dataset.CountRow == 12)
		{
			C_msgOk("���� �ʰ������Ƿ� �� �߰��� �� �����ϴ�");	
			return false;
		}
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	if(row < 1) return;

	if(dataset == dsMAIN)
	{
		dsMAIN.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
		dsMAIN.NameString(row,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
		
		dsMAIN.NameString(row, "CHG_SEQ") = "0";
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
		if(colid == "BUDG_MONTH_ASSIGN_AMT")
		{
			reCalcSum();
		}
	}
	else if(dataset == dsMAIN)
	{
		if(colid == "BUDG_ITEM_ASSIGN_AMT")
		{
			//if(!chkNumber.checked) return;
			var		lfAmt = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_ASSIGN_AMT"));
			var		lfSum = C_convSafeFloat(dsSUB01.NameSum("BUDG_MONTH_ASSIGN_AMT",0,0));
			if(lfAmt != lfSum)
			{
				var lsRet = C_msgYesNo("�����ݾװ� �����ݾ��� ��ġ���� �ʽ��ϴ�.<br> �ڵ����� �����Ͻðڽ��ϱ�?");
				if(lsRet == "Y")
				{
					dvdMonth();
				}
			}
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
			var	ldMain = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_ASSIGN_AMT"));
			var	ldSubSum = dsSUB01.NameSum("BUDG_MONTH_ASSIGN_AMT",0,0);
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
	//G_Load(dsMASTER);
	
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
	//G_Load(dsMASTER);
	
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
	for(var i = 1 ; i <= dsSUB01.CountRow ; ++i)
	{
		dsSUB01.NameString(i,"BUDG_MONTH_ASSIGN_AMT") = dsSUB01.NameString(i,"BUDG_MONTH_REQ_AMT");
	}
	dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_ASSIGN_AMT") = dsSUB01.NameSum("BUDG_MONTH_ASSIGN_AMT",0,0);
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
