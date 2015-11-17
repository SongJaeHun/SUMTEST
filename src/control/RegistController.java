package control;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardService;

public class RegistController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		BoardService service = BoardService.getInstance();
		ModelAndView mv = new ModelAndView();
		String mail_id = request.getParameter("mail_id_1");
		String mail_id2 = request.getParameter("mail_id_2");
		String siteAdd = request.getParameter("siteAdd");
		String count = request.getParameter("count_3");
		System.out.println(mail_id + " zzz " + siteAdd);
		System.out.println(mail_id2 + " bbb " + siteAdd + "ㅁㅁㅁ" + request.getParameter("mail_id_3"));
		System.out.println(count) ;
		return mv;
	}

}
