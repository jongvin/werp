/**************************************************************************/
/* 1. �� �� �� �� id : t_WPersonOrderR.jsp(���κ��߷ɻ���)
/* 2. ����(�ó�����) : Left-Right(Master-Detail)
/* 3. ��  ��  ��  �� : ���κ��߷ɻ��� ���
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-03)
/* 5. ����  ���α׷� : ����
/* 6. Ư  ��  ��  �� : ����
/**************************************************************************/
function Initialize()
{
	//objectPatch();
	G_addDataSet(dsMASTER, null, gridMASTER, sSelectPageName+D_P1("ACT","MASTER"), "������");
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�߷ɸ��");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsORDER_SEQ, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsEMP_LIST, transEMP_LIST, null, sSelectPageName+D_P1("ACT","MAIN"), "�߷ɸ��");


	G_addRel(dsMASTER, dsMAIN);
	G_addRelCol(dsMAIN, "EMPNO", "EMP_NO");
	
	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.

	gridMAIN.TabToss = false;

	G_setLovCol(gridMAIN,"DEPT_CODE");
	G_setLovCol(gridMAIN,"DEPT_NAME");

	gridMASTER.focus();

}
function OnLoadBefore(dataset)
{
	if (dataset == dsMASTER)	//�������� ��������
	{
		
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MASTER")
										+ D_P2("NAME",txtNAME.value);
	}
	else if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
										+ D_P2("EMP_NO",dsMASTER.NameString(dsMASTER.RowPosition,"EMPNO"));
	}
	else if(dataset == dsORDER_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","ORDER_SEQ");
	}
	else if(dataset == dsEMP_LIST)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","EMP_LIST");
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
	if (asCalendarID == "ORDER_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,asCalendarID) = asDate;
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
	if(dataset == dsMAIN)
	{
		G_Load(dsORDER_SEQ);
		dsMAIN.NameString(dsMAIN.RowPosition,"ORDER_SEQ") = dsORDER_SEQ.NameString(dsORDER_SEQ.RowPosition,"ORDER_SEQ");
		dsMAIN.NameString(dsMAIN.RowPosition,"SAFE_MNG_TAG") = "F";
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
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "DEPT_CODE" || colid == "DEPT_NAME" )
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode = "DEPT_CODE";
			var			lsTargetName = "DEPT_NAME";
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,lsTargetCode) = "";
				dataset.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("DEPT_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("DEPT_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
		else if(colid == "ORDER_DT")
		{
			COL_DATA = dataset.NameString(row,colid);
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "DEPT_CODE" || colid == "DEPT_NAME" )
		{
			var			lsTargetCode = "DEPT_CODE";
			var			lsTargetName = "DEPT_NAME";
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_DEPT_CODE1", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("DEPT_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("DEPT_NAME");
				}
			}
		}
		else if(colid == "ORDER_DT")
		{
			C_Calendar(colid, "D", dataset.NameString(row,colid));
		}
	}
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
	if(dataset == dsMAIN)
	{
		if(colid == "DEPT_NAME")
		{
			dataset.NameString(row,"DEPT_CODE") = dataset.NameString(row - 1,"DEPT_CODE");
		}
		else if(colid == "DEPT_CODE")
		{
			dataset.NameString(row,"DEPT_NAME") = dataset.NameString(row - 1,"DEPT_NAME");
		}
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//

function	btnApplOrder_onClick()
{
	var		lnCnt = dsMASTER.CountRow;
	G_Load(dsEMP_LIST);
	for(var i = 1 ; i <= lnCnt ; ++i)
	{
		G_addRow(dsEMP_LIST);
		dsEMP_LIST.NameString(dsEMP_LIST.RowPosition,"EMP_NO") = dsMASTER.NameString(i,"EMPNO");
	}
	transEMP_LIST.Parameters = "ACT=EMP_LIST";
	if(!G_saveData(dsEMP_LIST))return;
	C_msgOk("�߷��۾� �ݿ��۾��� ���������� ����Ǿ����ϴ�.");
	G_Load(dsMAIN);
}
function	btnApplOrder_onClick2()
{
	var		lnCnt = dsMASTER.CountRow;
	G_Load(dsEMP_LIST);
	for(var i = 1 ; i <= lnCnt ; ++i)
	{
		if(dsMASTER.RowMark(i) == 1)
		{
			G_addRow(dsEMP_LIST);
			dsEMP_LIST.NameString(dsEMP_LIST.RowPosition,"EMP_NO") = dsMASTER.NameString(i,"EMPNO");
		}
	}
	transEMP_LIST.Parameters = "ACT=EMP_LIST";
	if(!G_saveData(dsEMP_LIST))return;
	C_msgOk("�߷��۾� �ݿ��۾��� ���������� ����Ǿ����ϴ�.");
	G_Load(dsMAIN);
}
