package control;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BoardService;

public class HomeController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		BoardService service=BoardService.getInstance();
		ModelAndView mv=new ModelAndView();
		try {
			HttpSession session=request.getSession();
			System.out.println("홈컨트롤러 로그인인포 값 " + session.getAttribute("loginInfo"));
			ArrayList list=service.getAllBoard();
			System.out.println("home컨트롤러 ********" + list);
			request.setAttribute("home", list);
			mv.setPath("home.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}

}
