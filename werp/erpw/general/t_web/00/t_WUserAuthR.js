/**************************************************************************/
/* 1. �� �� �� �� id : t_WUserAuthR.jsp(����ں����Ѱ���)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : ����ں����Ѱ���
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-12)
/* 5. ����  ���α׷� : ����
/* 6. Ư  ��  ��  �� : ����
/**************************************************************************/
var			strFIND_EMP_NO = "";
var			strFIND_EMP_NAME = "";
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "����ڸ��");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "���ѻ����");
	G_addDataSet(dsSUB02, trans, gridSUB02, sSelectPageName+D_P1("ACT","SUB02"), "����ѻ����");
	G_addDataSet(dsSUB03, trans, gridSUB03, sSelectPageName+D_P1("ACT","SUB03"), "���Ѻμ�����");
	G_addDataSet(dsSUB04, trans, gridSUB04, sSelectPageName+D_P1("ACT","SUB04"), "����Ѻμ�����");
	
	G_addDataSet(dsCOPY, transCopy, null, sSelectPageName+D_P1("ACT","COPY"), "���Ѻ���");
	G_addDataSet(dsSET, transSet, null, sSelectPageName+D_P1("ACT","SET"), "�⺻���Ѽ���");
	


	G_addRel(dsMAIN, dsSUB01);
	G_addRelCol(dsSUB01, "EMPNO", "EMPNO");

	G_addRel(dsMAIN, dsSUB02);
	G_addRelCol(dsSUB02, "EMPNO", "EMPNO");
	
	G_addRel(dsSUB01, dsSUB03);
	G_addRelCol(dsSUB03, "EMPNO", "EMPNO");
	G_addRelCol(dsSUB03, "COMP_CODE", "COMP_CODE");

	G_addRel(dsSUB01, dsSUB04);
	G_addRelCol(dsSUB04, "EMPNO", "EMPNO");
	G_addRelCol(dsSUB04, "COMP_CODE", "COMP_CODE");
	
	G_setReadOnlyCol(gridSUB01,"COMP_CODE");
	G_setReadOnlyCol(gridSUB01,"COMPANY_NAME");
	G_setReadOnlyCol(gridSUB02,"COMP_CODE");
	G_setReadOnlyCol(gridSUB02,"COMPANY_NAME");
	G_setReadOnlyCol(gridSUB03,"DEPT_CODE");
	G_setReadOnlyCol(gridSUB03,"DEPT_NAME");
	G_setReadOnlyCol(gridSUB04,"DEPT_CODE");
	G_setReadOnlyCol(gridSUB04,"DEPT_NAME");

	gridMAIN.focus();
	//G_focusDataset(dsMAIN);
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
							+ D_P2("SEARCH_CONDITION",txtSEARCH_CONDITION.value);
	}
	else if(dataset == dsSUB01)
	{
		var	strKEY = dsMAIN.RowPosition < 1 ? "":dsMAIN.NameString(dsMAIN.RowPosition,"EMPNO");
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
							+ D_P2("EMPNO",strKEY);
	}
	else if(dataset == dsSUB02)
	{
		var	strKEY = dsMAIN.RowPosition < 1 ? "":dsMAIN.NameString(dsMAIN.RowPosition,"EMPNO");
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB02")
							+ D_P2("EMPNO",strKEY);
	}
	else if(dataset == dsSUB03)
	{
		var	strKEY = dsSUB01.RowPosition < 1 ? "":dsSUB01.NameString(dsSUB01.RowPosition,"EMPNO");
		var	strKEY2 = dsSUB01.RowPosition < 1 ? "":dsSUB01.NameString(dsSUB01.RowPosition,"COMP_CODE");
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB03")
							+ D_P2("EMPNO",strKEY)
							+ D_P2("COMP_CODE",strKEY2);
	}
	else if(dataset == dsSUB04)
	{
		var	strKEY = dsSUB01.RowPosition < 1 ? "":dsSUB01.NameString(dsSUB01.RowPosition,"EMPNO");
		var	strKEY2 = dsSUB01.RowPosition < 1 ? "":dsSUB01.NameString(dsSUB01.RowPosition,"COMP_CODE");
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB04")
							+ D_P2("EMPNO",strKEY)
							+ D_P2("COMP_CODE",strKEY2);
	}
	else if (dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
	}
	else if (dataset == dsSET)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SET");
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
function	CopyOneRow(arSrcDataset,arSrcRow,arDstDataset,arDstRow)
{
	for(var j = 1 ; j <= arSrcDataset.CountColumn ; ++ j)
	{
		arDstDataset.NameString(arDstRow,arSrcDataset.ColumnID(j)) = arSrcDataset.ColumnString(arSrcRow,j);
	}
	return true;
}
function	MoveSelectedRows(arSrcDataset,arDstDataset)
{
	var		lrArrayRows = new Array();
	for(var i = 1 ; i <= arSrcDataset.CountRow ; ++ i)
	{
		if(arSrcDataset.RowMark(i) == 1)
		{
			lrArrayRows.push(i);
			G_addRow(arDstDataset);
			if(!CopyOneRow(arSrcDataset,i,arDstDataset,arDstDataset.RowPosition)) return;
		}
	}
	for(var i = lrArrayRows.length - 1 ; i >= 0 ; --i)
	{
		G_deleteRow(arSrcDataset,lrArrayRows[i],false);
	}
}
function	CheckExistsEmp(arEmpNo)
{
	var		iCount = dsMAIN.CountRow;
	for( var i = 1 ; i <= iCount ; ++i)
	{
		if(arEmpNo == dsMAIN.NameString(i,"EMPNO"))
		{
			C_msgOk("�̹� �����ϴ� ����� �����ϼ̽��ϴ�.");
			return true;
		}
	}
	return false;
}
function	FindEmp()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_SEARCH_USER_GRANT", lrArgs,"F");
	if (lrRet != null)
	{
		strFIND_EMP_NO = lrRet.get("EMPNO");
		strFIND_EMP_NAME = lrRet.get("NAME");
		return true;
	}
	else
	{
		return false;
	}
}
function	CheckSave()
{
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var ret = C_msgYesNoCancel("���� ����� ������ �����ϼž� �۾��� �����մϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return false;
		}
		else if(ret == "C")
		{
			return false;
		}
	}
	return true;
}

function	FindAndAdd()
{
	if(!D_checkSelectDataset("�߰�")) return ;
	if(!D_checkIsLoaded()) return ;
	if(!D_checkWriteEnable()) return ;
	if(!D_checkMasterRowExists("�߰�")) return ;
	if(!CheckSave()) return;
	if(!FindEmp()) return;
	if(CheckExistsEmp(strFIND_EMP_NO)) return;
	
	G_addRow(G_FocusDataset);
	dsMAIN.NameString(dsMAIN.RowPosition,"EMPNO") = strFIND_EMP_NO;
	dsMAIN.NameString(dsMAIN.RowPosition,"NAME") = strFIND_EMP_NAME;

	G_Load(dsSUB01);
	G_Load(dsSUB02);

	if (G_FocusObject != null) G_FocusObject.focus();
}
function	FindAndInsert()
{
	if(!D_checkSelectDataset("����")) return ;
	if(!D_checkIsLoaded()) return ;
	if(!D_checkWriteEnable()) return ;
	if(!D_checkMasterRowExists("����")) return ;
	if(!CheckSave()) return;
	if(!FindEmp()) return;
	if(CheckExistsEmp(strFIND_EMP_NO)) return;

	G_insertRow(G_FocusDataset);
	dsMAIN.NameString(dsMAIN.RowPosition,"EMPNO") = strFIND_EMP_NO;
	dsMAIN.NameString(dsMAIN.RowPosition,"NAME") = strFIND_EMP_NAME;

	G_Load(dsSUB01);
	G_Load(dsSUB02);

	if (G_FocusObject != null) G_FocusObject.focus();
}
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	if(G_FocusDataset == dsMAIN)
	{
		D_defaultLoad();
	}
}

// �߰�
function btnadd_onclick()
{
	if(G_FocusDataset == dsMAIN)
	{
		FindAndAdd();
	}
	else
	{
		C_msgOk("�߰�,���� �� ������ �Ͻ� �� �����ϴ�.(���� ���� �Ǵ� ���� ��ư�� ����Ͽ� �ֽʽÿ�.");
		return;
	}
}

// ����
function btninsert_onclick()
{
	if(G_FocusDataset == dsMAIN)
	{
		FindAndInsert();
	}
	else
	{
		C_msgOk("�߰�,���� �� ������ �Ͻ� �� �����ϴ�.(���� ���� �Ǵ� ���� ��ư�� ����Ͽ� �ֽʽÿ�.");
		return;
	}
}

// ����
function btndelete_onclick()
{
	if(G_FocusDataset == dsMAIN)
	{
		D_defaultDelete();
	}
	else
	{
		C_msgOk("�߰�,���� �� ������ �Ͻ� �� �����ϴ�.(���� ���� �Ǵ� ���� ��ư�� ����Ͽ� �ֽʽÿ�.");
		return;
	}
}

// ����
function btnsave_onclick()
{
	D_defaultSave(dsSUB01);
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
	return true;
}

function OnRowInserted(dataset, row)
{
	dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_TRANS_CLS") = "F";
	dsMAIN.NameString(dsMAIN.RowPosition,"DEPT_CHG_CLS") = "T";
}

function OnRowDeleteBefore(dataset)
{
	if(dataset == dsSUB02)
	{
		dsSUB03.ClearData();
		dsSUB04.ClearData();
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

// �̺�Ʈ����-------------------------------------------------------------------//
function	btnGrantCompCode_onClick()
{
	MoveSelectedRows(dsSUB02,dsSUB01);
	G_Load(dsSUB03);
	G_Load(dsSUB04);
	gridSUB02.focus();
	if(dsSUB02.RowPosition > 0 && dsSUB02.RowMark(dsSUB02.RowPosition) != 1)
	{
		dsSUB02.RowMark(dsSUB02.RowPosition) = 1;
	}
}
function	btnRevokeCompCode_onClick()
{
	MoveSelectedRows(dsSUB01,dsSUB02);
	G_Load(dsSUB03);
	G_Load(dsSUB04);
	gridSUB01.focus();
	if(dsSUB01.RowPosition > 0 && dsSUB01.RowMark(dsSUB01.RowPosition) != 1)
	{
		dsSUB01.RowMark(dsSUB01.RowPosition) = 1;
	}
}
function	btnGrantDeptCode_onClick()
{
	MoveSelectedRows(dsSUB04,dsSUB03);
	gridSUB04.focus();
	if(dsSUB04.RowPosition > 0 && dsSUB04.RowMark(dsSUB04.RowPosition) != 1)
	{
		dsSUB04.RowMark(dsSUB04.RowPosition) = 1;
	}
}
function	btnRevokeDeptCode_onClick()
{
	MoveSelectedRows(dsSUB03,dsSUB04);
	gridSUB03.focus();
	if(dsSUB03.RowPosition > 0 && dsSUB03.RowMark(dsSUB03.RowPosition) != 1)
	{
		dsSUB03.RowMark(dsSUB03.RowPosition) = 1;
	}
}
function	btnCopyOther_onClick()
{
	if(!D_checkIsLoadedInternal(dsMAIN)) return false;
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var ret = C_msgYesNoCancel("���۾��� ���ؼ��� ���� ������ �ϼž� �մϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return false;
		}
		else if(ret == "C")
		{
			return false;
		}
	}
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("������ ���� ���� ����ڸ� �����Ͻʽÿ�.");
		return;
	}
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");
	lrArgs.set("THIS_EMPNO", dsMAIN.NameString(dsMAIN.RowPosition,"EMPNO"));
	

	lrRet = C_LOV("T_SEARCH_USER_COPY", lrArgs,"F");
	if (lrRet == null) return false;
	if(dsMAIN.NameString(dsMAIN.RowPosition,"EMPNO") == lrRet.get("EMPNO"))
	{
		C_msgOk("������ ���� ���� ����ڿ� �����ؿ� ������ ���� ����ڰ� ������ ������Դϴ�.");
		return;
	}
	G_Load(dsCOPY);
	dsCOPY.NameString(dsCOPY.RowPosition,"EMPNO_SRC") = lrRet.get("EMPNO");
	dsCOPY.NameString(dsCOPY.RowPosition,"EMPNO_DST") = dsMAIN.NameString(dsMAIN.RowPosition,"EMPNO");
	
	transCopy.Parameters = "ACT=COPY";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("���簡 �����Ͽ����ϴ�.");
		G_Load(dsSUB01);
		G_Load(dsSUB02);
	}
}
function	btnSetDefault_onClick()
{
	if(!D_checkIsLoadedInternal(dsMAIN)) return false;
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var ret = C_msgYesNoCancel("���۾��� ���ؼ��� ���� ������ �ϼž� �մϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return false;
		}
		else if(ret == "C")
		{
			return false;
		}
	}
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("������ ������ ����ڸ� �����Ͻʽÿ�.");
		return;
	}
	G_Load(dsSET);
	dsSET.NameString(dsSET.RowPosition,"EMPNO") = dsMAIN.NameString(dsMAIN.RowPosition,"EMPNO");
	dsSET.NameString(dsSET.RowPosition,"OPTIONS") = cbSETDEFAULT.value;
	
	transSet.Parameters = "ACT=SET";

	if(G_saveData(dsSET))
	{
		C_msgOk("�⺻������ �����Ͽ����ϴ�.");
		G_Load(dsSUB01);
		G_Load(dsSUB02);
	}
}
function	document_onKeyDown()
{
	if(event.srcElement == txtSEARCH_CONDITION && event.keyCode == 13)
	{
		btnquery_onclick();
	}
}
