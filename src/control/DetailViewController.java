package control;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardService;
import model.BoardVO;

public class DetailViewController implements Controller {

   @Override
   public ModelAndView execute(HttpServletRequest request,
         HttpServletResponse response) {
      BoardService service=BoardService.getInstance();
      ModelAndView mv=new ModelAndView();
      
      int mail_no=0;
         mail_no=Integer.parseInt(request.getParameter("mail_no"));
      
      System.out.println("mail_no 컨트롤"+ mail_no +"*1**");
      
      try {
         BoardVO vo = service.getDetailView(mail_no);
         request.setAttribute("detail", vo);
         request.setAttribute("html_path", vo.getHtml_path());
         String filePaths[] = vo.getFilePaths();
         
        
         
         if(filePaths != null){
        	 for(int i = 0 ; i < filePaths.length ; i++){
          		String temp = filePaths[i].substring(
          				filePaths[i].indexOf("-") + 1 , filePaths[i].length());
         		
          		filePaths[i] = temp.substring(
         				temp.indexOf("-") + 1 , temp.length());
          		
          		
              }
        	 
         }
         
         request.setAttribute("filePaths", filePaths);
         System.out.println(vo.getHtml_path());
         mv.setPath("detailview.jsp");
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      return mv;
   }

}
