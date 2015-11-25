package control;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DownController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		ModelAndView mv = new ModelAndView();
		
		String attachmentPath = request.getParameter("file_path");
		System.out.println("첨부파일 경로1 : " + attachmentPath);
		
//		attachmentPath = attachmentPath.replaceAll("\\", "\\");
	//	System.out.println("첨부파일 경로2 : " + attachmentPath);
		//String saveFileName = attachmentPath;
		attachmentPath = attachmentPath.trim();
		String saveFileName = attachmentPath.substring(
				attachmentPath.indexOf("-") + 1 , attachmentPath.length());


		saveFileName = saveFileName.substring(saveFileName.indexOf("-") + 1 , saveFileName.length());
		System.out.println("인코딩 전 : " + saveFileName);
		try {
			saveFileName = URLEncoder.encode(saveFileName,"UTF-8");
			System.out.println("인코딩 후 : " + saveFileName);
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
/*		String saveFileName = temp.substring(
				temp.indexOf("-") + 1 , temp.length());
*/
		
		
		try {
			

			
			FileInputStream fileInputStream = new FileInputStream(attachmentPath);

			//response.setHeader("Content-Disposition", "attachment;filename=\""+ saveFileName + "\";");
			response.setHeader("Content-Disposition", "attachment;filename="+ saveFileName + ";");
			
			response.setHeader("Content-Type", "application/octet-stream");
			
			response.setHeader("Content-Transfer-Encoding", "binary;");
			response.setHeader("Pragma", "no-cache;");
			response.setHeader("Expires", "-1;");
			
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
		
		//mv.setPath("detailview.jsp");
		
		return null;
	}

}
