/**************************************************************************/
/* 1. �� �� �� �� id : t_WCashPay01.js(���������ⳳȮ��)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-17)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�ܾ׸�");
	G_addDataSet(dsCOPY, transCopy, null, sSelectPageName+D_P1("ACT","COPY"), "����store");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");

	gridMAIN.focus();

}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName 	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("BANK_CODE",txtBANK_CODE.value)
											+ D_P2("ACCNO_CODE",txtACCNO_CODE.value)
											+ D_P2("DT_F",txtDT_F.value);
	}
	else if (dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
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
	gridMAIN.focus();
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
	D_defaultSave(dsMAIN);
}

// ���
function btncancel_onclick()
{	
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
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
function btnDT_F_onClick()
{
	C_Calendar("DT_F", "D", txtDT_F.value);
}

//�ű��ܾ���ȸ
function btnSELECT_NEW_onClick()
{
 	var i = 0;

	if(dsMAIN.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData();
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
				dsCOPY.AddRow()
				cnt = dsCOPY.CountRow;
				dsCOPY.NameString(cnt,"ACCOUNT_NO") = dsMAIN.NameString(i,"ACCOUNT_NO");
				dsCOPY.NameString(cnt,"BANK_CODE") = dsMAIN.NameString(i,"BANK_CODE");
	}		

	transCopy.Parameters = "ACT=COPY";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("�ű���ȸ �۾��� �Ϸ�Ǿ����ϴ�.","�˸�");
		G_Load(dsMAIN);
	}
}

//��������
function btnSAVE_ORDER_onClick()
{
	btnsave_onclick();
}

function OnColumnChanged(dataset, row, colid)
{

}
//���¹�ȣ
function txtACCNO_CODE_onblur()
{	
	if (C_isNull(txtACCNO_CODE.value))
	{
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtACCNO_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("FBS_TRANSFER_CLS", '');
	
	lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE3", lrArgs,"T");

	if (lrRet == null) return;
	
	txtACCNO_CODE.value = lrRet.get("ACCNO");
	txtBANK_NAME.value = lrRet.get("BANK_NAME");
	txtBANK_CD.value = lrRet.get("BANK_CODE");
	txtBANK_CODE.value = '%';
}
function btnACCNO_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtACCNO_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("FBS_TRANSFER_CLS", '');
	
	lrRet = C_LOV("T_ACCNO_CODE3", lrArgs,"F");

	if (lrRet == null) return;
	
	txtACCNO_CODE.value = lrRet.get("ACCNO");
	txtBANK_NAME.value = lrRet.get("BANK_NAME");
	txtBANK_CD.value = lrRet.get("BANK_CODE");
	txtBANK_CODE.value = '%';
}
//EXCEL�� EXPORT
function btnEXCEL_EXPORT_onClick()
{
}