package control;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
			BoardVO vo = service.getMemberInfo();
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		return mv;
	}

}
