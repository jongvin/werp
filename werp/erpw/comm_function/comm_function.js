var MOUSE_OVER="#FF0000";
var MOUSE_OUT="#000000";

//----------------------------------------------------------------
function makeCookie(name, value)  // 쿠키 생성
//----------------------------------------------------------------
{
   var temp,temp1
   temp = gs_conv_function(name)
   temp1 = value
   if (value == "") 
       temp1 = "err"
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate()+300);
          document.cookie =  temp + "=" + escape(temp1) + "; path=/; expires=" + todayDate.toGMTString() + ";"

   makeCookie_session()
//          + ( (expire) ? "; expires=" + expire.toGMTString() : "")
}
//---------------------------------------------------------------------
function readCookie(uName)       // 쿠키 조회
//---------------------------------------------------------------------
{
	var end,temp
   temp = gs_conv_function(uName)
	var flag = document.cookie.indexOf(temp+'=');
	if (flag == -1) return "err"
	if (flag != -1) { 
		flag += temp.length + 1
		end = document.cookie.indexOf(';', flag) 

		if (end == -1) end = document.cookie.length
		return unescape(document.cookie.substring(flag, end))
	}
}
//----------------------------------------------------------------------
function gs_conv_function(name)   // 쿠키명에 @을 *로 conversion함
//----------------------------------------------------------------------
{
  var temp_len,i,temp
  temp = ""
  for (i=0; i< name.length; i++)
      if (name.substr(i,1) == '@') 
          temp = temp + '*'
      else
          temp = temp + name.substr(i,1)
  return temp
}
//----------------------------------------------------------------
function makeCookie_session()  // 쿠키 생성
//----------------------------------------------------------------
{
   var temp
   temp = readCookie("JSESSIONID")
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate()+300);
          document.cookie =  "JSESSIONID" + "=" + temp + "; path=/; expires=" + todayDate.toGMTString() + ";"

}
//----------------------------------------------------------------------
function clearCookie()   // clear 쿠키 
//----------------------------------------------------------------------
{ 
//  document.cookie="username=;expires=Sun Apr 16 00:00:01 GMT 1999" 
//  alert("Your cookie has been deleted!") 
    var cookieName,thisCookie
	    if (document.cookie != "") {
	    		thisCookie = document.cookie.split("; ")
	    	    var expireDate = new Date
	    	    expireDate.setDate(expireDate.getDate()-1000)
	    	    for (i=0; i<thisCookie.length; i++) {
	    	        cookieName = thisCookie[i].split("=")[0]
//                 alert(cookieName+expireDate.toGMTString())
                 if (cookieName != "*g_code_dept*")
	    	           document.cookie = cookieName + "=;expires=" + expireDate.toGMTString() + ";"
	    	    }
	    }
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
function f_ds_select_q(ls_ds,ls_sql)
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
  
//         eval("sa_key = sa_key + " + arg_ds + ".NameValue(ll_start_1,'" + array[ll_loop] + "')") 
  i = parseInt(ls_colcnt,10)
  var lls_sql = ls_sql
  lls_sql = lls_sql.replace(/\+/g,'!')
  eval(ls_ds + '.DataID="/werp/erpw/comm_function/comm_select_' + i + 'q.jsp?in_sql=' + lls_sql + '"')
  eval(ls_ds + ".SyncLoad = true")
  eval(ls_ds + ".reset()")
  eval("ll_cnt = " + ls_ds + ".CountRow")
  return ll_cnt
}  
//------------------------------------------------------------------------------
function f_ds_ds_select_q(ls_ds,ls_sql)
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
  
//         eval("sa_key = sa_key + " + arg_ds + ".NameValue(ll_start_1,'" + array[ll_loop] + "')") 
  i = parseInt(ls_colcnt,10)
  var lls_sql = ls_sql
  lls_sql = lls_sql.replace(/\+/g,'!')
  eval(ls_ds + '.DataID="/werp/erpw/comm_function/comm_select_' + i + 'q.jsp?in_sql=' + lls_sql + '"')
  eval(ls_ds + ".SyncLoad = true")
  eval(ls_ds + ".reset()")
  eval("ll_cnt = " + ls_ds + ".CountRow")
  return ll_cnt
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
  
  var lls_sql = ls_sql
  lls_sql = lls_sql.replace(/\+/g,'!')


  switch(parseInt(ls_colcnt))  
    {
     case 1 : ds_select.DataID="/werp/erpw/comm_function/comm_select_1q.jsp?in_sql=" + lls_sql; break 
     case 2 : ds_select.DataID="/werp/erpw/comm_function/comm_select_2q.jsp?in_sql=" + lls_sql; break 
     case 3 : ds_select.DataID="/werp/erpw/comm_function/comm_select_3q.jsp?in_sql=" + lls_sql; break 
     case 4 : ds_select.DataID="/werp/erpw/comm_function/comm_select_4q.jsp?in_sql=" + lls_sql; break 
     case 5 : ds_select.DataID="/werp/erpw/comm_function/comm_select_5q.jsp?in_sql=" + lls_sql; break 
     case 6 : ds_select.DataID="/werp/erpw/comm_function/comm_select_6q.jsp?in_sql=" + lls_sql; break 
     case 7 : ds_select.DataID="/werp/erpw/comm_function/comm_select_7q.jsp?in_sql=" + lls_sql; break 
     case 8 : ds_select.DataID="/werp/erpw/comm_function/comm_select_8q.jsp?in_sql=" + lls_sql; break 
     case 9 : ds_select.DataID="/werp/erpw/comm_function/comm_select_9q.jsp?in_sql=" + lls_sql; break 
     case 10 : ds_select.DataID="/werp/erpw/comm_function/comm_select_10q.jsp?in_sql=" + lls_sql; break 
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
  var lls_sql = ls_sql
  lls_sql = lls_sql.replace(/\+/g,'!')

  
  switch(parseInt(ls_colcnt))  
    {
     case 1 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_1q.jsp?in_sql=" + lls_sql; break 
     case 2 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_2q.jsp?in_sql=" + lls_sql; break 
     case 3 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_3q.jsp?in_sql=" + lls_sql; break 
     case 4 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_4q.jsp?in_sql=" + lls_sql; break 
     case 5 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_5q.jsp?in_sql=" + lls_sql; break 
     case 6 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_6q.jsp?in_sql=" + lls_sql; break 
     case 7 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_7q.jsp?in_sql=" + lls_sql; break 
     case 8 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_8q.jsp?in_sql=" + lls_sql; break 
     case 9 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_9q.jsp?in_sql=" + lls_sql; break 
     case 10 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_10q.jsp?in_sql=" + lls_sql; break 
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
  var lls_sql = ls_sql
  lls_sql = lls_sql.replace(/\+/g,'!')

  switch(parseInt(ls_colcnt))  
    {
     case 1 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_1q.jsp?in_sql=" + lls_sql; break 
     case 2 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_2q.jsp?in_sql=" + lls_sql; break 
     case 3 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_3q.jsp?in_sql=" + lls_sql; break 
     case 4 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_4q.jsp?in_sql=" + lls_sql; break 
     case 5 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_5q.jsp?in_sql=" + lls_sql; break 
     case 6 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_6q.jsp?in_sql=" + lls_sql; break 
     case 7 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_7q.jsp?in_sql=" + lls_sql; break 
     case 8 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_8q.jsp?in_sql=" + lls_sql; break 
     case 9 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_9q.jsp?in_sql=" + lls_sql; break 
     case 10 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_10q.jsp?in_sql=" + lls_sql; break 
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
  var lls_sql = ls_sql
  lls_sql = lls_sql.replace(/\+/g,'!')

  

  switch(parseInt(ls_colcnt))  
    {
     case 1 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_1q.jsp?in_sql=" + lls_sql; break 
     case 2 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_2q.jsp?in_sql=" + lls_sql; break 
     case 3 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_3q.jsp?in_sql=" + lls_sql; break 
     case 4 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_4q.jsp?in_sql=" + lls_sql; break 
     case 5 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_5q.jsp?in_sql=" + lls_sql; break 
     case 6 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_6q.jsp?in_sql=" + lls_sql; break 
     case 7 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_7q.jsp?in_sql=" + lls_sql; break 
     case 8 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_8q.jsp?in_sql=" + lls_sql; break 
     case 9 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_9q.jsp?in_sql=" + lls_sql; break 
     case 10 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_10q.jsp?in_sql=" + lls_sql; break 
     }
 ds_select3.SyncLoad = true
 ds_select3.reset()
 ll_cnt = ds_select3.CountRow
 return ll_cnt
} 
 //---------------------------------------------------------------------------------
function f_select10_q(ls_sql)
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
  var lls_sql = ls_sql
  lls_sql = lls_sql.replace(/\+/g,'!')


  switch(parseInt(ls_colcnt))  
    {
     case 1 : ds_select10.DataID="/werp/erpw/comm_function/comm_select_1q.jsp?in_sql=" + lls_sql; break 
     case 2 : ds_select10.DataID="/werp/erpw/comm_function/comm_select_2q.jsp?in_sql=" + lls_sql; break 
     case 3 : ds_select10.DataID="/werp/erpw/comm_function/comm_select_3q.jsp?in_sql=" + lls_sql; break 
     case 4 : ds_select10.DataID="/werp/erpw/comm_function/comm_select_4q.jsp?in_sql=" + lls_sql; break 
     case 5 : ds_select10.DataID="/werp/erpw/comm_function/comm_select_5q.jsp?in_sql=" + lls_sql; break 
     case 6 : ds_select10.DataID="/werp/erpw/comm_function/comm_select_6q.jsp?in_sql=" + lls_sql; break 
     case 7 : ds_select10.DataID="/werp/erpw/comm_function/comm_select_7q.jsp?in_sql=" + lls_sql; break 
     case 8 : ds_select10.DataID="/werp/erpw/comm_function/comm_select_8q.jsp?in_sql=" + lls_sql; break 
     case 9 : ds_select10.DataID="/werp/erpw/comm_function/comm_select_9q.jsp?in_sql=" + lls_sql; break 
     case 10 : ds_select10.DataID="/werp/erpw/comm_function/comm_select_10q.jsp?in_sql=" + lls_sql; break 
     }
 ds_select10.SyncLoad = true
 ds_select10.reset()
 ll_cnt = ds_select10.CountRow
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
  var lls_sql = ls_sql
  lls_sql = lls_sql.replace(/\+/g,'!')

  switch(parseInt(ls_colcnt))  
    {
     case 1 : ds_close_check.DataID="/werp/erpw/comm_function/comm_select_1q.jsp?in_sql=" + lls_sql; break 
     case 2 : ds_close_check.DataID="/werp/erpw/comm_function/comm_select_2q.jsp?in_sql=" + lls_sql; break 
     case 3 : ds_close_check.DataID="/werp/erpw/comm_function/comm_select_3q.jsp?in_sql=" + lls_sql; break 
     case 4 : ds_close_check.DataID="/werp/erpw/comm_function/comm_select_4q.jsp?in_sql=" + lls_sql; break 
     case 5 : ds_close_check.DataID="/werp/erpw/comm_function/comm_select_5q.jsp?in_sql=" + lls_sql; break 
     case 6 : ds_close_check.DataID="/werp/erpw/comm_function/comm_select_6q.jsp?in_sql=" + lls_sql; break 
     case 7 : ds_close_check.DataID="/werp/erpw/comm_function/comm_select_7q.jsp?in_sql=" + lls_sql; break 
     case 8 : ds_close_check.DataID="/werp/erpw/comm_function/comm_select_8q.jsp?in_sql=" + lls_sql; break 
     case 9 : ds_close_check.DataID="/werp/erpw/comm_function/comm_select_9q.jsp?in_sql=" + lls_sql; break 
     case 10 : ds_close_check.DataID="/werp/erpw/comm_function/comm_select_10q.jsp?in_sql=" + lls_sql; break 
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
	var lls_sql = ls_sql
	  lls_sql = lls_sql.replace(/\+/g,'!')
    ds_update.DataID = "/werp/erpw/comm_function/comm_update.jsp?arg_cmd=" + lls_sql
    ds_update.SyncLoad = true
    ds_update.reset()
}
//---------------------------------------------------------------------------------
function f_update_mssql(ls_sql)     //프로그램에서 막바로 sql문장을 이용하여 update,delete,insert할경우사용
//---------------------------------------------------------------------------------
{
	var lls_sql = ls_sql
	  lls_sql = lls_sql.replace(/\+/g,'!')
    ds_update.DataID = "/werp/erpw/comm_function/comm_update_mssql.jsp?arg_cmd=" + lls_sql
    ds_update.SyncLoad = true
    ds_update.reset()
}

//---------------------------------------------------------------------------------
function gf_mail_to(tran_sender_id,tran_callback,tran_id,tran_phone,tran_msg)     // sms 메세지 보내기 
//---------------------------------------------------------------------------------
{
	// gf_mail_to('박두현','0113878587','장희선','01197927939','행복하세요')
	// ds_update   dataset정의 요망.  

	// tran_sender_id : 보내는 사람 이름
	// tran_callback : 보내는 사람 전화번호
	// tran_id        : 받는사람 이름
	// tran_phone     : 받는사람 전화번호
	// tran_msg       : 메세지 
	var lls_tran_msg = tran_msg
	  lls_tran_msg = lls_tran_msg.replace(/\+/g,'!')
	var arg_cmd 
	   arg_cmd = "insert into SMSUSER.em_tran ( tran_callback,tran_id, tran_phone, tran_msg, tran_status, tran_date, tran_type) " +  
            " VALUES ( " + 
            " '" + tran_callback + "', " +  
            " '" + tran_id + "', " +  
            " '" + tran_phone + "', " +  
            " '" + lls_tran_msg + "', " +  
            " '1',  " +  
            "  getdate(), " + 
            "  '0'  " + 
            "       )"
    ds_update.DataID = "/werp/erpw/comm_function/comm_mail_to.jsp?arg_cmd=" + arg_cmd
    ds_update.SyncLoad = true
    ds_update.reset()
	   arg_cmd = "insert into SMSUSER.em_tran_worldro (sender_id, tran_callback,tran_id, tran_phone, tran_msg, tran_status, tran_date, tran_type) " +  
            " VALUES ( " + 
            " '" + tran_sender_id + "', " +  
            " '" + tran_callback + "', " +  
            " '" + tran_id + "', " +  
            " '" + tran_phone + "', " +  
            " '" + lls_tran_msg + "', " +  
            " '1',  " +  
            "  getdate(), " + 
            "  '0'  " + 
            "       )"
    ds_update.DataID = "/werp/erpw/comm_function/comm_mail_to.jsp?arg_cmd=" + arg_cmd
    ds_update.SyncLoad = true
    ds_update.reset()
}
//---------------------------------------------------------------------------------
function f_update_sql_multy(ls_sql)     //프로그램에서 막바로 sql문장을 이용하여 update,delete,insert할경우사용(다중 쿼리 작업시 사용)
//---------------------------------------------------------------------------------
{
	var lls_sql = ls_sql
	  lls_sql = lls_sql.replace(/\+/g,'!')
     ds_update.DataID = "/werp/erpw/comm_function/comm_update_multy.jsp?arg_cmd=" + lls_sql
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
function f_sysdatetime()                       //현날짜/시간구하기 
//---------------------------------------------------------------------------
{
	var ld_date
	var gs_home1 = top.frames['security'].gs_home.value
	ds_sysdate.DataID = gs_home1 + "/login/z_sysdate_mi_seq_1q.jsp"
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
   var is_userid = top.frames['security'].user_id.value
   
	result = window.showModalDialog(is_dept_search_addr,gs_home1 + "@" + arg_dept + "@" + is_empno + "@" + is_userid,"dialogWidth:500px;dialogHeight:500px");
	
	if(result == "") return false;

	array = result.split("@");
	top.frames['security'].gs_dept_code.value=array[0]
	top.frames['security'].gs_comp_code.value=array[1];
	top.frames['security'].gs_comp_name.value=array[2];
	top.frames['security'].gs_dept_name.value=array[4];
	top.frames['security'].gs_dept_proj_tag.value=array[5];
	top.frames['security'].gs_use_tag.value=array[6];
	top.frames['security'].gs_degree.value=array[7];
	return true
}     
//---------------------------------------------------------------------------
function f_dept_code_find_all(arg_dept)                       //전체 부서 찾기 
//---------------------------------------------------------------------------
{
	var result;
	var array = new Array();
	var gs_home1 = top.frames['security'].gs_home.value
	var is_dept_search_addr = gs_home1 + '/comm_search/z_dept_find_all_1h.html'
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
	top.frames['security'].gs_degree.value=array[7];
	return true
}     
//---------------------------------------------------------------------------
function f_crystal_report(arg_var)                       //크리스탈보고서 오픈 
//---------------------------------------------------------------------------
{ 
	var result
	var crystal_rpt
	var arg_temp
	var w, h

	var argArray = new Array();
	var re, re2, re3;
	var rtnValue = "";

	re  = /&RptParams/gi;
	re2 = /&/gi;
	re3 = /,/gi;

	argArray = arg_var.split(re);

	if (argArray.length >= 1) {
		rtnValue = rtnValue + argArray[0]
		for (var i = 2;argArray.length >= i; i++) {
			rtnValue = rtnValue + "&RptParams" + (argArray[i - 1].replace(re2,"%26")).replace(re3,"%3B"); //, 는 ;로 바꿔보냄 asp쪽에서 다시 ;=> , 변경함
		}
	}

	arg_temp = "Rptname=" + rtnValue

	//arg_temp = "Rptname=" + arg_var
	if (top.frames['security'] == null)
		crystal_rpt = arg_var
	else {   
		crystal_rpt = top.frames['security'].gs_crystal_addr.value + 
		//                 "db_user=" + top.frames['security'].gs_crystal_user.value + 
		//                 "&db_password=" +  top.frames['security'].gs_crystal_password.value +
		arg_temp 
	}                 
	h = screen.availHeight  - 20
	w = screen.availWidth - 10

	//result = window.open(crystal_rpt,"11","height=760px,width=1000px,left=0,top=0,resizable=1,status=0,location= 0, menubar=0 ")
	
	
	result = window.open(crystal_rpt,'',"height="+h+",width="+w +",left=0,top=0,resizable=1,status=0")
	//result = window.showModalDialog(crystal_rpt,'',"height="+h+",width="+w +",left=0,top=0,resizable=1,status=0")

	//alert(crystal_rpt)
	//result = window.showModalDialog(crystal_rpt,"11","dialogWidth:1024px;dialogHeight:768px;resizable=1;status=0")
	//result = window.showModalDialog(crystal_rpt,"11","dialogWidth:"+w+";dialogHeight:"+h+";resizable=1;status=0")
	return true
}
function f_crystal_report2(arg_var)                       //크리스탈보고서 오픈 
//---------------------------------------------------------------------------
{ 
	var result
	var crystal_rpt
	var arg_temp
	var w, h

	var argArray = new Array();
	var re, re2, re3;
	var rtnValue = "";

	re  = /&RptParams/gi;
	re2 = /&/gi;
	re3 = /,/gi;

	argArray = arg_var.split(re);

	if (argArray.length >= 1) {
		rtnValue = rtnValue + argArray[0]
		for (var i = 2;argArray.length >= i; i++) {
			rtnValue = rtnValue + "&RptParams" + (argArray[i - 1].replace(re2,"%26")).replace(re3,"%3B"); //, 는 ;로 바꿔보냄 asp쪽에서 다시 ;=> , 변경함
		}
	}

	arg_temp = "Rptname=" + rtnValue

	//arg_temp = "Rptname=" + arg_var
	if (top.frames['security'] == null)
		crystal_rpt = arg_var
	else {   
		crystal_rpt = top.frames['security'].gs_crystal_addr.value + 
		//                 "db_user=" + top.frames['security'].gs_crystal_user.value + 
		//                 "&db_password=" +  top.frames['security'].gs_crystal_password.value +
		arg_temp 
	}                 
	h = screen.availHeight  - 20
	w = screen.availWidth - 10

	//result = window.open(crystal_rpt,"11","height=760px,width=1000px,left=0,top=0,resizable=1,status=0,location= 0, menubar=0 ")
	
	
	result = window.open(crystal_rpt,'',"height="+h+",width="+w +",left=0,top=0,resizable=1,status=0")
	//result = window.showModalDialog(crystal_rpt,'',"height="+h+",width="+w +",left=0,top=0,resizable=1,status=0")

	//alert(crystal_rpt)
	//result = window.showModalDialog(crystal_rpt,"11","dialogWidth:1024px;dialogHeight:768px;resizable=1;status=0")
	//result = window.showModalDialog(crystal_rpt,"11","dialogWidth:"+w+";dialogHeight:"+h+";resizable=1;status=0")
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
	var is_empno = top.frames['security'].empno.value
	
	result = window.showModalDialog(is_dept_search_addr,gs_home1 + "@" + arg_dept+ "@" + is_empno,"dialogWidth:500px;dialogHeight:500px");
	
	if(result == "") return false;

	array = result.split("@");
	top.frames['security'].gs_dept_code.value=array[0]
	top.frames['security'].gs_dept_name.value=array[1];
	top.frames['security'].gs_sell_code.value=array[2];
	top.frames['security'].gs_sell_name.value=array[3];
	return true
}
//--------------------------------------------- 분양 영수증 번호 생성 및 logging
function f_h_receive_print(arg_dept, arg_sell, arg_dongho, arg_cust, arg_date, arg_amt,  arg_id, arg_remarks)   
//---------------------------------------------------------------------------
{
	var ll_receive_no, ll_from_no, ll_to_no
	var ls_temp, ll_t


	ls_temp = arg_date.substr(3, 1) + arg_date.substr(5, 2)
	ll_from_no = parseInt(ls_temp + '0000')
	ll_to_no   = parseInt(ls_temp + '9999')

	for (i=1; i<=20; i++) 
	{

		ll_cnt = f_select10_q("select count(*) select_1  from h_receive_print  where receive_no between + " + ll_from_no + " and " + ll_to_no)   
		if (ll_cnt > 0)  {
			ls_temp = ds_select10.NameValue(1,'select_1')
			if (ls_temp == 0)
				ll_receive_no = ll_from_no
			else  {
				ll_cnt = f_select10_q("select max(nvl(receive_no, '0')) select_1  from h_receive_print  where receive_no between + " + ll_from_no + " and " + ll_to_no)   
				if (ll_cnt > 0)  
					ll_receive_no = parseInt(ds_select10.NameValue(1,'select_1'))
			}
		}
		else {
			ll_receive_no = ll_from_no	
		}
		
		ll_receive_no++
		
		arg_cmd = " insert into h_receive_print " +   
	   			 "   values (" + ll_receive_no + ", " + 
	   			 " '" + arg_dept + "' , " +  
	   			 " '" + arg_sell + "' , " +  
	   			 " '" + arg_dongho + "' , "  + 
	   			 " '" + arg_cust + "' , "  + 
	   			 " '" + arg_date + "' , " + arg_amt + " , "  + 
	   			 " sysdate, "  + 
	   			 " '" + arg_id + "' , " + 
	   			 " '" + arg_remarks + "' ) " 
		is_update_ok = 0
		f_update_receive_print_sql(arg_cmd)
		
		if (is_update_ok == 0) {
			return  ll_receive_no   // 정상
		}
		else 
		{
			ll_receive_no = 0       // error
		}
		
	}  

	return ll_receive_no + '@' + ls_remarks
}     

//---------------------------------------------------------------------------------
function f_update_receive_print_sql(ls_sql)     //프로그램에서 막바로 sql문장을 이용하여 update,delete,insert할경우사용
//---------------------------------------------------------------------------------
{   
	var lls_sql = ls_sql
	  lls_sql = lls_sql.replace(/\+/g,'!')
    ds_update10.DataID = "/werp/erpw/comm_function/comm_update.jsp?arg_cmd=" + lls_sql
    ds_update10.SyncLoad = true
    ds_update10.reset()
}

//----------------------------------------------------------------------
function f_close_chk(arg_dept,arg_date,arg_gubun)   // 각단위업무마감여부 체크(현장코드,년월,업무구분)
//----------------------------------------------------------------------
{
	var ll_cnt
	var ls_date,ls_temp,ls_m,ls_l,ls_q,ls_s,ls_f,ls_c

	if (arg_date.length == 8) {
		ls_temp = arg_date.substr(0, 4) + '.' + 
					 arg_date.substr(4, 2) + '.' + 
					 arg_date.substr(6, 2)
	}
	else {
		ls_temp = arg_date
	}

	ls_date = ls_temp.substr(0,7) + '.01';
	
	ll_cnt = f_close_query("select m_close select_1,l_close select_2,q_close select_3,s_close select_4," +
	                    "       f_close select_5,cost_close select_6 " +
	                    "from c_spec_const_closing where dept_code = " + "'" + arg_dept + "'" +
	                    " and yymm = " + "'" + ls_date + "'")
	if ( ll_cnt < 1 ) {
		return false
	}	
	ls_m = ds_close_check.NameValue(ds_close_check.RowPosition,"select_1")
	ls_l = ds_close_check.NameValue(ds_close_check.RowPosition,"select_2")
	ls_q = ds_close_check.NameValue(ds_close_check.RowPosition,"select_3")
	ls_s = ds_close_check.NameValue(ds_close_check.RowPosition,"select_4")
	ls_f = ds_close_check.NameValue(ds_close_check.RowPosition,"select_5")
	ls_c = ds_close_check.NameValue(ds_close_check.RowPosition,"select_6")
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
		case 'C' :
			if ( ls_c == 'Y' ) {
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
	
   ds_process.DataID = '/werp/erpw/comm_function/z_process_read_1q.jsp?arg_code=' + arg_gubun
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
      ll_cnt = f_ds_select_q("ds_login_date","select sysdate  select_1  from dual")    // system datetime가져오기 
      
      ds_login_status.DataID = '/werp/erpw/login/m_login_status_1q.jsp?arg_seq_key=0'
      ds_login_status.SyncLoad=true
      ds_login_status.reset() 
      ds_login_status.AddRow()
      
      ds_login_status.NameValue(ds_login_status.RowPosition,"ip_address") = top.frames['security'].gs_ip_addr.value
      ds_login_status.NameValue(ds_login_status.RowPosition,"start_time") = ds_login_date.NameValue(1,"select_1")
      
      ds_report_seq.DataID = '/werp/erpw/login/m_unq_num_1q.jsp'
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

      tr_log.Action = '/werp/erpw/login/m_login_status_1tr.jsp'
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
         if (top.frames['security']== null) {
             if (evt.keyCode == 82)   //조회  r
                btnquery_onclick()
             if (evt.keyCode == 83)  // 확인 s
                Button_confirm_onclick()
             if (evt.keyCode == 90)  // 닫기 z 
                Button_close_onclick()
             return   
          }
         aa = top.frames['main_ct'].location.href
         bb = aa.indexOf("?") + 1 
         ll_security  = aa.substr(bb,1)
             top.frames['main_title'].title_name.focus()

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
             if (evt.keyCode == 77) { 'M' // 명칭 규격 단위 표준내역코드 변경 
                top.frames['main_ct'].special_name_update()
                return
             }
             return   
          }  
//          if (ll_security == "p") {
            if (top.frames['main_title'].div_p.style.visibility == "visible") {

             //if (evt.keyCode == 82)   //조회 
             //   top.frames['main_ct'].btnquery_prt_onclick()
             if (evt.keyCode == 80)  // 출력 
                //top.frames['main_ct'].btnprint_onclick()
				top.frames['main_ct'].btnquery_prt_onclick()
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
//-------------------------------------------------------
function security_check(arg_ds)
//-------------------------------------------------------
{   
   var array = new Array();
   var ll_loop,aa,bb,ll_security
   array = arg_ds.split("@");
   aa = top.frames['main_ct'].location.href
   bb = aa.indexOf("?") + 1 
   ll_security  = aa.substr(bb,1)
   if (ll_security == 'r') {
	    for (ll_loop=0; ll_loop < array.length; ll_loop++)  {
	         eval(array[ll_loop] + ".ReadOnly = true")
	    }
   }
   return ll_security
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
       if (after_sa_key == "") return ll_start_2
       if (sa_key == after_sa_key) 
           return ll_start_1   	   	  
    }
 }
 return 0 
}
//----------------------------------------------------------------------------
function gf_key_copy(arg_ds,arg_col)                     // 변경된key값을 보관용 dup chk
//---------------------------------------------------------------------------- 
{
  // arg_ds = 'ds_1'   dataset 명
  // arg_col = "colid_1@colid_2") // 반드시 짝수 배열이어야 한다.
  // return값이 0이면 에러 1은 정상 
 var sa_key,result
 var ll_count,ll_start_1,ll_loop,ls_status,ll_last
 var array = new Array();

 eval("ll_count = " + arg_ds + ".CountRow")

 array = arg_col.split("@");
 if (array.length % 2 != 0) {
    alert("컬럼의 갯수가 2배수가 아닙니다")
    return ;
 }
 ll_last = array.length / 2 

 for (ll_start_1 =1 ; ll_start_1 <= ll_count; ll_start_1++) {
    sa_key = "" 
    for (ll_loop=0; ll_loop < ll_last; ll_loop++)  {
         eval("sa_key = " + arg_ds + ".NameValue(ll_start_1,'" + array[ll_loop] + "')") 
         eval(arg_ds + ".NameValue(ll_start_1,'" + array[(ll_loop + ll_last)] + "')" + " = sa_key  ") 
    }
 }
 eval(arg_ds + ".ResetStatus()") 
 return 
}
//----------------------------------------------------------------------------
function f_reject_window()                    // 막바로 주소를 입력하였을경우 
//---------------------------------------------------------------------------- 
{
  return false
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
  var  input = string_date.replace(/-/g,"");
  input = input.replace(/\./g,"");
  input = input.replace(/\//g,"");
  var inputYear = input.substr(0,4);
  var inputMonth = input.substr(4,2) - 1;
  var inputDate = input.substr(6, input.length - 6);			//자릿수가 많을경우  input.length - 6
  var resultDate = new Date(inputYear, inputMonth, inputDate);
  if ( input.length > 8 )	return false
  if ( resultDate.getFullYear() != inputYear ||
       resultDate.getMonth() != inputMonth ||
       resultDate.getDate() != inputDate) {
    	 return false
  }
  else {
  	return true
  }
}
//---------------------------------------------------------------------------
function is_date(as_date)	   //
//---------------------------------------------------------------------------
{	if( as_date =='' || as_date == 'undefined' ) return true
   if(  ! f_check_date(as_date) ){
	  alert('오류: 날자가 아닙니다')
	  return false
	}
	else{
		return true
	}
}
//----------------------------------------------------------------------------
function gf_cvt_date(string_date)       // 날자에 . / - 을 제외한 순수한날자만구함(반드시f_check_date)이함수로 먼저 날짜check할것
//----------------------------------------------------------------------------
{  
  var  input = string_date.replace(/-/g,"");
  input = input.replace(/\./g,"");
  input = input.replace(/\//g,"");
  return input
}
//----------------------------------------------------------------------------
function gf_gd_start_end_date(ls_ds,ls_start_date,ls_end_date)   // end-날자가 시작일자보다 크거나 같을경우만 정상
//----------------------------------------------------------------------------
{  
  var ll_cnt,i,ls_start_temp,ls_end_temp
  eval("ll_cnt = " + ls_ds + ".CountRow")
  if (ll_cnt < 1) return 0
  for (i=1;i<=ll_cnt;i++) {
  		eval("ls_start_temp = " + ls_ds + ".NameValue(" + i + ",'" + ls_start_date + "')")
  		eval("ls_end_temp = " + ls_ds + ".NameValue(" + i+ ",'" + ls_end_date + "')")
  		if (ls_start_temp == '' || ls_start_temp == null) {
  			if (ls_end_temp == '' || ls_end_temp == null) continue
  			else return i
  	   }		 
      lb_ret = f_check_date(ls_start_temp)
      if (lb_ret == false) return i
      lb_ret = f_check_date(ls_end_temp)
      if (lb_ret == false) return i
      
  		if (gf_cvt_date(ls_end_temp) >= gf_cvt_date(ls_start_temp)) continue
  		else return i
  }		
  return 0
}
//----------------------------------------------------------------------------
function gf_em_start_end_date(ls_start_date,ls_end_date)   // end-날자가 시작일자보다 크거나 같을경우만 정상
//----------------------------------------------------------------------------
{  
  if (ls_start_date == '' || ls_start_date == null || ls_start_date == '        ' ) {
  	 if (ls_end_date == '' || ls_end_date == null || ls_end_date == '        ') return true
  	 else return false
  }		 
  lb_ret = f_check_date(ls_start_date)
  if (lb_ret == false) return false
  lb_ret = f_check_date(ls_end_date)
  if (lb_ret == false) return false
  if (gf_cvt_date(ls_end_date) >= gf_cvt_date(ls_start_date)) return true
  return false
}
//--------------------------------------------------------------------
function gf_initial_security() 
//--------------------------------------------------------------------------	
 {
	var aa,bb,ll_security;
   aa = top.frames['main_ct'].location.href
   bb = aa.indexOf("?") + 1 
   ll_security  = aa.substr(bb,1)
  return ll_security
 }

//--------------------------------------------------------------------------
function gf_excel_copy_row_col(arg_ds,arg_gd,arg_row,arg_tot_row,arg_col_type,arg_auto_insert) 
//--------------------------------------------------------------------------	
 {
   // 엑셀자료를 복사한후 GRID에 붙여넣기 하였을경우에 엑셀의 자료를 GRID에 복사및 추가 한다
   // arg_ds      : dataset명칭            예) 'ds_1'
   // arg_gd      : 그리드 명칭            예) 'gd_1'
   // arg_row     : current row            예)  ds_1.RowPosition
   // arg_tot_row : 총 건수                예)  ds_1.CountRow
   // arg_col_type: 컬럼 id와 정보(배열명) 예)  'name','S','cnt_qty','N'      type: S는 스트링   N: NUMERIC 필드 H:는 옮기지않음
   // arg_auto_insert: 복사할 row가 많으면 자동 addrow         예) 'Y': 자동 ADDROW   'N': ADDROW하지않음  
   var arg_col_name
   eval("arg_col_name =  " + arg_gd + ".GetColumn()")
	var ls_excel_data
   ls_excel_data = window.clipboardData.getData('text')   // 클립보드 데이타 가져오기 
   if (ls_excel_data.length == 0) return 'err'
  // 행의수를  구하기 
  var i,ll_row=0
  var ls_temp
  for (i=0;i<ls_excel_data.length;i++) {
     ls_temp = ls_excel_data.substr(i,1)
     if (escape(ls_temp) == '%0D') {
        ll_row = ll_row + 1
     }
  }
  // 열의 수를 구하기
  var ll_col=1
  for (i=0;i<ls_excel_data.length;i++) {
     ls_temp = ls_excel_data.substr(i,1)
     if (escape(ls_temp) == '%09') {
        ll_col = ll_col + 1
     }
     if (escape(ls_temp) == '%0D') {
        break
     }
  }

   var ls_col_type = new Array()
   ls_col_type = arg_col_type
	var ls_to_excel=''
   ls_excel_data = window.clipboardData.getData('text') 
  var ll_col_start = -1 
  var i
  //화면에서 클릭한 컬럼이 array에서 몇번째 인지 check
  for (i=0;i<ls_col_type.length;i++) {
      if (arg_col_name == ls_col_type[i]) {
          ll_col_start = i
          break
      }
   }
  if (ll_col_start == -1) {
     return 'err'
  }
 
  var i,j
  var ls_temp,ls_temp_data
  ls_temp_data = ''
  j = ll_col_start              // 컬럼의 첫번째 위치 (유저가 클릭한 첫번째 컬럼위치)
  ll_real_row = arg_row
  for (i=0;i<ls_excel_data.length;i++) {
     ls_temp = ls_excel_data.substr(i,1)

     if (escape(ls_temp) == '%0D' ) {
        ls_temp_data = gf_excel_conv(ls_col_type[j+1],ls_temp_data)
        if (ls_col_type[j+1] != 'H')
           eval(arg_ds + ".NameValue(" + ll_real_row + ",'" + ls_col_type[j] + "')" + " = ls_temp_data  ")  
        j = j + 2
        i=i+1
        ls_temp_data = ''
        j = ll_col_start       // 첫번쨰로 재 세팅 
        ll_real_row = ll_real_row + 1
        if (i+1 == ls_excel_data.length) continue
        if (arg_tot_row < ll_real_row) { 
            if (arg_auto_insert == 'Y')
                eval(arg_ds + ".AddRow()")
        }
        continue
     }
     if (escape(ls_temp) == '%09') {
        ls_temp_data = gf_excel_conv(ls_col_type[j+1],ls_temp_data)
        if (ls_col_type[j+1] != 'H')
           eval(arg_ds + ".NameValue(" + ll_real_row + ",'" + ls_col_type[j] + "')" + " = ls_temp_data  ")  
        j = j + 2
        ls_temp_data = ''
        continue
     }
     ls_temp_data = ls_temp_data + ls_temp   // 한개의 컬럼 값.
  }
  return ls_to_excel
 }
//--------------------------------------------------------------------
function gf_excel_conv(arg_col_type,temp_data) 
//--------------------------------------------------------------------------	
 {

   var ls_col_type,ls_temp_data
   var i,ls_temp
   ls_temp_data = ''
   ls_col_type = arg_col_type
   for (i=0;i<temp_data.length;i++) {
     ls_temp = temp_data.substr(i,1)
     if (arg_col_type == 'N') 
        if (ls_temp == ',' || ls_temp == ' ')  continue
     ls_temp_data = ls_temp_data + ls_temp        
   }
  return ls_temp_data
 }
//------------------------------------------------------------------------
function gf_protect_on(arg_tab) // 프로텍트를 건다.
//------------------------------------------------------------------------
{	
      var ls_temp,ls_tag_name,ll_len
      eval('ll_len = ' + arg_tab + '.all.length')
		for(i = 0; i <ll_len; i++){
		   eval('ls_tag_name = ' + arg_tab + '.all(i).tagName')
			if (ls_tag_name == 'INPUT' || ls_tag_name == 'TEXTAREA'  || ls_tag_name == 'OBJECT'){
             eval('ls_temp = ' + arg_tab + '.all(i).id')
             if (ls_temp == "") continue
				 if (ls_tag_name != 'OBJECT'){ 
					  //eval(ls_temp + '.disabled=true')
					  eval(ls_temp + '.contentEditable=false')
						eval(ls_temp + '.style.color="gray"')
				 }
				 if (ls_tag_name == 'OBJECT') {
				    if (ls_temp.substr(0,3) == 'em_')
				       eval(ls_temp + '.readonly=true')
				    if (ls_temp.substr(0,5) == 'ccom_') {
				       eval(ls_temp + '.Enable=false')
				    }   
				 }     
			}		
		}
}
//------------------------------------------------------------------------
function gf_protect_off(arg_tab) // 프로텍트를 푼다.
//------------------------------------------------------------------------
{	
      var ls_temp,ls_tag_name,ll_len
      eval('ll_len = ' + arg_tab + '.all.length')
		for(i = 0; i <ll_len; i++){
		   eval('ls_tag_name = ' + arg_tab + '.all(i).tagName')
			if (ls_tag_name == 'INPUT' || ls_tag_name == 'TEXTAREA'   || ls_tag_name == 'OBJECT'){
             eval('ls_temp = ' + arg_tab + '.all(i).id')
             if (ls_temp == "") continue
				 if (ls_tag_name != 'OBJECT') {
					 //eval(ls_temp + '.disabled=false')
				    eval(ls_temp + '.contentEditable=true')
					 eval(ls_temp + '.style.color="black"')
				 }
				 if (ls_tag_name == 'OBJECT') {
				    if (ls_temp.substr(0,3) == 'em_')
				       eval(ls_temp + '.readonly=false')
				    if (ls_temp.substr(0,5) == 'ccom_') 
				       eval(ls_temp + '.Enable=true')
				 }     
			}		
		}
}
//------------------------------------------------------------------------
function gf_create_file(arg_file,arg_text)   // create text file
//------------------------------------------------------------------------
{	
 var fso, tf;
  
  fso = new ActiveXObject("Scripting.FileSystemObject");
  tf = fso.CreateTextFile("c:\\" + arg_file, true);
  // 줄 바꿈 문자가 있는 줄을 씁니다.
  tf.WriteLine(arg_text) ;
  // 파일에 줄 바꿈 문자를 세 개 씁니다.      
  tf.Close();
 }     

//------------------------------------------------------------------------
function gf_read_file(arg_file)   // read record 1건
//------------------------------------------------------------------------
{	
  var fso, f1, ts, s, f2;
  var ForReading = 1;
  fso = new ActiveXObject("Scripting.FileSystemObject");
  ts = fso.OpenTextFile("c:\\" + arg_file, ForReading);
  s = ts.ReadLine();
  ts.Close();
  return s
}  
//------------------------------------------------------------------------
function gf_delete_file(arg_file)   // text file 삭제
//------------------------------------------------------------------------
{	
  var fso, f1, ts, s;
  fso = new ActiveXObject("Scripting.FileSystemObject");
  f1 = fso.GetFile("c:\\" + arg_file);
  f1.Delete();
}  
//-------------------------------------------------------------------------------
function gf_point(il_number,il_point,il_rc)      //소수몇자리를 구하는법(사용하지말것 오류 : gf_round를 대신사용할것)       
//--------------------------------------------------------------------------------
{
    // il_number   : 변하고자하는 numeric field
    // il_point    : 소수점 자리수   10.007  일 경우 3
    // il_rc       : c: 자름    il_point가 3이면 4번째값이 무엇이던지 자름
    //             : r: 반올림  il_point가 3이면 4번째값에서 반올림함.

   var is_number,i,j
   j=0
   is_number = il_number + ''
   
   for (i=0; i < is_number.length; i++) {
      if (is_number.substr(i,1) == '.') {
         j = i
         break
      }
   }

   if (j == 0)
      return il_number

   i=is_number.length
   i = i - j + 1         // 소수 아래의 숫자를 계산
   if (i <= il_point)    // 소수 아래의 숫자가 구하고자하는 소수점자리수보다 적으면 return
      return il_number 

 
   i = j + il_point  + 2     // 소수점구하는숫자 다음의 숫자가 무엇인지를 알기위해
   if (il_point == 0) {
      i = j + il_point  + 1     // 소수점구하는숫자 다음의 숫자가 무엇인지를 알기위해
      if ((il_rc == 'r') || (il_rc == 'R')) {
         if (is_number.substr(i,1) >= '5')
             return parseInt(is_number,10) + 1
      }
      return parseInt(is_number,10)
   }

   if ((il_rc == 'r') || (il_rc == 'R')) {
      if (is_number.substr(i,1) >= '5')
          is_number = is_number.substr(0,i -2) + (parseInt(is_number.substr(i-1,1),10) + 1)
      else
          is_number = is_number.substr(0,i - 1)
      return parseFloat(is_number)
   }

  // 무조건 자름 
   is_number = is_number.substr(0,i - 1)
   return parseFloat(is_number)

}

//-------------------------------------------------------------------------------
function gf_this_before_update(arg_primary,arg_this,arg_before)      // dataset 수정여부 check(다른사람이  수정했는지check)
//--------------------------------------------------------------------------------
{
	var ls_status,ll_search_row,ls_colid
	var i,j,k,ll_this_value,ll_before_value
   eval("j = " + arg_this + ".CountColumn") 
	for (i=1;i<=ds_1.CountRow;i++) { 
      eval ( "ls_status = " + arg_this + ".SysStatus(" + i + ")")  
      if (ls_status != 3) continue
	   ll_search_row = gf_present_chk(arg_primary,arg_this,arg_before,i)
	   if (ll_search_row == 0) continue
	   for (k=1;k<=j;k++) { 
	   	eval("ls_colid = " + arg_this + ".ColumnID(" + k + ") ")
	   	eval("ll_this_value = " + arg_this + ".OrgNameValue(" + i + ",'" + ls_colid + "')" ) 
	   	eval("ll_before_value = " + arg_before+ ".NameValue(" + ll_search_row + ",'" + ls_colid + "')" ) 
	      if (ll_this_value != ll_before_value) return i
	  }
   }	  
  return 0	      
}
//----------------------------------------------------------------------------
function gf_present_chk(arg_col,arg_this,arg_ds,arg_i)                     // 값이 존재하는지 여부 check
//---------------------------------------------------------------------------- 
{
  // arg_col = "colid_1@colid_2")
  // arg_this = 현재 dataset
  // arg_ds   == 이전 dataset
  // i        == 현재 비교하고가자는 값의 row arg_this의 row갑이다 
  // return값이 0보다 크면 return값이 찾은  row값이며 0이며는 찾지못함 
 var sa_key,after_sa_key,result
 var ll_count,ll_start_1,ll_start_2,ll_dup,ll_loop,ls_status
 var array = new Array();

 eval("ll_count = " + arg_ds + ".CountRow")

 array = arg_col.split("@");

 sa_key = "" 
 for (ll_loop=0; ll_loop < array.length; ll_loop++)  {
      eval("sa_key = sa_key + " + arg_this + ".OrgNameValue(" + arg_i + ",'" + array[ll_loop] + "')") 
 }

 for (ll_start_1 =1 ; ll_start_1 <= ll_count; ll_start_1++) {
 	    after_sa_key=""
	    for (ll_loop=0; ll_loop < array.length; ll_loop++)  {
	         eval("after_sa_key = after_sa_key + " + arg_ds + ".NameValue(ll_start_1,'" + array[ll_loop] + "')") 
       }
       if (sa_key == after_sa_key) 
           return ll_start_1   	   	  
 }

 return 0 
}

//---------------------------------------------------------------------------
function f_reSize(objId, xRes, yRes)
// 작성자:임종빈
// 일자:2006.01.04
//기능설명: 특정 object(들)의 width 와 height 를 윈도우 사이즈에 맞게 리사이즈한다. 
//                 (윈도우 리사이즈시 변경된 사이즈만큼 해당오브젝트의 사이즈도 변경해준다)
//                 여러 오브젝트를 array형태로 한번에 호출할수 있다. objid = ('gd_1, 'gd_2', 'gd_3',...)
//                 X축(width) , Y축(height)으로 리사이즈를 할것인지 선택가능.  xRes=(true, true, false,..)  yRes=(true,false, true,...)
// 사용샘플: erpw/const/e_web/e_accident_report_1h.html 의 f_set_resize()에서 이함수를 호출 하고 
//                  윈도우 resize 이벤트에서 f_set_resize() 를 호출한다. (처음 윈도우가 오픈될때 resize 이벤트를 타지 않으므로 
//					onload시 f_set_resize()를 호출하여 윈도사이즈에 맞게 object시이즈를 변경해준다)
//                  resize event =>   f_set_resize() => f_reSize()
//---------------------------------------------------------------------------
{	
	var id, xr, yr

	var xOff , yOff 

    var cWidth = document.body.clientWidth;
	var cHeight = document.body.clientHeight;

	var w, h

	if ( !(cWidth > 0 && cHeight > 0 ) ) {return}

	for(i=0; i<objId.length ;i++){ 
		id = objId[i];
		xr = xRes[i];
		yr = yRes[i];
		
		if (xr) {
			xOff = document.getElementById(id).style.pixelLeft;

			w = cWidth - xOff -5;

			if ( w > 0 ) {document.getElementById(id).style.width = w;}
		}

		if (yr) {
			yOff = document.getElementById(id).style.pixelTop;

			h = cHeight - yOff -5;

			if ( h > 0 ) {document.getElementById(id).style.height = h;}
		}
	}
} 
//---------------------------------------------------------------------------
function LimitTextLength(obj)
// 작성자:임종빈
// 일자:2006.01.05
//기능설명: obj(textarea, input) 의 maxlength 를 기준으로 초과입력됫을때 경고 메세지 보여주고 초과된거 삭제한다. 
//                 textarea가 maxlength 와 무관하게 초과입력되므로 이함수를 사용하여 초과입력 방지..
//                 input은 초과입력방지 하지만.. 영문일때만 제대로 작동하고.. 한글을 입력한경우에 1바이트로 인식하여 실제로는 초과입력됨
// 사용샘플: erpw/const/e_web/e_accident_report_1h.thml 의 tx_accident 의 onChange onKeyUp 이벤트에서 호출
//---------------------------------------------------------------------------
{
 var temp;
 var f = obj.value.length;
 var msglen = obj.maxLength; //최대 길이
 var tmpstr = "";
 var strlen;
 var errmsg = "총 영문 "+msglen+"자 한글 "+msglen/2+"자 까지 쓰실 수 있습니다." ;
 
  for(k=0;k<f;k++){
	   temp = obj.value.charAt(k);
	   
	   if(escape(temp).length > 4)
			msglen -= 2;
	   else
			msglen--;

	   if(msglen < 0){
			alert(errmsg);
			obj.value = tmpstr;
			break;
	   }
	   else{
			tmpstr += temp;
	   }
  }
 
}

//---------------------------------------------------------------------------
function __ws__(id)  
//작성자:쉬프트정보통신(가우스/추가:임종빈) 
//일자:2006.02.10
//기능설명:3월1일로 예정된 MS explorer 패치 에서 activeX 의 html에서 직접 사용을 제한하는 업데이트가 적용될예정임.
//                문제를 해결하기위해서 코딩변경이 불가피하고 이 funciton은 변경되는 코딩에서 호출하는 함수 이다.
//
//---------------------------------------------------------------------------
{
document.write(id.innerHTML);id.id=""; 

} 
//-------------------------------------------------------------------------------
function gf_round(il_number,il_point,il_rc)      //소수몇자리를 구하는법         
//--------------------------------------------------------------------------------
{
    // il_number   : 변하고자하는 numeric field
    // il_point    : 소수점 자리수   10.007  일 경우 3
    // il_rc       : c: 자름    il_point가 3이면 4번째값이 무엇이던지 자름
    //             : r: 반올림  il_point가 3이면 4번째값에서 반올림함.
 var is_number,i,j,temp_amt

	is_number = '1'
	j='0.'
   for (i=0; i <= il_point; i++) {
   	is_number = is_number + '0';
   	if ( i != 0) {
   		j = j + '0';
   	}
   }
   j = parseFloat(j + '1');

   i = parseInt(is_number,10);
   temp_amt = il_number * i;
   if (il_rc == 'r' || il_rc == 'R') {
   	temp_amt = Math.round(temp_amt)
   }
   else {
   	temp_amt = Math.floor(temp_amt)
   }
	temp_amt = temp_amt * j;   

   return parseFloat(temp_amt)

}
//---------------------------------------------------------------------------
function f_multiply(arg_i,arg_j)                       //전체 부서 찾기 
//---------------------------------------------------------------------------
{
	var temp_k
	temp_k=arg_i*arg_j
   return Math.floor(gf_round(arg_i*arg_j,5,'r'))
}
