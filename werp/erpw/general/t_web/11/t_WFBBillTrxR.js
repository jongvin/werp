/**************************************************************************/
/* 1. �� �� �� �� id : t_WFBBillTrxR.js(�����ŷ���)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-23)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "���ݰŷ���");
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
											+ D_P2("TRX_GUBUN",txtTRX_GUBUN.value)
											+ D_P2("BANK_CD",txtBANK_CD.value)
											+ D_P2("FUTUREBANK_CD",txtFUTUREBANK_CD.value)
											+ D_P2("DT_F",txtDT_F.value)
											+ D_P2("DT_T",txtDT_T.value)
											+ D_P2("ACCNO_CODE",txtACCNO_CODE.value);
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
	G_Load(dsMAIN);	
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
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
	}
	if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
	}		
	if (asCalendarID == "DT_F1")
	{
		txtDT_F1.value = asDate;
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
function btnDT_T_onClick()
{
	C_Calendar("DT_T", "D", txtDT_T.value);
}
function btnDT_F1_onClick()
{
	C_Calendar("DT_F1", "D", txtDT_F1.value);
}

//�����û
function btnDOCU_NUM_onClick()
{
/*	if ( C_isNull(txtBANK_CD.value) )
	{
		C_msgOk("�����û�� ������ �����ϼ���.","Ȯ��")
		return;
	}	

	G_Load(dsCOPY);
	dsCOPY.ClearData();
	dsCOPY.AddRow()
	cnt = dsCOPY.CountRow;
	
	dsCOPY.NameString(cnt,"COMP_CODE") = txtCOMP_CODE.value;
	dsCOPY.NameString(cnt,"BANK_CODE") = txtBANK_CD.value;
	dsCOPY.NameString(cnt,"TRADE_YMD") = C_Replace(txtDT_F1.value,'-','');
	dsCOPY.NameString(cnt,"MISS_NUM") = C_LPad(txtDOCU_NUM.value,6,'0');

	transCopy.Parameters = "ACT=COPY";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("�����û �۾��� �Ϸ�Ǿ����ϴ�.","�˸�");
		G_Load(dsMAIN);
	} */
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
	txtBANK_CODE.value = lrRet.get("BANK_CODE");	
	txtBANK_CD.value = '%';
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
	txtBANK_CODE.value = lrRet.get("BANK_CODE");	
	txtBANK_CD.value = '%';
}