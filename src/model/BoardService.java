package model;

import java.sql.SQLException;
import java.util.ArrayList;

public class BoardService {
	private static BoardService instance=new BoardService();
	private BoardService(){}
	public static BoardService getInstance(){
		return instance;
	}
	BoardDao dao=BoardDao.getInstance();
	
	public ArrayList getAllBoard() throws SQLException{
		ArrayList list=dao.getAllBoard();
		return list;
	}
	
	public ArrayList getBoardView(int acc_id) throws SQLException{
		ArrayList list=dao.getMailView(acc_id);
		return list;
	}
	
	public ArrayList getGmailBoard(int acc_id) throws SQLException{
		ArrayList list=dao.getGmailBoard(acc_id);
		return list;
	}
	
	public ArrayList getNaverBoard(int acc_id) throws SQLException{
		ArrayList list=dao.getNaverBoard(acc_id);
		return list;
	}
	
	public ArrayList getHotmailBoard(int acc_id) throws SQLException{
		ArrayList list=dao.getHotmailBoard(acc_id);
		return list;
	}
	
	/*public void getMail(ArrayList accList) throws SQLException{
		dao.getMail(accList);
	}*/
	
	public ArrayList login(BoardVO vo) throws SQLException{
		return dao.login(vo.getUser_id(),vo.getUser_pwd());
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
		
}
