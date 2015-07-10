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
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�����ⳳ");
	G_addDataSet(dsCOPY, transCopy, null, sSelectPageName+D_P1("ACT","COPY"), "����store");
	G_addDataSet(dsMAKE, transMake, null, sSelectPageName+D_P1("ACT","MAKE"), "����Ÿ����");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsPASS, null, null, sSelectPageName+D_P1("ACT","PASS"), "��ȣȮ��");
	
	document.all.btnCASH_CONFIRM.disabled = false;
	document.all.btnCASH_CANCEL.disabled = true;	
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName 	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("PAY_GUBUN",txtPAY_GUBUN.value)
											+ D_P2("PAY_STATUS",txtPAY_STATUS.value)
											+ D_P2("BANK_CODE",txtBANK_CODE.value)											
											+ D_P2("DT_F",txtDT_F.value)
											+ D_P2("DT_T",txtDT_T.value)
											+ D_P2("CUST_CODE",txtCUST_SEQ.value)
											+ D_P2("METHOD_CODE",txtMETHOD_CODE.value);
	}
	else if (dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
	}	
	else if (dataset == dsMAKE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAKE");
	}			
	else if (dataset == dsPASS)
	{
  	dataset.DataID = sSelectPageName + D_P1("ACT","PASS")
  										+ D_P2("EMP_NO",txtEMP_NO.value)
  										+ D_P2("MANAGER_PASS1",txtMANAGER_PASS1.value)
  										+ D_P2("MANAGER_PASS2",txtMANAGER_PASS2.value);
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
	//D_defaultLoad();
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
	else if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
	}	
	else if (asCalendarID == "DT_F1")
	{
		txtDT_F1.value = asDate;
	}
	else if (asCalendarID == "DT_T1")
	{
		txtDT_T1.value = asDate;
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

function btnDT_T1_onClick()
{
	C_Calendar("DT_T1", "D", txtDT_T1.value);
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
	
	if(dsMAIN.CountRow==0) return;
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if ((dsMAIN.NameString(i,"PAY_STATUS") == "0" )||(dsMAIN.NameString(i,"PAY_STATUS") == "1" ))
		  {
				dsMAIN.NameString(i,"SELECT_YN") = "T";
			}		
	}
	
	txtDT_F1.focus();
}

//��ü���
function btnCANCEL_ALL_onClick()
{
	var i = 0;
	
	if(dsMAIN.CountRow==0) return;
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if ((dsMAIN.NameString(i,"PAY_STATUS") == "0" )||(dsMAIN.NameString(i,"PAY_STATUS") == "1" ))
		  {
				dsMAIN.NameString(i,"SELECT_YN") = "F";
			}		
	}
	
	txtDT_F1.focus();
}

//��ư control
function button_status_onblur()
{
  if (txtPAY_STATUS.value == "0")
  {
			document.all.btnCASH_CONFIRM.disabled = false;
	    document.all.btnCASH_CANCEL.disabled = true;	
	}
	else if (txtPAY_STATUS.value == "1")
  {
			document.all.btnCASH_CONFIRM.disabled = true;
	    document.all.btnCASH_CANCEL.disabled = false;	
	}	
	else
  {
			document.all.btnCASH_CONFIRM.disabled = true;
	    document.all.btnCASH_CANCEL.disabled = true;	
	}			
}

//����Ÿ����
function btnDATA_MAKE_onClick()
{
 	var i = 0;
 	var cnt = 0;

	G_Load(dsMAKE);
	dsMAKE.ClearData();
	dsMAKE.AddRow()
	cnt = dsMAKE.CountRow;
	dsMAKE.NameString(cnt,"COMP_CODE") = txtCOMP_CODE.value;	
	dsMAKE.NameString(cnt,"FROM_DATE") = txtDT_F.value.replace(/-/g,'');		
	dsMAKE.NameString(cnt,"TO_DATE") = txtDT_T.value.replace(/-/g,'');
	
	transMake.Parameters = "ACT=MAKE";

	if(G_saveData(dsMAKE))
	{
		C_msgOk("����Ÿ���� �۾��� �Ϸ�Ǿ����ϴ�.","�˸�");
		G_Load(dsMAIN);
	}
}
//�����Ȯ��
function btnCASH_CONFIRM_onClick()
{
 	var i = 0;
 	var cnt = 0;
 	var arrRtn = null;
	var arrRtn2 = null;
		
	if(dsMAIN.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData();
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if (dsMAIN.NameString(i,"SELECT_YN") == "T" )
		  {
				if ( dsMAIN.NameString(i,"CONTRACT_GUBUN") == "C" )
				{
					 C_msgOk(dsMAIN.NameString(i,"CUST_NAME")+'�� ������ü�� �ƴմϴ�.' ,"Ȯ��");
					 dsMAIN.NameString(i,"SELECT_YN") = "F";
				}
			  else
			  {	
					dsCOPY.AddRow()
					cnt = dsCOPY.CountRow;
					dsCOPY.NameString(cnt,"PAY_SEQ") = dsMAIN.NameString(i,"PAY_SEQ");
					cnt++;
				}	
			}		
	}
		
	if ( cnt == 0 )
	{
		C_msgOk("���õ� �ڷᰡ �����ϴ�.","Ȯ��")
		return;
	}	

	arrRtn2 = window.showModalDialog("t_PFBBillManagerconfR.jsp", arrRtn, "center:yes; dialogWidth:405px; dialogHeight:245px; status:no; help:no; scroll:no");

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
		C_msgOk("�����Ȯ�� �۾��� �Ϸ�Ǿ����ϴ�.","�˸�");
		G_Load(dsMAIN);
	}
}

//��������
function btnCASH_CANCEL_onClick()
{
 	var i = 0;
 	var cnt = 0;
 	var arrRtn = null;
	var arrRtn2 = null;
		
	if(dsMAIN.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData()
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if (dsMAIN.NameString(i,"SELECT_YN") == "T" )
		  {
				dsCOPY.AddRow()
				cnt = dsCOPY.CountRow;
				dsCOPY.NameString(cnt,"PAY_SEQ") = dsMAIN.NameString(i,"PAY_SEQ");
				cnt++;
			}		
	}
		
	if ( cnt == 0 )
	{
		C_msgOk("���õ� �ڷᰡ �����ϴ�.","Ȯ��")
		return;
	}	

	arrRtn2 = window.showModalDialog("t_PFBBillManagerconfR.jsp", arrRtn, "center:yes; dialogWidth:405px; dialogHeight:245px; status:no; help:no; scroll:no");

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
	
	transCopy.Parameters = "ACT=COPY2";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("�������� �۾��� �Ϸ�Ǿ����ϴ�.","�˸�");
		G_Load(dsMAIN);
	}
}

//�հ谪setting
function SUM_SET_onblur()
{
 	var i = 0;
 	var dbSum_ALL = 0;
 	var dbSum_PAY = 0;
 	var dbSum_NON = 0;
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		
			dbSum_ALL = dbSum_ALL + C_convSafeFloat(C_removeComma(dsMAIN.NameValue(i,"PAY_AMT"),false));
			
		  if (dsMAIN.NameString(i,"PAY_STATUS") == "4" )
		  {
				dbSum_PAY = dbSum_PAY + C_convSafeFloat(C_removeComma(dsMAIN.NameValue(i,"PAY_AMT"),false));
			}
			
			dbSum_NON = dbSum_ALL - dbSum_PAY ;
	}
	
	txtTOTAL_SUM.value = C_toNumberFormatString(dbSum_ALL,false);
	txtPAY_SUM.value = C_toNumberFormatString(dbSum_PAY,false);
	txtNOPAY_SUM.value = C_toNumberFormatString(dbSum_NON,false);
}

function OnColumnChanged(dataset, row, colid)
{
	if(dataset == dsMAIN)
	{
		if(colid ==	"SELECT_YN")
		{

		}
	}
}
//���
function btnCASH_PRINT_onClick()
{
	var		lnCnt = dsMAIN.CountRow;
	if(lnCnt == 0) return;
 
  var vDT_F   = txtDT_F.value.replace(/-/g,'');
  var vDT_T   = txtDT_T.value.replace(/-/g,'');
  var vDT_F1  = txtDT_F1.value.replace(/-/g,'');
  var vDT_T1  = txtDT_T1.value.replace(/-/g,'');  
 	var reportFile ="r_t_110007.rpt";
	var vcust_seq ;
	
	frmList.EXPORT_TAG.value ='W';
	frmList.RUN_TAG.value = '1';
	frmList.REQUEST_NAME.value = '���ھ����ⳳȮ�θ���Ʈ';
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile;
	
	var strTemp = "";
	if ( C_isNull(txtCUST_CODE.value) ) vcust_seq = '%';
	if ( C_isNull(vDT_F1) ) vDT_F1 = '1';
	if ( C_isNull(vDT_T1) ) vDT_T1 = '9';
	
	strTemp  = "P_COMP_CODE__" + txtCOMP_CODE.value;
	strTemp += "&&P_COMP_NAME__" + txtCOMP_NAME.value;
	strTemp += "&&P_PAY_GUBUN__" + txtPAY_GUBUN.value;
	strTemp += "&&P_PAY_STATUS__" + txtPAY_STATUS.value;
	strTemp += "&&P_DUE_DATE_F__" + vDT_F;
	strTemp += "&&P_DUE_DATE_T__" + vDT_T;
	strTemp += "&&P_CUST_SEQ__" + vcust_seq;
	strTemp += "&&P_OUT_BANK__" + txtBANK_CODE.value;
	strTemp += "&&P_PAY_DATE_F__" + vDT_F1;
	strTemp += "&&P_PAY_DATE_T__" + vDT_T1;
	strTemp += "&&P_PAY_METHOD__" + txtMETHOD_CODE.value;
	/*strTemp += "&&P_EMP_NO__" + sEmpNo;*/
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}