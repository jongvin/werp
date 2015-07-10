drop directory FBS_LOG_DIR;      
drop directory FBS_BILL_RECV_DIR;
drop directory FBS_BILL_SEND_DIR;
drop directory FBS_CASH_RECV_DIR;
drop directory FBS_CASH_SEND_DIR;
drop directory FBS_REALTIME_SEND_DIR;
drop directory FBS_REALTIME_TEMP_DIR;

create directory FBS_LOG_DIR       AS 'C:\FBS\log';
create directory FBS_BILL_RECV_DIR AS 'C:\FBS\bill_recv';
create directory FBS_BILL_SEND_DIR AS 'C:\FBS\bill_send';
create directory FBS_CASH_RECV_DIR AS 'C:\FBS\cash_recv';
create directory FBS_CASH_SEND_DIR AS 'C:\FBS\cash_send';
create directory FBS_REALTIME_SEND_DIR AS 'C:\FBS\realtime_send';
create directory FBS_REALTIME_TEMP_DIR AS 'C:\FBS\realtime_temp';

