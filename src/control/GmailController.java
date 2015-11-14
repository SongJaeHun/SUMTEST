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
		int acc_id=0;
		acc_id=Integer.parseInt(request.getParameter("acc_id"));
		System.out.println("gmail컨트롤러"+acc_id+"***");
		try {
			ArrayList list=service.getGmailBoard(acc_id);
			request.setAttribute("gmail", list);
			mv.setPath("mailview.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}

}
