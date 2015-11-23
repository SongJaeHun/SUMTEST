package control;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BoardService;

public class RemoveAccController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		BoardService service = BoardService.getInstance();
		ArrayList accList = new ArrayList();
		String acc_id = request.getParameter("acc_id");
		boolean isRemove = false;
		try{
			isRemove = service.removeAcc(Integer.parseInt(acc_id));
			accList = service.getLoninInfo();
			HttpSession session = request.getSession();
			
			
			if(isRemove){
				//삭제 성공 --> accountDel.jsp 이동
				mv.setPath("DispatcherServlet?command=home");
			}else{
				session.setAttribute("isRemove", false);
				
				
				mv.setPath("accountDel.jsp");
			}
			session.setAttribute("loginInfo", accList);
			
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		
		
		return mv;
	}

}
