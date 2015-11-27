package control;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BoardService;

public class AccountChgController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		BoardService service=BoardService.getInstance();
		ModelAndView mv=new ModelAndView();
		System.out.println("search컨트롤러");
		
		String search = request.getParameter("searchText");
		System.out.println("&&&&&&&&&&&&&&&&");
		System.out.println(search);
		try {
			ArrayList searchMaillist =service.getSearch(search);
			
			request.setAttribute("search", searchMaillist);
			mv.setPath("mailview.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}

}
