package net.member.controller;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.member.action.Action;
import net.member.action.ActionForward;
/*
 * 멤버관련 컨트롤러
 */
@WebServlet("*.mem")
public class MemberFrontController extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	private Map<String, Object> commandMap = new HashMap<String, Object>();

	public MemberFrontController()
	{
		super();
	}

	public void init(ServletConfig config) throws ServletException
	{
		super.init(config);
		loadProperties("net/member/properties/Command");
	}
	//net/member/properties/Command파일에 대한 정보를 등록
	private void loadProperties(String path)
	{
		ResourceBundle rb = ResourceBundle.getBundle(path);
		Enumeration<String> actionEnum = rb.getKeys();
		
		while (actionEnum.hasMoreElements())
		{
			String command = actionEnum.nextElement();
			String className = rb.getString(command);
			
			try
			{
				Class<?> commandClass = Class.forName(className);
				Object commandInstance = commandClass.newInstance();
				commandMap.put(command, commandInstance);
			}
			catch (Exception e)
			{
				System.out.println(e.getMessage());
			}
		}

	}
	//겟방식 -> doProcess
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		doProcess(request, response);
	}
	//포스트방식 -> doProcess
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		doProcess(request, response);
	}
	//겟+포스트 둘다 허용
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//총URI
		String requestURI = request.getRequestURI();
		//현재프로그램의 경로
		String contextPath = request.getContextPath();
		//총URI-현재경로 = 접속요청한 명령어( 예) SmsMainView.sms
		String command = requestURI.substring(contextPath.length());
		
		//맵에 저장한 Properties의 정보가 있다면 가져오기
		ActionForward forward = setForward((Action) (commandMap.get(command)), request, response);
		if (forward != null)
		{
			//Redirect를 할것인지 포워드를 할것인지에 대한 정보를 바탕으로 이동
			if (forward.isRedirect())
			{
				response.sendRedirect(forward.getPath());
				return;
			}
			else
			{
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
		//에러페이지 출력
		else{
			response.sendRedirect("error/errorPage.jsp");
			return;
		}
	}
	//모델클래스에 다녀옴
	private ActionForward setForward(Action action, HttpServletRequest request, HttpServletResponse response)
	{
		ActionForward forward;
		try
		{
			forward = action.execute(request, response);
			return forward;
		} catch (Exception e)
		{
			System.out.println(e.getMessage());
		}

		return null;
	}

}
