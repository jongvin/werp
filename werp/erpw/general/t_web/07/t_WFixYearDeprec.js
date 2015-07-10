/**************************************************************************/
/* 1. �� �� �� �� id : t_WFixYearDeprec.js(ȸ�⺰�󰢾�)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : ȸ�⺰�󰢾� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-23)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�����ڻ����");
	G_addDataSet(dsMAIN2, trans, gridMAIN2, sSelectPageName+D_P1("ACT","MAIN2"), "ȸ�⺰�󰢾�");
	G_addDataSet(dsASSETCLS, null, null, sSelectPageName+D_P1("ACT","ASSET_CLS_CODE"), "�ڻ�����");
	G_addDataSet(dsDEPREC_FINISH, null, null, sSelectPageName+D_P1("ACT","DEPREC_FINISH"), "�󰢿Ϸᱸ��");

	
	G_addDataSet(dsLOV, null, null,null, "LOV");
	G_addDataSet(dsCUR_DATE, null, null,sSelectPageName+D_P1("ACT","CUR_DATE"), "���ó�¥");
	
	G_addRel(dsMAIN, dsMAIN2);
	G_addRelCol(dsMAIN2, "FIX_ASSET_SEQ", "FIX_ASSET_SEQ");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;
	
	G_setReadOnlyCol(gridMAIN,"ASSET_MNG_NO");
	G_setReadOnlyCol(gridMAIN,"ASSET_NAME");
	G_setReadOnlyCol(gridMAIN,"DEPREC_FINISH");
	G_setReadOnlyCol(gridMAIN,"ASSET_SIZE");
	G_setReadOnlyCol(gridMAIN,"GET_DT");
	G_setReadOnlyCol(gridMAIN,"SRVLIFE");
	G_setReadOnlyCol(gridMAIN,"GET_COST_AMT");
	G_setReadOnlyCol(gridMAIN,"BASE_AMT");
	G_setReadOnlyCol(gridMAIN,"MNG_DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"REMARK");
	
	gridMAIN.focus();
	G_Load(dsCUR_DATE, null);
	G_Load(dsASSETCLS, null);
	G_Load(dsDEPREC_FINISH, null);
	chkTotal01.checked = true;
	chkTotal01_onclick();
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
									 + D_P2("FIX_ASSET_SEQ", dsMAIN.NameString(dsMAIN.RowPosition,"FIX_ASSET_SEQ"))
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value);
	}
	else if(dataset == dsASSETCLS)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ASSET_CLS_CODE");									
	}
	else if(dataset == dsDEPREC_FINISH)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DEPREC_FINISH");									
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
function	CheckCompCode()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("���� ������ڵ带 �����ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}

//��ü ���� ����
function	chkTotal01_onclick()
{
	if(chkTotal01.checked)
	{
		txtITEM_CODE.value ="";
		txtITEM_NAME.value ="";
		txtITEM_CODE.readOnly=true;
		txtITEM_CODE.style.backgroundColor = "#EFEFEF";
		btnITEM_CODE.disabled  = true;

		txtITEM_NM_CODE.value ="";
		txtITEM_NM_NAME.value ="";
		txtITEM_NM_CODE.readOnly=true;
		txtITEM_NM_CODE.style.backgroundColor = "#EFEFEF";
		btnITEM_NM_CODE.disabled  = true;
		chkTotal02.checked = true;
	}
else
	{
		txtITEM_CODE.readOnly=false;
		txtITEM_CODE.style.backgroundColor = "#ffffff";
		btnITEM_CODE.disabled = false;

		txtITEM_NM_CODE.readOnly=false;
		txtITEM_NM_CODE.style.backgroundColor = "#ffffff";
		btnITEM_NM_CODE.disabled = false;
		chkTotal02.checked = false;
	}
}
function	chkTotal02_onclick()
{
	if(chkTotal02.checked)
	{
		txtITEM_NM_CODE.value ="";
		txtITEM_NM_NAME.value ="";
		txtITEM_NM_CODE.readOnly=true;
		txtITEM_NM_CODE.style.backgroundColor = "#EFEFEF";
		btnITEM_NM_CODE.disabled  = true;
	}
	else
	{
		txtITEM_NM_CODE.readOnly=false;
		txtITEM_NM_CODE.style.backgroundColor = "#ffffff";
		btnITEM_NM_CODE.disabled = false;
	}
}

//��ȸ�� üũ
function checkCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("�������  �����Ͻʽÿ�.", "Ȯ��");
		return;
	}
	if (txtITEM_CODE.value == "" && chkTotal01.checked == false)
	{
		C_msgOk("ǰ���ڵ带 �Է��Ͻðų� '��ü'�� �����Ͻʽÿ�.", "Ȯ��");
		return;
	}
	if (txtITEM_NM_CODE.value == "" && chkTotal02.checked == false)
	{
		C_msgOk("ǰ���ڵ带 �Է��Ͻðų� '��ü'�� �����Ͻʽÿ�.", "Ȯ��");
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
	D_defaultDelete();
}

// ����
function btnsave_onclick()
{	

	D_defaultSave(dsMAIN2);
	D_defaultLoad();
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "MOVE_DT_FROM")
	{
		dsMAIN2.NameString(dsMAIN2.RowPosition,"MOVE_DT_FROM") = asDate;
		if ( !C_isNull(dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_FROM")))
		{
			strMoveDtFrom = dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_FROM").replace(/-/gi,"");
			strMoveDtTo	 = dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_TO").replace(/-/gi,"");

			if (parseInt(strMoveDtFrom) > parseInt(strMoveDtTo))
			{
				C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
				dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_FROM") = olddata;
				return;
			}
		}	
	}
	else if (asCalendarID == "MOVE_DT_TO")
	{
		dsMAIN2.NameString(dsMAIN2.RowPosition,"MOVE_DT_TO") = asDate;
		if ( !C_isNull(dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_TO")))
		{
			strMoveDtFrom = dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_FROM").replace(/-/gi,"");
			strMoveDtTo	 = dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_TO").replace(/-/gi,"");

			if (parseInt(strMoveDtFrom) > parseInt(strMoveDtTo))
			{
				C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
				dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_TO") = olddata;
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
	
	if (dataset == dsMAIN2)
	{
		G_Load(dsMOVE_SEQ, null);
	
		dataset.NameString(dataset.RowPosition,"MOVE_SEQ") 		= dsMOVE_SEQ.NameValue(dsMOVE_SEQ.RowPosition,"MOVE_SEQ");
		dataset.NameString(dsMAIN.RowPosition,"MOVE_DT_FROM") 	= dsCUR_DATE.NameValue(dsCUR_DATE.RowPosition,"CUR_DATE");//����Ʈ���ó�¥�Է�
		gridMAIN2.focus();
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
}

function OnExit(dataset, grid, row, colid, olddata)
{
	var		COL_DATA;
	COL_DATA = dsMAIN2.NameString(row,colid);
	if (COL_DATA == "") return;
	if(colid == "MOVE_DT_FROM")
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
				
				if ( !C_isNull(dataset.NameValue(row, "MOVE_DT_FROM")))
				{
					strMoveDtFrom = dataset.NameValue(row, "MOVE_DT_FROM").replace(/-/gi,"");
					strMoveDtTo	 = dataset.NameValue(row, "MOVE_DT_TO").replace(/-/gi,"");

					if (parseInt(strMoveDtFrom) > parseInt(strMoveDtTo))
					{
						C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
						dataset.NameValue(row, "MOVE_DT_FROM") = olddata;
						return;
					}
				}	
			}
			else
			{
				dsMAIN2.NameString(row,colid) = olddata;
				C_msgOk("��¥���� �߸� �ԷµǾ����ϴ�.","�˸�");
    
				return ;
			}
		}
	}
	else if(colid == "MOVE_DT_TO")
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
				
				if ( !C_isNull(dataset.NameValue(row, "MOVE_DT_TO")))
				{
					strMoveDtFrom = dataset.NameValue(row, "MOVE_DT_FROM").replace(/-/gi,"");
					strMoveDtTo	 = dataset.NameValue(row, "MOVE_DT_TO").replace(/-/gi,"");

					if (parseInt(strMoveDtFrom) > parseInt(strMoveDtTo))
					{
						C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
						dataset.NameValue(row, "MOVE_DT_TO") = olddata;
						return;
					}
				}	
			}
			else
			{
				dsMAIN2.NameString(row,colid) = olddata;
				C_msgOk("��¥���� �߸� �ԷµǾ����ϴ�.","�˸�");
    
				return ;
			}
		}
	}
	else if(colid == "DEPT_NAME")
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		
		lrArgs.set("SEARCH_CONDITION", dataset.NameValue(row, "DEPT_NAME"));
		
		if ( C_isNull(dataset.NameValue(row, "DEPT_NAME")))
		{
			dataset.NameValue(row, "DEPT_CODE") ="";	
		}
		else
		{
			lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1", lrArgs,"T");
		}
		if (lrRet == null) 
		{
			dataset.NameValue(row, "DEPT_CODE")		= "";
			dataset.NameValue(row, "DEPT_NAME")	= "";
			return;
		}
		
		
		dataset.NameValue(row, "DEPT_CODE")		= lrRet.get("DEPT_CODE");
		dataset.NameValue(row, "DEPT_NAME")	= lrRet.get("DEPT_NAME");
	}
	else if(colid == "EMP_NM")
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		
		lrArgs.set("SEARCH_CONDITION",dataset.NameValue(row, "EMP_NM"));
		
		if ( C_isNull(dataset.NameValue(row, "EMP_NM")))
		{
			dataset.NameValue(row, "EMP_NO") ="";	
		}
		else
		{
			lrRet = C_AutoLov(dsLOV,"T_EMP_NO1", lrArgs,"T");
		}
		if (lrRet == null)
		{
			dataset.NameValue(row, "EMP_NO")	= "";
			dataset.NameValue(row, "EMP_NM")	= "";
		 	return;
		}
		dataset.NameValue(row, "EMP_NO")	= lrRet.get("EMPNO");
		dataset.NameValue(row, "EMP_NM")	= lrRet.get("NAME");
	}
	
	else if(colid == "MNG_MAIN_NM")
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		
		lrArgs.set("SEARCH_CONDITION",dataset.NameValue(row, "MNG_MAIN_NM"));
		
		if ( C_isNull(dataset.NameValue(row, "MNG_MAIN_NM")))
		{
			dataset.NameValue(row, "MNG_MAIN") ="";	
		}
		else
		{
			lrRet = C_AutoLov(dsLOV,"T_EMP_NO1", lrArgs,"T");
		}
		if (lrRet == null)
		{
			dataset.NameValue(row, "MNG_MAIN")	= "";
			dataset.NameValue(row, "MNG_MAIN_NM")	="";
			 return;
		}
		dataset.NameValue(row, "MNG_MAIN")		= lrRet.get("EMPNO");
		dataset.NameValue(row, "MNG_MAIN_NM")	= lrRet.get("NAME");
	}
	else if(colid == "MNG_SUB_NM")
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		
		lrArgs.set("SEARCH_CONDITION",dataset.NameValue(row, "MNG_SUB_NM"));
		
		if ( C_isNull(dataset.NameValue(row, "MNG_SUB_NM")))
		{
			dataset.NameValue(row, "MNG_SUB") ="";	
		}
		else
		{
			lrRet = C_AutoLov(dsLOV,"T_EMP_NO1", lrArgs,"T");
		}
		if (lrRet == null)
		{
			dataset.NameValue(row, "MNG_SUB")	= "";
			dataset.NameValue(row, "MNG_SUB_NM")	="";	
			 return;
		}
		dataset.NameValue(row, "MNG_SUB")	= lrRet.get("EMPNO");
		dataset.NameValue(row, "MNG_SUB_NM")	= lrRet.get("NAME");
	}
	
}

function OnPopup(dataset, grid, row, colid, data)
{
	if ( dataset == dsMAIN2)
	{
		if(colid == "MOVE_DT_FROM")
		{
			C_Calendar("MOVE_DT_FROM", "D", dataset.NameString(row,"MOVE_DT_FROM"));
		}
		else if(colid == "MOVE_DT_TO")
		{
			C_Calendar("MOVE_DT_TO", "D", dataset.NameString(row,"MOVE_DT_TO"));
		}
		else if(colid == "DEPT_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_DEPT_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "DEPT_CODE")		= lrRet.get("DEPT_CODE");
			dataset.NameValue(row, "DEPT_NAME")	= lrRet.get("DEPT_NAME");
		}
		else if(colid == "EMP_NM")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION","");
		
			lrRet = C_LOV("T_EMP_NO1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "EMP_NO")	= lrRet.get("EMPNO");
			dataset.NameValue(row, "EMP_NM")	= lrRet.get("NAME");
		}
		else if(colid == "MNG_MAIN_NM")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_EMP_NO1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "MNG_MAIN")	= lrRet.get("EMPNO");
			dataset.NameValue(row, "MNG_MAIN_NM")	= lrRet.get("NAME");
		}
		else if(colid == "MNG_SUB_NM")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_EMP_NO1", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row, "MNG_SUB")	= lrRet.get("EMPNO");
			dataset.NameValue(row, "MNG_SUB_NM")	= lrRet.get("NAME");
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

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}
//ǰ���ڵ�
function txtITEM_CODE_onblur()
{
	
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

	if (txtITEM_CODE.value == "")
	{
		C_msgOk("ǰ���ڵ带 ������ �Է��Ͻʽÿ�.");
		return;
	}
	if (txtITEM_NM_CODE.value == "")
	{
		txtITEM_NM_NAME.value 	= "";
		txtITEM_NM_CODE.value 	= "";
		txtITEM_NM_NAME.value 	= "";
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
		C_msgOk("ǰ���ڵ带 ������ �Է��Ͻʽÿ�.");
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_NM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtITEM_NM_CODE.value	= lrRet.get("ITEM_NM_CODE");
	txtITEM_NM_NAME.value	= lrRet.get("ITEM_NM_NAME");
}//���Ѿ��� �μ�����(�������)
//�����ڵ�ã��
function txtACC_CODE_onblur()
{
	if (txtACC_CODE.value == "")
	{
		txtACC_NAME.value 	= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);
	
	//�Է°���,�Ұ��ɰ���
	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE3", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtACC_CODE.value	= lrRet.get("ACC_CODE");
	txtACC_NAME.value	= lrRet.get("ACC_NAME");
}
function btnACC_CODE_onClick()
{
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_ACC_CODE3", lrArgs,"F");
	
	if (lrRet == null) return;

	txtACC_CODE.value	= lrRet.get("ACC_CODE");
	txtACC_NAME.value	= lrRet.get("ACC_NAME");
}
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
function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("CLSE_ACC_ID", txtCLSE_ACC_ID.value);
	

	lrRet = C_AutoLov(dsLOV,"T_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
	btnquery_onclick();
	
}
function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("CLSE_ACC_ID", "");
	
	lrRet = C_LOV("T_YEAR", lrArgs,"F");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
	btnquery_onclick();

}