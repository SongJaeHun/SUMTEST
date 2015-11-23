package control;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mail.AddAccInfo;
import model.BoardService;

public class RegistAccController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		BoardService service = BoardService.getInstance();
		ModelAndView mv = new ModelAndView();
		ArrayList accList = new ArrayList();
		AddAccInfo accInfo = new AddAccInfo(
										request.getParameterValues("mail_id"),
										request.getParameterValues("siteAdd"),
										request.getParameterValues("mail_pwd"));
		
		try{
			accList = service.getRegistResult(accInfo);
			HttpSession session=request.getSession();
			session.setAttribute("loginInfo",accList);
			mv.setPath("DispatcherServlet?command=home");
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		return mv;
	}

}
