declare
lsmail			long;
lsRet			Varchar2(2000);
begin
dbms_output.Enable;
lsmail := '';
lsmail := '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> '||chr(10)||
' <html> '||chr(10)||
' 	<head> '||chr(10)||
' 		<title>테스트메일</title> '||chr(10)||
' 	</head> '||chr(10)||
' 	<body> '||chr(10)||
' 		<table width="100%" border="1" cellpadding="0" cellspacing="0"> '||chr(10)||
' 			<tr> '||chr(10)||
' 				<td> '||chr(10)||
' 					지급구분 '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					지급액 '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					은행 '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					지급계좌 '||chr(10)||
' 				</td> '||chr(10)||
' 			</tr> '||chr(10)||
' 			<tr> '||chr(10)||
' 				<td> '||chr(10)||
' 					현금 '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					1,000,400 '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					하나은행 '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					200-984-048498 '||chr(10)||
' 				</td> '||chr(10)||
' 			</tr> '||chr(10)||
' 			<tr> '||chr(10)||
' 				<td> '||chr(10)||
' 					어음 '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					1,000,400 '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					우리은행 '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					200-984-048498 '||chr(10)||
' 				</td> '||chr(10)||
' 			</tr> '||chr(10)||
' 		</table> '||chr(10)||
' 	</body> '||chr(10)||
' <html> ';
lsRet := FBS_UTIL_PKG.mail_send('김철홍<cholhong@cj.net>',null,'테스트메일',lsmail,'Y');
dbms_output.put_line(lsRet);
end;
/
