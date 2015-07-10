/**************************************************************************/
/* 1. �� �� �� �� id : t_WEdiCreateR.jsp(������ü���ϻ���)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : ������ü���ϻ��� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-23)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize() 
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "��ü���ϻ����ڷ�");
	G_addDataSet(dsSUB01, null, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "��ü���ϻ����̷�");
  G_addDataSet(dsBANK, null, null, sSelectPageName+D_P1("ACT","BANK"), "�����ڵ���ȸ");	
	G_addDataSet(dsACCOUNT, null, null, sSelectPageName+D_P1("ACT","ACCOUNT"), "���¹�ȣ��ȸ");
	G_addDataSet(dsPASS, null, null, sSelectPageName+D_P1("ACT","PASS"), "��ȣȮ��");
	G_addDataSet(dsDateChk, null, null, sSelectPageName+D_P1("ACT","DateChk"), "��¥üũ");
  G_addDataSet(dsCOPY, transCopy, null, sSelectPageName+D_P1("ACT","COPY"), "����store");	
	
	gridMAIN.focus();
		
	G_addRel(dsBANK,dsACCOUNT);
	G_addRelCol(dsACCOUNT,"CODE","BANK_CODE");

	G_Load(dsBANK);
	G_Load(dsACCOUNT);
	
//	document.all.btnREC_SEND.disabled = true;
}
function OnLoadBefore(dataset)
{
	var	strBANK_CODE = dsBANK.NameString(dsBANK.RowPosition,"CODE");
	var	strACCNO_CODE = dsACCOUNT.NameString(dsACCOUNT.RowPosition,"CODE");
	
	if(dataset == dsMAIN)
	{		
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("PAY_GUBUN",txtPAY_GUBUN.value)
										 + D_P2("PAY_DUE_DATE",txtDT_F.value)
										 + D_P2("BANK_CODE",strBANK_CODE)
										 + D_P2("ACCNO_CODE",strACCNO_CODE);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("BANK_CODE",strBANK_CODE);
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
	else if (dataset == dsPASS)
	{
  	dataset.DataID = sSelectPageName + D_P1("ACT","PASS")
  										+ D_P2("EMP_NO",txtEMP_NO.value)
  										+ D_P2("MANAGER_PASS1",txtMANAGER_PASS1.value)
  										+ D_P2("MANAGER_PASS2",txtMANAGER_PASS2.value);
	}
	else if (dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
	}
	else if (dataset == dsDateChk)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DateChk")
											+ D_P2("DT_T",txtDT_T.value);
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
	//D_defaultLoad();
	G_Load(dsMAIN);
	G_Load(dsSUB01);
	SUM_SET_onblur()	
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
	if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
	}
	else if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
		
	  G_Load(dsDateChk);
	
		if ( dsDateChk.NameValue(1,"DAYS") > 10 ||dsDateChk.NameValue(1,"DAYS") < 0 )
		{
			txtDT_T.value = '' ;
			C_msgOk("�������ڴ� �������ڸ� �������� 10���� �ʰ��Ҽ� �����ϴ�.","�˸�");
			return;
		}	
	}	
}

function OnRowInsertBefore(dataset)
{
}
function OnRowInserted(dataset, row)
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
	
	txtSELECT_SUM.value = dbSum_ALL;
	txtSELECT_CNT.value = dbCnt_ALL;
}
//��ü���
function btnCANCEL_ALL_onClick()
{
	var i = 0;
	
	if(dsMAIN.CountRow==0) return;
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
			dsMAIN.NameString(i,"SELECT_YN") = "F";
	}
	
	txtSELECT_SUM.value = 0;
	txtSELECT_CNT.value = 0;
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

	if ( dataset == dsMAIN )
	{
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
	else
	{
			if ( dsSUB01.NameString(row,"SELECT_YN") == 'T')
			{
				for (i=1;i<=dsSUB01.CountRow;i++) {
	
					  if (i != row )
					  {
							dsSUB01.NameString(i,"SELECT_YN") = 'F';
						}		
				}	
			}	
	}				
}
//��ü���ϻ���
function 	btnEDI_CREATE_onClick()
{
 	var i = 0;
 	var cnt = 0;
 	var arrRtn = null;
	var arrRtn2 = null;
	var	strBANK_CODE = dsBANK.NameString(dsBANK.RowPosition,"CODE");
	var	strACCNO_CODE = dsACCOUNT.NameString(dsACCOUNT.RowPosition,"CODE");
	
	if(dsMAIN.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData()
	

	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if (dsMAIN.NameString(i,"SELECT_YN") == "T" )
		  {
				dsCOPY.AddRow()
				cnt = dsCOPY.CountRow;
				dsCOPY.NameString(cnt,"PAY_SEQ") = dsMAIN.NameString(i,"PAY_SEQ");
				dsCOPY.NameString(cnt,"COMP_CODE") = txtCOMP_CODE.value;
				dsCOPY.NameString(cnt,"PAY_GUBUN") = txtPAY_GUBUN.value;
				dsCOPY.NameString(cnt,"PAY_YMD") = txtDT_F.value;
				dsCOPY.NameString(cnt,"BANK_CODE") = strBANK_CODE;
				dsCOPY.NameString(cnt,"ACCOUNT_NO") = strACCNO_CODE;
				cnt++;
			}		
	}
		
	if ( cnt == 0 )
	{
		C_msgOk("���õ� �ڷᰡ �����ϴ�.","Ȯ��");
		return;
	}	

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

  transCopy.Parameters = "ACT=COPY";
   
	if(G_saveData(dsCOPY))
	{
		C_msgOk("��ü���ϻ��� �۾��� �Ϸ�Ǿ����ϴ�.","�˸�");
		G_Load(dsMAIN);
		G_Load(dsSUB01);
		SUM_SET_onblur()
	}
	
}
//��ü���ϻ���
function 	btnEDIDELETE_onClick()
{
 	var i = 0;
 	var cnt = 0;
	
	if(dsSUB01.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData()
	
	for (i=1;i<=dsSUB01.CountRow;i++) {
		  if (dsSUB01.NameString(i,"SELECT_YN") == "T" )
		  {
				if (C_isNull(dsSUB01.NameString(i,"SEND_DATE")))
				{
					dsCOPY.AddRow()
					cnt = dsCOPY.CountRow;
					dsCOPY.NameString(cnt,"PAY_SEQ") = dsSUB01.NameString(i,"EDI_HISTORY_SEQ");
					cnt++;
				}
			  else	
			  {	
					C_msgOk("�ش��ڷ�� ������ �Ұ��� �մϴ�.","����");
				  dsSUB01.NameString(i,"SELECT_YN")= "F" ;
				  return;
				}
			}		
	}
		
	if ( cnt == 0 )
	{
		C_msgOk("���õ� �ڷᰡ �����ϴ�.","Ȯ��");
		return;
	}	

  transCopy.Parameters = "ACT=COPY2";
   
	if(G_saveData(dsCOPY))
	{
		C_msgOk("��ü���ϻ��� �۾��� �Ϸ�Ǿ����ϴ�.","�˸�");
		G_Load(dsMAIN);
		G_Load(dsSUB01);
		SUM_SET_onblur()	
	}
	
}
//��ü���ϼ۽�
function 	btnEDISEND_onClick()
{
 	var i = 0;
 	var cnt = 0;
	var	strBANK_CODE = dsBANK.NameString(dsBANK.RowPosition,"CODE");
	
	if(dsSUB01.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData()
	
	for (i=1;i<=dsSUB01.CountRow;i++) {
		  if (dsSUB01.NameString(i,"SELECT_YN") == "T" )
		  {
				if (C_isNull(dsSUB01.NameString(i,"SEND_DATE")))
				{
					dsCOPY.AddRow()
					cnt = dsCOPY.CountRow;
					dsCOPY.NameString(cnt,"FILE_NAME") = dsSUB01.NameString(i,"SEND_FILE_NAME");
					dsCOPY.NameString(cnt,"COMP_CODE") = txtCOMP_CODE.value;
					dsCOPY.NameString(cnt,"BANK_CODE") = strBANK_CODE;				
					dsCOPY.NameString(cnt,"PAY_SEQ") = dsSUB01.NameString(i,"EDI_HISTORY_SEQ");
					dsCOPY.NameString(cnt,"PAY_YMD") = dsSUB01.NameString(i,"STD_YMD");
					cnt++;
				}
			  else	
			  {	
					C_msgOk("�ش��ڷ�� �̹� �۽ŵǾ����ϴ�.","����");
				  dsSUB01.NameString(i,"SELECT_YN")= "F" ;
				  return;
				}
			}		
	}
		
	if ( cnt == 0 )
	{
		C_msgOk("���õ� �ڷᰡ �����ϴ�.","Ȯ��");
		return;
	}	

  transCopy.Parameters = "ACT=COPY3";
   
	if(G_saveData(dsCOPY))
	{
		C_msgOk("��ü���ϼ۽� �۾��� �Ϸ�Ǿ����ϴ�.","�˸�");
		G_Load(dsSUB01);
	}
	
}
//ó���������
function 	btnRESULTRECV_onClick()
{
 	var i = 0;
 	var cnt = 0;
	var	strBANK_CODE = dsBANK.NameString(dsBANK.RowPosition,"CODE");
	
	if(dsSUB01.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData()
	dsCOPY.AddRow()
	cnt = dsCOPY.CountRow;
	dsCOPY.NameString(cnt,"COMP_CODE") = txtCOMP_CODE.value;
  dsCOPY.NameString(cnt,"BANK_CODE") = strBANK_CODE;				

  transCopy.Parameters = "ACT=COPY4";
   
	if(G_saveData(dsCOPY))
	{
		C_msgOk("ó��������� �۾��� �Ϸ�Ǿ����ϴ�.","�˸�");
		G_Load(dsMAIN);
		G_Load(dsSUB01);
		SUM_SET_onblur()	
	}
	
}
//����۽�
function 	btnRECSEND_onClick()
{
 	var i = 0;
 	var cnt = 0;
	var	strBANK_CODE = dsBANK.NameString(dsBANK.RowPosition,"CODE");
	
	if(dsSUB01.CountRow==0) return;
	if ( C_isNull(txtDT_T.value))
	{
		C_msgOk("�������ڸ� �Է��ϼ���.","Ȯ��");
		txtDT_T.focus
		return;
	}	
	
	G_Load(dsCOPY);
	dsCOPY.ClearData()
		
	for (i=1;i<=dsSUB01.CountRow;i++) {
		  if (dsSUB01.NameString(i,"SELECT_YN") == "T" )
		  {
				if (C_isNull(dsSUB01.NameString(i,"SEND_DATE")))
				{
					dsCOPY.AddRow()
					cnt = dsCOPY.CountRow;
					dsCOPY.NameString(cnt,"BANK_CODE") = strBANK_CODE;				
					dsCOPY.NameString(cnt,"FILE_NAME") = dsSUB01.NameString(i,"SEND_FILE_NAME");
					dsCOPY.NameString(cnt,"PAY_SEQ")   = dsSUB01.NameString(i,"EDI_HISTORY_SEQ");
					dsCOPY.NameString(cnt,"PAY_YMD")   = txtDT_T.value;
					cnt++;
				}
			  else	
			  {	
					C_msgOk("�ش��ڷ�� �̹� �۽ŵǾ����ϴ�.","����");
				  dsSUB01.NameString(i,"SELECT_YN")= "F" ;
				  return;
				}
			}		
	}
		
	if ( cnt == 0 )
	{
		C_msgOk("���õ� �ڷᰡ �����ϴ�.","Ȯ��");
		return;
	}	

  transCopy.Parameters = "ACT=COPY5";
   
	if(G_saveData(dsCOPY))
	{
		C_msgOk("����۽� �۾��� �Ϸ�Ǿ����ϴ�.","�˸�");
		G_Load(dsSUB01);
	}
	
}
//��ưcontrol
function 	btncontrol_onclick()
{
//	var	strBANK_CODE = dsBANK.NameString(dsBANK.RowPosition,"CODE");
//	var strPAY_GUBUN = txtPAY_GUBUN.value ;
	
//	if ( strPAY_GUBUN == '4' && strBANK_CODE.value == '20' )
//	{
//		document.all.btnREC_SEND.disabled = false;
//	}		
//	else
//	{
//		document.all.btnREC_SEND.disabled = true;
//	}			
}
