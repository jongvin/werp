PL/SQL Developer Test script 3.0
8
begin
  -- Call the function
  :result := fbs_util_pkg.mail_send(p_mailto => :p_mailto,
                                    p_mailcc => :p_mailcc,
                                    p_subject => :p_subject,
                                    p_contents => :p_contents,
                                    p_html_yn => :p_html_yn);
end;
6
result
1
OK
5
p_mailto
1
신인철<icshin72@paran.com>,황대봉<dbhwang@lgcns.com>,이희선<heesunlee@lgcns.com>,서명서<cool_wow77@hotmail.com>,김흥수<protokhs@hanmail.net>
5
p_mailcc
0
5
p_subject
1
CJ개발 FBS메일 발송TEST
5
p_contents
1
<Long>
8
p_html_yn
1
N
5
0
