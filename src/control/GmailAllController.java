package control;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BoardService;

public class GmailAllController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		BoardService service=BoardService.getInstance();
		ModelAndView mv=new ModelAndView();
		String gmailOK="gmailOK";
		System.out.println("gmailAll컨트롤러");
		try {
			ArrayList list=service.getGmailBoard();
			request.setAttribute("gmailAll", list);
			request.setAttribute("gmailOK", gmailOK);
			mv.setPath("mailview.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}

}
