/**************************************************************************/
/* 1. �� �� �� �� id : t_PPLMaDeptExecR.jsp(�������ͼ��λ���)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-06-07)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

var opnrArgs = window.dialogArguments;

function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "��γ������");
	G_addDataSet(dsSUB01, null, gridSUB01, null, "�����ݾ׸��");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	G_addRel(dsMAIN, dsSUB01);
	
	G_addRelCol(dsSUB01, "WORK_YM", "WORK_YM");
	G_addRelCol(dsSUB01, "ITEM_NO", "ITEM_NO");
	G_addRelCol(dsSUB01, "APPLY_SEQ", "APPLY_SEQ");

	gridMAIN.Focus();
	G_Load(dsMAIN);
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("DEPT_CODE",opnrArgs.get("DEPT_CODE"))
											+ D_P2("WORK_YM",opnrArgs.get("WORK_YM"))
											+ D_P2("ITEM_NO",opnrArgs.get("ITEM_NO"));
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("WORK_YM",dsMAIN.NameString(dsMAIN.RowPosition,"WORK_YM"))
											+ D_P2("ITEM_NO",dsMAIN.NameString(dsMAIN.RowPosition,"ITEM_NO"))
											+ D_P2("APPLY_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"APPLY_SEQ"));
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
function	showSlip(dataset,row)
{
	var pSLIP_ID        = dataset.NameString(row,"SLIP_ID");
	var pSLIP_IDSEQ     = dataset.NameString(row,"SLIP_IDSEQ");
	var pMAKE_COMP_CODE = dataset.NameString(row,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dataset.NameString(row,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dataset.NameString(row,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dataset.NameString(row,"SLIP_KIND_TAG");
	var pREADONLY_TF    = "F";

	PopupOpen_AccSlipRetrieve (
		pSLIP_ID,
		pSLIP_IDSEQ,
		pMAKE_DT,
		pMAKE_SEQ,
		pSLIP_KIND_TAG,
		pMAKE_COMP_CODE,
		pREADONLY_TF
	);
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
}

// ����
function btninsert_onclick()
{
}

// ����
function btndelete_onclick()
{
}

// ����
function btnsave_onclick()
{
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
	if (dataset == dsMAIN)
	{
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
	
}

function OnPopup(dataset, grid, row, colid, data)
{
	
}
function OnDblClick(dataset, grid, row, colid)
{
}

// �̺�Ʈ����-------------------------------------------------------------------//





function	btnShowCashSlip_onclick()
{
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("��ȸ�� ���� �����Ͻʽÿ�.");
		return;
	}
	showSlip(dsSUB01,dsSUB01.RowPosition);
}
