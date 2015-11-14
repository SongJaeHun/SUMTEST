package control;

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
		ArrayList list = null;
		try{
			list = service.login(vo);	//로그인 된 계정 목록들..
			
			if(vo!=null){
				HttpSession session=request.getSession();
				session.setAttribute("loginInfo",list);
				mv.setPath("DispatcherServlet?command=home");
			}else{
				mv.setPath("login_fail.jsp");
			}
			
			if(list != null){
				//list 를 넘겨서 메일 받을수 있게 함수 작성 할 것. service.getMail(Arraylist list);
				service.getMail(list);
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		return mv;

	}

}
