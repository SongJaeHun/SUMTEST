package query;

public interface Query {
	String SEQUENCENUM="select  s_mail_no.nextval from dual";
	String DATENUM=" select to_char(sysdate,'YYYY/MM/DD HH24:MI:SS') from dual";
	//String INSERT="insert into board(b_no,b_subject,b_name,b_pass,b_text,b_date,b_count) values(?,?,?,?,?,to_date(?,'yyyy/mm/dd hh24:MI:SS'),?)";
	//String INCREMEMTCOUNT="update board set b_count=b_count+1 where b_no=?";
	String ALLVIEW="select * from mail_info, account where mail_info.acc_id = account.acc_id and account.mb_id = 1";
	String GVIEW="select * from mail_info, account where mail_info.acc_id = account.acc_id and account.mb_id = 1 and acc_site_name = 'GMAIL'";
	String NVIEW="select * from mail_info, account where mail_info.acc_id = account.acc_id and account.mb_id = 1 and acc_site_name = 'NAVER'";
	String HVIEW="select * from mail_info, account where mail_info.acc_id = account.acc_id and account.mb_id = 1 and acc_site_name = 'DAUM'";
	String BOARDVIEW = "select mail_no,title,to_char(b_date,'YYYY/MM/DD HH24:MI:SS'),recv_addr from mail_info where mail_no=?";
	String PASSCHECK="select user_pwd from board where user_pwd=?";
	//String DELETE="delete from board where b_no=?";
	//String UPDATE="update board set b_subject=?, b_name=?,b_text=? where b_no=?";
			
}
