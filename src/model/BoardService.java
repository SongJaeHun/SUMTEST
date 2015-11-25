package model;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;

import mail.AddAccInfo;
import mail.MailContent;

public class BoardService {
	private static BoardService instance=new BoardService();
	private BoardService(){}
	public static BoardService getInstance(){
		return instance;
	}
	BoardDao dao=BoardDao.getInstance();
	
	public ArrayList getAllBoard() throws SQLException{
		return dao.getAllBoard();
		
	}
	
	public int registContent(MailContent mail) throws SQLException{
		int updateCount = dao.registCount(mail);
		return updateCount;
	}
	
	public ArrayList getBoardView(int acc_id) throws SQLException{
		ArrayList list=dao.getMailView(acc_id);
		return list;
	}
	
	public ArrayList getGmailBoard(int acc_id) throws SQLException{
		ArrayList list=dao.getGmailBoard(acc_id);
		return list;
	}
	
	public ArrayList getGmailBoard() throws SQLException{
		ArrayList list=dao.getGmailBoard();
		return list;
	}
	
	public ArrayList getSearch(String search) throws SQLException{
		ArrayList searchMailList =dao.getSearch(search);
		return searchMailList;
	}
	
	public ArrayList getRecent() throws SQLException{
		ArrayList getRecent = dao.getRecent();
		return getRecent;
	}
	
	public ArrayList getNaverBoard(int acc_id) throws SQLException{
		ArrayList list=dao.getNaverBoard(acc_id);
		return list;
	}
	
	public ArrayList getNaverBoard() throws SQLException{
		ArrayList list=dao.getNaverBoard();
		return list;
	}
	
	public ArrayList getHotmailBoard(int acc_id) throws SQLException{
		ArrayList list=dao.getHotmailBoard(acc_id);
		return list;
	}
	
	public ArrayList getHotmailBoard() throws SQLException{
		ArrayList list=dao.getHotmailBoard();
		return list;
	}
	
	public void getMail(ArrayList accList) throws SQLException{
		dao.getMail(accList);
	}
	
	public ArrayList login(BoardVO vo) throws SQLException{
		return dao.login(vo.getUser_id(),vo.getUser_pwd());
	}
	
	public ArrayList getRegistResult(AddAccInfo addInfo) throws SQLException{
		return dao.getRegistResult(addInfo);
	}
	
	
	public ArrayList register(BoardVO vo) throws SQLException{
		return dao.register(vo.getUser_id(),vo.getUser_pwd(),vo.getUser_name(),vo.getCf_email());
	}
	
	public BoardVO getDetailView(int mail_no) throws SQLException{
		BoardVO vo = dao.getDetailView(mail_no);
		System.out.println(vo);
		return vo;
	}
	/*public BoardVO getBoardView(int b_no) throws SQLException{
		dao.incrementConut(b_no);
		BoardVO vo=dao.getBoardView(b_no);
		return vo;
	}
	public String passCheck(int b_no) throws SQLException{
		String pass=dao.isPass(b_no);
		return pass;
	}*/
	public boolean getAccCheck(String mail_id) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getAccCheck(mail_id);
	}
	public boolean removeAcc(int acc_id) throws SQLException {
		// TODO Auto-generated method stub
		return dao.removeAcc(acc_id);
	}
	public void updateDeleteFlag(int accountId) throws SQLException {
		// TODO Auto-generated method stub
		 dao.updateDeleteFlag(accountId);
		
	}
	public ArrayList getLoninInfo() throws SQLException {
		// TODO Auto-generated method stub
		return dao.loginInfo();
	}
	public BoardVO getMemberInfo() throws SQLException {
		// TODO Auto-generated method stub
		return dao.getMemberInfo();
	}
	public Date getLastReceivedDate(int accountId) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getLastReceivedDate(accountId);
	}
	public boolean getExistFlag(int accountId) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getExistFlag(accountId);
	}
		
}
