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
var			lbEnter = false;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "����ڸ��");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "���ѻ����");
	G_addDataSet(dsSUB02, trans, gridSUB02, sSelectPageName+D_P1("ACT","SUB02"), "����ѻ����");
	
	G_addDataSet(dsSET, transSet, null, sSelectPageName+D_P1("ACT","SET"), "�⺻���Ѽ���");
	


	G_addRel(dsMAIN, dsSUB01);
	G_addRelCol(dsSUB01, "ACC_GRP_CODE", "ACC_GRP_CODE");

	G_addRel(dsMAIN, dsSUB02);
	G_addRelCol(dsSUB02, "ACC_GRP_CODE", "ACC_GRP_CODE");
	
	G_setReadOnlyCol(gridSUB01,"COMP_CODE");
	G_setReadOnlyCol(gridSUB01,"COMPANY_NAME");
	G_setReadOnlyCol(gridSUB02,"COMP_CODE");
	G_setReadOnlyCol(gridSUB02,"COMPANY_NAME");

	gridMAIN.focus();
	//G_focusDataset(dsMAIN);
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
							//+ D_P2("SEARCH_CONDITION",txtSEARCH_CONDITION.value);
	}
	else if(dataset == dsSUB01)
	{
		var	strKEY = dsMAIN.RowPosition < 1 ? "":dsMAIN.NameString(dsMAIN.RowPosition,"ACC_GRP_CODE");
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
							+ D_P2("ACC_GRP_CODE",strKEY);
	}
	else if(dataset == dsSUB02)
	{
		var	strKEY = dsMAIN.RowPosition < 1 ? "":dsMAIN.NameString(dsMAIN.RowPosition,"ACC_GRP_CODE");
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB02")
							+ D_P2("ACC_GRP_CODE",strKEY);
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
		if(arSrcDataset.NameString(i,"CHK_CLS") == "T")
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
function	CheckExistsEmp(arACC_GRP_CODE)
{
	var		iCount = dsMAIN.CountRow;
	for( var i = 1 ; i <= iCount ; ++i)
	{
		if(arACC_GRP_CODE == dsMAIN.NameString(i,"ACC_GRP_CODE"))
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
		strFIND_EMP_NO = lrRet.get("ACC_GRP_CODE");
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
		D_defaultInsert();
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
	gridSUB02.focus();
	D_defaultLoad();
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
	dsMAIN.NameString(dsMAIN.RowPosition,"USE_TAG") = "T";
}

function OnRowDeleteBefore(dataset)
{
	if(dataset == dsSUB02)
	{
	}
	return true;
}

function OnRowDeleted(dataset, row)
{
}

function OnColumnChanged(dataset, row, colid)
{
	if(lbEnter) return;
	lbEnter = true;
	try
	{
		if(dataset == dsSUB01)
		{
			if(colid == 'CHK_CLS')
			{
				if(dataset.NameString(dataset.RowPosition,"FUND_INPUT_CLS") != "T")
				{
					var			lv = C_convSafeFloat(dataset.NameString(dataset.RowPosition,"ACC_LVL"));
					var			liCount = dataset.CountRow;
					var			lsTag = dataset.NameString(row,"CHK_CLS");
					for(var i = row+1;i<=liCount;++i)
					{
						var		lvTemp = C_convSafeFloat(dataset.NameString(i,"ACC_LVL"));
						if(lvTemp <= lv) break;
						dataset.NameString(i,"CHK_CLS") = lsTag;
					}
				}
			}
		}
		else if(dataset == dsSUB02)
		{
			if(colid == 'CHK_CLS')
			{
				if(dataset.NameString(dataset.RowPosition,"FUND_INPUT_CLS") != "T")
				{
					var			lv = C_convSafeFloat(dataset.NameString(dataset.RowPosition,"ACC_LVL"));
					var			liCount = dataset.CountRow;
					var			lsTag = dataset.NameString(row,"CHK_CLS");
					for(var i = row+1;i<=liCount;++i)
					{
						var		lvTemp = C_convSafeFloat(dataset.NameString(i,"ACC_LVL"));
						if(lvTemp <= lv) break;
						dataset.NameString(i,"CHK_CLS") = lsTag;
					}
				}
			}
		}
		else
		{
		}
	}
	catch(e)
	{
	}
	lbEnter = false;
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
	gridSUB02.focus();
	if(dsSUB02.RowPosition > 0 && dsSUB02.RowMark(dsSUB02.RowPosition) != 1)
	{
		dsSUB02.RowMark(dsSUB02.RowPosition) = 1;
	}
}
function	btnRevokeCompCode_onClick()
{
	MoveSelectedRows(dsSUB01,dsSUB02);
	gridSUB01.focus();
	if(dsSUB01.RowPosition > 0 && dsSUB01.RowMark(dsSUB01.RowPosition) != 1)
	{
		dsSUB01.RowMark(dsSUB01.RowPosition) = 1;
	}
}

function	btnAllCheck1_onClick()
{
	var i = 0;
	for(i=1;i<=dsSUB01.CountRow;i++){
		if(dsSUB01.NameString(i,"FUND_INPUT_CLS") == "T") {
			dsSUB01.NameString(i,"CHK_CLS") = "T";
		}
	}
}

function	btnAllUnCheck1_onClick()
{
	var i = 0;
	for(i=1;i<=dsSUB01.CountRow;i++){
		if(dsSUB01.NameString(i,"FUND_INPUT_CLS") == "T") {
			dsSUB01.NameString(i,"CHK_CLS") = "F";
		}
	}
}

function	btnAllCheck2_onClick()
{
	var i = 0;
	for(i=1;i<=dsSUB02.CountRow;i++){
		if(dsSUB02.NameString(i,"FUND_INPUT_CLS") == "T") {
			dsSUB02.NameString(i,"CHK_CLS") = "T";
		}
	}
}

function	btnAllUnCheck2_onClick()
{
	var i = 0;
	for(i=1;i<=dsSUB02.CountRow;i++){
		if(dsSUB02.NameString(i,"FUND_INPUT_CLS") == "T") {
			dsSUB02.NameString(i,"CHK_CLS") = "F";
		}
	}
}


