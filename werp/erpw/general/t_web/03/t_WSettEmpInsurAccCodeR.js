/**************************************************************************/
/* 1. �� �� �� �� id : t_WSettIndInsurAccCodeR.jsp(���纸���⺻�����������)
/* 2. ����(�ó�����) : Left-Right(Master-Detail)
/* 3. ��  ��  ��  �� : ���纸���⺻�����������
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-23)
/* 5. ����  ���α׷� : ����
/* 6. Ư  ��  ��  �� : ����
/**************************************************************************/
function Initialize()
{
	//objectPatch();
	G_addDataSet(dsACC_CODE, null, gridACC_CODE, sSelectPageName+D_P1("ACT","ACC_CODE"), "��������");
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�����ڵ�");


	
	gridACC_CODE.focus();

	

}
function OnLoadBefore(dataset)
{
	if (dataset == dsACC_CODE)	//�������� ��������
	{
		
		dataset.DataID = sSelectPageName	+ D_P1("ACT","ACC_CODE")
										+ D_P2("ACC_GRP",'8')			//����
										+ D_P2("ACC_NAME",'');
	}
	else if(dataset == dsMAIN)
	{

		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN");
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
		}
	}
	for(var i = 0 ; i < lrArrayRows.length  ; ++i)
	{
		G_addRow(arDstDataset);
		if(!CopyOneRow(arSrcDataset,lrArrayRows[i],arDstDataset,arDstDataset.RowPosition)) return;
	}
	for(var i = lrArrayRows.length - 1 ; i >= 0 ; --i)
	{
		G_deleteRow(arSrcDataset,lrArrayRows[i],false);
	}
}

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	gridACC_CODE.focus();
	D_defaultLoad();
	gridMAIN.focus();
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	//D_defaultAdd();
}

// ����
function btninsert_onclick()
{
	//D_defaultInsert();
}

// ����
function btndelete_onclick()
{
	//D_defaultDelete();
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
function	btnSet_onClick()
{
	MoveSelectedRows(dsACC_CODE,dsMAIN);
	dsACC_CODE.ResetStatus();
}
function	btnReSet_onClick()
{
	MoveSelectedRows(dsMAIN,dsACC_CODE);
	dsACC_CODE.ResetStatus();
}
