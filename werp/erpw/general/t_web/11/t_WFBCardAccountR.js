/**************************************************************************/
/* 1. �� �� �� �� id : t_WFBCardUseR.jsp(����ī���̿볻�����)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ����ī���̿볻�����
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-22)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "����ī��û������");
	G_addDataSet(dsCOPY, transCopy, null, sSelectPageName+D_P1("ACT","COPY"), "����store");
	G_addDataSet(dsLOV , null, null, null, "LOV");
	G_addDataSet(dsDAY_CLOSE, null, null, null, "��������");
	G_addDataSet(dsAUTO_FBS_CARD_ACNT_SEQ, null, null, null, "FBS_������ü_�ڵ���ǥ_�۾���ȣ");
	G_addDataSet(dsACCT_CHK, null, null, null, "������üũ");

	txtDATE_FROM.value = sDTF;
	txtDATE_DISPLAY.value = sDTF + '-05';

	G_setLovCol(gridMAIN,"ACC_NAME");
	G_setLovCol(gridMAIN,"VAT_ACC_NAME");
	G_setLovCol(gridMAIN,"DEPT_NAME");
  
	G_setReadOnlyCol(gridMAIN,"CARDNUMBER");
	G_setReadOnlyCol(gridMAIN,"USE_DATE_TIME");
	G_setReadOnlyCol(gridMAIN,"AMT");
	G_setReadOnlyCol(gridMAIN,"MERCHANTNAME");
	G_setReadOnlyCol(gridMAIN,"APPROVALNumber");
	G_setReadOnlyCol(gridMAIN,"MCCName");
	G_setReadOnlyCol(gridMAIN,"TAXGubun");
	G_setReadOnlyCol(gridMAIN,"Adjuststatus");
	G_setReadOnlyCol(gridMAIN,"SLIP");
	G_setReadOnlyCol(gridMAIN,"AdjustFinishDatetime");
	G_setReadOnlyCol(gridMAIN,"PAYHOPEDATE");
	
	G_setReadOnlyCol(gridMAIN,"SUPPLYAmt");
	G_setReadOnlyCol(gridMAIN,"VatAmt");
	
	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridMAIN.TabToss = false;

	gridMAIN.focus();

	// �ڵ���ǥ	start...
	txtSLIP_MAKE_DT_F.value	= sDate;
	txtSLIP_MAKE_DT.value	= sDate;

	txtPAYHOPEDATE_F.value	= sDTF + '-05';
	txtPAYHOPEDATE.value	= sDTF + '-05';

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
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("CARDNUMBER",cboCARDNUMBER.value)
										 + D_P2("SENDDATE_F",txtDATE_FROM.value.replace(/-/g,''));
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
	else if(dataset == dsAUTO_FBS_CARD_ACNT_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","AUTO_FBS_CARD_ACNT_SEQ");
	}
	else if(dataset == dsACCT_CHK)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","ACCT_CHK")
											+ D_P2("DEPT_CODE",sDeptCode)
											+ D_P2("ACC_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"ACC_CODE"));
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
function	chkTopCondition()
{
	return true;
}
function	chkSave()
{
	if (G_isChangedDataset(dsMAIN))
	{
		var ret = C_msgYesNo("��������� ������ �� �۾��� �����մϴ�.<br>����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return false;
			return true;
		}
		else
		{
			return false;
		}
	}
	return true;
}

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	D_defaultLoad();
	SUM_SET_onblur();
//	if ( C_isNull( dsMAIN.NameString(1,"Slip_id")) == false )
//	{
//		G_setReadOnlyCol(gridMAIN,"USAGEGUBUN");
//		G_setReadOnlyCol(gridMAIN,"ACC_CODE");
//		return;
//	}		
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
	btnAllSelCancle_onClick();
	trans.Parameters = "";
	D_defaultSave(dsMAIN);
	btnquery_onclick();
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "SLIP_MAKE_DT")
	{
		txtSLIP_MAKE_DT_F.value = asDate;
		txtSLIP_MAKE_DT.value = asDate;
	}
	else if (asCalendarID == "PAYHOPEDATE")
	{
		txtPAYHOPEDATE.value = asDate;
	/*	for(i=1;i<=dsMAIN.CountRow;i++)
		{
			if (dsMAIN.NameString(i,"SELECT_YN") == "T" && dsMAIN.NameString(i,"MAKE_CLS") == "F" && dsMAIN.NameString(i,"USAGEGUBUN") == "C")
			{
					dsMAIN.NameString(i,"PAYHOPEDATE") = txtPAYHOPEDATE.value;	
			}
		}	*/		
	}
	else if (asCalendarID == "DATE_FROM")
	{
		txtDATE_FROM.value = asDate;
		txtDATE_DISPLAY.value = asDate + '-05';
	}
	/*
	else if (asCalendarID == "PAYHOPEDATE")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"PAYHOPEDATE") = asDate;
	}	
	*/
}

function OnRowPosChanged(dataset, row)
{
	if(dataset == dsMAIN)
	{
		if(dataset.NameString(row,"MAKE_CLS") == "T") {
			gridMAIN.ColumnProp("USAGEGUBUN","Edit")	="None";
			gridMAIN.ColumnProp("ACC_NAME","Edit")		="None";
			gridMAIN.ColumnProp("VAT_ACC_NAME","Edit")	="None";
			gridMAIN.ColumnProp("DEPT_NAME","Edit")	="None";
//			gridMAIN.ColumnProp("PAYHOPEDATE","Edit")	="None";

//			gridMAIN.ColumnProp("SUPPLYAmt","Edit")	="None";
//			gridMAIN.ColumnProp("VatAmt","Edit")	="None";
		} else {
			gridMAIN.ColumnProp("USAGEGUBUN","Edit")	="";
			gridMAIN.ColumnProp("ACC_NAME","Edit")		="";
			gridMAIN.ColumnProp("VAT_ACC_NAME","Edit")	="";
			gridMAIN.ColumnProp("DEPT_NAME","Edit")	="";
//			gridMAIN.ColumnProp("PAYHOPEDATE","Edit")	="";

//			gridMAIN.ColumnProp("SUPPLYAmt","Edit")	="";
//			gridMAIN.ColumnProp("VatAmt","Edit")	="";
		}

		G_Load(dsACCT_CHK) ;
		if ( dataset.NameString(row,"TAX") != "1" || dsACCT_CHK.CountRow > 0 )
		{
			gridMAIN.ColumnProp("VAT_ACC_NAME","Edit")	="None";
			dataset.NameString(row,"VAT_ACC_CODE")= "";
			dataset.NameString(row,"VAT_ACC_NAME")= "";
		}			
		
	}
}

function OnRowInsertBefore(dataset)
{
	return false;
}
function OnRowInserted(dataset, row)
{
}
function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "ACC_CODE" || colid == "ACC_NAME" )
		{	
			var	lsNewData = dataset.NameString(row,colid);
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,"ACC_CODE") = "";
				dsMAIN.NameString(liDataRow,"ACC_NAME") = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;

			lrArgs.set("DEPT_CODE", dsMAIN.NameString(liDataRow,"DEPT_CODE") );
			lrArgs.set("SEARCH_CONDITION", dataset.NameString(liDataRow,colid));

			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE0", lrArgs,"T");		
			
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsMAIN.NameString(liDataRow,"ACC_CODE") = lrRet.get("ACC_CODE");
					dsMAIN.NameString(liDataRow,"ACC_NAME") = lrRet.get("ACC_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}

			G_Load(dsACCT_CHK) ;
			if ( dataset.NameString(row,"TAX") != "1" || dsACCT_CHK.CountRow > 0 )
			{
				gridMAIN.ColumnProp("VAT_ACC_NAME","Edit")	="None";
				dataset.NameString(liDataRow,"VAT_ACC_CODE") = "" ;
				dataset.NameString(liDataRow,"VAT_ACC_NAME") = "" ;
				if ( dataset.NameString(row ,"VatAmt" ) != 0 )
				{
					var Amt = dataset.NameString(row ,"Amt" );
					dataset.NameString(row ,"SUPPLYAmt" ) = Amt;
					dataset.NameString(row ,"VatAmt" ) = 0;
				}
			}									
			else
			{
					gridMAIN.ColumnProp("VAT_ACC_NAME","Edit")	="";
			}
		}
		else if(colid == "VAT_ACC_CODE" || colid == "VAT_ACC_NAME" )
		{
			var	lsNewData = dataset.NameString(row,colid);
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,"VAT_ACC_CODE") = "";
				dsMAIN.NameString(liDataRow,"VAT_ACC_NAME") = "";
				dataset.NameString(row ,"SUPPLYAmt" ) = dataset.NameString(row ,"Amt" );
				dataset.NameString(row ,"VatAmt" ) = 0; 			
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("WORK_CODE", vWORK_CODE);
			lrArgs.set("DEPT_CODE", sDeptCode);			
			lrArgs.set("SEARCH_CONDITION", dataset.NameString(liDataRow,colid));
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE7", lrArgs,"T");
			
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsMAIN.NameString(liDataRow,"VAT_ACC_CODE") = lrRet.get("ACC_CODE");
					dsMAIN.NameString(liDataRow,"VAT_ACC_NAME") = lrRet.get("ACC_NAME");
					if ( dataset.NameString(row ,"VatAmt" ) == 0 )
					{
						var supplyamt = dataset.NameString(row ,"SUPPLYAmt" );
						dataset.NameString(row ,"SUPPLYAmt" ) = C_Ceil( C_Round( supplyamt / 11 ,2)*10 , 0);
						dataset.NameString(row ,"VatAmt" ) = C_convSafeInt( C_Round( supplyamt / 11 ,2)*1 , 0);
					}	
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
				if (olddata == null)
				{
					dataset.NameString(row ,"SUPPLYAmt" ) = dataset.NameString(row ,"Amt" );
					dataset.NameString(row ,"VatAmt" ) = 0;
				}	
			}
		}
		else if(colid == "PAYHOPEDATE" )
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,lsNewData);
			 
		}			 
		else if(colid == "DEPT_CODE" || colid == "DEPT_NAME" )
		{
			var	lsNewData = dataset.NameString(row,colid);
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,"DEPT_CODE") = "";
				dsMAIN.NameString(liDataRow,"DEPT_NAME") = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
	
			lrArgs.set("COMP_CODE", txtSLIP_MAKE_COMP_CODE.value);
			lrArgs.set("SEARCH_CONDITION", dataset.NameString(liDataRow,colid));
		
			lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");
			
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsMAIN.NameString(liDataRow,"DEPT_CODE") = lrRet.get("DEPT_CODE");
					dsMAIN.NameString(liDataRow,"DEPT_NAME") = lrRet.get("DEPT_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}	
	}	
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "ACC_CODE" || colid == "ACC_NAME" )
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("DEPT_CODE", dsMAIN.NameString(liDataRow,"DEPT_CODE") );
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE0", lrArgs,"F");
			
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsMAIN.NameString(liDataRow,"ACC_CODE") = lrRet.get("ACC_CODE");
					dsMAIN.NameString(liDataRow,"ACC_NAME") = lrRet.get("ACC_NAME");
				}
			}	

			G_Load(dsACCT_CHK) ;
//			C_msgOk(dsACCT_CHK.NameString(1,"ACC_CODE"),"�˸�");
			if ( dataset.NameString(row,"TAX") != "1" || dsACCT_CHK.CountRow > 0 )
			{
				gridMAIN.ColumnProp("VAT_ACC_NAME","Edit")	="None";
				dataset.NameString(liDataRow,"VAT_ACC_CODE") = "" ;
				dataset.NameString(liDataRow,"VAT_ACC_NAME") = "" ;
				if ( dataset.NameString(row ,"VatAmt" ) != 0 )
				{
					var Amt = dataset.NameString(row ,"Amt" );
					dataset.NameString(row ,"SUPPLYAmt" ) = Amt;
					dataset.NameString(row ,"VatAmt" ) = 0;
				}				
			}
			else
			{
					gridMAIN.ColumnProp("VAT_ACC_NAME","Edit")	="";
			}
		}
		else if(colid == "VAT_ACC_CODE" || colid == "VAT_ACC_NAME" )
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("WORK_CODE", vWORK_CODE);
			lrArgs.set("DEPT_CODE", sDeptCode);			
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE7", lrArgs,"F");
			
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsMAIN.NameString(liDataRow,"VAT_ACC_CODE") = lrRet.get("ACC_CODE");
					dsMAIN.NameString(liDataRow,"VAT_ACC_NAME") = lrRet.get("ACC_NAME");
					if ( dataset.NameString(row ,"VatAmt" ) == 0 )
					{
						var supplyamt = dataset.NameString(row ,"SUPPLYAmt" );
						dataset.NameString(row ,"SUPPLYAmt" ) = C_Ceil( C_Round( supplyamt / 11 ,2)*10 ,0);
						dataset.NameString(row ,"VatAmt" ) = C_convSafeInt( C_Round( supplyamt / 11 ,2)*1 , 0);
						
					}	
				}
			}
			else
			{
				if (dataset.NameString(row,"VAT_ACC_CODE") == null)
				{
					dataset.NameString(row ,"SUPPLYAmt" ) = dataset.NameString(row ,"Amt" );
					dataset.NameString(row ,"VatAmt" ) = 0;
				}		
			}							
		}
		else if(colid == "PAYHOPEDATE" )
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
		  C_Calendar("PAYHOPEDATE", "D", dsMAIN.NameString(liDataRow,"PAYHOPEDATE"));
		}	
		else if(colid == "DEPT_CODE" || colid == "DEPT_NAME" )
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("COMP_CODE", txtSLIP_MAKE_COMP_CODE.value);
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"F");
			
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsMAIN.NameString(liDataRow,"DEPT_CODE") = lrRet.get("DEPT_CODE");
					dsMAIN.NameString(liDataRow,"DEPT_NAME") = lrRet.get("DEPT_NAME");
				}
			}				
		}			
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//

function btnDATE_FROM_onClick()
{	
	C_Calendar("DATE_FROM", "M", txtDATE_FROM.value);
}

function txtDATE_DISPLAY_onChange()
{	
	txtDATE_FROM.value = txtDATE_DISPLAY.value.replace(/-/g,'').substr(0,6);
}

//��ü����
function btnSELECT_ALL_onClick()
{
	var i = 0;
	
	if(dsMAIN.CountRow==0) return;
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
			 dsMAIN.NameString(i,"SELECT_YN") = "T";
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
}
//����Ϸ�
function btnCARD_FINISH_onClick()
{
 	var i = 0;
 	var cnt = 0;
	
	if(dsMAIN.CountRow==0) return;
	
	G_Load(dsCOPY);
	dsCOPY.ClearData()

	for (i=1;i<=dsMAIN.CountRow;i++) {
		  if (dsMAIN.NameString(i,"SELECT_YN") == "T" )
		  {
				dsCOPY.AddRow()
				cnt = dsCOPY.CountRow;
				dsCOPY.NameString(cnt,"CARDNUMBER") = dsMAIN.NameString(i,"CARDNUMBER");
				dsCOPY.NameString(cnt,"ADJUSTYEARMONTH") = dsMAIN.NameString(i,"ADJUSTYEARMONTH");
				dsCOPY.NameString(cnt,"ACCTSUBSEQ") = dsMAIN.NameString(i,"ACCTSUBSEQ");
				cnt++;
			}		
	}
		
	if ( cnt == 0 )
	{
		C_msgOk("���õ� �ڷᰡ �����ϴ�.","Ȯ��");
		return;
	}	

	transCopy.Parameters = "ACT=COPY";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("����Ϸ� �۾��� �Ϸ�Ǿ����ϴ�.","�˸�");
		G_Load(dsMAIN);
	}
}
//�հ谪setting
function SUM_SET_onblur()
{
 	var i = 0;
 	var dbSum_ALL = dsMAIN.NameSum("AMT",0,0); 
 	var dbSum_NON = 0;
 	var dbSum_COMPANY = 0;
 	var dbSum_PERSON = 0;
	 	
	for (i=1;i<=dsMAIN.CountRow;i++) {

		  if (dsMAIN.NameString(i,"USAGEGUBUN") == "1" )
		  {
				dbSum_NON = dbSum_NON + dsMAIN.NameValue(i,"AMT");
			}
			else if (dsMAIN.NameString(i,"USAGEGUBUN") == "C" )
			{
				dbSum_COMPANY = dbSum_COMPANY + dsMAIN.NameValue(i,"AMT");
			}
			else if (dsMAIN.NameString(i,"USAGEGUBUN") == "P" )
			{
				dbSum_PERSON = dbSum_PERSON + dsMAIN.NameValue(i,"AMT");
			}
	}
	
	txtTOTAL_SUM.value = C_toNumberFormatString(dbSum_ALL,false) ;
	txtNOUSE_SUM.value = C_toNumberFormatString(dbSum_NON,false);
	txtCOMPANY_SUM.value = C_toNumberFormatString(dbSum_COMPANY,false);
	txtPERSON_SUM.value = C_toNumberFormatString(dbSum_PERSON,false);
}
//���
function btnCARD_PRINT_onClick()
{
	
}

//��������
function btnSLIP_MAKE_DT_onClick()
{
	txtSLIP_MAKE_DT_F.value = txtSLIP_MAKE_DT.value;
	
	C_Calendar("SLIP_MAKE_DT", "D", txtSLIP_MAKE_DT.value);
}

//���������
function btnPAYHOPEDATE_onClick()
{
	txtPAYHOPEDATE_F.value = txtPAYHOPEDATE.value;
	
	C_Calendar("PAYHOPEDATE", "D", txtPAYHOPEDATE.value);

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

	if (txtPAYHOPEDATE.value == "")
	{
		C_msgOk("����������� �Է��Ͽ� �ֽʽÿ�.");
		txtPAYHOPEDATE.focus();
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
	var	strUseSelCnt = 0;
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		if (dsMAIN.NameString(i,"SELECT_YN") == "T")
		{
			if (dsMAIN.NameString(i,"MAKE_CLS") == "T")
			{
				strMakeSelCnt++;
				dsMAIN.NameString(i,"SELECT_YN") = "F";
			}
			else if (dsMAIN.NameString(i,"USAGEGUBUN") != "C")
			{
				strUseSelCnt++;
				dsMAIN.NameString(i,"SELECT_YN") = "F";
			}
			else {
				strAMT_TAG++;
				dsMAIN.NameString(i,"PAYHOPEDATE") = txtPAYHOPEDATE.value;
/*				G_Load(dsACCT_CHK) ;
				if ( dsMAIN.NameString(i,"TAX") == "1" && dsACCT_CHK.CountRow == 0 && dsMAIN.NameString(i,"VAT_ACC_CODE")== "" )
				{
					C_msgOk("�ΰ��������� ��ϵ��� �ʾҽ��ϴ�.","�˸�");
					gridMAIN.focus();
					return;
				}	*/
			}
		}
	}

	if (strMakeSelCnt > 0)
	{
		C_msgOk("�̹� ��ǥ����� �׸��� ���õ��־� ������ �����Ͽ����ϴ�.");
	}

	if (strUseSelCnt > 0)
	{
		C_msgOk("����(ó������)���� �ƴ� �׸��� ���õ��־� ������ �����Ͽ����ϴ�.");
	}
	
	if (strAMT_TAG == 0)
	{
		C_msgOk("���õ� �׸��� �����ϴ�.");
		return;
	}

	G_Load(dsAUTO_FBS_CARD_ACNT_SEQ, null);
	
	trans.Parameters = "";
	trans.Parameters += "ACT=AUTO_FBS_CARD_ACNT";
	trans.Parameters += ",AUTO_FBS_CARD_ACNT_SEQ="+dsAUTO_FBS_CARD_ACNT_SEQ.NameString(1,"AUTO_FBS_CARD_ACNT_SEQ");
	trans.Parameters += ",SLIP_MAKE_DT="+C_Replace(txtSLIP_MAKE_DT.value,"-","");
	trans.Parameters += ",PAYHOPEDATE="+C_Replace(txtPAYHOPEDATE.value,"-","");
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
				dsMAIN.NameString(i,"PAYHOPEDATE") = "";
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
	trans.Parameters += "ACT=DELETE_FBS_CARD_ACNT";
	
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
		if(dsMAIN.NameString(i,"KEEP_CLS") != "T") dsMAIN.NameString(i,"SELECT_YN") = "T";
	}
}

// ��ü�������
function btnAllSelCancle_onClick()
{
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		if(dsMAIN.NameString(i,"KEEP_CLS") != "T") dsMAIN.NameString(i,"SELECT_YN") = "F";
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
	var pMAKE_DT 	    	= dsMAIN.NameString(vRow,"MAKE_DT").replace(/-/gi,"");
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
function btnBUDG_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	var vRow = dsMAIN.RowPosition;
	if ( vRow == 0 ) return ;
	
	lrArgs.set("COMP_CODE", txtSLIP_MAKE_COMP_CODE.value);
	lrArgs.set("COMP_NAME", txtSLIP_MAKE_COMP_NAME.value);
	lrArgs.set("DEPT_CODE", txtSLIP_MAKE_DEPT_CODE.value);
	lrArgs.set("DEPT_NAME", txtSLIP_MAKE_DEPT_NAME.value);
	lrArgs.set("BUDG_YM"	, txtSLIP_MAKE_DT.value.replace(/-/gi,"").substring(0,6));
	lrArgs.set("ACC_CODE" , dsMAIN.NameString(vRow,"ACC_CODE"));
	lrArgs.set("ACC_NAME" , dsMAIN.NameString(vRow,"ACC_NAME"));

	var	lrRet = window.showModalDialog(
		"../01/t_PBudgRetrieve.jsp",
		lrArgs,
		"center:yes; dialogWidth:976px;	dialogHeight:623px;	status:no; help:no;	scroll:no"
	);
}