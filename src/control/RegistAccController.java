package control;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardService;

public class RegistAccController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		BoardService service = BoardService.getInstance();
		ModelAndView mv = new ModelAndView();
		String [] mails = request.getParameterValues("mail_id");
		String [] sites = request.getParameterValues("siteAdd");
		String [] pwds = request.getParameterValues("mail_pwd");
		
		
		try{
			int isRegist = service.getRegistResult(mails,pwds,sites);
			mv.setPath("home.jsp");
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		return mv;
	}

}
