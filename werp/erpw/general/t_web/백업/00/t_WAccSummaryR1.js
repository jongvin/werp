/**************************************************************************/
/* 1. �� �� �� �� id : t_WAccSummaryR.js(�����ڵ�)
/* 2. ����(�ó�����) : Left-Right(Master-Detail)
/* 3. ��  ��  ��  �� : �����ڵ� �� �����ڵ��� ���
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-15)
/* 5. ����  ���α׷� : ����
/* 6. Ư  ��  ��  �� : ����
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsACC_CODE, null, gridACC_CODE, sSelectPageName+D_P1("ACT","ACC_CODE"), "��������");
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�����ڵ�");


	G_addRel(dsACC_CODE, dsMAIN);
	G_addRelCol(dsMAIN, "ACC_CODE", "ACC_CODE");
	
	gridACC_CODE.focus();

}
function OnLoadBefore(dataset)
{
	if (dataset == dsACC_CODE)	//�������� ��������
	{
		var		strACC_CODE = txtACC_CODE.value;

		dataset.DataID = sSelectPageName	+ D_P1("ACT","ACC_CODE")
											+ D_P2("ACC_CODE",strACC_CODE);
	}
	else if(dataset == dsMAIN)
	{
		var 	strACC_CODE = dsACC_CODE.NameString(dsACC_CODE.RowPosition,"ACC_CODE");

		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("ACC_CODE",strACC_CODE);
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
	return true;
}

function OnRowInserted(dataset, row)
{
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

function OnPopup(dataset, grid, row, colid, data)
{
}

// �̺�Ʈ����-------------------------------------------------------------------//
function txtACC_CODE_onblur()
{
	G_Load(dsACC_CODE,null);
}

