package control;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BoardService;
import model.BoardVO;

public class RegisterController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		BoardService service=BoardService.getInstance();
		ModelAndView mv=new ModelAndView();
		String user_id = request.getParameter("user_id");
		String user_pwd = request.getParameter("user_pwd");
		String user_name = request.getParameter("user_name");
		String cf_email = request.getParameter("cf_email");
		
		BoardVO vo = new BoardVO(user_id,user_pwd,user_name,cf_email);
		ArrayList list = null;
		
		try{
			list = service.register(vo);	//로그인 된 계정 목록들..
			
			System.out.println("***회원가입컨트롤러 리스트 ");
			if(list.isEmpty()==false){
				System.out.println("회원가입 성공!!");
				mv.setPath("index.jsp");
			}else{
				System.out.println("회원가입 실패!!!");
				mv.setPath("index.jsp");
			}
			
			/*if(list != null){
				//list 를 넘겨서 메일 받을수 있게 함수 작성 할 것. service.getMail(Arraylist list);
				service.getMail(list);
			}*/
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		return mv;

	}

}
