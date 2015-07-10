/**************************************************************************/
/* 1. �� �� �� �� id : t_WCashPay01.js(�������޽���Ȯ��)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-20)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó�� 
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "���ݽ���");
	G_addDataSet(dsCOPY, transCopy, null, sSelectPageName+D_P1("ACT","COPY"), "����store");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsPASS, null, null, sSelectPageName+D_P1("ACT","PASS"), "��ȣȮ��");
	G_addDataSet(dsBANK, null, null, sSelectPageName+D_P1("ACT","BANK"), "�����ڵ���ȸ");	
  G_addDataSet(dsMSG, null, null, sSelectPageName+D_P1("ACT","MSG"), "����޼���");	
	G_addDataSet(dsACCOUNT, null, null, sSelectPageName+D_P1("ACT","ACCOUNT"), "���¹�ȣ��ȸ");
	
	gridMAIN.focus();
	
	G_addRel(dsBANK,dsACCOUNT);
	G_addRelCol(dsACCOUNT,"CODE","BANK_CODE");

	G_Load(dsBANK);
	G_Load(dsACCOUNT);

  //document.all.btnRealTime_Send.disabled = true;
}
function OnLoadBefore(dataset)
{
	var	strBANK_CODE = dsBANK.NameString(dsBANK.RowPosition,"CODE");
	var	strACCNO_CODE = dsACCOUNT.NameString(dsACCOUNT.RowPosition,"CODE");	
	
	if (dataset == dsMAIN)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName 	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("PAY_GUBUN",txtPAY_GUBUN.value)
											+ D_P2("PAY_DUE_DATE",txtDT_F.value)
											+ D_P2("BANK_CODE",strBANK_CODE)
											+ D_P2("ACCNO_CODE",strACCNO_CODE)
											+ D_P2("PAY_STATUS",txtPAY_STATUS.value);
	}
	else if (dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
	}	
	else if (dataset == dsPASS)
	{
  	dataset.DataID = sSelectPageName + D_P1("ACT","PASS")
  										+ D_P2("EMP_NO",txtEMP_NO.value)
  										+ D_P2("MANAGER_PASS1",txtMANAGER_PASS1.value)
  										+ D_P2("MANAGER_PASS2",txtMANAGER_PASS2.value);
	}
	else if(dataset == dsBANK)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BANK")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value);
	}		
	else if(dataset == dsACCOUNT)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ACCOUNT")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("BANK_CODE",strBANK_CODE);	
	}	
	else if(dataset == dsMSG)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MSG")
										 + D_P2("PAY_SEQ",txtPAY_SEQ.value);
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
//	D_defaultLoad();
	button_status_onblur();
	SUM_SET_onblur()
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


//�ŷ�ó�ڵ�
function txtCUST_CODE_onblur()
{
	if (C_isNull(txtCUST_CODE.value))
	{ 
		txtCUST_CODE.value = '';
		txtCUST_NAME.value = '';
		txtCUST_SEQ.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	txtCUST_CODE.value = lrRet.get("CUST_CODE");
	txtCUST_NAME.value = lrRet.get("CUST_NAME");
	txtCUST_SEQ.value = lrRet.get("CUST_SEQ");

}

function btnCUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);

	if (C_isNull(txtCUST_CODE.value))
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"T");
	}

	if (lrRet == null) return;

	txtCUST_CODE.value = lrRet.get("CUST_CODE");
	txtCUST_NAME.value = lrRet.get("CUST_NAME");
	txtCUST_SEQ.value = lrRet.get("CUST_SEQ");
	
}

//��ü����
function btnSELECT_ALL_onClick()
{
	var i = 0;
 	var dbSum_ALL = dsMAIN.NameSum("PAY_AMT",0,0); 
 	var dbCnt_ALL = dsMAIN.CountRow;	
	
	if(dsMAIN.CountRow==0) return;
	
	for (i=1;i<=dsMAIN.CountRow;i++) {

				dsMAIN.NameString(i,"SELECT_YN") = "T";
	}
	
	if ( txtPAY_STATUS.value == "1" || txtPAY_STATUS.value == "2" )
	{	
		txtSELECT_SUM.value = dbSum_ALL;
		txtSELECT_CNT.value = dbCnt_ALL;
	}	
}

//��ü���
function btnCANCEL_ALL_onClick()
{
	var i = 0;
	
	if(dsMAIN.CountRow==0) return;
	
	for (i=1;i<=dsMAIN.CountRow;i++) {

				dsMAIN.NameString(i,"SELECT_YN") = "F";
	}
	
	if ( txtPAY_STATUS.value == "1" || txtPAY_STATUS.value == "2" )
	{	
		txtSELECT_SUM.value = 0;
		txtSELECT_CNT.value = 0;
	}		
}

//��ư control
function button_status_onblur()
{
  if ( (txtPAY_STATUS.value == "2")|| (txtPAY_STATUS.value == "5")|| (txtPAY_STATUS.value == "6"))
  {
			document.all.btnRealTime_Send.disabled = false;
	}
	else
  {
			document.all.btnRealTime_Send.disabled = true;
	}			
}

//��ü�۽�
function btnRealTime_Send_onClick()
{
 	var i = 0;
 	var cnt = 0;
 	var totalcnt = 0;
 	var successcnt = 0;
 	var failcnt = 0;
 	var arrRtn = null;
	var arrRtn2 = null;
	var msg;
	
	if(dsMAIN.CountRow==0) return;
	
	if ( dsMAIN.NameValueRow("SELECT_YN" ,"T") == 0 )
	{
			C_msgOk("���õ� �ڷᰡ �����ϴ�.","Ȯ��");
			return ;
	}
	//��ȣȮ��
	arrRtn2 = window.showModalDialog("t_PFBEdiCreateR.jsp", arrRtn, "center:yes; dialogWidth:405px; dialogHeight:245px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
	if(arrRtn2[0]=="TRUE")
	{
		var	strMANAGER_PASS1 	= arrRtn2[1];
		var	strMANAGER_PASS2	= arrRtn2[2];

		txtMANAGER_PASS1.value = strMANAGER_PASS1 ;
		txtMANAGER_PASS2.value = strMANAGER_PASS2 ;
	}
	
	G_Load(dsPASS);
	
	var ret_msg = dsPASS.NameString(1,"RET_MSG");
	
	if ( ret_msg != "OK")
	{
		C_msgOk(ret_msg,"�˸�");
		return ;
	}		

	G_Load(dsCOPY);
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if (dsMAIN.NameString(i,"SELECT_YN") == "T" )
		  {
				dsCOPY.ClearData();
				dsCOPY.AddRow();
				cnt = dsCOPY.CountRow;
				dsCOPY.NameString(cnt,"PAY_SEQ") = dsMAIN.NameString(i,"PAY_SEQ");
				transCopy.Parameters = "ACT=COPY";
				G_saveData(dsCOPY);
				txtPAY_SEQ.value = dsCOPY.NameString(cnt,"PAY_SEQ");
				G_Load(dsMSG);
				if  ( dsMSG.NameString(1,"STATUS")== '4' )
				{
					successcnt++;
				}					
				else
				{
					failcnt++;
				}		
				totalcnt++;
			}		
	}
	
	msg = '�ѰǼ� : ' + totalcnt + '��' + "<BR>" ;
	msg = msg + '�����Ǽ� : ' + successcnt + '��' +  "<BR>" ;
	msg = msg + '���аǼ� : ' + failcnt + '��' + "<BR>" ;
	msg = msg + '��ü�۽� �۾��� �Ϸ�Ǿ����ϴ�.';
	C_msgOk(msg,"�˸�");
	G_Load(dsMAIN);

}

//�հ谪setting
function SUM_SET_onblur()
{
 	var dbSum_ALL = dsMAIN.NameSum("PAY_AMT",0,0); 
 	var dbCnt_ALL = dsMAIN.CountRow;

	txtTOTAL_SUM.value = C_toNumberFormatString(dbSum_ALL,false); //�ѱݾ�
	txtTOTAL_CNT.value = dbCnt_ALL;                               //�ѰǼ�

	txtSELECT_SUM.value = 0 ;
	txtSELECT_CNT.value = 0 ;

}

function OnColumnChanged(dataset, row, colid)
{
	var dbSum_SELECT = C_convSafeFloat(C_removeComma(txtSELECT_SUM.value,false),false);
	var dbCnt_SELECT = C_convSafeFloat(txtSELECT_CNT.value,false);	

	if(colid ==	"SELECT_YN")
	{
		if ( dsMAIN.NameString(row,"SELECT_YN")== 'T' )
		{
			 txtSELECT_SUM.value = dbSum_SELECT +  dsMAIN.NameValue(row,"PAY_AMT");
			 txtSELECT_CNT.value = dbCnt_SELECT + 1 ;
		}	 
		else
		{	
			 txtSELECT_SUM.value = dbSum_SELECT - dsMAIN.NameValue(row,"PAY_AMT");
			 txtSELECT_CNT.value = dbCnt_SELECT - 1 ;				 
	  }
	} 
}
