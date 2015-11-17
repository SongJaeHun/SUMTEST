package control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardService;

public class AccCheckController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		BoardService service = BoardService.getInstance();
		ModelAndView mv = new ModelAndView();
		
		String mail_id = request.getParameter("mail_id");
		System.out.println(mail_id);
		try{
			boolean isCheck = service.getAccCheck(mail_id);
			if(isCheck){
				mv.setPath("setting.jsp");
				System.out.println("******&&12324345&&&&&&&&&***********");

			}else{
				System.out.println("******&&&&&&&&&&&&&&&&&&&&&&***********");
				mv.setPath("index.html");
				
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		return mv;	
		
	}

}
