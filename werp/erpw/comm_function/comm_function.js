var MOUSE_OVER="#FF0000";
var MOUSE_OUT="#000000";

//----------------------------------------------------------------
function makeCookie(name, value)  // ��Ű ����
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
function readCookie(uName)       // ��Ű ��ȸ
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
function gs_conv_function(name)   // ��Ű���� @�� *�� conversion��
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
function makeCookie_session()  // ��Ű ����
//----------------------------------------------------------------
{
   var temp
   temp = readCookie("JSESSIONID")
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate()+300);
          document.cookie =  "JSESSIONID" + "=" + temp + "; path=/; expires=" + todayDate.toGMTString() + ";"

}
//----------------------------------------------------------------------
function clearCookie()   // clear ��Ű 
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
function jumin_check(arg_jumin)   // �ֹε�Ϲ�ȣ üũ
//----------------------------------------------------------------------
{
 var jumin 	
 var i,k
 var total = 0;
 var totalmod,chd
 var temp = new Array(13);    // �ֹε�Ϲ�ȣ �� �ڸ��� ������ �迭 Ȯ��
 jumin=arg_jumin             //�ֹι�ȣ ����
 for(i=0; i<13; i++)
	temp[i] = parseInt(jumin.charAt(i));  // ������ ���ؼ� �� �ڸ��� ������ ��ȯ�Ͽ� �迭�� ������
 for(i=0; i<12; i++)
 {
		k = i + 2;
		if(k >= 10)
			k = k % 10 + 2;
		total = total + temp[i] * k;   // �� �ڸ��� 2,3,4,....�� ���ؼ� �� ����� ������
 }  
 totalmod = total % 11;  // 11�� ���� �������� ����
 chd = 11 - totalmod;   // 11���� ��
 if (chd==10)
   chd=0;
 if (chd==11)
   chd=1;           // ���� ����� 11�̳� 10ó�� �� �ڸ��� ��쿡�� �� �ڸ��� �����
 if(chd == temp[12])  // ���� ����� �ֹε�Ϲ�ȣ ���ڸ��� ������
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
function f_update_sql(ls_sql)     //���α׷����� ���ٷ� sql������ �̿��Ͽ� update,delete,insert�Ұ����
//---------------------------------------------------------------------------------
{
	var lls_sql = ls_sql
	  lls_sql = lls_sql.replace(/\+/g,'!')
    ds_update.DataID = "/werp/erpw/comm_function/comm_update.jsp?arg_cmd=" + lls_sql
    ds_update.SyncLoad = true
    ds_update.reset()
}
//---------------------------------------------------------------------------------
function f_update_mssql(ls_sql)     //���α׷����� ���ٷ� sql������ �̿��Ͽ� update,delete,insert�Ұ����
//---------------------------------------------------------------------------------
{
	var lls_sql = ls_sql
	  lls_sql = lls_sql.replace(/\+/g,'!')
    ds_update.DataID = "/werp/erpw/comm_function/comm_update_mssql.jsp?arg_cmd=" + lls_sql
    ds_update.SyncLoad = true
    ds_update.reset()
}

//---------------------------------------------------------------------------------
function gf_mail_to(tran_sender_id,tran_callback,tran_id,tran_phone,tran_msg)     // sms �޼��� ������ 
//---------------------------------------------------------------------------------
{
	// gf_mail_to('�ڵ���','0113878587','����','01197927939','�ູ�ϼ���')
	// ds_update   dataset���� ���.  

	// tran_sender_id : ������ ��� �̸�
	// tran_callback : ������ ��� ��ȭ��ȣ
	// tran_id        : �޴»�� �̸�
	// tran_phone     : �޴»�� ��ȭ��ȣ
	// tran_msg       : �޼��� 
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
function f_update_sql_multy(ls_sql)     //���α׷����� ���ٷ� sql������ �̿��Ͽ� update,delete,insert�Ұ����(���� ���� �۾��� ���)
//---------------------------------------------------------------------------------
{
	var lls_sql = ls_sql
	  lls_sql = lls_sql.replace(/\+/g,'!')
     ds_update.DataID = "/werp/erpw/comm_function/comm_update_multy.jsp?arg_cmd=" + lls_sql
    ds_update.SyncLoad = true
    ds_update.reset()
}
//---------------------------------------------------------------------------
function f_sysdate()                       //����¥���ϱ� 
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
function f_sysdatetime()                       //����¥/�ð����ϱ� 
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
function f_dept_code_find(arg_dept)                       //���� ã�� 
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
function f_dept_code_find_all(arg_dept)                       //��ü �μ� ã�� 
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
function f_crystal_report(arg_var)                       //ũ����Ż������ ���� 
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
			rtnValue = rtnValue + "&RptParams" + (argArray[i - 1].replace(re2,"%26")).replace(re3,"%3B"); //, �� ;�� �ٲ㺸�� asp�ʿ��� �ٽ� ;=> , ������
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
function f_crystal_report2(arg_var)                       //ũ����Ż������ ���� 
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
			rtnValue = rtnValue + "&RptParams" + (argArray[i - 1].replace(re2,"%26")).replace(re3,"%3B"); //, �� ;�� �ٲ㺸�� asp�ʿ��� �ٽ� ;=> , ������
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
function f_hdept_code_find(arg_dept)                       //���� ã�� (�о�����)
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
//--------------------------------------------- �о� ������ ��ȣ ���� �� logging
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
			return  ll_receive_no   // ����
		}
		else 
		{
			ll_receive_no = 0       // error
		}
		
	}  

	return ll_receive_no + '@' + ls_remarks
}     

//---------------------------------------------------------------------------------
function f_update_receive_print_sql(ls_sql)     //���α׷����� ���ٷ� sql������ �̿��Ͽ� update,delete,insert�Ұ����
//---------------------------------------------------------------------------------
{   
	var lls_sql = ls_sql
	  lls_sql = lls_sql.replace(/\+/g,'!')
    ds_update10.DataID = "/werp/erpw/comm_function/comm_update.jsp?arg_cmd=" + lls_sql
    ds_update10.SyncLoad = true
    ds_update10.reset()
}

//----------------------------------------------------------------------
function f_close_chk(arg_dept,arg_date,arg_gubun)   // ������������������ üũ(�����ڵ�,���,��������)
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
function f_process(arg_gubun)   // ���μ����� ���ΰ��� Return�Ѵ�(arg_gubun=���μ����ڵ�)
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
function f_report_log(arg_remark)   // ������ ��½� �α��ϴ� function
//----------------------------------------------------------------------
{
	//    login status    ��� ����.......................
	   var ll_cnt
      ll_cnt = f_ds_select_q("ds_login_date","select sysdate  select_1  from dual")    // system datetime�������� 
      
      ds_login_status.DataID = '/werp/erpw/login/m_login_status_1q.jsp?arg_seq_key=0'
      ds_login_status.SyncLoad=true
      ds_login_status.reset() 
      ds_login_status.AddRow()
      
      ds_login_status.NameValue(ds_login_status.RowPosition,"ip_address") = top.frames['security'].gs_ip_addr.value
      ds_login_status.NameValue(ds_login_status.RowPosition,"start_time") = ds_login_date.NameValue(1,"select_1")
      
      ds_report_seq.DataID = '/werp/erpw/login/m_unq_num_1q.jsp'
      ds_report_seq.SyncLoad=true;             // seq no ���ϱ�
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
             if (evt.keyCode == 82)   //��ȸ  r
                btnquery_onclick()
             if (evt.keyCode == 83)  // Ȯ�� s
                Button_confirm_onclick()
             if (evt.keyCode == 90)  // �ݱ� z 
                Button_close_onclick()
             return   
          }
         aa = top.frames['main_ct'].location.href
         bb = aa.indexOf("?") + 1 
         ll_security  = aa.substr(bb,1)
             top.frames['main_title'].title_name.focus()

//         if  (ll_security == "r") {
         if (top.frames['main_title'].div_r.style.visibility == "visible") { 
             if (evt.keyCode == 82)   //��ȸ
                top.frames['main_ct'].btnquery_onclick()
             return   
         }  
//         if (ll_security == "u") {
         if (top.frames['main_title'].div_u.style.visibility == "visible") {             

             if (evt.keyCode == 82)   //��ȸ 
                top.frames['main_ct'].btnquery_onclick()
             if (evt.keyCode == 65)  // �߰�
                top.frames['main_ct'].btnadd_onclick()
             if (evt.keyCode == 73)  // ����
                top.frames['main_ct'].btninsert_onclick()
             if (evt.keyCode == 68) {  // ����
                top.frames['main_ct'].btndelete_onclick()
                return
             }
             if (evt.keyCode == 83)  // ����
                top.frames['main_ct'].btnsave_onclick()
             if (evt.keyCode == 90)  // ��� 
                top.frames['main_ct'].btncancel_onclick()
             if (evt.keyCode == 77) { 'M' // ��Ī �԰� ���� ǥ�س����ڵ� ���� 
                top.frames['main_ct'].special_name_update()
                return
             }
             return   
          }  
//          if (ll_security == "p") {
            if (top.frames['main_title'].div_p.style.visibility == "visible") {

             //if (evt.keyCode == 82)   //��ȸ 
             //   top.frames['main_ct'].btnquery_prt_onclick()
             if (evt.keyCode == 80)  // ��� 
                //top.frames['main_ct'].btnprint_onclick()
				top.frames['main_ct'].btnquery_prt_onclick()
             return   
          }  
//          if (ll_security == "s") {
            if (top.frames['main_title'].div_s.style.visibility == "visible") {

             if (evt.keyCode == 82)   //��ȸ 
                top.frames['main_ct'].btnquery_onclick()
             if (evt.keyCode == 83)  // ����
                top.frames['main_ct'].btnsave_onclick()
             if (evt.keyCode == 90)  // ��� 
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
  // arg_ds = 'ds_1'   dataset ��
  // arg_col = "colid_1@colid_2")
  // return���� 0���� ũ�� return���� dup�� row���̸� 0�̸�� dup�� ���� 
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
function gf_key_copy(arg_ds,arg_col)                     // �����key���� ������ dup chk
//---------------------------------------------------------------------------- 
{
  // arg_ds = 'ds_1'   dataset ��
  // arg_col = "colid_1@colid_2") // �ݵ�� ¦�� �迭�̾�� �Ѵ�.
  // return���� 0�̸� ���� 1�� ���� 
 var sa_key,result
 var ll_count,ll_start_1,ll_loop,ls_status,ll_last
 var array = new Array();

 eval("ll_count = " + arg_ds + ".CountRow")

 array = arg_col.split("@");
 if (array.length % 2 != 0) {
    alert("�÷��� ������ 2����� �ƴմϴ�")
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
function f_reject_window()                    // ���ٷ� �ּҸ� �Է��Ͽ������ 
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
function f_check_date(string_date)                    // ������ Valid �� üũ�Ѵ�.
//----------------------------------------------------------------------------
{  
  var  input = string_date.replace(/-/g,"");
  input = input.replace(/\./g,"");
  input = input.replace(/\//g,"");
  var inputYear = input.substr(0,4);
  var inputMonth = input.substr(4,2) - 1;
  var inputDate = input.substr(6, input.length - 6);			//�ڸ����� �������  input.length - 6
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
	  alert('����: ���ڰ� �ƴմϴ�')
	  return false
	}
	else{
		return true
	}
}
//----------------------------------------------------------------------------
function gf_cvt_date(string_date)       // ���ڿ� . / - �� ������ �����ѳ��ڸ�����(�ݵ��f_check_date)���Լ��� ���� ��¥check�Ұ�
//----------------------------------------------------------------------------
{  
  var  input = string_date.replace(/-/g,"");
  input = input.replace(/\./g,"");
  input = input.replace(/\//g,"");
  return input
}
//----------------------------------------------------------------------------
function gf_gd_start_end_date(ls_ds,ls_start_date,ls_end_date)   // end-���ڰ� �������ں��� ũ�ų� ������츸 ����
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
function gf_em_start_end_date(ls_start_date,ls_end_date)   // end-���ڰ� �������ں��� ũ�ų� ������츸 ����
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
   // �����ڷḦ �������� GRID�� �ٿ��ֱ� �Ͽ�����쿡 ������ �ڷḦ GRID�� ����� �߰� �Ѵ�
   // arg_ds      : dataset��Ī            ��) 'ds_1'
   // arg_gd      : �׸��� ��Ī            ��) 'gd_1'
   // arg_row     : current row            ��)  ds_1.RowPosition
   // arg_tot_row : �� �Ǽ�                ��)  ds_1.CountRow
   // arg_col_type: �÷� id�� ����(�迭��) ��)  'name','S','cnt_qty','N'      type: S�� ��Ʈ��   N: NUMERIC �ʵ� H:�� �ű�������
   // arg_auto_insert: ������ row�� ������ �ڵ� addrow         ��) 'Y': �ڵ� ADDROW   'N': ADDROW��������  
   var arg_col_name
   eval("arg_col_name =  " + arg_gd + ".GetColumn()")
	var ls_excel_data
   ls_excel_data = window.clipboardData.getData('text')   // Ŭ������ ����Ÿ �������� 
   if (ls_excel_data.length == 0) return 'err'
  // ���Ǽ���  ���ϱ� 
  var i,ll_row=0
  var ls_temp
  for (i=0;i<ls_excel_data.length;i++) {
     ls_temp = ls_excel_data.substr(i,1)
     if (escape(ls_temp) == '%0D') {
        ll_row = ll_row + 1
     }
  }
  // ���� ���� ���ϱ�
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
  //ȭ�鿡�� Ŭ���� �÷��� array���� ���° ���� check
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
  j = ll_col_start              // �÷��� ù��° ��ġ (������ Ŭ���� ù��° �÷���ġ)
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
        j = ll_col_start       // ù������ �� ���� 
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
     ls_temp_data = ls_temp_data + ls_temp   // �Ѱ��� �÷� ��.
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
function gf_protect_on(arg_tab) // ������Ʈ�� �Ǵ�.
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
function gf_protect_off(arg_tab) // ������Ʈ�� Ǭ��.
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
  // �� �ٲ� ���ڰ� �ִ� ���� ���ϴ�.
  tf.WriteLine(arg_text) ;
  // ���Ͽ� �� �ٲ� ���ڸ� �� �� ���ϴ�.      
  tf.Close();
 }     

//------------------------------------------------------------------------
function gf_read_file(arg_file)   // read record 1��
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
function gf_delete_file(arg_file)   // text file ����
//------------------------------------------------------------------------
{	
  var fso, f1, ts, s;
  fso = new ActiveXObject("Scripting.FileSystemObject");
  f1 = fso.GetFile("c:\\" + arg_file);
  f1.Delete();
}  
//-------------------------------------------------------------------------------
function gf_point(il_number,il_point,il_rc)      //�Ҽ����ڸ��� ���ϴ¹�(����������� ���� : gf_round�� ��Ż���Ұ�)       
//--------------------------------------------------------------------------------
{
    // il_number   : ���ϰ����ϴ� numeric field
    // il_point    : �Ҽ��� �ڸ���   10.007  �� ��� 3
    // il_rc       : c: �ڸ�    il_point�� 3�̸� 4��°���� �����̴��� �ڸ�
    //             : r: �ݿø�  il_point�� 3�̸� 4��°������ �ݿø���.

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
   i = i - j + 1         // �Ҽ� �Ʒ��� ���ڸ� ���
   if (i <= il_point)    // �Ҽ� �Ʒ��� ���ڰ� ���ϰ����ϴ� �Ҽ����ڸ������� ������ return
      return il_number 

 
   i = j + il_point  + 2     // �Ҽ������ϴ¼��� ������ ���ڰ� ���������� �˱�����
   if (il_point == 0) {
      i = j + il_point  + 1     // �Ҽ������ϴ¼��� ������ ���ڰ� ���������� �˱�����
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

  // ������ �ڸ� 
   is_number = is_number.substr(0,i - 1)
   return parseFloat(is_number)

}

//-------------------------------------------------------------------------------
function gf_this_before_update(arg_primary,arg_this,arg_before)      // dataset �������� check(�ٸ������  �����ߴ���check)
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
function gf_present_chk(arg_col,arg_this,arg_ds,arg_i)                     // ���� �����ϴ��� ���� check
//---------------------------------------------------------------------------- 
{
  // arg_col = "colid_1@colid_2")
  // arg_this = ���� dataset
  // arg_ds   == ���� dataset
  // i        == ���� ���ϰ����ڴ� ���� row arg_this�� row���̴� 
  // return���� 0���� ũ�� return���� ã��  row���̸� 0�̸�� ã������ 
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
// �ۼ���:������
// ����:2006.01.04
//��ɼ���: Ư�� object(��)�� width �� height �� ������ ����� �°� ���������Ѵ�. 
//                 (������ ��������� ����� �����ŭ �ش������Ʈ�� ����� �������ش�)
//                 ���� ������Ʈ�� array���·� �ѹ��� ȣ���Ҽ� �ִ�. objid = ('gd_1, 'gd_2', 'gd_3',...)
//                 X��(width) , Y��(height)���� ������� �Ұ����� ���ð���.  xRes=(true, true, false,..)  yRes=(true,false, true,...)
// ������: erpw/const/e_web/e_accident_report_1h.html �� f_set_resize()���� ���Լ��� ȣ�� �ϰ� 
//                  ������ resize �̺�Ʈ���� f_set_resize() �� ȣ���Ѵ�. (ó�� �����찡 ���µɶ� resize �̺�Ʈ�� Ÿ�� �����Ƿ� 
//					onload�� f_set_resize()�� ȣ���Ͽ� ��������� �°� object����� �������ش�)
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
// �ۼ���:������
// ����:2006.01.05
//��ɼ���: obj(textarea, input) �� maxlength �� �������� �ʰ��Էµ����� ��� �޼��� �����ְ� �ʰ��Ȱ� �����Ѵ�. 
//                 textarea�� maxlength �� �����ϰ� �ʰ��ԷµǹǷ� ���Լ��� ����Ͽ� �ʰ��Է� ����..
//                 input�� �ʰ��Է¹��� ������.. �����϶��� ����� �۵��ϰ�.. �ѱ��� �Է��Ѱ�쿡 1����Ʈ�� �ν��Ͽ� �����δ� �ʰ��Էµ�
// ������: erpw/const/e_web/e_accident_report_1h.thml �� tx_accident �� onChange onKeyUp �̺�Ʈ���� ȣ��
//---------------------------------------------------------------------------
{
 var temp;
 var f = obj.value.length;
 var msglen = obj.maxLength; //�ִ� ����
 var tmpstr = "";
 var strlen;
 var errmsg = "�� ���� "+msglen+"�� �ѱ� "+msglen/2+"�� ���� ���� �� �ֽ��ϴ�." ;
 
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
//�ۼ���:����Ʈ�������(���콺/�߰�:������) 
//����:2006.02.10
//��ɼ���:3��1�Ϸ� ������ MS explorer ��ġ ���� activeX �� html���� ���� ����� �����ϴ� ������Ʈ�� ����ɿ�����.
//                ������ �ذ��ϱ����ؼ� �ڵ������� �Ұ����ϰ� �� funciton�� ����Ǵ� �ڵ����� ȣ���ϴ� �Լ� �̴�.
//
//---------------------------------------------------------------------------
{
document.write(id.innerHTML);id.id=""; 

} 
//-------------------------------------------------------------------------------
function gf_round(il_number,il_point,il_rc)      //�Ҽ����ڸ��� ���ϴ¹�         
//--------------------------------------------------------------------------------
{
    // il_number   : ���ϰ����ϴ� numeric field
    // il_point    : �Ҽ��� �ڸ���   10.007  �� ��� 3
    // il_rc       : c: �ڸ�    il_point�� 3�̸� 4��°���� �����̴��� �ڸ�
    //             : r: �ݿø�  il_point�� 3�̸� 4��°������ �ݿø���.
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
function f_multiply(arg_i,arg_j)                       //��ü �μ� ã�� 
//---------------------------------------------------------------------------
{
	var temp_k
	temp_k=arg_i*arg_j
   return Math.floor(gf_round(arg_i*arg_j,5,'r'))
}