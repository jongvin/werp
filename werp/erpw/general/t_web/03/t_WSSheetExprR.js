/**************************************************************************/
/* 1. �� �� �� �� id : t_WSSheetExprR(�繫��ǥ��ĵ��)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-24)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsSHEET_CODE, null, null, null, "�繫��ǥ����");

	G_addDataSet(dsMAIN, trans, gridMAIN, null, "�繫��ǥ�׸�");
	G_addDataSet(dsSUB01, trans, gridSUB01, null, "�������׸�");
	G_addDataSet(dsSELECT01, null, gridSELECT01, null, "��������");
	G_addDataSet(dsSELECT02, null, gridSELECT02, null, "��ü����");
	G_addDataSet(dsPOSITION, null, null, null, "��ġ");
	G_addDataSet(dsREMAIN_CLS, null, null, null, "����");
	G_addDataSet(dsCALC_CLS, null, null, null, "��ȣ");
	G_addDataSet(dsMAKE, transMake, null, null, "�����ڵ�����");
	G_addDataSet(dsMAKE2, transMake2, null, null, "Ÿ��ĺ���");


	G_addRel(dsSHEET_CODE,dsMAIN);
	G_addRelCol(dsMAIN,"SHEET_CODE","SHEET_CODE");


	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"SHEET_CODE","SHEET_CODE");
	G_addRelCol(dsSUB01,"ITEM_CODE","ITEM_CODE");


	G_Load(dsPOSITION, null);
	G_Load(dsREMAIN_CLS, null);
	G_Load(dsCALC_CLS, null);
	G_Load(dsSHEET_CODE, null);
	G_Load(dsSELECT01, null);
	G_Load(dsMAKE, null);

	
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		var			strSHEET_CODE = dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_CODE");
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										+ D_P2("SHEET_CODE",strSHEET_CODE);
	}
	else if(dataset == dsSUB01)
	{
		var			strSHEET_CODE = dsMAIN.NameString(dsMAIN.RowPosition,"SHEET_CODE");
		var			strITEM_CODE = dsMAIN.NameString(dsMAIN.RowPosition,"ITEM_CODE");
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										+ D_P2("SHEET_CODE",strSHEET_CODE)
										+ D_P2("ITEM_CODE",strITEM_CODE);
	}
	else if(dataset == dsSHEET_CODE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SHEET_CODE");
	}
	else if(dataset == dsSELECT01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SELECT01");
	}
	else if(dataset == dsSELECT02)
	{
		var			strSHEET_CODE = dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_CODE");
		dataset.DataID = sSelectPageName + D_P1("ACT","SELECT02")
										+ D_P2("SHEET_CODE",strSHEET_CODE);
	}
	else if(dataset == dsPOSITION)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","POSITION");
	}
	else if(dataset == dsREMAIN_CLS)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","REMAIN_CLS");
	}
	else if(dataset == dsCALC_CLS)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CALC_CLS");
	}
	else if(dataset == dsMAKE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAKE");
	}
	else if(dataset == dsMAKE2)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAKE2");
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
function	SafeToNumber(asValue)
{
	try
	{
		return parseInt(asValue);
	}
	catch(e)
	{
		return 0;
	}
}
function	Retrieve()
{
	G_Load(dsMAIN, null);
	gridMAIN.focus();
}
function	ApplyAccCode()
{
	if(dsSELECT01.RowPosition <= 0)
	{
		C_msgOk("���� ���������� �����Ͻð� �۾��Ͻʽÿ�.","�˸�");
		return;
	}
	var			strEXPR_SEQ1 = dsMAIN.NameString(dsMAIN.RowPosition,"EXPR_SEQ1");
	if(strEXPR_SEQ1 != "0")
	{
		C_msgOk("��ı����� ��ǥ���� ��츸 �����մϴ�.","�˸�");
		return;
	}
	G_addRow(dsSUB01);
	dsSUB01.NameString(dsSUB01.RowPosition,"ACC_CODE")
			= dsSELECT01.NameString(dsSELECT01.RowPosition,"ACC_CODE");
	dsSUB01.NameString(dsSUB01.RowPosition,"ACC_CODE_NAME")
			= dsSELECT01.NameString(dsSELECT01.RowPosition,"ACC_NAME");
	gridSUB01.focus();
}
function	ApplyItemCode()
{
	if(dsSELECT02.RowPosition <= 0)
	{
		C_msgOk("���� ��ü������ �����Ͻð� �۾��Ͻʽÿ�.","�˸�");
		return;
	}
	var			strEXPR_SEQ1 = dsMAIN.NameString(dsMAIN.RowPosition,"EXPR_SEQ1");
	if(!(strEXPR_SEQ1 == "1" ||
		strEXPR_SEQ1 == "2" ||
		strEXPR_SEQ1 == "3" ||
		strEXPR_SEQ1 == "4" ))
	{
		C_msgOk("��ı����� ��ü���� ��츸 �����մϴ�.","�˸�");
		return;
	}
	var			strITEM_CODE = dsMAIN.NameString(dsMAIN.RowPosition,"ITEM_CODE");
	if(strITEM_CODE == dsSELECT02.NameString(dsSELECT02.RowPosition,"ITEM_CODE"))
	{
		C_msgOk("�ڽ��� ������ ���� �����ϴ�.","�˸�");
		return;
	}
	G_addRow(dsSUB01);
	dsSUB01.NameString(dsSUB01.RowPosition,"ACC_CODE")
			= dsSELECT02.NameString(dsSELECT02.RowPosition,"ITEM_CODE");
	dsSUB01.NameString(dsSUB01.RowPosition,"ACC_CODE_NAME")
			= dsSELECT02.NameString(dsSELECT02.RowPosition,"ITEM_NAME");
	gridSUB01.focus();
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
	if(G_FocusDataset == dsMAIN)
	{
		D_defaultAdd();
	}
}

// ����
function btninsert_onclick()
{
	if(G_FocusDataset == dsMAIN)
	{
		D_defaultInsert();
	}
}

// ����
function btndelete_onclick()
{
	if(G_FocusDataset == dsMAIN ||
			G_FocusDataset == dsSUB01)
	{
		D_defaultDelete();
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
	if(dataset == dsMAIN)
	{
		G_Load(dsSELECT02, null);
	}
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
		var			strSHEET_CODE = dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_CODE");
		dsMAIN.NameString(row,"SHEET_CODE") = strSHEET_CODE;
		dsMAIN.NameString(row,"CURR_PAST_CLS") = "C";
		dsMAIN.NameString(row,"POSITION") = "L";
		dsMAIN.NameString(row,"OUT_CLS") = "T";
		dsMAIN.NameString(row,"EXPR_SEQ1") = "0";
		dsMAIN.NameString(row,"UPLINE_CLS") = "F";
		dsMAIN.NameString(row,"DOWNLINE_CLS") = "F";
		dsMAIN.NameString(row,"BOLD_CLS") = "0";
		dsMAIN.NameString(row,"SEQ_TYPE") = "9";
		if(row > 1)
		{
			dsMAIN.NameString(row,"ITEM_LVL") = dsMAIN.NameString(row - 1,"ITEM_LVL");
		}
		else
		{
			dsMAIN.NameString(row,"ITEM_LVL") = "1";
		}
	}
	else if(dataset == dsSUB01)
	{
		dsSUB01.NameString(row,"SEQ") = SafeToNumber(dsSUB01.Max(dsSUB01.ColumnIndex("SEQ"),0,0)+1);
		dsSUB01.NameString(row,"POSITION") = dsMAIN.NameString(dsMAIN.RowPosition,"POSITION");
		dsSUB01.NameString(row,"CALC_CLS") = "P";
		dsSUB01.NameString(row,"REMAIN_CLS") = "R";
	}
}

function OnRowDeleteBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dsSUB01.ClearData();
	}
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

function OnPopup(dataset, grid, row, colid, data)
{
}
function	OnDblClick(dataset, grid, row, colid)
{
	if(grid == gridSELECT01)
	{
		ApplyAccCode();
	}
	else if(grid == gridSELECT02)
	{
		ApplyItemCode();
	}
}
// �̺�Ʈ����-------------------------------------------------------------------//
function	btnMake_onClick()
{
	G_Load(dsMAKE,null);
	dsMAKE.NameString(dsMAKE.RowPosition,"SHEET_CODE") = dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_CODE");
	transMake.Parameters = "ACT=MAKE";
	G_saveData(dsMAKE);
	Retrieve();
}
function	btnMake2_onClick()
{
	if(dsMAIN.CountRow > 0)
	{
		if(C_msgOkCancel("���� �ۼ��� ����� ��� ���� �˴ϴ�. �� �۾��� ���� �Ͻðڽ��ϱ�?","���") != "O")
		{
			return;
		}
	}
	var			lrDict = new C_Dictionary();
	var			lrRet = null;
	lrDict.set("SHEET_TYPE",dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_TYPE"));
	lrDict.set("SHEET_NAME","");
	lrRet = C_LOV("FIND_SHEET_CODE",lrDict);
	if(lrRet == null) return;
	var			strSOURCE = lrRet.get("SHEET_CODE");
	G_Load(dsMAKE2,null);
	if(strSOURCE == dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_CODE"))
	{
		C_msgOk("���� ��õ�� ����� �����ϴ�.","�˸�");
		return;
	}
	dsMAKE2.NameString(dsMAKE2.RowPosition,"SHEET_CODE_TARGET") = dsSHEET_CODE.NameString(dsSHEET_CODE.RowPosition,"SHEET_CODE");
	dsMAKE2.NameString(dsMAKE2.RowPosition,"SHEET_CODE_SOURCE") = strSOURCE;
	transMake2.Parameters = "ACT=MAKE2";
	G_saveData(dsMAKE2);
	Retrieve();
}
function	btnApplySelect01_onClick()
{
	ApplyAccCode();
}
function	btnApplySelect02_onClick()
{
	ApplyItemCode();
}
