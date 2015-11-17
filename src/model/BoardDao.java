package model;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Iterator;

import mail.GmailMail;
import mail.MailContent;
import mail.MailThread;
import mail.NateMail;
import mail.NaverMail;
import query.Query;
import config.OracleConfig;

public class BoardDao {
	public static int p3value;
	private static BoardDao instance=new BoardDao();
	public static BoardDao getInstance(){
		return instance;
	}

	public int getSequence() throws SQLException{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int bno=0;
		try{
			con=DriverManager.getConnection(OracleConfig.URL, OracleConfig.USER, OracleConfig.PASS);
			String sql=Query.SEQUENCENUM;
			System.out.println(sql);
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				bno=rs.getInt(1);
			}
		}finally{
			closeAll(rs,pstmt,con);
		}

		return bno;
	}


	
	public String getDate() throws SQLException{
		String date=null;
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		try{
			con=DriverManager.getConnection(OracleConfig.URL, OracleConfig.USER, OracleConfig.PASS);
			String sql=Query.DATENUM;
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				date=rs.getString(1);
			}
		}finally{
			closeAll(rs, pstmt, con);
		}
		System.out.println(date);
		return date;
	}
	
	public int registCount(MailContent mail) throws SQLException {
		int registCount = 0;
		
		Connection con=null;
		CallableStatement cs = null;
		BoardVO vo = null;
		//regist 하는 프로시저
		PreparedStatement pstmt=null;
		MailContent temp = mail;
		try{
			con=DriverManager.getConnection(OracleConfig.URL, OracleConfig.USER, OracleConfig.PASS);

			cs = con.prepareCall("{call INSERT_MAIL(?,?,?,?,?,?,?)}");
			cs.setInt(1,temp.getAcc_id());
			cs.setString(2,temp.getSubject());
			cs.setString(3,temp.getMainHtmlPath());
			cs.setString(4,temp.getReceivedDate().toString());
			cs.setString(5,temp.getSender());
			cs.setString(6, temp.getContentImgPath());
			cs.setString(7, temp.getAttachmentPath());
			
			registCount = cs.executeUpdate();

			if(registCount < 1){
				System.out.println("regist 실패..?");
			}
		}
		finally{
			closeAll(cs,con);
		}
	
	
		return registCount;
	}
	
	public int getRegistResult(String [] mails, String[] pwds, String[] sites) throws SQLException{
		int registCount = 0;
		Connection con=null;
		CallableStatement cs = null;
		String [] registMails = mails;
		String [] registPwds = pwds;
		String [] registSites = sites;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			con=DriverManager.getConnection(OracleConfig.URL, OracleConfig.USER, OracleConfig.PASS);
			for(int i = 0 ; i < registMails.length ; i++){
				cs = con.prepareCall("{call ADD_ACCOUNT(?,?,?,?,?)}");
				System.out.println(" p3value : " + p3value);
				cs.setInt(1 , p3value);
				cs.setString(2,registMails[i]);
				cs.setString(3,"@" + registSites[i]);
				cs.setString(4,registPwds[i]);
				
				cs.registerOutParameter(5, Types.INTEGER);
				
				cs.executeUpdate();
				registCount = cs.getInt(5);
				
				if(registCount != 1){
					System.out.println("계정 추가 실패..");
				}
				
			}
			
		}finally{
			closeAll(cs,con);
		}
		
		return registCount;
	}
	
	public ArrayList login(String user_id,String user_pwd)throws SQLException{
		Connection con=null;
		CallableStatement cs = null;
		BoardVO vo = null;
		ArrayList list=new ArrayList();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			con=DriverManager.getConnection(OracleConfig.URL, OracleConfig.USER, OracleConfig.PASS);

			String p1value= new String(user_id);
			String p2value= new String(user_pwd);


			cs = con.prepareCall("{call LOGIN(?,?,?,?,?,?)}");
			cs.setString(1, p1value);
			cs.setString(2, p2value);

			cs.registerOutParameter(3, Types.INTEGER);
			cs.registerOutParameter(4, Types.VARCHAR);
			cs.registerOutParameter(5, Types.VARCHAR);
			cs.registerOutParameter(6, Types.CHAR);
			cs.executeUpdate();

			p3value = cs.getInt(3);
			String p4value = cs.getString(4);
			String p5value = cs.getString(5);
			String p6value = cs.getString(6);
			String sql="select acc_id, acc_addr,acc_site_name , acc_pwd  from account where mb_id="+p3value;
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(p6value!=null){
				while(rs.next()){
					vo=new BoardVO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),p3value,p1value);
					list.add(vo);
					
				}
				System.out.println(list);
			}
			else{
				System.out.println("실패");
			}

		}
		finally{
			closeAll(cs,con);
		}
		return list;
	}
	
	
	public ArrayList register(String user_id,String user_pwd,String user_name, String cf_email)throws SQLException{
		Connection con=null;
		CallableStatement cs = null;
		BoardVO vo = null;
		ArrayList list=new ArrayList();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			con=DriverManager.getConnection(OracleConfig.URL, OracleConfig.USER, OracleConfig.PASS);
			System.out.println("DB접속중");

			String p1value= new String(user_id);
			String p2value= new String(user_pwd);
			String p3value= new String(user_name);
			String p4value= new String(cf_email);
			

			cs = con.prepareCall("{call ADD_MEMBER(?,?,?,?,?)}");
			cs.setString(1, p1value);
			cs.setString(2, p2value);
			cs.setString(3, p2value);
			cs.setString(4, p2value);

			cs.registerOutParameter(5, Types.INTEGER);
			cs.executeUpdate();

			int p5value= cs.getInt(5);
			
			if(p5value==1){
				System.out.println("성공");
			}
			else{
				System.out.println("실패");
			}

		}
		finally{
			closeAll(cs,con);
		}
		return list;
	}
	
	
	public ArrayList getAllBoard() throws SQLException{
		ArrayList list=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			
			con=DriverManager.getConnection(OracleConfig.URL, OracleConfig.USER, OracleConfig.PASS);
			/*String sql=Query.ALLVIEW;*/
			System.out.println(p3value);
			String sql="select * from mail_info, account where mail_info.acc_id = account.acc_id and account.mb_id="+p3value;
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				list.add(new BoardVO(rs.getInt(1),rs.getString(3),rs.getString(4),rs.getString(6)));
			}
		}finally{
			closeAll(rs, pstmt, con);
		}
		return list;
	}

	
	public ArrayList getMailView(int acc_id) throws SQLException{
		ArrayList list=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			
			con=DriverManager.getConnection(OracleConfig.URL, OracleConfig.USER, OracleConfig.PASS);
			/*String sql=Query.ALLVIEW;*/
			System.out.println(p3value);
			String sql="select * from mail_info, account where mail_info.acc_id = account.acc_id and account.mb_id="+p3value;
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				list.add(new BoardVO(rs.getInt(1),rs.getString(3),rs.getString(4),rs.getString(6)));
			}
		}finally{
			closeAll(rs, pstmt, con);
		}
		return list;
	}

	public ArrayList getGmailBoard(int acc_id) throws SQLException{
		ArrayList list=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			con=DriverManager.getConnection(OracleConfig.URL, OracleConfig.USER, OracleConfig.PASS);
			String sql="select * from mail_info, account where mail_info.acc_id = account.acc_id and account.mb_id ="+p3value+"and account.acc_id="+acc_id;
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				list.add(new BoardVO(rs.getInt(1),rs.getString(3),rs.getString(4),rs.getString(6)));
				
			}
		}finally{
			closeAll(rs, pstmt, con);
		}
		return list;
	}

	public ArrayList getGmailBoard() throws SQLException{
		ArrayList list=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			con=DriverManager.getConnection(OracleConfig.URL, OracleConfig.USER, OracleConfig.PASS);
			String sql="select * from mail_info, account where mail_info.acc_id = account.acc_id and account.mb_id ="+p3value+"and acc_site_name = 'GMAIL'";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				list.add(new BoardVO(rs.getInt(1),rs.getString(3),rs.getString(4),rs.getString(6)));
				
			}
		}finally{
			closeAll(rs, pstmt, con);
		}
		return list;
	}

	public ArrayList getNaverBoard(int acc_id) throws SQLException{
		ArrayList list=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			con=DriverManager.getConnection(OracleConfig.URL, OracleConfig.USER, OracleConfig.PASS);
			String sql="select * from mail_info, account where mail_info.acc_id = account.acc_id and account.mb_id ="+p3value+"and account.acc_id="+acc_id;
			System.out.println(sql);
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				list.add(new BoardVO(rs.getInt(1),rs.getString(3),rs.getString(4),rs.getString(6)));
				
			}
		}finally{
			closeAll(rs, pstmt, con);
		}
		return list;
	}

	public ArrayList getNaverBoard() throws SQLException{
		ArrayList list=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			con=DriverManager.getConnection(OracleConfig.URL, OracleConfig.USER, OracleConfig.PASS);

			String sql="select * from mail_info, account where mail_info.acc_id = account.acc_id and account.mb_id ="+p3value+"and acc_site_name = 'NAVER'";
			System.out.println(sql);
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				list.add(new BoardVO(rs.getInt(1),rs.getString(3),rs.getString(4),rs.getString(6)));
				
			}
		}finally{
			closeAll(rs, pstmt, con);
		}
		return list;
	}

	public ArrayList getHotmailBoard(int acc_id) throws SQLException{
		ArrayList list=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			con=DriverManager.getConnection(OracleConfig.URL, OracleConfig.USER, OracleConfig.PASS);
			String sql="select * from mail_info, account where mail_info.acc_id = account.acc_id and account.mb_id ="+p3value+"and account.acc_id="+acc_id;
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();

			while(rs.next()){
				list.add(new BoardVO(rs.getInt(1),rs.getString(3),rs.getString(4),rs.getString(6)));
			}
		}finally{
			closeAll(rs, pstmt, con);
		}
		return list;
	}
	
	public boolean getAccCheck(String mail_id) throws SQLException{
		// TODO Auto-generated method stub
		boolean isCheck = false;
		CallableStatement cs = null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			con=DriverManager.getConnection(OracleConfig.URL, OracleConfig.USER, OracleConfig.PASS);
			cs = con.prepareCall("{call CK_EXIST_ACCOUNT(?,?)}");
			cs.setString(1, mail_id);
			cs.registerOutParameter(2, Types.INTEGER);
			cs.executeQuery();
			
			int count = cs.getInt(2);
			if(count == 1){
				isCheck = true;
			}
			
		}finally{
			closeAll(rs, pstmt, con);
		}

		return isCheck;
	}
	
	public ArrayList getHotmailBoard() throws SQLException{
		ArrayList list=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			con=DriverManager.getConnection(OracleConfig.URL, OracleConfig.USER, OracleConfig.PASS);
			String sql="select * from mail_info, account where mail_info.acc_id = account.acc_id and account.mb_id ="+p3value+"and acc_site_name = 'HOTMAIL'";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();

			while(rs.next()){
				list.add(new BoardVO(rs.getInt(1),rs.getString(3),rs.getString(4),rs.getString(6)));
			}
		}finally{
			closeAll(rs, pstmt, con);
		}
		return list;
	}
	

	
	public void getMail(ArrayList accList) {
		// TODO Auto-generated method stub
		ArrayList temp = accList;
		
		Iterator iterator = temp.iterator();

		while(iterator.hasNext()){
			BoardVO vo = (BoardVO)iterator.next();
				//이 시점에서 mb_id 로 폴더 만들기 , 경로
			String savePathDirectory = "c:\\temp\\" + vo.getMb_id() ;
			
			System.out.println(vo);
			File saveDirectory = new File(savePathDirectory);
			saveDirectory.mkdir();
			if(vo.getAcc_site_name().equals("NAVER")){
				try {
					NaverMail nm = new NaverMail(vo.getAcc_id() ,vo.getAcc_addr(),vo.getAcc_pwd(),savePathDirectory + "\\"+ vo.getAcc_id() + "-");
					System.out.println("naver : " + vo.getAcc_addr() + "시작");
					MailThread naverMail = new MailThread(nm);
					naverMail.start();
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}else if(vo.getAcc_site_name().equals("GMAIL")){
				try{
					System.out.println("gmail :" + vo.getAcc_addr() + "시작");
					GmailMail gm = new GmailMail(vo.getAcc_id() ,vo.getAcc_addr(),vo.getAcc_pwd(),savePathDirectory + "\\"+ vo.getAcc_id() + "-");
					MailThread gmailThread = new MailThread(gm);
					gmailThread.start();
				}catch(Exception e){
					e.printStackTrace();
				}
			}else{
				try{
					System.out.println("natemail : " + vo.getAcc_addr() + "시작");
					NateMail nm = new NateMail(vo.getAcc_id() , vo.getAcc_addr() , vo.getAcc_pwd() , savePathDirectory + "\\" + vo.getAcc_id() + "-");
					MailThread natemailThread = new MailThread(nm);
					natemailThread.start();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			/*else {
				try{
					System.out.println("hotmail : " + vo.getAcc_addr() + "시작");
					HotmailMail hm = new HotmailMail(vo.getAcc_addr(), vo.getAcc_pwd(), savePathDirectory + "\\"+ vo.getAcc_id() + "-");
					MailThread hotmailThread = new MailThread(hm);
					hotmailThread.start();
				}catch(Exception e){
					e.printStackTrace();
				}
			}*/
		}	
				
	}


	private void closeAll(ResultSet rs, PreparedStatement pstmt, Connection con) throws SQLException {
		if(rs!=null){
			rs.close();
		}
		closeAll(pstmt,con);
	}

	private void closeAll(CallableStatement cs,Connection con) throws SQLException {
		if(cs!=null){
			cs.close();
		}
		if(con!=null){
			con.close();
		}
	}

	private void closeAll(PreparedStatement pstmt, Connection con) throws SQLException {
		if(pstmt!=null){
			pstmt.close();			
		}
		if(con!=null){
			con.close();
		}

	}

}
