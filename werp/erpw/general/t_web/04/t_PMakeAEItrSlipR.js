/**************************************************************************/
/* 1. �� �� �� �� id : t_WBudgDeptMapR(�����û)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-30)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var vAccClse = false;
var vMonClse = false;
var vDayClse = false;
var vDeptClse = false;

var vMAKE_COMP_CODE = "";
var vMAKE_DEPT_CODE = "";
var vMAKE_DT_TRANS  = "";

var vGET_TYPE = "";
var vWORK_SLIP_ID = "";
var vWORK_SLIP_IDSEQ = "";

function Initialize()
{
	document.body.topMargin = 0;
	document.body.leftMargin = 0;

	lrArgs = window.dialogArguments;


	G_addDataSet(dsWORK_SLIP_IDSEQ, transMakeDefault,  null, sSelectPageName+D_P1("ACT","WORK_SLIP_IDSEQ"), "����������");
	G_addDataSet(dsMAKE_SLIP, transMakeSlip,  null, sSelectPageName+D_P1("ACT","WORK_SLIP_IDSEQ"), "����������");

	G_Load(dsWORK_SLIP_IDSEQ);
	vWORK_SLIP_ID = dsWORK_SLIP_IDSEQ.NameString(dsWORK_SLIP_IDSEQ.RowPosition,"WORK_SLIP_ID");
	vWORK_SLIP_IDSEQ = dsWORK_SLIP_IDSEQ.NameString(dsWORK_SLIP_IDSEQ.RowPosition,"WORK_SLIP_IDSEQ");
	dsWORK_SLIP_IDSEQ.NameString(dsWORK_SLIP_IDSEQ.RowPosition,"WORK_CODE") = vWORK_CODE;
	dsWORK_SLIP_IDSEQ.NameString(dsWORK_SLIP_IDSEQ.RowPosition,"DEPT_CODE") = lrArgs.dept_code;
	dsWORK_SLIP_IDSEQ.NameString(dsWORK_SLIP_IDSEQ.RowPosition,"LOAN_NO") = lrArgs.loan_no;
	dsWORK_SLIP_IDSEQ.NameString(dsWORK_SLIP_IDSEQ.RowPosition,"LOAN_REFUND_SEQ") = lrArgs.loan_refund_seq;
	transMakeDefault.Parameters = "ACT=MAKE_DEFAULT";
	G_saveData(dsWORK_SLIP_IDSEQ);
	AccSearch();

}

function OnLoadBefore(dataset)
{
	if (dataset == dsWORK_SLIP_IDSEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","WORK_SLIP_IDSEQ");
	}
	else if(dataset == dsMAKE_SLIP)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAKE_SLIP");
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

function AccSearch()
{
	ifrmOtherAccPage.AccSearch(vWORK_CODE, vWORK_SLIP_ID, vWORK_SLIP_IDSEQ);
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
	//D_defaultSave(dsMAIN);
}

// ���
function btncancel_onclick()
{
	//if (G_FocusObject != null) G_FocusObject.focus();
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

var lockOnColumnChanged = false;

function	OnColumnChanged(dataset, row, colid)
{
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}

function OnDuplicateColumn(dataset,grid,row,colid)
{
}

function OnDblClick(dataset, grid, row, colid)
{
}

function OnSuccess(dataset, p_Trans)
{
}
// �̺�Ʈ����-------------------------------------------------------------------//
function	document_onKeyDown()
{
	if(event.altLeft && event.keyCode == 112)
	{
		//SetDefaultCheckDept();
	}
}





function	ConfirmSelected()
{
	if(!ifrmOtherAccPage.AccSaveNoMsg())
	{
		return;
	}
	G_Load(dsMAKE_SLIP);
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"WORK_SLIP_ID") = vWORK_SLIP_ID;
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"WORK_SLIP_IDSEQ") = vWORK_SLIP_IDSEQ;
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"WORK_CODE") = vWORK_CODE;
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"DEPT_CODE") = lrArgs.dept_code;
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"COMP_CODE") = lrArgs.comp_code;
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"LOAN_NO") = lrArgs.loan_no;
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"LOAN_REFUND_SEQ") = lrArgs.loan_refund_seq;
	transMakeSlip.Parameters = "ACT=MAKE_SLIP";
	if(!G_saveData(dsMAKE_SLIP)) return;

	window.returnValue = "OK";
	window.close();
	
}
function imgOk_onClick()
{

	ConfirmSelected();
}

function imgCancle_onClick()
{
	window.returnValue = null;
	window.close();
}
