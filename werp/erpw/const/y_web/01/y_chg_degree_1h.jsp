<%@ page contentType="text/html; charset=EUC_KR" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- **************************************************************		-->
<!-- 1. ���α׷� id   : y_chg_degree_1h.html 	-->
<!-- 2. ����(�ó�����): ��ȸ�� �Է�											-->
<!-- 3. �� �� �� ��   : ���೻�� �ۼ�   	-->
<!-- 4. �� �� �� ��   :  �ڵ��� �ۼ�												-->
<!-- 5. �������α׷�  :																-->
<!-- 6. Ư �� �� ��   :															-->
<!-- *************************************************************		-->
<HTML>
<LINK rel="stylesheet" type="text/css" href="erpw.css">
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=ks_c_5601-1987">
<META content="MSHTML 6.00.2716.2200" name=GENERATOR>
<SCRIPT SRC="../../../comm_function/comm_function.js"></SCRIPT> 
<SCRIPT language=JavaScript>

var gs_home = top.frames['security'].gs_home.value

var is_dept_search_addr = gs_home + '/comm_search/z_dept_find_1h.html'
var is_ds_1_addr = gs_home + '/const/y_web/01/y_chg_degree_1q.jsp?arg_dept_code='         
var is_tr_1_addr = gs_home + '/const/y_web/01/y_chg_degree_1tr.jsp'
var is_dept_code = ""
var is_dept_name = ""

//------------------------------------------------------------------------
function init_move()                            //�Է½� �ʱⰪ ����
//------------------------------------------------------------------------
{
  if (ds_1.CountRow ==1) { 
      ds_1.NameValue(ds_1.RowPosition,"chg_no_seq") = 1
      ds_1.NameValue(ds_1.RowPosition,"chg_degree") = 1
  }    
  else {
      ds_1.NameValue(ds_1.RowPosition,"chg_no_seq") = ds_1.NameValue(ds_1.RowPosition + 1,"chg_no_seq") + 1 
      ds_1.NameValue(ds_1.RowPosition,"chg_degree") = ds_1.NameValue(ds_1.RowPosition + 1,"chg_degree") + 1
      ds_1.NameValue(ds_1.RowPosition,"cnt_amt")    = ds_1.NameValue(ds_1.RowPosition + 1,"cnt_amt")
      ds_1.NameValue(ds_1.RowPosition,"amt")        = ds_1.NameValue(ds_1.RowPosition + 1,"amt")
  }    
  ds_1.NameValue(ds_1.RowPosition,"dept_code") = is_dept_code   
  ds_1.NameValue(ds_1.RowPosition,"approve_class") = "1"
  tr_1.Post()
  sp_call()
}
//------------------------------------------------------------------------
function btnquery_onclick()                     // ��ȸ  
//------------------------------------------------------------------------
{
ds_1.DataID = is_ds_1_addr + is_dept_code
ds_1.SyncLoad=true
ds_1.Reset()
}
//-----------------------------------------------------------------------
function btnadd_onclick()                       // �߰� 
//------------------------------------------------------------------------
{
 if  (is_dept_code == "") {
     alert("������ �����Ͻʽÿ�(�˻��� �����ʽÿ�)")
      return
 }     
 if  (ds_1.CountRow != 0) {
     if (ds_1.NameValue(1,"approve_class") != "4") {
        alert("���� ������ ������ �ȵǾ����Ƿ� �Է��Ҽ� �����ϴ�\n  �ݵ�� ������ �۾��Ͻʽÿ�")
        return
     }   
     ds_1.RowPosition=1
     ds_1.InsertRow(ds_1.RowPosition)
 }
 else     
    ds_1.AddRow()
 init_move()
}
//-----------------------------------------------------------------------
function btninsert_onclick()                    // ����
//-----------------------------------------------------------------------
{
  btnadd_onclick()
}
//------------------------------------------------------------------------
function btndelete_onclick()                    // ���� 
//------------------------------------------------------------------------
{
 if  (is_dept_code == "") return
 if  (ds_1.RowPosition < 1) return
 if  ((ds_1.NameValue(ds_1.RowPosition,"approve_class") == "4") || (ds_1.NameValue(ds_1.RowPosition,"approve_class") == "6")) {
     alert("������ �Ǿ����Ƿ� ���� �Ҽ� �����ϴ�")
     return
 }     
  ll_chg_no_seq = ds_1.NameValue(ds_1.RowPosition,"chg_no_seq")
  
  ds_1.DeleteRow(ds_1.RowPosition)

  if  (confirm("�����Ǿ����ϴ� �����Ͻðڽ��ϱ�?")){
		  arg_cmd = "delete from y_chg_budget_detail   " +   
		                 "  where (dept_code = '" + is_dept_code + "' and "   + 
				           "         chg_no_seq = " + ll_chg_no_seq + ")   "   
		   f_update_sql(arg_cmd)
		   arg_cmd = "delete from y_chg_budget_parent   " +   
		                 "  where (dept_code = '" + is_dept_code + "' and "   + 
				           "         chg_no_seq = " + ll_chg_no_seq + ")   "   
		   f_update_sql(arg_cmd)
		   tr_1.Post()
  }
  else
  	 btnquery_onclick()	   
 }
//---------------------------------------------------------------------------
function btnsave_onclick()                       // ����
//---------------------------------------------------------------------------
{
 if  (is_dept_code == "") return
 
  if  (ds_1.NameValue(1,"approve_class") == "1") {   //�۾�����
     ld_date = f_sysdate()
      ds_1.NameValue(1,"work_dt")  = ld_date
 }      
  if  (ds_1.NameValue(1,"approve_class") == "2") {   //��û
     ld_date = f_sysdate()
     ds_1.NameValue(1,"request_dt")  = ld_date
 }      

  if (ds_1.IsUpdated){
    if  (confirm("����Ǿ����ϴ� �����Ͻðڽ��ϱ�?"))
        tr_1.Post()
 } 
}
//-----------------------------------------------------------------
function sp_call()               //sp call(���೻���� ���������� ����) 
//------------------------------------------------------------------
{
        ls_dept_code = ds_1.NameValue(ds_1.RowPosition,"dept_code")
        ll_chg_no_seq = ds_1.NameValue(ds_1.RowPosition,"chg_no_seq")
        ll_user = parent.frames['security'].empno.value   
        ds_update.DataID = 'y_sp_y_degree_insert.jsp?arg_dept_code=' + ls_dept_code + '&arg_chg_no_seq=' + ll_chg_no_seq +
                           '&arg_user=' + ll_user
        ds_update.SyncLoad = true
        ds_update.reset()
}

//----------------------------------------------------------------------------
function btncancel_onclick()                     // ���
//---------------------------------------------------------------------------- 
{
  ds_1.Undo(ds_1.RowPosition)
}
//----------------------------------------------------------------------------
function btnexit_onclick(ls_arg)                 // ���� 
//-----------------------------------------------------------------------------
{
	  if (ds_1.IsUpdated) {
     if  (confirm("����Ǿ����ϴ� �����Ͻðڽ��ϱ�?")) 
        {  //���� routine
        }   
 
   }     

// parent.frames['main_ct'].window.close()     
}
//---------------------------------------------------------------------------
function chg_budget()                        //���� ���� 
//---------------------------------------------------------------------------
{
 if  (is_dept_code == "") return
 

  if (ds_1.IsUpdated){
    if  (confirm("����Ǿ����ϴ� �����Ͻðڽ��ϱ�?")) {
		  if  (ds_1.NameValue(1,"approve_class") == "1") {   //�۾�����
		     ld_date = f_sysdate()
		      ds_1.NameValue(1,"work_dt")  = ld_date
		 }      
		  if  (ds_1.NameValue(1,"approve_class") == "2") {   //��û
		     ld_date = f_sysdate()
		     ds_1.NameValue(1,"request_dt")  = ld_date
		 }      
        tr_1.Post()
    }    
    else
        return    
   } 
  makeCookie("@y_chg_budget_detail@",ds_1.NameValue(ds_1.RowPosition,"dept_code") + "@" + is_dept_name + "@" + 
                                   ds_1.NameValue(ds_1.RowPosition,"chg_no_seq")+"@" +
                                   ds_1.NameValue(ds_1.RowPosition,"chg_degree")+"@" +
                                   ds_1.NameValue(ds_1.RowPosition,"approve_class") + "@" + 
                                   'y_chg_degree_1h.html')
  if  (ds_1.NameValue(ds_1.RowPosition,"approve_class") == "4")
     top.frames['main_ct'].location.href(gs_home + "/const/y_web/01/y_chg_budget_child_1h.html" +"?"+'r')
  else
     top.frames['main_ct'].location.href(gs_home + "/const/y_web/01/y_chg_budget_child_1h.html" +"?"+'u')
}  
//---------------------------------------------------------------------------
function chg_budget_excel()                        //���� ���� (������ �����ۼ�)
//---------------------------------------------------------------------------
{
 if  (is_dept_code == "") return
 

  if (ds_1.IsUpdated){
    if  (confirm("����Ǿ����ϴ� �����Ͻðڽ��ϱ�?")) {
		  if  (ds_1.NameValue(1,"approve_class") == "1") {   //�۾�����
		     ld_date = f_sysdate()
		      ds_1.NameValue(1,"work_dt")  = ld_date
		 }      
		  if  (ds_1.NameValue(1,"approve_class") == "2") {   //��û
		     ld_date = f_sysdate()
		     ds_1.NameValue(1,"request_dt")  = ld_date
		 }      
        tr_1.Post()
    }    
    else
        return    
   } 
  makeCookie("@y_chg_budget_detail@",ds_1.NameValue(ds_1.RowPosition,"dept_code") + "@" + is_dept_name + "@" + 
                                   ds_1.NameValue(ds_1.RowPosition,"chg_no_seq")+"@" +
                                   ds_1.NameValue(ds_1.RowPosition,"chg_degree")+"@" +
                                   ds_1.NameValue(ds_1.RowPosition,"approve_class") + "@" + 
                                   'y_chg_degree_1h.html')
  if  (ds_1.NameValue(ds_1.RowPosition,"approve_class") == "4")
     alert("������ �Ǿ����Ƿ� ������ �����ۼ��� �Ҽ� �����ϴ�")
  else
     top.frames['main_ct'].location.href(gs_home + "/const/y_web/01/y_chg_budget_child_excel_1h.html" +"?"+'u')
}  
//---------------------------------------------------------------------------
function dept_code_find()                       //���� ã�� 
//---------------------------------------------------------------------------
{
	result = f_dept_code_find(dept_name.value)
	if (result==false) return
	
	is_dept_code = top.frames['security'].gs_dept_code.value
	is_dept_name = top.frames['security'].gs_dept_name.value

	dept_name.value = is_dept_name

	btnquery_onclick()
}
//------------------------------------------------------------------------
function keyDown()                       //�˻��� �Է��� enter�� �������
//------------------------------------------------------------------------
{
	if (window.event.keyCode == 13) { 
		dept_code_find();
	} 
}
//---------------------------------------------------------------------------
function window_onload()                      // window open event
//---------------------------------------------------------------------------
{
  if (f_reject_window()) return
   top.frames['main_title'].mouse_over()
   ll_cnt = f_select_q("select etc_code select_1, child_name select_2  from z_code_etc_child where class_tag = '004' order by etc_code") //���α���
   top.frames['main_title'].title_name.value = " " + "���� ���"  
	is_dept_code = top.frames['security'].gs_dept_code.value
	is_dept_name = top.frames['security'].gs_dept_name.value
	dept_name.value = is_dept_name

   tr_1.Action = is_tr_1_addr
   btnquery_onclick()
     // -------------------------���೻������  ���ٰ� �ٽ� ���ƿ������ �ش� ���������� �������ؼ� ������������
   var result="";
	var array = new Array();
	result = readCookie("@y_chg_budget_detail@")
   if (result == "err") {
      return
   }   
	else {   
	   array = result.split("@");
      ll_chg_degree = parseInt(array[3])  //����������ȣ 
      ds_1.RowPosition = ds_1.ValueRow(3,ll_chg_degree)   // 3�� "chg_degree" column ��
      makeCookie("@y_chg_budget_detail@","")
    }

}
</SCRIPT>
<script language=JavaScript for=gd_1 event=OnKeyPress(kcode)>
if (kcode == 13) {
    if (ds_1.RowPosition == ds_1.CountRow)  
        btnadd_onclick()
    else     
        ds_1.RowPosition++
}
</script>
<SCRIPT language=JavaScript for=gd_1 event=OnDblClick(row,colid)>
ds_1.RowPosition=row
chg_budget()
</SCRIPT>

<SCRIPT language=JavaScript for=gd_1 event=OnCloseUp(row,colid)>
if (colid == "approve_class") {
   if  (ds_1.OrgNameValue(row,"approve_class") == "4")   {
       ds_1.NameValue(row,"approve_class") = ds_1.OrgNameValue(row,"approve_class")
          alert("������ �Ǿ����Ƿ� �����Ҽ� �����ϴ�")
       return false
   }
   else
   if  (ds_1.OrgNameValue(row,"approve_class") == "6")  {
        if (ds_1.NameValue(row,"approve_class") != "2") {
          ds_1.NameValue(row,"approve_class") = ds_1.OrgNameValue(row,"approve_class")
          alert("��û���θ� ������ �����մϴ�")
          return false
        }
   }     
}   
</SCRIPT>
<script language=JavaScript for=ds_1 event=OnRowPosChanged(row)>
  if (ds_1.NameValue(ds_1.RowPosition,"approve_class") == "4") 
      gd_1.Editable = false
  else
      gd_1.Editable = true
           
</SCRIPT>

</HEAD>
<BODY style="FONT-SIZE: 12px"  onload=window_onload() oncontextmenu="return false" >
<SCRIPT language=JavaScript for=ds_1 event=OnLoadError()>
  alert("Error Code(ds_1) : " + ds_1.ErrorCode + "\n" + "Error Message : " + ds_1.ErrorMsg + "\n");
</SCRIPT>
<SCRIPT language=JavaScript for=ds_update event=OnLoadError()>
  alert("Error Code(ds_update) : " + ds_update.ErrorCode + "\n" + "Error Message : " + ds_update.ErrorMsg + "\n");
</SCRIPT>

<SCRIPT language=JavaScript for=tr_1 event=OnFail()>
  alert("Error Code (tr_1): " + tr_1.ErrorCode + "\n" + "Error Message : " + tr_1.ErrorMsg + "\n");
</SCRIPT>
 <Object id=ds_sysdate
      style="Z-INDEX: 100; LEFT: 339px; POSITION: absolute; TOP: 13px" 
      classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49> </OBJECT>
 <Object id=ds_select
      style="Z-INDEX: 100; LEFT: 339px; POSITION: absolute; TOP: 13px" 
      classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49> </OBJECT>

<OBJECT id=ds_1 
    style="Z-INDEX: 100; LEFT: 339px; POSITION: absolute; TOP: 13px" 
    classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
</OBJECT>
<OBJECT id=ds_update 
    style="Z-INDEX: 100; LEFT: 339px; POSITION: absolute; TOP: 13px" 
    classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
</OBJECT>

<OBJECT id=tr_1 
    style="Z-INDEX: 103; LEFT: 477px; POSITION: absolute; TOP: 2px" 
    classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="Action" VALUE="">
	<PARAM NAME="KeyName" VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="JSP(I:y_chg_degree_1tr=ds_1)">
	<PARAM NAME="Protocol" VALUE="1"></OBJECT>
<DIV id=hdept_page_1 
         style="Z-INDEX: 111; LEFT: 4px; WIDTH: 255px; POSITION: absolute; TOP: 2px; HEIGHT: 24px;FONT-SIZE: 12px" >
      <table width="100%" height="100%"  BORDER="1"  align="center"   CELLSPACING="0" style="FONT-SIZE: 12px">
         <tr BGCOLOR="white" > 
             <td   BGCOLOR="#7494B8" style="COLOR: #ffffff"> 
                 <div align="right">�����</div></td>
             <td >
						<INPUT id=dept_name style=" FONT-SIZE: 12px;" size=25 onkeyDown="keyDown()">
						<input type="button_query" value=" �˻�" 
					        style="color:#2E4A4A; font-size:13px;  CURSOR: hand; width=40px;
					        background-color:#E9F5F5; border:1 #A1A9A9 solid; height:20px"   
					        onmouseover="this.style.backgroundColor='#C0E8DB'; this.style.color='#EF315E'" 
					        onmouseout="this.style.backgroundColor='#E9F5F5'; this.style.color='#0E4433'
					        "  onclick=dept_code_find()>
         </tr>                 
      </table>
</DIV>      
<LABEL id=Label_2  
    style="WIDTH: 380px; LEFT: 290px;POSITION: absolute; HEIGHT: 25px; TOP:9px">(���α����� ��û�����Ͻø� ���೻�� ���� ó���� �Ҽ��ֽ��ϴ�)
</LABEL>

<input type="button_query1" value=" �����ۼ�" 
          style="filter='progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#C7E2E2, EndColorStr=#FFFFFF)';font-size: 10pt; border:1 solid #000000; CURSOR: hand; 
            border:1 #A1A9A9 solid; LEFT: 800px; POSITION: absolute; WIDTH: 65px; TOP: 7px;  height:17px"   
            onmouseover="this.style.backgroundColor='#C0E8DB'; this.style.color='#EF315E'" 
            onmouseout="this.style.backgroundColor='#E9F5F5'; this.style.color='#0E4433'
           "  onclick=chg_budget()>

<input type="button_query2" value="�����ڷ�� �����ۼ�" 
          style="filter='progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#C7E2E2, EndColorStr=#FFFFFF)';font-size: 10pt; border:1 solid #000000; CURSOR: hand; 
            border:1 #A1A9A9 solid; LEFT: 875px; POSITION: absolute; WIDTH: 125px; TOP: 7px;  height:17px"   
            onmouseover="this.style.backgroundColor='#C0E8DB'; this.style.color='#EF315E'" 
            onmouseout="this.style.backgroundColor='#E9F5F5'; this.style.color='#0E4433'
           "  onclick=chg_budget_excel()>
<OBJECT id=gd_1 
    style="FONT-SIZE: 12px; Z-INDEX: 102; LEFT: 2px; WIDTH: 1010px; POSITION: absolute; TOP: 30px;
    HEIGHT: 620px" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49>
	<PARAM NAME="MultiRowSelect" VALUE="0">
	<PARAM NAME="AutoInsert" VALUE="-1">
	<PARAM NAME="AllShowEdit" VALUE="-1">
   <PARAM NAME="BorderStyle"  VALUE=4>
	<PARAM NAME="Editable" VALUE="-1">
	<PARAM NAME="ColSizing" VALUE="-1">
	<PARAM NAME="Format" VALUE='
	  <C> Name="��������" ID=chg_degree BgColor={decode(currow-tointeger(currow/2)*2,0,"#F4F2D8",1,"ffffff")} HeadAlign=Center HeadBgColor=#7494B8  HeadColor=#ffffff   Width=54 </C>
	  <C> Name="���� ����" ID=chg_title  BgColor={decode(currow-tointeger(currow/2)*2,0,"#F4F2D8",1,"ffffff")} HeadAlign=Center HeadBgColor=#7494B8  HeadColor=#ffffff   Width=330 </C>
	  <C> Name="���α���" ID=approve_class EditStyle=Lookup Data="ds_select:select_1:select_2"  BgColor={decode(currow-tointeger(currow/2)*2,0,"#F4F2D8",1,"ffffff")} HeadAlign=Center HeadBgColor=#CA7944 HeadColor=#ffffff   Width=60 </C>
	  <C> Name="�۾�����1"  ID=work_dt    Edit=None  BgColor={decode(currow-tointeger(currow/2)*2,0,"#F4F2D8",1,"ffffff")} HeadAlign=Center HeadBgColor=#7494B8  HeadColor=#ffffff   Width=80 </C>
	  <C> Name="��û����" ID=request_dt  Edit=None  BgColor={decode(currow-tointeger(currow/2)*2,0,"#F4F2D8",1,"ffffff")} HeadAlign=Center HeadBgColor=#7494B8  HeadColor=#ffffff   Width=80 </C>
	  <C> Name="��������" ID=approve_dt Edit=None   BgColor={decode(currow-tointeger(currow/2)*2,0,"#F4F2D8",1,"ffffff")} HeadAlign=Center HeadBgColor=#7494B8  HeadColor=#ffffff   Width=80 </C>
	  <C> Name="���ޱݾ�" ID=cnt_amt  Value={DECODE(cnt_amt,0," ",cnt_amt)} Edit=None  BgColor={decode(currow-tointeger(currow/2)*2,0,"#F4F2D8",1,"ffffff")} HeadAlign=Center HeadBgColor=#7494B8  HeadColor=#ffffff   Width=100 </C>
	  <C> Name="����ݾ�" ID=amt  Value={DECODE(amt,0," ",amt)} Edit=None  BgColor={decode(currow-tointeger(currow/2)*2,0,"#F4F2D8",1,"ffffff")} HeadAlign=Center HeadBgColor=#7494B8  HeadColor=#ffffff   Width=100 </C>'>
	<PARAM NAME="DataID" VALUE="ds_1"></OBJECT>

</BODY></HTML>
