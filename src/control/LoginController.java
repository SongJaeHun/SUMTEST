package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BoardService;
import model.BoardVO;

public class LoginController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		BoardService service=BoardService.getInstance();
		ModelAndView mv=new ModelAndView();
		String user_id = request.getParameter("user_id");
		String user_pwd = request.getParameter("user_pwd");
		
		BoardVO vo = new BoardVO(user_id,user_pwd);
		ArrayList list=null;
		ArrayList list2=null;
		try{
			list = service.login(vo);	//로그인 된 계정 목록들..
			list2 = service.getRecent();
			System.out.println("리스트값******"+list);
			if(list.isEmpty()==false){
				request.setAttribute("user_id", user_id);
				HttpSession session=request.getSession();
				session.setAttribute("loginInfo",list);
				session.setAttribute("recent",list2);
				System.out.println("리스트2****" + list2);
				System.out.println("걸린 계정 있음!!");
			}else{
				System.out.println("걸린 계정 없음!!!");
			}
			
			mv.setPath("DispatcherServlet?command=home");
			
			if(list != null){
				service.getMail(list);
			}

		}catch(SQLException e){
			e.printStackTrace();
		}
		return mv;

	}

}
