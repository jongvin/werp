/**************************************************************************/
/* 1. �� �� �� �� id : t_WCustCodeR.js(�ŷ�ó�ڵ�)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-15)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

var lrArgs = window.dialogArguments;
var	intX = 0;
var	intY = 0;
var	intWidth = 300;
var	intHeight = 200;
function Initialize()
{
	document.body.topMargin = 0;
	document.body.leftMargin = 0;
	
	if (intX == 0 && intY == 0 )
	{
		window.dialogTop = (window.screen.availHeight / 2) - ((intHeight + 25) / 2);
		window.dialogLeft = (window.screen.availWidth / 2) - ((intWidth + 6) / 2);
	}
	else
	{
		window.dialogTop = intY;
		window.dialogLeft = intX;
	}
	G_addDataSet(dsMAIN, trans, null, null, "���¾�ȣ����");
	
	window.dialogHeight = (intHeight + 25).toString() + "px";
	window.dialogWidth = (intWidth + 6).toString() + "px";
}


function ConfirmSelected()
{
	if(txtNEW_PASSWORD.value == txtNEW_PASSWORD_CONFIRM.value)
	{
	}
	else
	{
		C_msgOk("�űԾ�ȣ�� ��ȣ���Է��� ���� �ٸ��ϴ�.");
		return;
	}
	G_Load(dsMAIN);
	dsMAIN.NameString(dsMAIN.RowPosition,"OLD_PW") = txtOLD_PASSWORD.value;
	dsMAIN.NameString(dsMAIN.RowPosition,"ACCNO") = lrArgs.accno;
	dsMAIN.NameString(dsMAIN.RowPosition,"NEW_PW") = txtNEW_PASSWORD.value;
	dsMAIN.NameString(dsMAIN.RowPosition,"EMP_NO") = lrArgs.emp_no;
	if(!G_saveData(dsMAIN))return;
	window.returnValue = "OK";
	window.close();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
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

function btnquery_onclick()
{
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

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
}


function OnKeyPress(dataset, grid, kcode)
{
}

function OnDblClick(dataset, grid, row, colid)
{
}

// �̺�Ʈ����-------------------------------------------------------------------//
function document_onKeyDown()
{
	if (event.keyCode == 27)
	{
		imgCancle_onClick();
	}
}


function btnRetrieve_onClick()
{
	G_Load(dsMain, null);
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
