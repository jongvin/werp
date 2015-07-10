/**************************************************************************/
/* 1. �� �� �� �� id : t_WFixDeprecCalR.js(�����󰢰���۾�)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : �����󰢰���۾�
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsCALC,transBatch,null,null,"�����󰢰��");
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�������۾�");
	G_addDataSet(dsMAIN2, trans, gridMAIN2, sSelectPageName+D_P1("ACT","MAIN2"), "�����󰢴����", false, false);
	G_addDataSet(dsMAIN3, null, gridMAIN3, sSelectPageName+D_P1("ACT","MAIN3"), "�μ����󰢾�");
	G_addDataSet(dsFIX_SHEET, transApply, null, null, "����");
	
	G_addDataSet(dsREMOVE, transREMOVE, null, sSelectPageName+D_P1("ACT","REMOVE"), "��ǥ����");

	G_addRel(dsMAIN, dsMAIN2);
	G_addRelCol(dsMAIN2, "WORK_SEQ", "WORK_SEQ");
	
	G_addRel(dsMAIN2, dsMAIN3);
	G_addRelCol(dsMAIN3, "WORK_SEQ", "WORK_SEQ");
	G_addRelCol(dsMAIN3, "FIX_ASSET_SEQ", "FIX_ASSET_SEQ");

	G_addDataSet(dsWORK_SEQ, null, null, "", "WORK_SEQ");
	G_addDataSet(dsLOV, null, null, "", "LOV");

	txtCOMP_CODE.value		= sCompCode;
	txtCOMPANY_NAME.value	= sCompName;
	
	G_setReadOnlyCol(gridMAIN,"WORK_USENO");
	G_setReadOnlyCol(gridMAIN,"EMP_NM");
	G_setReadOnlyCol(gridMAIN,"TRANS_CLS");
	G_setReadOnlyCol(gridMAIN,"MAKE_SLIPNO");
	
	G_setReadOnlyCol(gridMAIN3,"DEPT_NAME");
	G_setReadOnlyCol(gridMAIN3,"SUM_DT_FROM");
	G_setReadOnlyCol(gridMAIN3,"SUM_DT_TO");
	G_setReadOnlyCol(gridMAIN3,"DEPREC_AMT");
	
	txtWORK_DT_FROM.value	= vDATE.substr(0,4)+"-01-01";
    	txtWORK_DT_TO.value  	= vDATE.substr(0,4)+"-"+vDATE.substr(4,2)+"-"+vDATE.substr(6,2);
    	
    	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		var			strCOMP_CODE 		= txtCOMP_CODE.value;
		var			strWORK_DT_FROM 	= txtWORK_DT_FROM.value;
		var			strWORK_DT_TO 		= txtWORK_DT_TO.value;
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("WORK_DT_FROM",strWORK_DT_FROM)
									 + D_P2("WORK_DT_TO",strWORK_DT_TO);
									
	}
	else if(dataset == dsMAIN2)
	{
		var			strWORK_SEQ 		= dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ");
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN2")
									 + D_P2("WORK_SEQ",strWORK_SEQ);
	}
	else if(dataset == dsMAIN3)
	{
		var			strWORK_SEQ 		= dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ");
		var 			strDEPT_CODE	       = txtDEPT_CODE.value;
		if(C_isNull(strDEPT_CODE))
		{
			strDEPT_CODE ="%";
		}
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN3")
									 + D_P2("WORK_SEQ",strWORK_SEQ)
									 + D_P2("FIX_ASSET_SEQ",dsMAIN2.NameString(dsMAIN2.RowPosition,"FIX_ASSET_SEQ"))
									 + D_P2("DEPT_CODE", strDEPT_CODE)
									 + D_P2("SUM_DT_FROM", txtSUM_DT_FROM.value)
									 + D_P2("SUM_DT_TO", txtSUM_DT_TO.value);
	}
	else if(dataset == dsWORK_SEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","WORK_SEQ");									
	}
	else if(dataset == dsCALC)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CALC");									
	}
	else if(dataset == dsFIX_SHEET)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","FIX_SHEET");								
	}
	else if(dataset == dsREMOVE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","REMOVE");
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
function	Apply()
{
	G_Load(dsFIX_SHEET, null);

	G_addRow(dsFIX_SHEET);
	
	strCLSE_ACC_ID = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_FROM_DT").substring(0, 4);
	//alert(txtCOMP_CODE.value);
	dsFIX_SHEET.NameString(dsFIX_SHEET.RowPosition,"WORK_SEQ") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ");
	dsFIX_SHEET.NameString(dsFIX_SHEET.RowPosition,"COMP_CODE") = txtCOMP_CODE.value; 
	dsFIX_SHEET.NameString(dsFIX_SHEET.RowPosition,"FIX_ASSET_SEQ") = dsMAIN2.NameString(dsMAIN2.RowPosition,"FIX_ASSET_SEQ");
	dsFIX_SHEET.NameString(dsFIX_SHEET.RowPosition,"CLSE_ACC_ID") = strCLSE_ACC_ID;
	dsFIX_SHEET.NameString(dsFIX_SHEET.RowPosition,"TRANS_CLS") = "T";
	
	transApply.Parameters = "ACT=APPLY"; 
	
	if(!G_saveData(dsFIX_SHEET)) return;
	C_msgOk("������  ���������� ����Ǿ����ϴ�.");
	dsMAIN.NameString(dsMAIN.RowPosition,"TRANS_CLS") = "T";
	G_saveData(dsMAIN);


}
function	ApplyCancel()
{
	G_Load(dsFIX_SHEET, null);

	G_addRow(dsFIX_SHEET);

	dsFIX_SHEET.NameString(dsFIX_SHEET.RowPosition,"WORK_SEQ") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ");
	dsFIX_SHEET.NameString(dsFIX_SHEET.RowPosition,"TRANS_CLS") = "F";
	
	transApply.Parameters = "ACT=APPLY"; 
	if(!G_saveData(dsFIX_SHEET)) return;
	C_msgOk("��Ұ�   ���������� ����Ǿ����ϴ�.");
	dsMAIN.NameString(dsMAIN.RowPosition,"TRANS_CLS") = "F";

	G_saveData(dsMAIN);
}
function	CalcProcess()
{
	G_Load(dsCALC, null);
	G_addRow(dsCALC);
	dsCALC.NameString(dsCALC.RowPosition,"WORK_SEQ") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ");
	
	transBatch.Parameters = "ACT=CALC"; 
	
	if(!G_saveData(dsCALC)) return;
	
	G_Load(dsMAIN2, null);
	C_msgOk("������ ����۾���  ���������� ����Ǿ����ϴ�.");
	gridMAIN.focus();
	
	
}


//��ȸ�� üũ
function checkCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("�������  �����Ͻʽÿ�.", "Ȯ��");
		return;
	}
	if (C_isNull(txtWORK_DT_FROM.value))
	{
		C_msgOk("�۾��������ڸ� �Է��Ͻʽÿ�.", "Ȯ��");
		return;
	}
	if (C_isNull(txtWORK_DT_TO.value))
	{
		C_msgOk("�۾��������ڸ� �Է��Ͻʽÿ�.", "Ȯ��");
		return;
	}
	
	if (!C_isNull(txtSUM_DT_FROM.value))
	{
		if (C_isNull(txtSUM_DT_TO.value))
		{
			C_msgOk("�ͼ��������ڸ� �Է��Ͻʽÿ�.", "Ȯ��");
			return;
		}
	}
	if (!C_isNull(txtSUM_DT_TO.value))
	{
		if (C_isNull(txtSUM_DT_FROM.value))
		{
			C_msgOk("�ͼӽ������ڸ� �Է��Ͻʽÿ�.", "Ȯ��");
			return;
		}
	}
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
function	makeInSlip()
{
	//if(!chkCondition()) return;
	
	//if(!chkSave()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("���� ��ǥ�� ������ ���� �����Ͻʽÿ�.");
		return;
	}
	if(!C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID")))
	{
		C_msgOk("�̹� ��ǥ�� ����Ǿ� �ֽ��ϴ�.");
		return;
	}
	if(dsMAIN.NameString(dsMAIN.RowPosition,"TRANS_CLS")=='F')
	{
		C_msgOk("������ ���¿��� ��������ǥ�� ������ �� �����ϴ�.");
		return;
	}
	var			lrObject = new Object();
	lrObject.work_seq = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ");
     	lrObject.div = "D";   
	var	arrRtn2 = window.showModalDialog("./t_PSlipFixDeprecR.jsp" , lrObject, "center:yes; dialogWidth:1024px; dialogHeight:768px; status:no; help:no; scroll:no");
	if(C_isNull(arrRtn2)) return;
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	if(liRow > 0) dsMAIN.RowPosition = liRow;
}
function	removeSlip()
{
	if(!checkCondition()) return;
	if(!chkSave()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("���� ����� �۾� ����� ���� �Ͻʽÿ�.");
		return;
	}
	
	var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID");

	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("��ǥ�� ����� ���� �����ϴ�.");
		return;
	}
	
	G_Load(dsREMOVE);
	alert(dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ"));
	alert(pSLIP_ID);
	dsREMOVE.NameString(dsREMOVE.RowPosition,"WORK_SEQ") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ");
	transREMOVE.Parameters = "ACT=REMOVE";
	if(!G_saveData(dsREMOVE))return;
	C_msgOk("������ ��ǥ�� ���������� �����Ǿ����ϴ�.");
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	dsMAIN.RowPosition = liRow;
}
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	if(!checkCondition()) return;
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	
	if ( !G_isLoaded("dsMAIN"))
	{
		C_msgOk("������ �۾�������  ������ȸ�ϼ���");
		return;	
	}
	

	if ( G_FocusDataset.id =="dsMAIN")
	{
		D_defaultAdd();
	}
	
	if ( G_FocusDataset.id =="dsMAIN2")
	{
		
	
		if (dsMAIN.NameString(dsMAIN.RowPosition,"TRANS_CLS") == "T")
		{
			C_msgOk("�������� ����� ���¿����� �߰� �۾��� �� �� �����ϴ�.");
			return;
		}
		if(C_isNull(txtCOMP_CODE.value))
		{
			C_msgOk("������ڵ尡 �Էµ��� �ʾҽ��ϴ�.");
			return;
		}
		if(dsMAIN.RowPosition < 1)
		{
			C_msgOk("���� ��ȸ�� �����Ͻʽÿ�.");
			return;
		}
		if (G_isChanged(dsMAIN.id))
		{
			C_msgOk("��������� ���� �� �۾��� �����Ͻʽÿ�.");
			return;
		}
		var arrRtn	= null;
		var arrRec	= new Object();
		arrRec.comp_code = txtCOMP_CODE.value;
		arrRec.work_seq = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ");
		arrRec.work_to_dt = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_TO_DT");
		arrRec.deprec_finish = dsMAIN.NameString(dsMAIN.RowPosition,"TARGET_CLS");
		arrRec.dataset = dsMAIN2;
	
		window.showModalDialog("t_PFixDeprecCal.jsp", arrRec, "center:yes; dialogWidth:800px; dialogHeight:400px; status:no; help:no; scroll:no");
	
		gridMAIN2.focus();
		
	}
}

// ����
function btninsert_onclick()
{
	
	btnadd_onclick();
}

// ����
function btndelete_onclick()
{
	if ( G_FocusDataset.id =="dsMAIN")
	{
		if(dsMAIN.CountRow < 1)
		{
			C_msgOk("������ �ڷᰡ �����ϴ�.");
			return;
		}
		if(dsMAIN.RowPosition < 1)
		{
			C_msgOk("������ ���� �����Ͻʽÿ�.");
			return;
		}
		// if(C_msgYesNo("���� �����Ͻðڽ��ϱ�?" , "����Ȯ��") == "N") return;
	}
	
	else if ( G_FocusDataset.id =="dsMAIN2")
	{
		if (dsMAIN.NameString(dsMAIN.RowPosition,"TRANS_CLS") == "T")
		{
			C_msgOk("�������� ����� ���¿����� ������ �� �����ϴ�.");
			return;
		}
		if(dsMAIN2.CountRow < 1)
		{
			C_msgOk("������ �ڷᰡ �����ϴ�.");
			return;
		}
		if(dsMAIN2.RowPosition < 1)
		{
			C_msgOk("������ ���� �����Ͻʽÿ�.");
			return;
		}
		// if(C_msgYesNo("���� �����Ͻðڽ��ϱ�?" , "����Ȯ��") == "N") return;
		

	}
	D_defaultDelete();
}

// ����
function btnsave_onclick()
{	

	D_defaultSave();
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "txtWORK_DT_FROM")
	{
		txtWORK_DT_FROM.value = asDate;
		if ( !C_isNull(txtWORK_DT_FROM.value))
		{
			strWorkDtFrom = txtWORK_DT_FROM.value.replace(/-/gi,"");
			strWorkDtTo	 = txtWORK_DT_TO.value.replace(/-/gi,"");

			if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
			{
				C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
				txtWORK_DT_FROM.value = olddata1;
				return;
			}
		}	
	}
	else if (asCalendarID == "txtWORK_DT_TO")
	{
		txtWORK_DT_TO.value = asDate;
		if ( !C_isNull(txtWORK_DT_TO.value))
		{
			strWorkDtFrom = txtWORK_DT_FROM.value.replace(/-/gi,"");
			strWorkDtTo	 = txtWORK_DT_TO.value.replace(/-/gi,"");

			if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
			{
				C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
				txtWORK_DT_TO.value = olddata2;
				return;
			}
		}	
	}
	else if (asCalendarID == "WORK_FROM_DT")
	{
		
		dsMAIN.NameString(dsMAIN.RowPosition,"WORK_FROM_DT") = asDate;
		if ( !C_isNull( dsMAIN.NameString(dsMAIN.RowPosition,"WORK_FROM_DT") ))
		{
			strWorkDtFrom = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_FROM_DT").replace(/-/gi,"");
			strWorkDtTo	 = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT_TO").replace(/-/gi,"");

			if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
			{
				C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
				dsMAIN.NameString(dsMAIN.RowPosition,"WORK_FROM_DT") = olddata1;
				return;
			}
		}	
	}
	else if (asCalendarID == "WORK_TO_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"WORK_TO_DT") = asDate;
		if ( !C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"WORK_TO_DT")))
		{
			strWorkDtFrom = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT_FROM").replace(/-/gi,"");
			strWorkDtTo	 = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_TO_DT").replace(/-/gi,"");

			if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
			{
				C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
				dsMAIN.NameString(dsMAIN.RowPosition,"WORK_TO_DT") = olddata2;
				return;
			}
		}	
	}
	else if (asCalendarID == "SUM_DT_FROM")
	{
		txtSUM_DT_FROM.value = asDate;
		if ( !C_isNull(txtSUM_DT_FROM.value))
		{
			strSumDtFrom = txtSUM_DT_FROM.value.replace(/-/gi,"");
			strSumDtTo	 = txtSUM_DT_TO.value.replace(/-/gi,"");

			if (parseInt(strSumDtFrom) > parseInt(strSumDtTo))
			{
				C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
				txtSUM_DT_FROM.value = olddata3;
				return;
			}
		}	
	}
	else if (asCalendarID == "SUM_DT_TO")
	{
		txtSUM_DT_TO.value = asDate;
		if ( !C_isNull(txtSUM_DT_TO.value))
		{
			strSumDtFrom   = txtSUM_DT_FROM.value.replace(/-/gi,"");
			strSumDtTo	 = txtSUM_DT_TO.value.replace(/-/gi,"");

			if (parseInt(strSumDtFrom) > parseInt(strSumDtTo))
			{
				C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
				txtSUM_DT_TO.value = olddata4;
				return;
			}
		}	
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
	
	if(dataset == dsMAIN)
	{
		G_Load(dsWORK_SEQ, null);
		var		strWORK_SEQ = dsWORK_SEQ.NameString(dsWORK_SEQ.RowPosition,"WORK_SEQ");

		dataset.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
		dataset.NameString(row,"WORK_SEQ") = strWORK_SEQ;
		dataset.NameString(row,"TARGET_CLS") = "1";
		dataset.NameString(row,"TRANS_CLS") = "F";
		dataset.NameString(row,"CAL_CLS") = "A";
		dataset.NameString(row,"WORK_DT") = vDATE1;
		dataset.NameString(row,"WORK_USENO") = sEmpNo;
		dataset.NameString(row,"EMP_NM") = sEmpNm;
	}
}

function OnRowDeleteBefore(dataset)
{
	if ( dataset == dsMAIN2)
	{
		dsMAIN3.ClearData();
	}
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
	if (dataset == dsMAIN)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if (COL_DATA == "") return;
		if(colid == "WORK_FROM_DT")
		{
			if(C_isNull(COL_DATA))
			{
				return ;
			}
			else
			{
				if(C_isValidDate(COL_DATA))
				{
					dataset.NameString(row,colid) = C_toDateFormatString(COL_DATA);
					
					if ( !C_isNull(dataset.NameValue(row, "WORK_FROM_DT")))
					{
						strWorkFromDt = dataset.NameValue(row, "WORK_FROM_DT").replace(/-/gi,"");
						strWorkToDt	 = dataset.NameValue(row, "WORK_TO_DT").replace(/-/gi,"");
	
						if (parseInt(strWorkFromDt) > parseInt(strWorkToDt))
						{
							C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
							dataset.NameValue(row, "WORK_FROM_DT") = olddata;
							return;
						}
					}	
				}
				else
				{
					dataset.NameString(row,colid) = olddata;
					C_msgOk("��¥���� �߸� �ԷµǾ����ϴ�.","�˸�");
	    
					return ;
				}
			}
		}
		else if(colid == "WORK_TO_DT")
		{
			if(C_isNull(COL_DATA))
			{
				return ;
			}
			else
			{
				if(C_isValidDate(COL_DATA))
				{
					dataset.NameString(row,colid) = C_toDateFormatString(COL_DATA);
					
					if ( !C_isNull(dataset.NameValue(row, "WORK_FROM_DT")))
					{
						strWorkFromDt = dataset.NameValue(row, "WORK_FROM_DT").replace(/-/gi,"");
						strWorkToDt	 = dataset.NameValue(row, "WORK_TO_DT").replace(/-/gi,"");
	
						if (parseInt(strWorkFromDt) > parseInt(strWorkToDt))
						{
							C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
							dataset.NameValue(row, "WORK_FROM_DT") = olddata;
							return;
						}
					}	
				}
				else
				{
					dataset.NameString(row,colid) = olddata;
					C_msgOk("��¥���� �߸� �ԷµǾ����ϴ�.","�˸�");
	    
					return ;
				}
			}
		}
		else if(colid == "WORK_USENO")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("SEARCH_CONDITION",dataset.NameValue(row, "WORK_USENO"));
			
			if ( C_isNull(dataset.NameValue(row, "WORK_USENO")))
			{
				dataset.NameValue(row, "EMP_NM") ="";	
			}
			else
			{
				lrRet = C_AutoLov(dsLOV,"T_EMP_NO1", lrArgs,"T");
			}
			if (lrRet == null)
			{
				dataset.NameValue(row, "WORK_USENO")	= "";
				dataset.NameValue(row, "EMP_NM")		= "";
			 	return;
			}
			dataset.NameValue(row, "WORK_USENO")	= lrRet.get("EMPNO");
			dataset.NameValue(row, "EMP_NM")	= lrRet.get("NAME");
		}
		
	}//end dsMAIN
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		 if(colid == "WORK_USENO")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION","");
		
			lrRet = C_LOV("T_EMP_NO1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "WORK_USENO")	= lrRet.get("EMPNO");
			dataset.NameValue(row, "EMP_NM")		= lrRet.get("NAME");
		}
		else if(colid == "WORK_FROM_DT")
		{
			C_Calendar("WORK_FROM_DT", "D", dataset.NameString(row,"WORK_FROM_DT"));
		}
		else if(colid == "WORK_TO_DT")
		{
			C_Calendar("WORK_TO_DT", "D", dataset.NameString(row,"WORK_TO_DT"));
		}
		
			
	}
}

function	OnRowPosChangeBefore(dataset, row)                                    //�ʼ� �Է��׸� check
{
	if(dataset == dsMAIN)
	{
	   if (dsMAIN.NameValue(row,"WORK_DT") == "")
	   {
	      C_msgOk("�۾����� �ݵ�� �Է��ؾ��մϴ�.", "Ȯ��");
	      return false;
	   }
	   if (dsMAIN.NameValue(row,"WORK_NAME") == "")
	   {
	      C_msgOk("�۾����� �ݵ�� �Է��ؾ��մϴ�.", "Ȯ��");
	      return false;
	   }
	   if ((dsMAIN.NameValue(row,"WORK_FROM_DT") == "") || (dsMAIN.NameValue(row,"WORK_TO_DT") == ""))
	   {
	      C_msgOk("�۾��Ⱓ�� �ݵ�� �Է��ؾ��մϴ�.", "Ȯ��");
	      return false;
	   }
	   if (dsMAIN.NameValue(row,"CAL_CLS") == "")
	   {
	      C_msgOk("�󰢱����� �ݵ�� �Է��ؾ��մϴ�.", "Ȯ��");
	      return false;
	   }
	   return true;
	}
	return true;
}

// �̺�Ʈ����-------------------------------------------------------------------//
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function	btnCalc_onClick()
{
	if(dsMAIN2.CountRow < 1)
	{
		C_msgOk("������ �ڷᰡ �����ϴ�.");
		return;
	}
	if(dsMAIN.NameString(dsMAIN.RowPosition,"TRANS_CLS") == "T")
	{
		C_msgOk("�������� ����� ���¿����� ������ �� �� �����ϴ�.");
		return;
	}
	if (dsMAIN2.IsUpdated == true)
	{
		C_msgOk("��������� ���� �� �۾��� �����Ͻʽÿ�.");
		return;
	}
	CalcProcess();
}
function	btnApply_onClick()
{
	if(dsMAIN2.CountRow < 1)
	{
		C_msgOk("������ �ڷᰡ �����ϴ�.");
		return;
	}
	if (dsMAIN.IsUpdated == true)
	{
		C_msgOk("��������� ���� �� �۾��� �����Ͻʽÿ�.");
		return;
	}
	if (dsMAIN2.IsUpdated == true)
	{
		C_msgOk("��������� ���� �� �۾��� �����Ͻʽÿ�.");
		return;
	}
	Apply();
}
function	btnApplyCancel_onClick()
{
	if(dsMAIN2.CountRow < 1)
	{
		C_msgOk("������ �ڷᰡ �����ϴ�.");
		return;
	}
	if (dsMAIN.IsUpdated == true)
	{
		C_msgOk("��������� ���� �� �۾��� �����Ͻʽÿ�.");
		return;
	}
	if (dsMAIN2.IsUpdated == true)
	{
		C_msgOk("��������� ���� �� �۾��� �����Ͻʽÿ�.");
		return;
	}
	ApplyCancel();
}
function setDate_onFocus(div)
{
	if (div=="1")
	{
		olddata1 = txtWORK_DT_FROM.value;
	}
	else if (div=="2")
	{
		olddata2 = txtWORK_DT_TO.value;	
	}
	else if (div=="3")
	{
		olddata3 = txtSUM_DT_FROM.value;	
	}
	else if (div=="4")
	{
		olddata4 = txtSUM_DT_TO.value;	
	}
	
}
function txtWORK_DT_FROM_onChange()
{
		
	if ( !C_isNull(txtWORK_DT_FROM.value))
	{
		strWorkDtFrom = txtWORK_DT_FROM.value.replace(/-/gi,"");
		strWorkDtTo	 = txtWORK_DT_TO.value.replace(/-/gi,"");

		if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
		{
			C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
			txtWORK_DT_FROM.value = olddata1;
			return;
		}
	}	
}
function btnWORK_DT_FROM_onClick()
{
	//olddata1 = txtWORK_DT_FROM.value;
	C_Calendar("txtWORK_DT_FROM", "D", txtWORK_DT_FROM.value);
	 
}
function txtWORK_DT_TO_onChange()
{	
	
	if ( !C_isNull(txtWORK_DT_TO.value))
	{
		strWorkDtFrom = txtWORK_DT_FROM.value.replace(/-/gi,"");
		strWorkDtTo	 = txtWORK_DT_TO.value.replace(/-/gi,"");

		if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
		{
			C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
			txtWORK_DT_TO.value = olddata2;
			return;
		}
	}		
}
function btnWORK_DT_TO_onClick()
{
	//olddata2 = txtWORK_DT_TO.value; 
	C_Calendar("txtWORK_DT_TO", "D", txtWORK_DT_TO.value);
	
}

function txtSUM_DT_FROM_onChange()
{
		
	if ( !C_isNull(txtSUM_DT_FROM.value))
	{
		strSumDtFrom   = txtSUM_DT_FROM.value.replace(/-/gi,"");
		strSumDtTo	 = txtSUM_DT_TO.value.replace(/-/gi,"");

		if (parseInt(strSumDtFrom) > parseInt(strSumDtTo))
		{
			C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
			txtSUM_DT_FROM.value = olddata3;
			return;
		}
	}
	
}
function btnSUM_DT_FROM_onClick()
{
	//olddata3 = txtSUM_DT_FROM.value; 
	C_Calendar("SUM_DT_FROM", "D", txtSUM_DT_FROM.value);
}
function txtSUM_DT_TO_onChange()
{	
	
	if ( !C_isNull(txtSUB_DT_TO.value))
	{
		strSumDtFrom 	 = txtSUM_DT_FROM.value.replace(/-/gi,"");
		strSumDtTo	 = txtSUM_DT_TO.value.replace(/-/gi,"");

		if (parseInt(strSumDtFrom) > parseInt(strSumDtTo))
		{
			C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
			txtSUM_DT_TO.value = olddata4;
			return;
		}
	}		
}
function btnSUM_DT_TO_onClick()
{
	//olddata4 = txtSUM_DT_TO.value; 
	C_Calendar("SUM_DT_TO", "D", txtSUM_DT_TO.value);
	
}


function	btnMakeInSlip_onClick()	//
{
	makeInSlip();
}
function	btnRemoveSlip_onClick()	//
{
	removeSlip();
}
function	btnShowSlip_onClick()
{
	var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID");
	var pSLIP_IDSEQ     = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_IDSEQ");
	var pMAKE_COMP_CODE = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_KIND_TAG");
	var pREADONLY_TF    = "F";
	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("��ǥ�� ����� ���� �����ϴ�.");
		return;
	}
	
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
//�ͼӺμ�
function txtDEPT_CODE_onblur()
{
	if (txtDEPT_CODE.value == "")
	{
		txtDEPT_NAME.value 	= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);
	
	//�μ�/���� �������
	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
}
function btnDEPT_CODE_onClick()
{
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_DEPT_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
}