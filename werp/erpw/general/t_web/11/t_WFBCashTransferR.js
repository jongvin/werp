/**************************************************************************/
/* 1. �� �� �� �� id : t_WCashPay01.js(�������޽���Ȯ��)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-20)
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
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "���ݽ���");
	G_addDataSet(dsCOPY, transCopy, null, sSelectPageName+D_P1("ACT","COPY"), "����store");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsDAY_CLOSE, null, null, null, "��������");
	G_addDataSet(dsAUTO_FBS_CASH_TRANS_SEQ, null, null, null, "FBS_������ü_�ڵ���ǥ_�۾���ȣ");
	
	gridMAIN.focus();
//	document.all.btnSeq_Create.disabled = true;

	// �ڵ���ǥ	start...
	txtSLIP_MAKE_DT_F.value	= sDate;
	txtSLIP_MAKE_DT.value	= sDate;

	txtSLIP_MAKE_COMP_CODE.value = sCompCode;
	txtSLIP_MAKE_COMP_NAME.value = sCompName;

	txtSLIP_MAKE_DEPT_CODE.value = sDeptCode;
	txtSLIP_MAKE_DEPT_NAME.value = sDeptName;

	txtSLIP_INOUT_DEPT_CODE.value = sInout_DeptCode;
	txtSLIP_INOUT_DEPT_NAME.value = sInout_DeptName;
	
	txtSLIP_CHARGE_PERS.value		= sCHARGE_PERS;
	txtSLIP_CHARGE_PERS_NAME.value	= sCHARGE_PERS_NAME;
	// �ڵ���ǥ	end...

}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName 	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("REQUEST_YMD",txtDT_F.value)
											+ D_P2("TRANSFER_STATUS",txtTRANSFER_STATUS.value)
											+ D_P2("OUTACCNO_CODE",txtOUTACCOUNT_CODE.value)
											+ D_P2("OUTBANK_CODE",txtOUTBANK_CODE.value)
											+ D_P2("INACCNO_CODE",txtINACCOUNT_CODE.value)
											+ D_P2("INBANK_CODE",txtINBANK_CODE.value);
	}
	else if (dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
	}
	else if(dataset == dsDAY_CLOSE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","DAY_CLOSE")
											+ D_P2("COMP_CODE",vMAKE_COMP_CODE)
											+ D_P2("DEPT_CODE",vMAKE_DEPT_CODE)
											+ D_P2("CLSE_DAY",vMAKE_DT_TRANS);
	}
	else if(dataset == dsAUTO_FBS_CASH_TRANS_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","AUTO_FBS_CASH_TRANS_SEQ");
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
	if (dsCOPY.CountRow > 0)
	{
		var ret = C_msgYesNoCancel("����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			btnsave_onclick();
			return ;
		}
		else if(ret == "C")
		{
			return ;
		}
	}
	
	dsCOPY.ClearData();
	
	//�ڷḦ �н��ϴ�.	
	if(!G_Load(dsMAIN)) return ;
	button_status_onblur()
}

// �߰�
function btnadd_onclick()
{
 	var arrRtn = Array(12);
	var arrRtn2 = null;

	if (dsCOPY.CountRow > 0)
	{
		var ret = C_msgYesNoCancel("����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			btnsave_onclick();
		}
		else if(ret == "C")
		{
			return ;
		}
		else
		{
			//�ڷḦ �н��ϴ�.	
			if(!G_Load(dsMAIN)) return ;
		}			
	}		

	arrRtn[0] = txtCOMP_CODE.value;
	arrRtn[1] = '';
	arrRtn[2] = '';
	arrRtn[3] = '';	
	arrRtn[4] = '';
	arrRtn[5] = '';
	arrRtn[6] = '';
	arrRtn[7] = '';
	arrRtn[8] = '';
	arrRtn[9] = '';
	arrRtn[10] = '';
	arrRtn[11] = '';		
	arrRtn2 = window.showModalDialog("t_PCashTransferR.jsp", arrRtn, "center:yes; dialogWidth:405px; dialogHeight:400px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
	if(arrRtn2[0]=="TRUE")
	{
		var	strREQUEST_YMD 	   = arrRtn2[1];
		var	strOUTACCOUNT_CODE = arrRtn2[2];
		var	strOUTBANK_CODE 	 = arrRtn2[3];
		var	strINACCOUNT_CODE	 = arrRtn2[4];
		var	strINBANK_CODE 	   = arrRtn2[5];
		var	strTRANSFER_AMT 	 = arrRtn2[6];
		var	strDESCRIPTION 	   = arrRtn2[7];
	}

	G_Load(dsCOPY);
	dsCOPY.ClearData()
	dsCOPY.AddRow()
	cnt = dsCOPY.CountRow;
	
	dsCOPY.NameString(cnt,"REQUEST_YMD") = C_Replace(strREQUEST_YMD,"-","");
	dsCOPY.NameString(cnt,"OUTACCOUNT_CODE") = strOUTACCOUNT_CODE;
	dsCOPY.NameString(cnt,"OUTBANK_CODE") = strOUTBANK_CODE;
	dsCOPY.NameString(cnt,"INACCOUNT_CODE") = strINACCOUNT_CODE;
	dsCOPY.NameString(cnt,"INBANK_CODE") = strINBANK_CODE;
	dsCOPY.NameString(cnt,"TRANSFER_AMT") = C_convSafeFloat(C_removeComma(strTRANSFER_AMT,false),false);
	dsCOPY.NameString(cnt,"COMP_CODE") = txtCOMP_CODE.value ;
	dsCOPY.NameString(cnt,"DESCRIPTION") = strDESCRIPTION ;
	
	transCopy.Parameters = "ACT=COPY1";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("������ �Ϸ�Ǿ����ϴ�.","�˸�");		
		G_Load(dsMAIN);
	}
			
  dsCOPY.ClearData()
}

// ����
function btninsert_onclick()
{
}

// ����
function btndelete_onclick()
{
  var i = 0;
 	var cnt = 0;
	
	if(dsMAIN.CountRow==0) return;
	if(dsCOPY.CountRow==0) 
	{
		G_Load(dsCOPY);
		dsCOPY.ClearData()
  }		
  
	for (i=1;i<=dsMAIN.CountRow;i++) {

		  if (dsMAIN.NameString(i,"SELECT_YN") == "T" )
		  {
				if (dsMAIN.NameString(i,"TRANSFER_STATUS") == "S" )
				{
					C_msgOk("�����Ҽ� �����ϴ�.","�˸�");
				  return;
				}  
				dsCOPY.AddRow()
				cnt = dsCOPY.CountRow;
				dsCOPY.NameString(cnt,"TRANSFER_SEQ") = dsMAIN.NameString(i,"TRANSFER_SEQ");
				dsMAIN.DeleteRow(i);
				i = i-1;
			}
	}				
}

// ����
function btnsave_onclick()
{
	if(dsCOPY.CountRow==0) return;
	
	transCopy.Parameters = "ACT=COPY2";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("������ �Ϸ�Ǿ����ϴ�.","�˸�");		
		G_Load(dsMAIN);
	}
	
	dsCOPY.ClearData()
}

// ���
function btncancel_onclick()
{	
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "SLIP_MAKE_DT")
	{
		txtSLIP_MAKE_DT.value = asDate;
	}
	else if (asCalendarID == "DT_F")
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

//��ư control
function button_status_onblur()
{
//  if ( (txtTRANSFER_STATUS.value == "S") || (txtTRANSFER_STATUS.value == "%"))
//  {
//			document.all.btnSeq_Create.disabled = true;
//	}
//	else
//  {
//			document.all.btnSeq_Create.disabled = false;
//	}			
}

//��ü����
function btnSeq_Create_onClick()
{
 	var i = 0;
 	var cnt = 0;
 	var MakeSelCnt = 0;
 	var StatusCnt = 0;
 	var arrRtn = null;
	var arrRtn2 = null;
	
	if(dsMAIN.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData();
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if (dsMAIN.NameString(i,"SELECT_YN") == "T" )
		  {
				if (dsMAIN.NameString(i,"KEEP_CLS") == "F" )
				{ 
					MakeSelCnt++;
					dsMAIN.NameString(i,"SELECT_YN") = "F" ;
				}
				else if ( dsMAIN.NameString(i,"TRANSFER_STATUS") == "S" )
				{ 
					StatusCnt++;
					dsMAIN.NameString(i,"SELECT_YN") = "F" ;
				}				
			  else
			  {	
					dsCOPY.AddRow();
					cnt = dsCOPY.CountRow;
					dsCOPY.NameString(cnt,"TRANSFER_SEQ") = dsMAIN.NameString(i,"TRANSFER_SEQ");
					cnt++;
				}	
			}		
	}
	
	if (MakeSelCnt > 0)
	{
		C_msgOk("��ǥȮ���� �ȵ� �׸��� ���õǾ� �־� ������ �����Ͽ����ϴ�.");
	}	
	
	if (StatusCnt > 0)
	{
		C_msgOk("��ü������ �Ϸ�� �׸��� ���õǾ� �־� ������ �����Ͽ����ϴ�.");
	}		
	
	if ( cnt == 0 )
	{
		C_msgOk("���õ� �ڷᰡ �����ϴ�.","Ȯ��")
		return;
	}	

	transCopy.Parameters = "ACT=COPY3";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("��ü���� �۾��� �Ϸ�Ǿ����ϴ�.","�˸�");
		G_Load(dsMAIN);
	}
	
	dsCOPY.ClearData()
}
function OnDblClick(dataset, grid, row, colid)
{
 	var arrRtn  = Array(12);
	var arrRtn2 = null;

	if (dsCOPY.CountRow > 0)
	{
		var ret = C_msgYesNoCancel("����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			btnsave_onclick();
		}
		else if(ret == "C")
		{
			return ;
		}
		else
		{
			//�ڷḦ �н��ϴ�.	
			if(!G_Load(dsMAIN)) return ;
		}			
	}
	if (dsMAIN.NameString(row,"TRANSFER_STATUS") == "S" )
	{
		C_msgOk("�����Ҽ� �����ϴ�.","�˸�");
	  return;
	}  
			
	arrRtn[0] = txtCOMP_CODE.value;
	arrRtn[1] = dsMAIN.NameString(row,"REQUEST_YMD");
	arrRtn[2] = dsMAIN.NameString(row,"OUT_ACCOUNT_NO");
	arrRtn[3] = dsMAIN.NameString(row,"OUT_BANK_CODE");	
	arrRtn[4] = dsMAIN.NameString(row,"OUT_BANK_NAME");
	arrRtn[5] = dsMAIN.NameString(row,"IN_ACCOUNT_NO");
	arrRtn[6] = dsMAIN.NameString(row,"IN_BANK_CODE");
	arrRtn[7] = dsMAIN.NameString(row,"IN_BANK_NAME");
	arrRtn[8] = dsMAIN.NameString(row,"REMAIN_AMT");
	arrRtn[9] = dsMAIN.NameString(row,"STD_YMD");
	arrRtn[10] = dsMAIN.NameString(row,"TRANSFER_AMT");	
	arrRtn[11] = dsMAIN.NameString(row,"DESCRIPTION");	
	
	arrRtn2 = window.showModalDialog("t_PCashTransferR.jsp", arrRtn, "center:yes; dialogWidth:405px; dialogHeight:400px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
	if(arrRtn2[0]=="TRUE")
	{
		var	strREQUEST_YMD 	   = arrRtn2[1];
		var	strOUTACCOUNT_CODE = arrRtn2[2];
		var	strOUTBANK_CODE 	 = arrRtn2[3];
		var	strINACCOUNT_CODE	 = arrRtn2[4];
		var	strINBANK_CODE 	   = arrRtn2[5];
		var	strTRANSFER_AMT 	 = arrRtn2[6];
		var	strDESCRIPTION 	   = arrRtn2[7];
	}

	G_Load(dsCOPY);
	dsCOPY.ClearData()
	dsCOPY.AddRow()
	cnt = dsCOPY.CountRow;
	
	dsCOPY.NameString(cnt,"TRANSFER_SEQ") = dsMAIN.NameString(row,"TRANSFER_SEQ");
	dsCOPY.NameString(cnt,"REQUEST_YMD") = C_Replace(strREQUEST_YMD,"-","");
	dsCOPY.NameString(cnt,"OUTACCOUNT_CODE") = strOUTACCOUNT_CODE;
	dsCOPY.NameString(cnt,"OUTBANK_CODE") = strOUTBANK_CODE;
	dsCOPY.NameString(cnt,"INACCOUNT_CODE") = strINACCOUNT_CODE;
	dsCOPY.NameString(cnt,"INBANK_CODE") = strINBANK_CODE;
	dsCOPY.NameString(cnt,"TRANSFER_AMT") = C_convSafeFloat(C_removeComma(strTRANSFER_AMT,false),false);
	dsCOPY.NameString(cnt,"COMP_CODE") = txtCOMP_CODE.value ;
	dsCOPY.NameString(cnt,"DESCRIPTION") = strDESCRIPTION ;
	
	transCopy.Parameters = "ACT=COPY4";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("������ �Ϸ�Ǿ����ϴ�.","�˸�");		
		G_Load(dsMAIN);
	}		
	
	dsCOPY.ClearData()
}
function OnColumnChanged(dataset, row, colid)
{

}
//��ݰ���ã��
function txtOUTACCOUNT_CODE_onblur()
{
	if (C_isNull(txtOUTACCOUNT_CODE.value))
	{
		txtOUTACCOUNT_CODE.value = '';
		txtOUTBANK_NAME.value = '';
		txtOUTBANK_CODE.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtOUTACCOUNT_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("FBS_TRANSFER_CLS", 'T');

	lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE3", lrArgs,"T");

	if (lrRet == null) return;
	
	txtOUTACCOUNT_CODE.value = lrRet.get("ACCNO");
	txtOUTBANK_NAME.value = lrRet.get("BANK_NAME");
	txtOUTBANK_CODE.value = lrRet.get("BANK_CODE");
}
function btnOUTACCOUNT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtOUTACCOUNT_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("FBS_TRANSFER_CLS", 'T');
	
	lrRet = C_LOV("T_ACCNO_CODE3", lrArgs,"F");

	if (lrRet == null) return;

	txtOUTACCOUNT_CODE.value = lrRet.get("ACCNO");
	txtOUTBANK_NAME.value = lrRet.get("BANK_NAME");
	txtOUTBANK_CODE.value = lrRet.get("BANK_CODE");
}
//�Աݰ���ã��
function txtINACCOUNT_CODE_onblur()
{
	if (C_isNull(txtINACCOUNT_CODE.value))
	{
		txtINACCOUNT_CODE.value = '';
		txtINBANK_NAME.value = '';
		txtINBANK_CODE.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtINACCOUNT_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("BANK_CODE", '%');
	lrArgs.set("ACCT_CLS", '%');

	lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	txtINACCOUNT_CODE.value = lrRet.get("ACCNO");
	txtINBANK_NAME.value = lrRet.get("BANK_NAME");
	txtINBANK_CODE.value = lrRet.get("BANK_CODE");
}
function btnINACCOUNT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtINACCOUNT_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("BANK_CODE", '%');
	lrArgs.set("ACCT_CLS", '%');

	lrRet = C_LOV("T_ACCNO_CODE1", lrArgs,"F");

	if (lrRet == null) return;

	txtINACCOUNT_CODE.value = lrRet.get("ACCNO");
	txtINBANK_NAME.value = lrRet.get("BANK_NAME");
	txtINBANK_CODE.value = lrRet.get("BANK_CODE");
}

//��������
function btnSLIP_MAKE_DT_onClick()
{
	txtSLIP_MAKE_DT_F.value = txtSLIP_MAKE_DT.value;
	
	C_Calendar("SLIP_MAKE_DT", "D", txtSLIP_MAKE_DT.value);
}

function Input_Clear()
{	
	if (C_isNull(txtSLIP_MAKE_COMP_CODE.value))
	{
		txtSLIP_MAKE_COMP_NAME.value = "";
		txtSLIP_MAKE_DEPT_CODE.value = "";
	}

	if (C_isNull(txtSLIP_MAKE_DEPT_CODE.value))
	{
		txtSLIP_MAKE_DEPT_NAME.value = "";
	}
	
}

// ���ǻ����
function btnSLIP_MAKE_COMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("WORK_CODE", vWORK_CODE);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE2", lrArgs,"T");
	
	if (lrRet == null) return;
	txtSLIP_MAKE_COMP_CODE.value	= "";
	Input_Clear();
	txtSLIP_MAKE_COMP_CODE.value	= lrRet.get("COMP_CODE");
	txtSLIP_MAKE_COMP_NAME.value	= lrRet.get("COMPANY_NAME");
	txtSLIP_CHARGE_PERS.value		= lrRet.get("CHARGE_PERS");
	txtSLIP_CHARGE_PERS_NAME.value	= lrRet.get("CHARGE_PERS_NAME");
}

//���Ǻμ�
function btnSLIP_MAKE_DEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtSLIP_MAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtSLIP_MAKE_DEPT_CODE.value);

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;
	
	txtSLIP_MAKE_DEPT_CODE.value	= "";
	Input_Clear();

	txtSLIP_MAKE_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtSLIP_MAKE_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
	Input_Clear();
}

//�ⳳ�μ�
function btnSLIP_INOUT_DEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtSLIP_MAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	//lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");
	lrRet = C_LOV_NEW("T_DEPT_CODE3", btnSLIP_INOUT_DEPT_CODE, lrArgs,"T");

	if (lrRet == null) return;
	
	txtSLIP_INOUT_DEPT_CODE.value	= "";
	Input_Clear();

	txtSLIP_INOUT_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtSLIP_INOUT_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
}

//�������
function btnSLIP_CHARGE_PERS_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtSLIP_MAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtSLIP_CHARGE_PERS.value);

	lrRet = C_LOV("Z_AUTHORITY_USER02", lrArgs,"T");

	if (lrRet == null) return;
	
	txtSLIP_CHARGE_PERS.value	= "";
	Input_Clear();

	txtSLIP_CHARGE_PERS.value	= lrRet.get("EMPNO");
	txtSLIP_CHARGE_PERS_NAME.value	= lrRet.get("NAME");
}

// ��ü��ǥ����
function	btnSlipCreate_onClick()
{
	if(!chkDayClose(true)) return;
	//����
	if (txtSLIP_MAKE_DT.value == "")
	{
		C_msgOk("�ۼ����ڸ� �Է��Ͽ� �ֽʽÿ�.");
		txtSLIP_MAKE_DT.focus();
		return;
	}

	if (txtSLIP_MAKE_COMP_CODE.value == "")
	{
		C_msgOk("����� �Է��Ͽ� �ֽʽÿ�.");
		return;
	}
	
	if (C_isNull(txtSLIP_MAKE_DEPT_CODE.value || txtSLIP_MAKE_DEPT_NAME.value))
	{
		C_msgOk("�ۼ��μ��� �Է��Ͽ� �ֽʽÿ�.");
		return;
	}
	
	if (C_isNull(txtSLIP_CHARGE_PERS.value || txtSLIP_CHARGE_PERS_NAME.value))
	{
		C_msgOk("��������� �Էµ��� �ʾҽ��ϴ�.<BR>*[��������>�ڵ���ǥ�ڵ�]���� �ڵ���ǥ�� ����� ��������� ��ϵƴ��� Ȯ�����ֽñ� �ٶ��ϴ�.");
		return;
	}
	
	if (C_isNull(txtSLIP_INOUT_DEPT_CODE.value || txtSLIP_INOUT_DEPT_NAME.value))
	{
		C_msgOk("�ⳳ�μ��� �Է��Ͽ� �ֽʽÿ�.");
		return;
	}

	var	strAMT_TAG = 0;
	var	strMakeSelCnt = 0;
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		if (dsMAIN.NameString(i,"SELECT_YN") == "T")
		{
			if (dsMAIN.NameString(i,"MAKE_CLS") == "T")
			{
				strMakeSelCnt++;
				dsMAIN.NameString(i,"SELECT_YN") = "F";
			}
			else {
				strAMT_TAG++;
			}
		}
	}

	if (strMakeSelCnt > 0)
	{
		C_msgOk("�̹� ��ǥ����� �׸��� ���õ��־� ������ �����Ͽ����ϴ�.");
	}
	
	if (strAMT_TAG == 0)
	{
		C_msgOk("���õ� �׸��� �����ϴ�.");
		return;
	}

	G_Load(dsAUTO_FBS_CASH_TRANS_SEQ, null);
	
	trans.Parameters = "";
	trans.Parameters += "ACT=AUTO_FBS_CASH_TRANS";
	trans.Parameters += ",AUTO_FBS_CASH_TRANS_SEQ="+dsAUTO_FBS_CASH_TRANS_SEQ.NameString(1,"AUTO_FBS_CASH_TRANS_SEQ");
	trans.Parameters += ",SLIP_MAKE_DT="+C_Replace(txtSLIP_MAKE_DT.value,"-","");
	trans.Parameters += ",SLIP_KIND_TAG=B";
	trans.Parameters += ",SLIP_MAKE_COMP_CODE="+txtSLIP_MAKE_COMP_CODE.value;
	trans.Parameters += ",SLIP_MAKE_DEPT_CODE="+txtSLIP_MAKE_DEPT_CODE.value;
	trans.Parameters += ",SLIP_CHARGE_PERS="+txtSLIP_CHARGE_PERS.value;
	trans.Parameters += ",SLIP_INOUT_DEPT_CODE="+txtSLIP_INOUT_DEPT_CODE.value;
	
	//alert(trans.Parameters);

	if(!G_saveDataMsg(dsMAIN)) return;;
	btnquery_onclick();
	/*
	btnRetrieve_onClick();
	
	txtBANK_CODE.value = "";
	txtBANK_NAME.value = "";
	txtACCNO.value = "";
	txtSLIP_ID.value = "";
	txtACC_CODE01.value	 = "";
	txtACC_NAME01.value	 = "";
	*/
}

// ��ü��ǥ����
function	btnSlipDelete_onClick()
{
	if(!chkDayClose(true)) return;
	
	var	strAMT_TAG = 0;
	var	strKeepSelCnt = 0;
	var	strNotMakeSelCnt = 0;

	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		if (dsMAIN.NameString(i,"SELECT_YN") == "T")
		{
			if (dsMAIN.NameString(i,"KEEP_CLS") == "T")
			{
				strKeepSelCnt++;
				dsMAIN.NameString(i,"SELECT_YN") = "F";
			}
			else if (dsMAIN.NameString(i,"MAKE_CLS") != "T")
			{
				strNotMakeSelCnt++;
				dsMAIN.NameString(i,"SELECT_YN") = "F";
			}

			else {
				strAMT_TAG++;
			}
		}
	}

	if (strKeepSelCnt > 0)
	{
		C_msgOk("����� ��ǥ�� Ȯ���� �׸��� ���õ��־� ������ �����Ͽ����ϴ�.");
	}

	if (strNotMakeSelCnt > 0)
	{
		C_msgOk("��ǥ �̹��� �׸��� ���õ��־� ������ �����Ͽ����ϴ�.");
	}
	
	if (strAMT_TAG == 0)
	{
		C_msgOk("���õ� �׸��� �����ϴ�.");
		return;
	}
	
	trans.Parameters = "";
	trans.Parameters += "ACT=DELETE_FBS_CASH_TRANS";
	
	//alert(trans.Parameters);
	
	if(!G_saveDataMsg(dsMAIN)) return;;
	btnquery_onclick();
	/*
	btnRetrieve_onClick();
	
	txtBANK_CODE.value = "";
	txtBANK_NAME.value = "";
	txtACCNO.value = "";
	txtSLIP_ID.value = "";
	txtACC_CODE01.value	 = "";
	txtACC_NAME01.value	 = "";
	*/
}

//ȸ�⸶��
function chkDayClose(bMsgView)
{
	//var vMsg = "( ��ǥ��ȣ : "+dsMAIN.NameString(row,"MAKE_SLIPNO") + " )";
	var vMsg = "";
	vMAKE_COMP_CODE = txtSLIP_MAKE_COMP_CODE.value;
	vMAKE_DEPT_CODE = txtSLIP_MAKE_DEPT_CODE.value;
	vMAKE_DT_TRANS  = txtSLIP_MAKE_DT.value;
	G_Load(dsDAY_CLOSE, null);
	if(dsDAY_CLOSE.CountRow==0) {
		if(bMsgView) C_msgOk("�ش������� ����庰 ���������� ��ϵ��� �ʾҽ��ϴ�.<BR>"+vMsg, "Ȯ��");
		vAccClse = false;
		vMonClse = false;
		vDayClse = false;
		vDeptClse = false;
		return false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "ACC_CLSE_CLS") == "T")
	{
		if(bMsgView) C_msgOk("�ش����ڴ� ȸ�⸶���Ǿ����ϴ�.<BR>"+vMsg, "Ȯ��");
		vAccClse = true;
		return false;
	} else {
		vAccClse = false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "MON_CLSE_CLS") == "T")
	{
		if(bMsgView) C_msgOk("�ش����ڴ� �������Ǿ����ϴ�.<BR>"+vMsg, "Ȯ��");
		vMonClse = true;
		return false;
	} else {
		vMonClse = false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "DAY_CLSE_CLS") == "T")
	{
		if(bMsgView) C_msgOk("�ش����ڴ� �ϸ����Ǿ����ϴ�.<BR>"+vMsg, "Ȯ��");
		vDayClse = true;
		return false;
	} else {
		vDayClse = false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "DEPT_CLSE_CLS") == "T")
	{		
		if(bMsgView) C_msgOk(txtMAKE_DEPT_NAME.value+"�� ��ǥ�Է±Ⱓ�� ����Ǿ����ϴ�.<BR>"+vMsg+"<BR>* ��ǥ�Է°��ɱⰣ : ("+dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "INPUT_DT")+")", "Ȯ��");
		vDeptClse = true;
		return false;
	} else {
		vDeptClse = false;
	}
	
	return true;
}

// ��ü����
function btnAllSelect_onClick()
{
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
//		if(dsMAIN.NameString(i,"KEEP_CLS") != "T") 
		dsMAIN.NameString(i,"SELECT_YN") = "T";
	}
}

// ��ü�������
function btnAllSelCancle_onClick()
{
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
//		if(dsMAIN.NameString(i,"KEEP_CLS") != "T") 
		dsMAIN.NameString(i,"SELECT_YN") = "F";
	}
}

//�� ǥ �� ȸ
function btnSlipRetrieve_onClick()
{
	var vRow = dsMAIN.RowPosition;
	if(dsMAIN.NameString(vRow,"MAKE_CLS") != "T") {
		C_msgOk("��ǥ�� ������� �ʾҽ��ϴ�.","�˸�");
		return;
	}

	var pSLIP_ID        = dsMAIN.NameString(vRow,"SLIP_ID");
	var pSLIP_IDSEQ     = dsMAIN.NameString(vRow,"SLIP_IDSEQ");
	var pMAKE_COMP_CODE = dsMAIN.NameString(vRow,"MAKE_COMP_CODE");
	var pMAKE_DT 	    = dsMAIN.NameString(vRow,"MAKE_DT").replace(/-/gi,"");
	var pMAKE_SEQ     	= dsMAIN.NameString(vRow,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsMAIN.NameString(vRow,"SLIP_KIND_TAG");
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