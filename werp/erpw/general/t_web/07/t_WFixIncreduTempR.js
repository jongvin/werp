/**************************************************************************/
/* 1. �� �� �� �� id : t_WFixIncreduR.js(�����ڻ��������׵��)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : �����ڻ��������׵�� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�����ڻ����");
	G_addDataSet(dsMAIN2, trans, gridMAIN2, sSelectPageName+D_P1("ACT","MAIN2"), "�����ڻ�������Ȳ");
	G_addDataSet(dsASSETCLS, null, null, sSelectPageName+D_P1("ACT","ASSET_CLS_CODE"), "�ڻ�����");
	G_addDataSet(dsDEPREC_FINISH, null, null, sSelectPageName+D_P1("ACT","DEPREC_FINISH"), "�󰢿Ϸᱸ��");

	G_addDataSet(dsINCREDU_SEQ, null, null, sSelectPageName+D_P1("ACT","INCREDU_SEQ"), "��������");
	G_addDataSet(dsLOV, null, null,null, "LOV");
	G_addDataSet(dsCUR_DATE, null, null,sSelectPageName+D_P1("ACT","CUR_DATE"), "���ó�¥");
	
	G_addRel(dsMAIN, dsMAIN2);
	G_addRelCol(dsMAIN2, "FIX_ASSET_SEQ", "FIX_ASSET_SEQ");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	G_setReadOnlyCol(gridMAIN,"ASSET_MNG_NO");
	G_setReadOnlyCol(gridMAIN,"ASSET_NAME");
	G_setReadOnlyCol(gridMAIN,"DEPREC_FINISH");
	G_setReadOnlyCol(gridMAIN,"ASSET_SIZE");
	G_setReadOnlyCol(gridMAIN,"GET_DT");
	G_setReadOnlyCol(gridMAIN,"SRVLIFE");
	G_setReadOnlyCol(gridMAIN,"GET_COST_AMT");
	G_setReadOnlyCol(gridMAIN,"BASE_AMT");
	G_setReadOnlyCol(gridMAIN,"MNG_DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"REMARK");
	
	gridMAIN.focus();
	G_Load(dsCUR_DATE, null);
	G_Load(dsASSETCLS, null);
	G_Load(dsDEPREC_FINISH, null);

}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("ASSET_CLS_CODE",dsASSETCLS.NameString(dsASSETCLS.RowPosition,"ASSET_CLS_CODE"))
									 + D_P2("ITEM_CODE",txtITEM_CODE.value)
									 + D_P2("ITEM_NM_CODE", txtITEM_NM_CODE.value)
									 + D_P2("DEPREC_FINISH",dsDEPREC_FINISH.NameString(dsDEPREC_FINISH.RowPosition,"CODE_LIST_ID"));
	}
	else if(dataset == dsMAIN2)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN2")
									 + D_P2("FIX_ASSET_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"FIX_ASSET_SEQ"));
	}
	else if(dataset == dsASSETCLS)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ASSET_CLS_CODE");									
	}
	else if(dataset == dsDEPREC_FINISH)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DEPREC_FINISH");									
	}
	else if(dataset == dsINCREDU_SEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","INCREDU_SEQ");								
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



//��ȸ�� üũ
function checkCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("������� �����ϼ���.", "Ȯ��");
		return;
	}
	
	return true;
}
//��ü ���� ����
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
		C_msgOk("�ڻ����� ������ȸ�ϼ���");
		return;	
	}
	
	if ( dsMAIN.CountRow <1)
	{
		C_msgOk("�ڻ����� �����Ƿ� ���������� ����� �� �����ϴ�");
		return;	
	}
	G_addRow(dsMAIN2);
}

// ����
function btninsert_onclick()
{
	btnadd_onclick();
}

// ����
function btndelete_onclick()
{
	if (G_FocusDataset == dsMAIN2)
	{
		if (dsMAIN.NameString(dsMAIN.RowPosition,"DEPREC_FINISH") == '3' ||  dsMAIN.NameString(dsMAIN.RowPosition,"DEPREC_FINISH") == '4' )
		{
			C_msgOk("�Ű��Ǵ� ���� �����ڻ��� <br>���� ������ ������ �� �����ϴ�.");
			return false;	
		}
	}
	D_defaultDelete();
}

// ����
function btnsave_onclick()
{	

	D_defaultSave(dsMAIN2);
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "INCREDU_DT")
	{
		dsMAIN2.NameString(dsMAIN2.RowPosition,"INCREDU_DT") = asDate;
	}
}
function OnDblClick(dataset, grid, row, colid)
{
	if (dataset == dsMAIN2)
	{
		if (dsMAIN.NameString(dsMAIN.RowPosition,"DEPREC_FINISH") == '3' ||  dsMAIN.NameString(dsMAIN.RowPosition,"DEPREC_FINISH") == '4' )
		{
			C_msgOk("�Ű��Ǵ� ���� �����ڻ��� <br>���� ������ ������ �� �����ϴ�. <br>���������� �����Ϸ��� ������������ <br> �Ϸᱸ���� �����ϼ���");
			return false;	
		}
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	if (dataset == dsMAIN2)
	{
		if (dsMAIN.NameString(dsMAIN.RowPosition,"DEPREC_FINISH") == '3' ||  dsMAIN.NameString(dsMAIN.RowPosition,"DEPREC_FINISH") == '4' )
		{
			C_msgOk("�Ű��Ǵ� ���� �����ڻ��� <br>���� ������ �Է��� �� �����ϴ�.");
			return false;	
		}
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	
	if (dataset == dsMAIN2)
	{
		G_Load(dsINCREDU_SEQ, null);
	
		dataset.NameString(dataset.RowPosition,"INCREDU_SEQ") 	= dsINCREDU_SEQ.NameValue(dsINCREDU_SEQ.RowPosition,"INCREDU_SEQ");
		//dataset.NameString(dataset.RowPosition,"INCREDU_CLS") 	= "1";
		dataset.NameString(dataset.RowPosition,"INCREDU_DT") 	= dsCUR_DATE.NameValue(dsCUR_DATE.RowPosition,"INCREDU_DT");//����Ʈ���ó�¥�Է�
		dataset.NameString(dataset.RowPosition,"INCSUB_CNT") 	= "1";
		gridMAIN2.focus();
	}
}
function OnRowPosChanged(dataset, row)
{
	if (dataset == dsMAIN)
	{
		if (dataset.NameString(dataset.RowPosition,"DEPREC_FINISH") == '3' ||  dataset.NameString(dataset.RowPosition,"DEPREC_FINISH") == '4' )
		{
			gridMAIN2.Editable='false';	
		}
		else
		{
			gridMAIN2.Editable='true';
		}
	}
	else if(dataset == dsMAIN2)
	{
		
		if(dataset.NameValue(row, 'INCREDU_CLS')=='1')
		{
			gridMAIN2.ColumnProp('INCSUB_AMT','Name')='�ں�������ݾ�';
			gridMAIN2.ColumnProp('INCREDU_DT','Name')='�ں�����������';
			G_setReadOnlyCol(gridMAIN2,"CUST_NAME");
			G_setReadOnlyCol(gridMAIN2,"EMP_NAME");
		}
		else if(dataset.NameValue(row,  'INCREDU_CLS')=='3')
		{
			gridMAIN2.ColumnProp('INCSUB_AMT','Name')='���ݾ�';
			gridMAIN2.ColumnProp('INCREDU_DT','Name')='�������';
			gridMAIN2.ColumnProp('CUST_NAME','Name')='���ó';
			gridMAIN2.ColumnProp('EMP_NAME','Name')='�������';
			
			G_setReadWriteCol(gridMAIN2, 'CUST_NAME');
			G_setReadWriteCol(gridMAIN2, 'EMP_NAME');
		}
		else if(dataset.NameValue(row,  'INCREDU_CLS')=='4')
		{
			gridMAIN2.ColumnProp('INCSUB_AMT','Name')='�Ű��ݾ�';
			gridMAIN2.ColumnProp('INCREDU_DT','Name')='�Ű�����';
			gridMAIN2.ColumnProp('CUST_NAME','Name')='�Ű�ó';
		       gridMAIN2.ColumnProp('EMP_NAME','Name')='�Ű������';
		       G_setReadWriteCol(gridMAIN2, 'CUST_NAME');
			G_setReadWriteCol(gridMAIN2, 'EMP_NAME');
		}
		
	}
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
	if(dataset == dsMAIN2)
	{
		if(colid =='INCREDU_CLS')
		{
			if(dataset.NameValue(row, colid)=='1')
			{
				gridMAIN2.ColumnProp('INCSUB_AMT','Name')='�ں�������ݾ�';
				gridMAIN2.ColumnProp('INCREDU_DT','Name')='�ں�����������';
				G_setReadOnlyCol(gridMAIN2,"CUST_NAME");
				G_setReadOnlyCol(gridMAIN2,"EMP_NAME");
			}
			else if(dataset.NameValue(row, colid)=='3')
			{
				gridMAIN2.ColumnProp('INCSUB_AMT','Name')='���ݾ�';
				gridMAIN2.ColumnProp('INCREDU_DT','Name')='�������';
				gridMAIN2.ColumnProp('CUST_NAME','Name')='���ó';
				gridMAIN2.ColumnProp('EMP_NAME','Name')='�������';
				G_setReadWriteCol(gridMAIN2, 'CUST_NAME');
				G_setReadWriteCol(gridMAIN2, 'EMP_NAME');
			}
			else if(dataset.NameValue(row, colid)=='4')
			{
				gridMAIN2.ColumnProp('INCSUB_AMT','Name')='�Ű��ݾ�';
				gridMAIN2.ColumnProp('INCREDU_DT','Name')='�Ű�����';
				gridMAIN2.ColumnProp('CUST_NAME','Name')='�Ű�ó';
				gridMAIN2.ColumnProp('EMP_NAME','Name')='�Ű������';
				G_setReadWriteCol(gridMAIN2, 'CUST_NAME');
				G_setReadWriteCol(gridMAIN2, 'EMP_NAME');
			}
			
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	var		COL_DATA;
	COL_DATA = dsMAIN2.NameString(row,colid);
	if (COL_DATA == "") return;
	if(colid == "INCREDU_DT")
	{
		if(C_isNull(COL_DATA))
		{
			return ;
		}
		else
		{
			if(C_isValidDate(COL_DATA))
			{
				dsMAIN2.NameString(row,colid) = C_toDateFormatString(COL_DATA);
			}
			else
			{
				dsMAIN2.NameString(row,colid) = olddata;
				C_msgOk("��¥���� �߸� �ԷµǾ����ϴ�.","�˸�");
    
				return ;
			}
		}
	}
	else if(colid == "CUST_NAME")
	{
		if(C_isNull(COL_DATA))
		{
			dataset.NameValue(row, "CUST_NAME")	="";
			dataset.NameValue(row, "ST_CUST_SEQ")	= "";
			return false ;
		}
	
		
	}
	else if(colid == "EMP_NAME")
	{
		if(C_isNull(COL_DATA))
		{
			dataset.NameValue(row, "ST_EMP_NO")	="";
			dataset.NameValue(row, "EMP_NAME")	= "";
			return false ;
		}
	
		
	}		
}

function OnPopup(dataset, grid, row, colid, data)
{
	
	if ( dataset == dsMAIN2)
	{
		if(colid == "INCREDU_DT")
		{
			C_Calendar("INCREDU_DT", "D", dataset.NameString(dataset.RowPosition,"INCREDU_DT"));
		}
		else if(colid == "CUST_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("SEARCH_CONDITION", "");
			
			lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row, "CUST_NAME")	= lrRet.get("CUST_NAME");
			dataset.NameValue(row, "ST_CUST_SEQ")	= lrRet.get("CUST_SEQ");
		}
		else if(colid == "EMP_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
			lrArgs.set("SEARCH_CONDITION", "");
			
			lrRet = C_LOV("Z_AUTHORITY_USER01", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row, "ST_EMP_NO")	= lrRet.get("EMPNO");
			dataset.NameValue(row, "EMP_NAME")	= lrRet.get("NAME");
		}		
	}
	
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

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}
//ǰ���ڵ�
function txtITEM_CODE_onblur()
{
	if (C_isNull(txtITEM_CODE.value))
	{
		txtITEM_NAME.value = "";
		return;
	}
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_AutoLov(dsLOV,"T_FIX_ITEM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtITEM_CODE.value	= lrRet.get("ITEM_CODE");
	txtITEM_NAME.value	= lrRet.get("ITEM_NAME");
}

function btnITEM_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtITEM_CODE.value	= lrRet.get("ITEM_CODE");
	txtITEM_NAME.value	= lrRet.get("ITEM_NAME");
}
//ǰ���ڵ�
function txtITEM_NM_CODE_onblur()
{

	if (!C_isNull(txtITEM_NM_CODE.value))
	{
		if (C_isNull(txtITEM_CODE.value))
		{
			C_msgOk("ǰ�񱸺��� ���� �����ϼ���.");
			return;
		}
	}
	
	if (C_isNull(txtITEM_NM_CODE.value))
	{
		txtITEM_NM_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_AutoLov(dsLOV,"T_FIX_ITEM_NM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtITEM_NM_CODE.value	= lrRet.get("ITEM_NM_CODE");
	txtITEM_NM_NAME.value	= lrRet.get("ITEM_NM_NAME");
}

function btnITEM_NM_CODE_onClick()
{
	if (txtITEM_CODE.value == "")
	{
		C_msgOk("ǰ�񱸺��� ���� �����ϼ���.");
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_NM_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtITEM_NM_CODE.value	= lrRet.get("ITEM_NM_CODE");
	txtITEM_NM_NAME.value	= lrRet.get("ITEM_NM_NAME");
}//���Ѿ��� �μ�����(�������)

//���źμ�
function txtMNG_DEPT_CODE_onblur()
{
	if (txtMNG_DEPT_CODE.value == "")
	{
		txtMNG_DEPT_NAME.value 	= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtMNG_DEPT_CODE.value);
	
	//�μ�/���� �������
	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtMNG_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtMNG_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
}
function btnMNG_DEPT_CODE_onClick()
{
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_DEPT_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtMNG_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtMNG_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
}
//��ġ����
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
//�ŷ�ó�˻�
function txtCUST_CODE_onblur()
{
	if (txtCUST_CODE.value == "")
	{
		txtCUST_NAME.value 	= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);
	

	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCUST_CODE.value	= lrRet.get("CUST_CODE");
	txtCUST_NAME.value	= lrRet.get("CUST_NAME");
	hiCUST_SEQ.value		= lrRet.get("CUST_SEQ");
}
function btnCUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCUST_CODE.value	= lrRet.get("CUST_CODE");
	txtCUST_NAME.value	= lrRet.get("CUST_NAME");
	hiCUST_SEQ.value		= lrRet.get("CUST_SEQ");
}

//�ڵ���ǥ����(�ں��� ����)
function btnAutoSlipMake_onClick()
{
	//if (!G_isLoaded("dsMAIN"))
	//{
		//C_msgOk("���� ��ȸ�� �����ϼ���");
		//return;	
	//}		
	
	//if (dsMAIN.CountRow  < 1)
	//{
		//C_msgOk("�ڵ������� �����ڻ��� �����ϴ�");	
		//return;
	//}
	
	var arrRtn = null;
	var arrRtn2 = null;
	
	arrRtn2 = window.showModalDialog("t_PSlip01FixIncreduR.jsp", arrRtn, "center:yes; dialogWidth:1024px; dialogHeight:768px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
}

//�Ű� �ڵ���ǥ����
function btnAutoSlipMake2_onClick()
{
	//if (!G_isLoaded("dsMAIN"))
	//{
		//C_msgOk("���� ��ȸ�� �����ϼ���");
		//return;	
	//}		
	
	//if (dsMAIN.CountRow  < 1)
	//{
		//C_msgOk("�ڵ������� �����ڻ��� �����ϴ�");	
		//return;
	//}
	
	var arrRtn = null;
	var arrRtn2 = null;
	
	arrRtn2 = window.showModalDialog("t_PSlip02FixIncreduR.jsp", arrRtn, "center:yes; dialogWidth:1024px; dialogHeight:768px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
}

//��� �ڵ���ǥ����
function btnAutoSlipMake3_onClick()
{
	//if (!G_isLoaded("dsMAIN"))
	//{
		//C_msgOk("���� ��ȸ�� �����ϼ���");
		//return;	
	//}		
	
	//if (dsMAIN.CountRow  < 1)
	//{
		//C_msgOk("�ڵ������� �����ڻ��� �����ϴ�");	
		//return;
	//}
	
	var arrRtn = null;
	var arrRtn2 = null;
	
	arrRtn2 = window.showModalDialog("t_PSlip03FixIncreduR.jsp", arrRtn, "center:yes; dialogWidth:1024px; dialogHeight:768px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
}
