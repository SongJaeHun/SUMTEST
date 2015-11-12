package control;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardService;

public class NaverController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		BoardService service=BoardService.getInstance();
		ModelAndView mv=new ModelAndView();
		try {
			ArrayList list=service.getNaverBoard();
			request.setAttribute("naver", list);
			mv.setPath("naver.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}

}
