package control;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BoardService;

public class NaverController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		BoardService service=BoardService.getInstance();
		ModelAndView mv=new ModelAndView();
		String naverOK="naverOK";
		int acc_id=0;
		acc_id=Integer.parseInt(request.getParameter("acc_id"));
		System.out.println("naver컨트롤러"+acc_id+"***");
		try {HttpSession session=request.getSession();
		session.setAttribute("mb_id", service.getMb_id());
		System.out.println("네이버컨트롤러 세션 *------------------" + session.getAttribute("mb_id"));
			ArrayList list=service.getNaverBoard(acc_id);
			request.setAttribute("naver", list);
			request.setAttribute("naverOK", naverOK);
			mv.setPath("mailview.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}

}
