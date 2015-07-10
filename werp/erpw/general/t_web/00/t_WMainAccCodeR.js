/**************************************************************************/
/* 1. �� �� �� �� id : t_WMainAccCodeR.jsp(�������屸�к���������)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-06)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			sACC_CODE = "";
var			sACC_NAME = "";
function Initialize()
{
	G_addDataSet(dsLOV,  null,   null, null, "LOV");

	G_addDataSet(dsCOST_DEPT_KIND, null, null, sSelectPageName+D_P1("ACT","COST_DEPT_KIND"), "�μ����屸��");

	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "��ǥ����");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "�μ����庰����");


	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"MAIN_ACC_CODE","MAIN_ACC_CODE");
	
	G_setReadOnlyCol(gridMAIN,"MAIN_ACC_CODE");
	G_setReadOnlyCol(gridMAIN,"ACC_NAME");

	G_setReadOnlyCol(gridSUB01,"MAIN_ACC_CODE");

	G_setLovCol(gridSUB01,"ACC_CODE");
	G_setLovCol(gridSUB01,"ACC_NAME");

	G_Load(dsCOST_DEPT_KIND, null);
	
	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridMAIN.TabToss = false;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridSUB01.TabToss = false;

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsCOST_DEPT_KIND)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COST_DEPT_KIND");
	}
	else if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
							+ D_P2("MAIN_ACC_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"MAIN_ACC_CODE"));
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
}

function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
		
		if (lrRet == null) return false;
	
		sACC_CODE	= lrRet.get("ACC_CODE");
		sACC_NAME	= lrRet.get("ACC_NAME");
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN)
	{
		dataset.NameString(row,"MAIN_ACC_CODE") = sACC_CODE;
		dataset.NameString(row,"ACC_NAME") = sACC_NAME;
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
	var			COL_DATA = dataset.NameString(row,colid);
	if (dataset == dsMAIN)
	{
	}
	else if(dataset == dsSUB01)
	{
		if (colid == "ACC_CODE" || colid == "ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", COL_DATA);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsSUB01)
	{
		if (colid == "ACC_CODE" || colid == "ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
		}
	}
}
function OnDuplicateColumn(dataset,grid,row,colid)
{
	if(dataset == dsSUB01)
	{
		if(colid == "ACC_CODE" || colid == "ACC_NAME")
		{
			if(row>=2)
			{
				dataset.NameString(row,"ACC_CODE") = dataset.NameString(row-1,"ACC_CODE");
				dataset.NameString(row,"ACC_NAME") = dataset.NameString(row-1,"ACC_NAME");
			}
		}
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
function	btnAddAll_onClick()
{
	for(var i = 1 ; i <= dsCOST_DEPT_KIND.CountRow ; ++ i)
	{
		G_addRow(dsSUB01);
		dsSUB01.NameString(dsSUB01.RowPosition,"COST_DEPT_KND_TAG") = dsCOST_DEPT_KIND.NameString(i,"COST_DEPT_KND_TAG");
		dsSUB01.NameString(dsSUB01.RowPosition,"ACC_CODE") = dsMAIN.NameString(dsMAIN.RowPosition,"MAIN_ACC_CODE");
		dsSUB01.NameString(dsSUB01.RowPosition,"ACC_NAME") = dsMAIN.NameString(dsMAIN.RowPosition,"ACC_NAME");
	}
}