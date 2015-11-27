package control;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BoardService;
import model.BoardVO;

public class MemInfoController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		ModelAndView mv = new ModelAndView();
		BoardService service = BoardService.getInstance();
		try{
			HttpSession session=request.getSession();
			session.setAttribute("mb_id", service.getMb_id());
			BoardVO vo = service.getMemberInfo();
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		return mv;
	}

}
