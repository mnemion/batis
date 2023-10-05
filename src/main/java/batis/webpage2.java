package batis;

import java.net.Inet4Address;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPClientConfig;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class webpage2 {
	
	@PostMapping("/ajax2.do")
	public String ajax2(@RequestBody String data, Model m) throws Exception {
		JSONParser jp = new JSONParser();
		JSONObject jo = (JSONObject)jp.parse(data);
		System.out.println(jo.get("userid"));
		return "ajax";
	}
	
	//name 형태로 fetch ajax 통신을 할 경우
	@PostMapping("/ajax.do")
	public String ajax(@RequestParam(required = false) String userid,
			@RequestParam(required = false) String usertel,
			Model m) {
		System.out.println(userid);
		System.out.println(usertel);
		m.addAttribute("mid", userid);
		m.addAttribute("mtel", usertel);
		return "ajax";
	}
	
	
	@PostMapping("/pay2.do")
	public String pay2(@RequestParam(required = false) String product_code
			,@RequestParam(required = false) String product_name
			,@RequestParam(required = false) String product_money
			,@RequestParam(required = false) String product_ea
			, Model m) {
		//addAllAttributes : Collection, Map (배열 형태로 view로 보낼 때 사용함)
		List<String> pd = new ArrayList<String>();
		pd.add(product_code);
		pd.add(product_name);
		pd.add(product_money);
		pd.add(product_ea);
		
		//System.out.println(pd);
		//m.addAllAttributes(Collection<String>, null);
		
		//Collection<String> cl = new ArrayList<String>();
		m.addAllAttributes(Arrays.asList(pd));
		
		return "pay2";
	}
	
	@PostMapping("/pay3.do")
	public String pay3(@ModelAttribute("data") paydto paydto, HttpServletRequest req) {
		req.setAttribute("goodcode", paydto.getGoodcode());
		req.setAttribute("price", paydto.getPrice());
		req.setAttribute("buyeremail", paydto.getBuyeremail());
		req.setAttribute("buyername", paydto.getBuyername());
		req.setAttribute("goodea", paydto.getGoodea());
		req.setAttribute("goodname", paydto.getGoodname());
		req.setAttribute("gopaymethod", paydto.getGopaymethod());
		req.setAttribute("rec_addr", paydto.getRec_addr());
		req.setAttribute("rec_post", paydto.getRec_post());
		req.setAttribute("rec_addr_dtc", paydto.getRec_addr_dtc());
		req.setAttribute("buyertel", paydto.getBuyertel());
		req.setAttribute("point", paydto.getPoint());
		
		return "pay3";
	}
	
	
	
	@Resource(name="filem")
	private filemodule fm;
	
	/* FTP 정보 관련 변수 */
	private String host;	//호스트 번호
	private String user;	//FTP 사용자 아이디
	private String pass;	//FTP 사용자 패스워드
	private int port;	//FTP 포트
	
	//FTP CDN 연결형태 (CDN - 콘텐츠 전송 네트워크 = 영상, 이미지, 파일)
	@RequestMapping("/ftpcon.do")
	//MultipartFile : 기본이 Stream 코드로 작동함
	public String ftpcon(MultipartFile mfile, HttpServletRequest req, Model m) {
		FTPClient ftp = new FTPClient();
		ftp.setControlEncoding("utf-8");	//한글 깨짐 방지
		FTPClientConfig cf = new FTPClientConfig();
		try {
			String filename = mfile.getOriginalFilename();
			System.out.println(filename);
			
			InetAddress inet = Inet4Address.getLocalHost();
			String ip = inet.getHostAddress();
			System.out.println(ip);
			
			this.host = "iup.cdn1.cafe24.com";
			this.user = "caffrey";
			this.pass = "TJwl9983!";
			this.port = 21;
			ftp.configure(cf);	//FTP Client로 연결을 준비하는 단계
			ftp.connect(this.host, this.port);	//Client로 서버에 접근 (호스트 정보, 포트 정보)
			
			if(ftp.login(this.user, this.pass)) {	//FTP 로그인(아이디, 패스워드)
				//BINARY_FILE_TYPE : 이미지, 동영상, 문서(PPT)
				//ASCII_FILE_TYPE : TXT파일
				ftp.setFileType(FTP.BINARY_FILE_TYPE);	//파일 전송 유형
				//System.out.println(ftp);	//접속 성공 시 정상적으로 해당 정보를 출력
				int rp = ftp.getReplyCode();	//status = 200 (정상)
				System.out.println(rp);
				//ftp.makeDirectory("img");	//디렉토리 생성
				//ftp.removeDirectory("img"); //디렉토리 삭제
				
				//FTP 파일 업로드 코드 (storeFile)
				boolean result = ftp.storeFile("/www/img/"+filename, mfile.getInputStream());
				if(result == true) {
					//DB 저장
					String url ="http://caffrey.cdn1.cafe24.com/www/img/"+filename;
					m.addAttribute("imgsrc", url);
					System.out.println("정상적으로 업로드 되었습니다.");
					
					//FTP 파일삭제 (deleteFile)
					boolean delok = ftp.deleteFile("/www/img/76caanm.png");
					System.out.println(delok);
					
				} else {
					System.out.println("해당 디렉토리 및 파일에 문제가 발생하였습니다.");
				}
			}
			else {
				System.out.println("FTP 정보가 올바르지 않습니다.");
			}
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("FTP 접속 정보 오류 및 접속 사용자 오버!!");
		}
		finally {
			try {
				ftp.disconnect();	//FTP 접속 종료!!
			}
			catch(Exception e) {
				System.out.println("접속 종료 오류 발생!!");
			}
		}
		return null;
	}
	
	
	private filevo fvo;	
	private memberdto md;
	@RequestMapping("fileview.do")
	public String fview(Model m) {
		
		List<filevo> list = fm.select();
		//System.out.println(fv.get(0).getFname());
		m.addAttribute("data", list);
		return "/view";
	}
	
	@Resource(name="members")
	private member_module mm;
	
	@PostMapping("/idcheck.do")
	public String idcheck(Model m,@RequestParam(required = false) String userid,HttpServletResponse res) {
		//res.setHeader("Access-Control-Allow-Origin", "*");
		//res.setHeader("Access-Control-Allow-Credentials", "true");	
		//res.setHeader("Access-Control-Allow-Headers", "origin");
		
		try {
			memberdto dto=mm.search_id(userid);  
			if(dto ==null) {
				m.addAttribute("mid","no");
			}else {
				m.addAttribute("mid","yes"); //getter로드시 null일 경우 100% 오류가 발생
			}
			
			
		}catch(Exception e) {
			System.out.println("오류1");
			
		}
		
		return "/WEB-INF/jsp/idcheck";
	}
	
	@Inject
	private SqlSessionFactory factory;
	
	@RequestMapping("/subpage.do")
	public String subpage(Model m) {
		new topclass(m);
		new topclass(m, factory);
		return "subpage";
	}
	
	@RequestMapping("/index.do")
	public String index(Model m) {
		new topclass(m);
		new topclass(m, factory);
		return "index";
	}
}

class topclass {
	SqlSession se = null;
	public topclass(Model m) {
		this.top(m);
	}
	
	public topclass(Model m, SqlSessionFactory factory) {
		this.se = factory.openSession();
		this.footer(m);
	}
	
	@RequestMapping("/topmenu.do")
	public String top(Model m) {
		m.addAttribute("data", "홍길동");
		return "topmenu";
	}
	
	@RequestMapping("/footer.do")
	public String footer(Model m) {
		copyrightdto dto = this.se.selectOne("memberDB.copys");
		m.addAttribute("copy", dto);
		return "footer";
	}
}