/**************************************************************************/
/* 1. �� �� �� �� id : t_WChangePersonPwR.js(���ξ�ȣ����)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

function Initialize()
{
	G_addDataSet(dsMAIN, trans, null, null, "���¾�ȣ����");
	
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
	dsMAIN.NameString(dsMAIN.RowPosition,"NEW_PW") = txtNEW_PASSWORD.value;
	dsMAIN.NameString(dsMAIN.RowPosition,"EMP_NO") = sEmpNo;
	if(!G_saveData(dsMAIN))return;
	C_msgOk("��ȣ�� ���������� ����Ǿ����ϴ�.");
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
	ConfirmSelected();
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


function	imgOk_onClick()
{
	ConfirmSelected();
}
