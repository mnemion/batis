package batis;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.SimpleFormatter;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletSecurityElement;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.dbcp.BasicDataSource;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class webpage {
	datavo vo = new datavo();
	@Autowired	//XML에 등록된 bean에 대한 id값을 가져올 때 사용함
	BasicDataSource datasouce;
	//XML에 ID에 이름을 로드하여 해당 SQL 정보를 Class에 전달하게 됨.
	
	//@ModelAttribute : parameter, method형태를 구성하게 된다. vo, dto 형태로 구성이 원칙
	//해당 name값을 vo나 dto에 동일하게 셋팅을 하며, Database Field명과 동일할 경우,
	//요청한 값을 모두 db에 저장시킬 수 있음.
	@SuppressWarnings("unused")
	
	
	@Inject    //xml에 대한 데이터를 가져올때 의존성 주입
	private SqlSessionFactory sqlsessionfactory;
	@Resource  //@Autowired 확장
	private SqlSessionTemplate sqlsession;
	
	/*
	 * @ModelAttribute (별명 명칭) 1개 이상 사용시 
	 * selectOne : 하나의 데이터만 가져올 때
	 * selectList : 해당 데이터를 범위 안에서 모두 가져올 때 
	 */
	
	
	
	
	
	
	
	@RequestMapping("/flieupok.do")
	public void uplaod(MultipartFile[] mfile, HttpServletRequest req) throws Exception {
		
		SqlSession se = sqlsessionfactory.openSession();
		
		
		String filename=null; //첨부파일 실제 이름
		String type1 =null; //첨부파일 type 가져오는 역활
		
		
		
		int ea = mfile.length;
		String url = req.getServletContext().getRealPath("/files/");
		//동일한 파일명을 제거하기 위해서 만들어 주는 코드
		System.out.println(url);
		Date dt = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
		
		
		//StringBuffer sb = new StringBuffer();
		ArrayList<String> sb = new ArrayList<String>();
		
		String rename= null;
		int w = 0;
		while(w < ea) {
			
			filename=mfile[0].getOriginalFilename();
			type1=filename.substring(filename.lastIndexOf("."));
			rename= sf.format(dt)+"_"+w+ type1;
			FileCopyUtils.copy(mfile[w].getBytes(), new File(url+rename));
			//sb.append("./files/"+rename+",");
			sb.add("./files/"+rename);
			Thread.sleep(1000); //작업을 1000=1초 일시정지
			w++;
		}
		String dbfilename = String.join(",", sb);  //arraylist, linkedlist, list에서만 사용 string.join : 배열을 문자열로 변경
		//int a = se.insert("reviewDB.files_insert",sb.toString());
		int a = se.insert("reviewDB.files_insert",dbfilename);
		if(a > 0) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	//리뷰 수정 완료
	@RequestMapping("/data_modify.do")
	public void modifyok(@ModelAttribute("review") datavo datavo) throws Exception {
		SqlSession se = sqlsessionfactory.openSession();
		
		int result = se.update("reviewDB.review_update",datavo);
		if(result > 0) {
			System.out.println("정상적으로 수정완료!!");
		}else {
			System.out.println("문법오류");
		}
		se.close();
	}
	
	
	
	
	
	
	//리뷰 수정
	@RequestMapping("/review_modify.do")
	public String review_view(Model m,@RequestParam(required = false) String ridx) {
		SqlSession se =null;
		try{
			se = sqlsessionfactory.openSession();
			//vo = se.selectOne("reviewDB.selectone", ridx);
			datavo vo = se.selectOne("reviewDB.selectone", ridx);
			//m.addAttribute("one",vo.getRname());
			
			ArrayList<String> onedata = new ArrayList<String>();
			onedata.add(vo.getRidx());
			onedata.add(vo.getRname());
			onedata.add(vo.getRpass());
			onedata.add(vo.getRtext());
			onedata.add(vo.getRindate());
			m.addAttribute("one",onedata);
		}catch(Exception e) {
			System.out.println("문법 오류");
		}finally {
			se.close();
		}
		
		return "/WEB-INF/jsp/review_view";
	}
	
	
	
	
	
	
	
	//리뷰 삭제
	@RequestMapping("review_delete.do")
	public String review_del(HttpServletResponse res,@RequestParam(required = false) String ridx) {
		PrintWriter pw = null;
		SqlSession se =null;
		try{
			se = sqlsessionfactory.openSession();
			int result = se.delete("reviewDB.review_delete",ridx);
			if(result > 0) {
				pw = res.getWriter();
				pw.write("<script>" + "alert('정상적으로 삭제 완료')" + "location.href='./review_list.do';" +"</script>");
				
			}else {
				System.out.println("sql문법 오류");
			}
			
		}catch(Exception e) {
			System.out.println("올바른 접근 방식이 아닙니다.");
		}finally {
			se.close();
		}
		
		return null;
	}
	// 리뷰 리스트 출력
	//defaultValue : 숫자형태 자료형일 때 사용
	//문자열일 떼 required =false를 사용
	@RequestMapping("/review_list.do")
	public void review_list(@RequestParam(required = false) String search, @RequestParam(defaultValue = "0") int ridx,HttpServletRequest req, HttpServletResponse res) {
		List<datavo> data = null;
		try {
			SqlSession se = sqlsessionfactory.openSession();
			String ct =se.selectOne("reviewDB.selectcount1");
			if(ridx < 2) {
				ridx=0;
			}else{
				int ctint = Integer.parseInt(ct);
				//ridx = ridx+(1-(ridx%1)%1);
				//ridx =(2*ridx)-2; 
				
				ridx=(ridx-1)*2;
			}
			if(search==null || search=="null" || search=="") {
				data = se.selectList("reviewDB.selectall",ridx);
			}else {
				data = se.selectList("reviewDB.selectsearch",search);
				
			}	
			
			req.setAttribute("ct", ct);
			req.setAttribute("data", data);
			req.setAttribute("search", search);
			//System.out.println(data.get(0).getRname());
			RequestDispatcher ds = req.getRequestDispatcher("/WEB-INF/jsp/review_list.jsp");  //
			ds.forward(req, res);
			se.close();
		}catch(Exception e) {
			System.out.println("Database 접속 오류 발생");
		}
	}
	
	
	
	
	
	
	@RequestMapping("/data_select.do")
	public String data_select(@ModelAttribute("review") datavo datvo) throws Exception{
		SqlSession se1 = sqlsessionfactory.openSession();
		
		/*List<String> li = new ArrayList<>();
		li=se1.selectList("reviewDB.selectcount",datvo);
		int a= li.size();
		System.out.println(a);*/
		
		SqlSession se = sqlsessionfactory.openSession();
		datavo dv = se.selectOne("reviewDB.selectcount1");
		System.out.println(dv.getCtn());
		return "/WEB-INF/jsp/login";
		//해당 페이지에 데이터 갯수가 출려 되도록 mybatis를 사용
	}
	
	@RequestMapping("/data_insert.do")
	public String data_insert(@ModelAttribute("review") datavo datavo) throws Exception {
		//System.out.println(datavo.getRname());
		
		SqlSession se = sqlsessionfactory.openSession();
		int a = se.insert("reviewDB.review_insert",datavo);
		if(a > 0) {
			System.out.println("정상적으로 리뷰가 등록 되었습니다.");
		}else {
			System.out.println("문법오류 발생");
		}
		return "/WEB-INF/jsp/login";
	}
	
	
	
	
	@RequestMapping("/login.do")
	public String logins() {	//BasicDataSource만 사용
		try {
			Connection con = datasouce.getConnection();
			String sql = "select count(*) as cnt from air_reserse";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			String result = rs.getString("cnt");
			System.out.println(result);
			rs.close();
			ps.close();
			con.close();
		}
		catch(Exception e) {
			System.out.println("Database 접속 오류!!");
		}
		
		return "/WEB-INF/jsp/login";
	}
}
