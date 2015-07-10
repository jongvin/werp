
//----------------------------------------------------------------
function makeCookie(name, value)  // 쿠키 생성
//----------------------------------------------------------------
{
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate() + 300);
          document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"
//          + ( (expire) ? "; expires=" + expire.toGMTString() : "")
}
//---------------------------------------------------------------------
function readCookie(uName)       // 쿠키 조회
//---------------------------------------------------------------------
{
	var end
	var flag = document.cookie.indexOf(uName+'=');
	if (flag == -1) return "err"
	if (flag != -1) { 
		flag += uName.length + 1
		end = document.cookie.indexOf(';', flag) 

		if (end == -1) end = document.cookie.length
		return unescape(document.cookie.substring(flag, end))
	}
}
//----------------------------------------------------------------------
function clearCookie()   // clear 쿠키 
//----------------------------------------------------------------------
{ 
  document.cookie="username=;expires=Sun Apr 16 00:00:01 GMT 2999" 
  alert("Your cookie has been deleted!") 
} 
//----------------------------------------------------------------------
function jumin_check(arg_jumin)   // 주민등록번호 체크
//----------------------------------------------------------------------
{
 var jumin 	
 var i,k
 var total = 0;
 var totalmod,chd
 var temp = new Array(13);    // 주민등록번호 각 자리를 저장할 배열 확보
 jumin=arg_jumin             //주민번호 보관
 for(i=0; i<13; i++)
	temp[i] = parseInt(jumin.charAt(i));  // 연산을 위해서 각 자리를 정수로 변환하여 배열에 저장함
 for(i=0; i<12; i++)
 {
		k = i + 2;
		if(k >= 10)
			k = k % 10 + 2;
		total = total + temp[i] * k;   // 각 자리에 2,3,4,....를 곱해서 그 결과를 누적함
 }  
 totalmod = total % 11;  // 11로 나눈 나머지를 구함
 chd = 11 - totalmod;   // 11에서 뺌
 if (chd==10)
   chd=0;
 if (chd==11)
   chd=1;           // 최종 결과가 11이나 10처럼 두 자리일 경우에는 뒷 자리를 사용함
 if(chd == temp[12])  // 최종 결과와 주민등록번호 끝자리가 같으면
   return true
 else
   return false
}
//------------------------------------------------------------------------------
function f_enter_key(colid,colid_array)
//------------------------------------------------------------------------------
{
	var ls_colid_array = new Array();
	ls_colid_array = colid_array.split("@")
   var i
   for (i=0; i< ls_colid_array.length; i++) {
       if (colid == ls_colid_array[i]) {
           if  (i == ls_colid_array.length - 1) 
                return "last"
           else {
           	     i++    
               return ls_colid_array[i]
               }
       }        
   }  
   return "err"
}         
//------------------------------------------------------------------------------
function f_select_q(ls_sql)
//------------------------------------------------------------------------------
{
var i,j,ll_find,ll_from,ls_colcnt,ll_cnt
  ll_find = 0
  ll_from = ls_sql.lastIndexOf("select_")
  for(i=ll_from ; i < ls_sql.length ; i++) {
     if  (ls_sql.substr(i,1) == "_") { 
         for (j=i; j < ls_sql.length ; j++) {
             if (ls_sql.substr(j,1) == " ") {
                 ll_find = 1
                 break
             }    
         }
     }
   if (ll_find == 1) break
  }      
  ls_colcnt = ls_sql.substr(i+1, j-i)
  

  switch(parseInt(ls_colcnt))  
    {
     case 1 : ds_select.DataID="erpw/comm_function/comm_select_1q.jsp?in_sql=" + ls_sql; break 
     case 2 : ds_select.DataID="erpw/comm_function/comm_select_2q.jsp?in_sql=" + ls_sql; break 
     case 3 : ds_select.DataID="erpw/comm_function/comm_select_3q.jsp?in_sql=" + ls_sql; break 
     case 4 : ds_select.DataID="erpw/comm_function/comm_select_4q.jsp?in_sql=" + ls_sql; break 
     case 5 : ds_select.DataID="erpw/comm_function/comm_select_5q.jsp?in_sql=" + ls_sql; break 
     case 6 : ds_select.DataID="erpw/comm_function/comm_select_6q.jsp?in_sql=" + ls_sql; break 
     case 7 : ds_select.DataID="erpw/comm_function/comm_select_7q.jsp?in_sql=" + ls_sql; break 
     case 8 : ds_select.DataID="erpw/comm_function/comm_select_8q.jsp?in_sql=" + ls_sql; break 
     case 9 : ds_select.DataID="erpw/comm_function/comm_select_9q.jsp?in_sql=" + ls_sql; break 
     case 10 : ds_select.DataID="erpw/comm_function/comm_select_10q.jsp?in_sql=" + ls_sql; break 
     }
 ds_select.SyncLoad = true
 ds_select.reset()
 ll_cnt = ds_select.CountRow
 return ll_cnt
}  
//-----------------------------------------------------------------------
function f_select1_q(ls_sql)
//-----------------------------------------------------------------------
{
  var i,j,ll_find,ll_from,ls_colcnt,ll_cnt
ll_find = 0
  ll_from = ls_sql.lastIndexOf("select_")
  for(i=ll_from ; i < ls_sql.length ; i++) {
     if  (ls_sql.substr(i,1) == "_") { 
         for (j=i; j < ls_sql.length ; j++) {
             if (ls_sql.substr(j,1) == " ") {
                 ll_find = 1
                 break
             }    
         }
     }
   if (ll_find == 1) break
  }      
  ls_colcnt = ls_sql.substr(i+1, j-i)
  
  switch(parseInt(ls_colcnt))  
    {
     case 1 : ds_select1.DataID="erpw/comm_function/comm_select_1q.jsp?in_sql=" + ls_sql; break 
     case 2 : ds_select1.DataID="erpw/comm_function/comm_select_2q.jsp?in_sql=" + ls_sql; break 
     case 3 : ds_select1.DataID="erpw/comm_function/comm_select_3q.jsp?in_sql=" + ls_sql; break 
     case 4 : ds_select1.DataID="erpw/comm_function/comm_select_4q.jsp?in_sql=" + ls_sql; break 
     case 5 : ds_select1.DataID="erpw/comm_function/comm_select_5q.jsp?in_sql=" + ls_sql; break 
     case 6 : ds_select1.DataID="erpw/comm_function/comm_select_6q.jsp?in_sql=" + ls_sql; break 
     case 7 : ds_select1.DataID="erpw/comm_function/comm_select_7q.jsp?in_sql=" + ls_sql; break 
     case 8 : ds_select1.DataID="erpw/comm_function/comm_select_8q.jsp?in_sql=" + ls_sql; break 
     case 9 : ds_select1.DataID="erpw/comm_function/comm_select_9q.jsp?in_sql=" + ls_sql; break 
     case 10 : ds_select1.DataID="erpw/comm_function/comm_select_10q.jsp?in_sql=" + ls_sql; break 
     }
 ds_select1.SyncLoad = true
 ds_select1.reset()
 ll_cnt = ds_select1.CountRow
 return ll_cnt
}  
//---------------------------------------------------------------------------------
function f_select2_q(ls_sql)
//---------------------------------------------------------------------------------
{
  var i,j,ll_find,ll_from,ls_colcnt,ll_cnt
  ll_find = 0
  ll_from = ls_sql.lastIndexOf("select_")
  for(i=ll_from ; i < ls_sql.length ; i++) {
     if  (ls_sql.substr(i,1) == "_") { 
         for (j=i; j < ls_sql.length ; j++) {
             if (ls_sql.substr(j,1) == " ") {
                 ll_find = 1
                 break
             }    
         }
     }
   if (ll_find == 1) break
  }      
  ls_colcnt = ls_sql.substr(i+1, j-i)
  

  switch(parseInt(ls_colcnt))  
    {
     case 1 : ds_select2.DataID="erpw/comm_function/comm_select_1q.jsp?in_sql=" + ls_sql; break 
     case 2 : ds_select2.DataID="erpw/comm_function/comm_select_2q.jsp?in_sql=" + ls_sql; break 
     case 3 : ds_select2.DataID="erpw/comm_function/comm_select_3q.jsp?in_sql=" + ls_sql; break 
     case 4 : ds_select2.DataID="erpw/comm_function/comm_select_4q.jsp?in_sql=" + ls_sql; break 
     case 5 : ds_select2.DataID="erpw/comm_function/comm_select_5q.jsp?in_sql=" + ls_sql; break 
     case 6 : ds_select2.DataID="erpw/comm_function/comm_select_6q.jsp?in_sql=" + ls_sql; break 
     case 7 : ds_select2.DataID="erpw/comm_function/comm_select_7q.jsp?in_sql=" + ls_sql; break 
     case 8 : ds_select2.DataID="erpw/comm_function/comm_select_8q.jsp?in_sql=" + ls_sql; break 
     case 9 : ds_select2.DataID="erpw/comm_function/comm_select_9q.jsp?in_sql=" + ls_sql; break 
     case 10 : ds_select2.DataID="erpw/comm_function/comm_select_10q.jsp?in_sql=" + ls_sql; break 
     }
 ds_select2.SyncLoad = true
 ds_select2.reset()
 ll_cnt = ds_select2.CountRow
 return ll_cnt
} 
//---------------------------------------------------------------------------------
function f_select3_q(ls_sql)
//---------------------------------------------------------------------------------
{
  var i,j,ll_find,ll_from,ls_colcnt,ll_cnt
  ll_find = 0
  ll_from = ls_sql.lastIndexOf("select_")
  for(i=ll_from ; i < ls_sql.length ; i++) {
     if  (ls_sql.substr(i,1) == "_") { 
         for (j=i; j < ls_sql.length ; j++) {
             if (ls_sql.substr(j,1) == " ") {
                 ll_find = 1
                 break
             }    
         }
     }
   if (ll_find == 1) break
  }      
  ls_colcnt = ls_sql.substr(i+1, j-i)
  

  switch(parseInt(ls_colcnt))  
    {
     case 1 : ds_select3.DataID="erpw/comm_function/comm_select_1q.jsp?in_sql=" + ls_sql; break 
     case 2 : ds_select3.DataID="erpw/comm_function/comm_select_2q.jsp?in_sql=" + ls_sql; break 
     case 3 : ds_select3.DataID="erpw/comm_function/comm_select_3q.jsp?in_sql=" + ls_sql; break 
     case 4 : ds_select3.DataID="erpw/comm_function/comm_select_4q.jsp?in_sql=" + ls_sql; break 
     case 5 : ds_select3.DataID="erpw/comm_function/comm_select_5q.jsp?in_sql=" + ls_sql; break 
     case 6 : ds_select3.DataID="erpw/comm_function/comm_select_6q.jsp?in_sql=" + ls_sql; break 
     case 7 : ds_select3.DataID="erpw/comm_function/comm_select_7q.jsp?in_sql=" + ls_sql; break 
     case 8 : ds_select3.DataID="erpw/comm_function/comm_select_8q.jsp?in_sql=" + ls_sql; break 
     case 9 : ds_select3.DataID="erpw/comm_function/comm_select_9q.jsp?in_sql=" + ls_sql; break 
     case 10 : ds_select3.DataID="erpw/comm_function/comm_select_10q.jsp?in_sql=" + ls_sql; break 
     }
 ds_select3.SyncLoad = true
 ds_select3.reset()
 ll_cnt = ds_select3.CountRow
 return ll_cnt
} 
//---------------------------------------------------------------------------------
function f_close_query(ls_sql)
//---------------------------------------------------------------------------------
{
  var i,j,ll_find,ll_from,ls_colcnt,ll_cnt
  ll_find = 0
  ll_from = ls_sql.lastIndexOf("select_")
  for(i=ll_from ; i < ls_sql.length ; i++) {
     if  (ls_sql.substr(i,1) == "_") { 
         for (j=i; j < ls_sql.length ; j++) {
             if (ls_sql.substr(j,1) == " ") {
                 ll_find = 1
                 break
             }    
         }
     }
   if (ll_find == 1) break
  }      
  ls_colcnt = ls_sql.substr(i+1, j-i)
  

  switch(parseInt(ls_colcnt))  
    {
     case 1 : ds_close_check.DataID="erpw/comm_function/comm_select_1q.jsp?in_sql=" + ls_sql; break 
     case 2 : ds_close_check.DataID="erpw/comm_function/comm_select_2q.jsp?in_sql=" + ls_sql; break 
     case 3 : ds_close_check.DataID="erpw/comm_function/comm_select_3q.jsp?in_sql=" + ls_sql; break 
     case 4 : ds_close_check.DataID="erpw/comm_function/comm_select_4q.jsp?in_sql=" + ls_sql; break 
     case 5 : ds_close_check.DataID="erpw/comm_function/comm_select_5q.jsp?in_sql=" + ls_sql; break 
     case 6 : ds_close_check.DataID="erpw/comm_function/comm_select_6q.jsp?in_sql=" + ls_sql; break 
     case 7 : ds_close_check.DataID="erpw/comm_function/comm_select_7q.jsp?in_sql=" + ls_sql; break 
     case 8 : ds_close_check.DataID="erpw/comm_function/comm_select_8q.jsp?in_sql=" + ls_sql; break 
     case 9 : ds_close_check.DataID="erpw/comm_function/comm_select_9q.jsp?in_sql=" + ls_sql; break 
     case 10 : ds_close_check.DataID="erpw/comm_function/comm_select_10q.jsp?in_sql=" + ls_sql; break 
     }
 ds_close_check.SyncLoad = true
 ds_close_check.reset()
 ll_cnt = ds_close_check.CountRow
 return ll_cnt
} 
//---------------------------------------------------------------------------------
function f_update_sql(ls_sql)     //프로그램에서 막바로 sql문장을 이용하여 update,delete,insert할경우사용
//---------------------------------------------------------------------------------
{
    ds_update.DataID = "erpw/comm_function/comm_update.jsp?arg_cmd=" + ls_sql
    ds_update.SyncLoad = true
    ds_update.reset()
}
//---------------------------------------------------------------------------------
function f_update_sql_multy(ls_sql)     //프로그램에서 막바로 sql문장을 이용하여 update,delete,insert할경우사용(다중 쿼리 작업시 사용)
//---------------------------------------------------------------------------------
{
    ds_update.DataID = "erpw/comm_function/comm_update_multy.jsp?arg_cmd=" + ls_sql
    ds_update.SyncLoad = true
    ds_update.reset()
}
//---------------------------------------------------------------------------
function f_sysdate()                       //현날짜구하기 
//---------------------------------------------------------------------------
{
	var ld_date
	var gs_home1 = top.frames['security'].gs_home.value
	ds_sysdate.DataID = gs_home1 + "/login/z_sysdate_1q.jsp"
	ds_sysdate.SyncLoad = true
	ds_sysdate.reset()
	ld_date = ds_sysdate.namevalue(1,"sysdate1")
	return ld_date
}
//---------------------------------------------------------------------------
function f_dept_code_find(arg_dept)                       //현장 찾기 
//---------------------------------------------------------------------------
{
	var result;
	var array = new Array();
	var gs_home1 = top.frames['security'].gs_home.value
	var is_dept_search_addr = gs_home1 + '/comm_search/z_dept_find_1h.html'
   var is_empno = top.frames['security'].empno.value
   
	result = window.showModalDialog(is_dept_search_addr,gs_home1 + "@" + arg_dept + "@" + is_empno,"dialogWidth:500px;dialogHeight:500px");
	
	if(result == "") return false;

	array = result.split("@");
	top.frames['security'].gs_dept_code.value=array[0]
	top.frames['security'].gs_comp_code.value=array[1];
	top.frames['security'].gs_comp_name.value=array[2];
	top.frames['security'].gs_dept_name.value=array[4];
	top.frames['security'].gs_dept_proj_tag.value=array[5];
	top.frames['security'].gs_use_tag.value=array[6];
	return true
}     
//---------------------------------------------------------------------------
function f_crystal_report(arg_var)                       //크리스탈보고서 오픈 
//---------------------------------------------------------------------------
{ 
	var result
	var crystal_rpt
	crystal_rpt = top.frames['security'].gs_crystal_addr.value + arg_var
	result = window.showModalDialog(crystal_rpt,"11","dialogWidth:1024px;dialogHeight:768px")
	return true
}
//---------------------------------------------------------------------------
function f_hdept_code_find(arg_dept)                       //현장 찾기 (분양현장)
//---------------------------------------------------------------------------
{
	var result;
	var array = new Array();
	var gs_home1 = top.frames['security'].gs_home.value
	var is_dept_search_addr = gs_home1 + '/general/h_web/00/h_code_house_find_1h.html'

	result = window.showModalDialog(is_dept_search_addr,gs_home1 + "@" + arg_dept,"dialogWidth:500px;dialogHeight:500px");
	
	if(result == "") return false;

	array = result.split("@");
	top.frames['security'].gs_dept_code.value=array[0]
	top.frames['security'].gs_dept_name.value=array[1];
	top.frames['security'].gs_sell_code.value=array[2];
	top.frames['security'].gs_sell_name.value=array[3];
	return true
}     
//----------------------------------------------------------------------
function f_close_chk(arg_dept,arg_date,arg_gubun)   // 각단위업무마감여부 체크(현장코드,년월,업무구분)
//----------------------------------------------------------------------
{
	var ll_cnt
	var ls_date,ls_m,ls_l,ls_q,ls_s,ls_f

	ls_date = arg_date.substr(0,7) + '.01';
	
	ll_cnt = f_close_query("select m_close select_1,l_close select_2,q_close select_3,s_close select_4," +
	                    "       f_close select5 " +
	                    "from c_spec_const_closing where dept_code = " + "'" + arg_dept + "'" +
	                    " and yymm = " + "'" + ls_date + "'")

	if ( ll_cnt < 1 ) {
		return true
	}	
	ls_m = ds_close_check.NameValue(ds_close_check.RowPosition,"select_1")
	ls_l = ds_close_check.NameValue(ds_close_check.RowPosition,"select_2")
	ls_q = ds_close_check.NameValue(ds_close_check.RowPosition,"select_3")
	ls_s = ds_close_check.NameValue(ds_close_check.RowPosition,"select_4")
	ls_f = ds_close_check.NameValue(ds_close_check.RowPosition,"select_5")
	
	switch(arg_gubun)  
	{
		case 'M' : 
			if ( ls_m == 'Y' ) {
				return true
			}
			else {
				return false
			}
			; break 
		case 'L' :
			if ( ls_l == 'Y' ) {
				return true
			}
			else {
				return false
			}
			; break 
		case 'Q' :
			if ( ls_q == 'Y' ) {
				return true
			}
			else {
				return false
			}
			; break 
		case 'S' :
			if ( ls_s == 'Y' ) {
				return true
			}
			else {
				return false
			}
			; break 
		case 'E' :
			if ( ls_f == 'Y' ) {
				return true
			}
			else {
				return false
			}
			; break 

	}
}
//----------------------------------------------------------------------
function f_process(arg_gubun)   // 프로세스의 여부값을 Return한다(arg_gubun=프로세스코드)
//----------------------------------------------------------------------
{
	var ll_cnt,ls_tag
	
   ds_process.DataID = 'erpw/comm_function/z_process_read_1q.jsp?arg_code=' + arg_gubun
   ds_process.SyncLoad=true
   ds_process.reset() 
	
	if ( ds_process.CountRow < 1 ) {
		return 'N'
	}	
	ls_tag = ds_process.NameValue(ds_process.RowPosition,"process_tag")
	return ls_tag
}
//----------------------------------------------------------------------
function f_report_log(arg_remark)   // 보고서 출력시 로깅하는 function
//----------------------------------------------------------------------
{
	//    login status    기록 시작.......................
	   var ll_cnt
      ll_cnt = f_select3_q("select sysdate  select_1  from dual")    // system datetime가져오기 
      
      ds_login_status.DataID = 'erpw/login/m_login_status_1q.jsp?arg_seq_key=0'
      ds_login_status.SyncLoad=true
      ds_login_status.reset() 
      ds_login_status.AddRow()
      
      ds_login_status.NameValue(ds_login_status.RowPosition,"ip_address") = top.frames['security'].gs_ip_addr.value
      ds_login_status.NameValue(ds_login_status.RowPosition,"start_time") = ds_select3.NameValue(1,"select_1")
      
      ds_report_seq.DataID = 'erpw/login/m_unq_num_1q.jsp'
      ds_report_seq.SyncLoad=true;             // seq no 구하기
      ds_report_seq.reset()
      
      ds_login_status.NameValue(ds_login_status.RowPosition,"seq_key") = ds_report_seq.NameValue(1,"nextval") 
      ds_login_status.NameValue(ds_login_status.RowPosition,"log_tag") = '3'
      ds_login_status.NameValue(ds_login_status.RowPosition,"user_id") = top.frames['security'].user_id.value     
      ds_login_status.NameValue(ds_login_status.RowPosition,"empno") = top.frames['security'].empno.value     
      ds_login_status.NameValue(ds_login_status.RowPosition,"name") = top.frames['security'].gs_name.value     
      ds_login_status.NameValue(ds_login_status.RowPosition,"dept_code") = top.frames['security'].dept_code.value     
      ds_login_status.NameValue(ds_login_status.RowPosition,"long_name") = top.frames['security'].short_name.value     
      ds_login_status.NameValue(ds_login_status.RowPosition,"remarks") = arg_remark

      tr_log.Action = 'erpw/login/m_login_status_1tr.jsp'
      tr_log.Post()

}
//--------------------------------------------------------------------
function groval_chkKey(evt) 
//--------------------------------------------------------------------------	
 {
	var mykey, alt, ctrl, shift,aa,bb,ll_security;
	if (window.Event) {
		mykey = evt.which;
		alt = (evt.modifiers & Event.ALT_MASK) ? true : false;
		ctrl = (evt.modifiers & Event.CTRL_MASK) ? true : false;
	} else {
		mykey = evt.keyCode;
		alt = evt.altKey;
		ctrl = evt.ctrlKey;
	}
  if( (evt.ctrlKey == true && (evt.keyCode == 78 || evt.keyCode == 82))  ||
        (evt.keyCode >= 112 && evt.keyCode <= 123)) //  || evt.keyCode == 8)
            {
        evt.keyCode = 0;
        evt.cancelBubble = true;
        evt.returnValue = false;
        return 
            }
	if (mykey!=18) {
		if (alt) {
         aa = top.frames['main_ct'].location.href
         bb = aa.indexOf("?") + 1 
         ll_security  = aa.substr(bb,1)

//         if  (ll_security == "r") {
         if (top.frames['main_title'].div_r.style.visibility == "visible") { 
             if (evt.keyCode == 82)   //조회
                top.frames['main_ct'].btnquery_onclick()
             return   
         }  
//         if (ll_security == "u") {
         if (top.frames['main_title'].div_u.style.visibility == "visible") {             

             if (evt.keyCode == 82)   //조회 
                top.frames['main_ct'].btnquery_onclick()
             if (evt.keyCode == 65)  // 추가
                top.frames['main_ct'].btnadd_onclick()
             if (evt.keyCode == 73)  // 삽입
                top.frames['main_ct'].btninsert_onclick()
             if (evt.keyCode == 68) {  // 삭제
                top.frames['main_ct'].btndelete_onclick()
                return
             }
             if (evt.keyCode == 83)  // 저장
                top.frames['main_ct'].btnsave_onclick()
             if (evt.keyCode == 90)  // 취소 
                top.frames['main_ct'].btncancel_onclick()
             return   
          }  
//          if (ll_security == "p") {
            if (top.frames['main_title'].div_p.style.visibility == "visible") {

             if (evt.keyCode == 82)   //조회 
                top.frames['main_ct'].btnquery_prt_onclick()
             if (evt.keyCode == 80)  // 출력 
                top.frames['main_ct'].btnprint_onclick()
             return   
          }  
//          if (ll_security == "s") {
            if (top.frames['main_title'].div_s.style.visibility == "visible") {

             if (evt.keyCode == 82)   //조회 
                top.frames['main_ct'].btnquery_onclick()
             if (evt.keyCode == 83)  // 저장
                top.frames['main_ct'].btnsave_onclick()
             if (evt.keyCode == 90)  // 취소 
                top.frames['main_ct'].btncancel_onclick()
             return   
          }
		}
	}
}

if (window.Event) {
	document.captureEvents(Event.KEYDOWN);
	document.onkeydown = groval_chkKey;
} else {
	document.onkeydown = function() {
		return groval_chkKey(event);
	}
}

//----------------------------------------------------------------------------
function f_dup_chk(arg_ds,arg_col)                     // dup chk
//---------------------------------------------------------------------------- 
{
  // arg_ds = 'ds_1'   dataset 명
  // arg_col = "colid_1@colid_2")
  // return값이 0보다 크면 return값이 dup된 row값이며 0이며는 dup이 없슴 
 var sa_key,after_sa_key,result
 var ll_count,ll_start_1,ll_start_2,ll_dup,ll_loop,ls_status
 var array = new Array();

 eval("ll_count = " + arg_ds + ".CountRow")

 array = arg_col.split("@");

 for (ll_start_1 =1 ; ll_start_1 <= ll_count; ll_start_1++) {
    eval ( "ls_status = " + arg_ds + ".SysStatus(" + ll_start_1 + ")")  
    if (ls_status == 0) continue
    sa_key = "" 
    for (ll_loop=0; ll_loop < array.length; ll_loop++)  {
         eval("sa_key = sa_key + " + arg_ds + ".NameValue(ll_start_1,'" + array[ll_loop] + "')") 
    }
    if (sa_key == "") return ll_start_1
    for (ll_start_2 = 1; ll_start_2 <= ll_count; ll_start_2++) {
      if (ll_start_1 == ll_start_2) continue
       after_sa_key = ""
	    for (ll_loop=0; ll_loop < array.length; ll_loop++)  {
	         eval("after_sa_key = after_sa_key + " + arg_ds + ".NameValue(ll_start_2,'" + array[ll_loop] + "')") 
       }
       if (after_sa_key == "") return ll_start_1
       if (sa_key == after_sa_key) 
           return ll_start_1   	   	  
    }
 }
 return 0 
}
//----------------------------------------------------------------------------
function f_reject_window()                    // 막바로 주소를 입력하였을경우 
//---------------------------------------------------------------------------- 
{
  if  ((document.referrer == "") || (top.frames['security']== null)) {
		self.opener=self;
		self.close();
      return true 
   }
   else { 
     var ls_was
	  if (top.frames['security'].gs_tomcat_addr == null)
         ls_was = ""
     else 
         ls_was = top.frames['security'].gs_tomcat_addr.value 
     if (ls_was != document.referrer.substr(0,ls_was.length)) {
		   self.opener=self;
		   self.close();
         return true 
     }
   }
 return false
}
//----------------------------------------------------------------------------
function f_check_date(string_date)                    // 날자의 Valid 를 체크한다.
//----------------------------------------------------------------------------
{  
  var input = string_date.replace(/-/g,"");
  var inputYear = input.substr(0,4);
  var inputMonth = input.substr(4,2) - 1;
  var inputDate = input.substr(6,2);
  var resultDate = new Date(inputYear, inputMonth, inputDate);
  if ( resultDate.getFullYear() != inputYear ||
       resultDate.getMonth() != inputMonth ||
       resultDate.getDate() != inputDate) {
    	 return false
  }
  else {
  	return true
  }
}