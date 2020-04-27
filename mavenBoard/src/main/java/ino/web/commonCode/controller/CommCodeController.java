package ino.web.commonCode.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.commonCode.service.CommCodeService;

@Repository
@Controller
public class CommCodeController {
	
	@Autowired 
	private CommCodeService commCodeService;
	@Autowired
	private PlatformTransactionManager transactionManager;
	
	// 공통코드 메인화면
	@RequestMapping("/commonCode.ino")
	public ModelAndView commonCode(HttpServletRequest req) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		
		List<HashMap<String,Object>> list = commCodeService.selectMasterCodeList();
	
		mav.addObject("list" , list);
		mav.setViewName("commonCodeMain");
		
		return mav;
	}
	
	// 공통코드 상세보기
	@RequestMapping("/commonCodeDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request,
		@RequestParam(value = "code", defaultValue = "") String code)throws Exception{
		
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("code", code);
		List<HashMap<String, Object>> codeList = commCodeService.detailCommonCodeList(map);
		
		mav.setViewName("commonCodeDetail");
		mav.addObject("codeList", codeList);
		mav.addObject("map", map);
		
		return mav;
	}

	// 공통코드 등록하기
	@RequestMapping("/commonCodeInsert.ino")
	public String commonCodeInsert() {

		return "commonCodeInsert";
	}

	// 공통코드 추가하기 (공통코드 중복 후 추가하기)
	@RequestMapping(value = "/insertCommonCode.ino")
	@ResponseBody
	public HashMap<String,Object> insertCommonCode(HttpServletRequest request) throws Exception {
		// [1.] 수정 , 삭제 , 추가, 중복검사 값을 담을 리스트 변수 설정
		List<HashMap<String, Object>> insertList = new ArrayList<>();
		List<HashMap<String, Object>> modifyList = new ArrayList<>();
		List<HashMap<String, Object>> deleteList = new ArrayList<>();
		
		// [2]. [추가 데이터 값 , 수정 데이터 값]을 각각 form태그에 name으로 불러온다.
		String[] masterCode = request.getParameterValues("masterCode");
		String[] detailCode = request.getParameterValues("detailCode");
		String[] detailCodeName = request.getParameterValues("detailCodeName");
		String[] radioCheck = request.getParameterValues("radioCheck");
		String[] flag = request.getParameterValues("flag");
		
		// 마스터 코드를 담아 성공했을 때 return하여 주소 코드를 전달 위함
		HashMap<String, Object> paramMap5 = new HashMap<String, Object>();
		paramMap5.put("masterCode" , masterCode);
	
		// [3.] 데이터에 해당하는 값을 해당하는 리스트에 담아주기 위함이다.
		for (int i =0; i <flag.length; i++){
			
			if(flag[i].equals("I")){
				HashMap<String, Object> forMap = new HashMap<String, Object>();

				forMap.put("masterCode", masterCode[i]);
				forMap.put("detailCodeName", detailCodeName[i]);
				forMap.put("radioCheck", radioCheck[i]);
				forMap.put("detailCode", detailCode[i]);

				insertList.add(forMap); // 저장할려는 데이터를 담는 리스트	
			}
			if(flag[i].equals("M")){
	
				HashMap<String, Object> forMap = new HashMap<String, Object>();
					
				forMap.put("detailCodeName", detailCodeName[i]);
				forMap.put("radioCheck", radioCheck[i]);
				forMap.put("detailCode", detailCode[i]);
						
				modifyList.add(forMap); //수정할려는 데이터를 담는 리스트
				
			}
			if(flag[i].equals("D")){
				
				HashMap<String, Object> forMap = new HashMap<String, Object>();
				
				forMap.put("detailCode", detailCode[i]);
				
				deleteList.add(forMap); //삭제할려는 데이터를 담는 리스트
			}
		}			
	 	// [4.] 각각 for문으로 담은 값을 하나의 map에 담아 정리해준다.(list로 넘길 시는 불필요)
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("insertList", insertList);
			
		HashMap<String, Object> paramMap2 = new HashMap<String, Object>();
		paramMap2.put("modifyList", modifyList);
			
		HashMap<String, Object> paramMap3 = new HashMap<String, Object>();
		paramMap3.put("deleteList", deleteList);
			
	// [10.]트랜잭션 매니저 사용하기 (Autowired 자동주입)
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
	//[11.] try{}catch 사용	
	try{
		// [5.] 해당하는 리스트를 들고 DB에 값을 적용위해 if문을 돌린다.
		if(insertList.size() != 0){
			// [6.] insertList(paramMap)를 가지고 중복검사를 먼저 실행한다.
			int count = commCodeService.count(paramMap);
			
			// [12.] catch에서 사용 위해 paramMap5에 count 값을 담는다.(중복 또한 무결성 제약 오류이다.)
			paramMap5.put("count",count);
			
			// [7.] 중복검사가 완료 된다면 추가를 한다.(중복검사가 걸린다면 catch문으로 이동한다(중복은 오류므로 catch에 걸린다.))
			commCodeService.insertCommonCodeList(paramMap);	
			paramMap5.put("resultStr", "success");
			
		} 
		// [8.] 수정하기
		if(modifyList.size() != 0){
			commCodeService.ModifyCommonCodeList(paramMap2);
			paramMap5.put("resultStr", "success");
		}
		// [9.] 삭제하기
		if(deleteList.size() !=0){
			commCodeService.DeleteCommonCodeList(paramMap3);
			paramMap5.put("resultStr", "success");
		}
		
		transactionManager.commit(status);
		
	}catch(Exception e){
		// [12.] 중복오류 또는 데이터 값 초과 오류(중복 또한 무결성 제약 오류이다.) 즉 오류와 if문을 이용해 resultStr 값을 가져온다.
		if(insertList.size() != 0){
			int count = (int) paramMap5.get("count");
			
			if(count !=0){
				paramMap5.put("resultStr", "fail");
			}else{
				transactionManager.rollback(status);
				paramMap5.put("resultStr", "length");
			}
		}else{
			transactionManager.rollback(status);
			paramMap5.put("resultStr", "length");
		}
		
	}
	return paramMap5;
	}	
}
