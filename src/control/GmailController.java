package control;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardService;

public class GmailController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		BoardService service=BoardService.getInstance();
		ModelAndView mv=new ModelAndView();
		try {
			ArrayList list=service.getGmailBoard();
			request.setAttribute("gmail", list);
			mv.setPath("gmail.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}

}
