/**************************************************************************/
/* 1. �� �� �� �� id : t_WETaxSale3R(���ݰ�꼭������)
/* 2. ����(�ó�����) : ������� ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-11)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var p;
var ph;
var peer;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "���ݰ�꼭");
	G_addDataSet(dsLOV, null, null, null, "LOV");

}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("DOC_COM_ID",sComid)
											+ D_P2("GEN_TM_S",txtDT_F.value.replace(/-/g,''))
											+ D_P2("GEN_TM_E",txtDT_T.value.replace(/-/g,''))
											+ D_P2("SUP_REGNUM",C_Trim(txtSUP_REGNUM.value))
											+ D_P2("DOC_NUMBER",C_Trim(txtDOC_NUMBER.value))
											+ D_P2("BUY_REGNUM",C_Trim(txtBUY_REGNUM.value));
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
	G_Load(dsMAIN, null);
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
	if ( colid == "PRT_CHK" )
	{
		if ( dataset.NameString(row , colid ) == "T" )
		{
			dataset.NameString(row , "STATUS" ) = "RDY";
		}
		else
		{
			dataset.NameString(row , "STATUS" ) = "INS";
		}
	}	
}

function OnExit(dataset, grid, row, colid, olddata)
{

}

function OnPopup(dataset, grid, row, colid, data)
{

}
function OnDblClick(dataset, grid, row, colid)
{
	// ���α׷��� ��ȿ���˻� �߰�
	// ������ ���丮
  var reportFile = "r_t_140001";
   	
	frmList.EXPORT_TAG.value = 'P';//cboExportTag.value;
	frmList.RUN_TAG.value = '1';//cboRunTag.value;
	frmList.REQUEST_NAME.value = '';//txtRequestName.value;
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	var strdoc_number = C_Trim(dataset.NameString(row ,"DOC_NUMBER")) ;
	var strdoc_com_id = dataset.NameString(row ,"DOC_COM_ID") ;
	// ���α׷��� �Ķ���� �߰�
	// �Ķ����1__��1&&�Ķ����2__��2&&....
	// ����
	strTemp += "DOC_NUMBER__" + strdoc_number + "&&";
	strTemp += "DOC_COM_ID__" + strdoc_com_id;
	
	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
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

//�����ڻ����ȣã��
function	btnSUP_REGNUM_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("AS_SB_GB1", "SUP");
	lrArgs.set("COM_ID1", sComid);
	lrArgs.set("AS_SB_GB2", "SUP");
	lrArgs.set("COM_ID2", sComid);	
	lrArgs.set("SET_CONDITION1", "");
	lrArgs.set("SET_CONDITION2", "");

	lrRet = C_LOV("TB_WT_PLANT_COMPANY", lrArgs,"F");
	
	if (lrRet == null) return;

	txtSUP_REGNUM.value	  = C_Trim(lrRet.get("REG_NUM"));
	txtSUP_COMPANY.value	= lrRet.get("COMPANY");
	
}
function	btnSUP_REGNUM_onblur()
{
	var	lsNewData = txtSUP_REGNUM.value;
	if(C_isNull(lsNewData))
	{
		txtSUP_REGNUM.value	  = "";
		txtSUP_COMPANY.value	= "";
		return;
	}			
				
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("AS_SB_GB1", "SUP");
	lrArgs.set("COM_ID1", sComid);
	lrArgs.set("AS_SB_GB2", "SUP");
	lrArgs.set("COM_ID2", sComid);	
	lrArgs.set("SET_CONDITION1", sComid);
	lrArgs.set("SET_CONDITION2", txtSUP_REGNUM.value);

	lrRet = C_AutoLov(dsLOV,"TB_WT_PLANT_COMPANY", lrArgs,"T");
	
	if (lrRet == null)
	{
		txtSUP_REGNUM.value	  = "";
		txtSUP_COMPANY.value	= "";
	}
	else
	{
		txtSUP_REGNUM.value	  = C_Trim(lrRet.get("REG_NUM"));
		txtSUP_COMPANY.value	= lrRet.get("COMPANY");
	}

}
//���޹޴��ڻ����ȣã��
function	btnBUY_REGNUM_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("AS_SB_GB1", "BUY");
	lrArgs.set("COM_ID1", sComid);
	lrArgs.set("AS_SB_GB2", "BUY");
	lrArgs.set("COM_ID2", sComid);	
	lrArgs.set("SET_CONDITION1", "");
	lrArgs.set("SET_CONDITION2", "");

	lrRet = C_LOV("TB_WT_PLANT_COMPANY", lrArgs,"F");
	
	if (lrRet == null) return;

	txtBUY_REGNUM.value	  = C_Trim(lrRet.get("REG_NUM"));
	txtBUY_COMPANY.value	= lrRet.get("COMPANY");

}
function	btnBUY_REGNUM_onblur()
{
	var	lsNewData = txtBUY_REGNUM.value;
	if(C_isNull(lsNewData))
	{
		txtBUY_REGNUM.value	  = "";
		txtBUY_COMPANY.value	= "";
		return;
	}			
				
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("AS_SB_GB1", "BUY");
	lrArgs.set("COM_ID1", sComid);
	lrArgs.set("AS_SB_GB2", "BUY");
	lrArgs.set("COM_ID2", sComid);	
	lrArgs.set("SET_CONDITION1", "");
	lrArgs.set("SET_CONDITION2", txtBUY_REGNUM.value);

	lrRet = C_AutoLov(dsLOV,"TB_WT_PLANT_COMPANY", lrArgs,"T");
	
	if (lrRet == null)
	{
		txtBUY_REGNUM.value	  = "";
		txtBUY_COMPANY.value	= "";
	}
	else
	{
		txtBUY_REGNUM.value	  = C_Trim(lrRet.get("REG_NUM"));
		txtBUY_COMPANY.value	= lrRet.get("COMPANY");
	}

}
//������ȣã��
function	btnDOCU_NO_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	del_status = null;
	
	lrArgs.set("DOC_COM_ID", sComid);
	lrArgs.set("GEN_TM", sDate.substr(0,6));
	lrArgs.set("STATUS", "INS");
	lrArgs.set("BUY_COMPANY", "");

	lrRet = C_LOV("TB_WT_SALE", lrArgs,"F");
	
	if (lrRet == null) return;

	txtDOC_NUMBER.value	= lrRet.get("DOC_NUMBER");
	
}
//���ڼ��ݰ�꼭����
function	btnRDY_onclick()
{
	var cnt = 0;
	
	for (i=1;i<=dsMAIN.CountRow;i++) {
		if ( dsMAIN.NameString(i,"PRT_CHK") == "T" )	cnt++;
	}
	
	if ( cnt == 0 ) 
	{
		C_msgOk("���õ� �ڷᰡ �����ϴ�.","�˸�");
		return;
	}
	
	trans.Parameters = "ACT=MAIN";
	if(!G_saveData(dsMAIN)) {
		return;
	}
		
	C_msgOk("�۾��� ����Ǿ����ϴ�.","����");
}
//���
function	btnPRINT_onclick()
{
	if(dsMAIN.CountRow == 0) return;	
	
	// ���α׷��� ��ȿ���˻� �߰�
	// ������ ���丮
  var reportFile = "r_t_140002.rpt";
   	
	frmList.EXPORT_TAG.value = 'W';//cboExportTag.value;
	frmList.RUN_TAG.value = '1';//cboRunTag.value;
	frmList.REQUEST_NAME.value = '���ڼ��ݰ�꼭����Ʈ';//txtRequestName.value;
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile ;
	
	var strTemp = "";
	var strgen_tm_s 	= txtDT_F.value.replace(/-/g,'') ;
	var strgen_tm_e 	= txtDT_T.value.replace(/-/g,'') ;
	var strsup_regnum = C_Trim(txtSUP_REGNUM.value) ;
	var strbuy_regnum = C_Trim(txtBUY_REGNUM.value) ;
	var strdoc_number = C_Trim(txtDOC_NUMBER.value) ;	
	var strdoc_com_id = sComid ;
	if ( C_isNull(strsup_regnum.value) ) strsup_regnum = '%';
	if ( C_isNull(strbuy_regnum.value) ) strbuy_regnum = '%';
	if ( C_isNull(strdoc_number.value) ) strdoc_number = '%';
	// ���α׷��� �Ķ���� �߰�
	// �Ķ����1__��1&&�Ķ����2__��2&&....
	// ����
	strTemp += "P_GEN_TM_S__" + strgen_tm_s ;
	strTemp += "&&P_GEN_TM_E__" + strgen_tm_e ;
	strTemp += "&&P_SUP_REGNUM__" + strsup_regnum ;
	strTemp += "&&P_BUY_REGNUM__" + strbuy_regnum ;
	strTemp += "&&P_DOC_NUMBER__" + strdoc_number ;
	strTemp += "&&P_DOC_COM_ID__" + strdoc_com_id;

	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}