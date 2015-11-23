package control;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardService;

public class DownController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		ModelAndView mv = new ModelAndView();
		
		String attachmentPath = request.getParameter("file_path");
		System.out.println("첨부파일 경로 : " + attachmentPath);
		
		String saveDir = "C:\\\\Users\\\\sjh\\\\Downloads\\\\";
		System.out.println(saveDir);
		
		
		
		String temp = attachmentPath.substring(
				attachmentPath.indexOf("-") + 1 , attachmentPath.length());
		
		String saveFileName = temp.substring(
				temp.indexOf("-") + 1 , temp.length());

		
		System.out.println("saveFileName : " + saveFileName);
		
		try {
			
			response.setHeader("Content-Disposition", "attachment;filename=\""+ saveFileName + "\";");
			
			FileInputStream fileInputStream = new FileInputStream(attachmentPath);
		
			ServletOutputStream servletOutputStream = response.getOutputStream();
			
			byte b[] = new byte[1024];
			int data = 0;
			
			while((data=(fileInputStream.read(b,0,b.length))) != -1){
				servletOutputStream.write(b,0,data);
			}
			servletOutputStream.flush();
			servletOutputStream.close();
			fileInputStream.close();
			
		
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		mv.setPath("detailview.jsp");
		
		return mv;
	}

}
