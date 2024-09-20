package kr.or.ddit.web.subscribe.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import kr.or.ddit.groupware.company.dao.CompanyMapper;
import kr.or.ddit.vo.BuyListVO;
import kr.or.ddit.vo.CompanyVO;
import kr.or.ddit.vo.ProdListVO;
import kr.or.ddit.web.buyList.dao.BuyListMapper;
import kr.or.ddit.web.prodList.dao.ProdListMapper;
import kr.or.ddit.web.subscribe.vo.AproveResponse;
import kr.or.ddit.web.subscribe.vo.ReadyResponse;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class KakaoPayService {

	@Autowired
	public BuyListMapper buyMapper;
	@Autowired
	public ProdListMapper prodMapper;
	@Autowired
	public CompanyMapper comMapper;

	public String orderId(String comNo) {
		int ran= (int) (Math.random() * 999)+100;
    	LocalDate now = LocalDate.now();
    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
    	String formatedNow = now.format(formatter);
    	String orderid = formatedNow+comNo+ran;
		return orderid;
	}

    /**
     *  카카오페이 결제창 연결
     * @param data
     * @return
     * @throws ParseException
     */
//    @SuppressWarnings("static-access")
	public ReadyResponse payReady(Map<String, String> data) throws ParseException {
    	int prodNo = Integer.parseInt( data.get("prodNo"));
    	int comNo = Integer.parseInt( data.get("comNo"));

    	ProdListVO prodVo = prodMapper.selectProd(prodNo);
    	CompanyVO company =comMapper.selectCompany(comNo);
    	String memNo = ""+company.getMemNo();
    	String memNm = data.get("memNm");

    	String item_code = prodVo.getProdNo()+"";
    	String total_amount = prodVo.getProdPrice()+"";

        Map<String, String> parameters = new HashMap<>();
        parameters.put("cid", "TC0ONETIME");                                    // 가맹점 코드(테스트용)
        parameters.put("partner_order_id", "1");    // 주문번호
        parameters.put("partner_user_id", memNm);            // 회원 이름
        parameters.put("item_name", prodVo.getProdNm());     // 상품명
        parameters.put("item_code", item_code);           	 // 상품 코드
        parameters.put("quantity", "1");                     // 상품 수량
        parameters.put("total_amount", total_amount);        // 상품 총액
        parameters.put("tax_free_amount", "0");               // 상품 비과세 금액
        parameters.put("approval_url", "http://localhost/connect/w/pay/completed"); // 결제 성공 시 URL
        parameters.put("cancel_url", "http://localhost/connect/w/subscribeView.do?msg=cancel");      // 결제 취소 시 URL
        parameters.put("fail_url", "http://localhost/connect/w/subscribeView.do?msg=fail");          // 결제 실패 시 URL

        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());
        RestTemplate template = new RestTemplate();
        String url = "https://open-api.kakaopay.com/online/v1/payment/ready";
        ResponseEntity<ReadyResponse> responseEntity = template.postForEntity(url, requestEntity, ReadyResponse.class);

        //사용중인 상품이 존재 여부 체크 및
        //그룹웨어 사용 시작날짜 세팅
        BuyListVO buyVo = selectBuyUse(comNo);
        buyVo.setComNo(comNo);
        buyVo.setProdNo(prodNo);
        buyVo.setBuyTid(responseEntity.getBody().getTid());

        buyMapper.insertBuyList(buyVo);

        return responseEntity.getBody();
    }


    /**
     * 카카오페이 결제 승인
     	사용자가 결제 수단을 선택하고 비밀번호를 입력해 결제 인증을 완료한 뒤,
     	최종적으로 결제 완료 처리를 하는 단계
     * @param tid
     * @param pgToken
     * @return
     */
    public AproveResponse payApprove(Map<String, String> payList) {
    	String tid= payList.get("tid");
    	String memNo= payList.get("memNo");
    	String memNm= payList.get("memNm");
    	String pgToken= payList.get("pgToken");
    	String comNo= payList.get("comNo");

        Map<String, String> parameters = new HashMap<>();
        parameters.put("cid", "TC0ONETIME");              // 가맹점 코드(테스트용)
        parameters.put("tid", tid);                       // 결제 고유번호
        parameters.put("partner_order_id","1" );
        parameters.put("partner_user_id",memNm );
        parameters.put("pg_token", pgToken);              // 결제승인 요청을 인증하는 토큰

        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());
        RestTemplate template = new RestTemplate();
        String url = "https://open-api.kakaopay.com/online/v1/payment/approve";
        AproveResponse approveResponse = template.postForObject(url, requestEntity, AproveResponse.class);
        buyMapper.updateBuyListTS(payList.get("tid"));

        return approveResponse;
    }

    /**
     * 카카오페이 측에 요청 시 헤더부에  필요한 값
    	Key 노출 XXX 안됨 ㄱ절대 개인정보임
     * @return
     */
    private HttpHeaders getHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-type", "application/json");
        return headers;
    }

    /**
     * 사용중인 그룹웨어건이 있는지 확인하는 절차
     * @param comNo
     * @return
     */
	public BuyListVO selectBuyUse(int comNo) {

    	//그룹웨어 사용 시작날짜 세팅
		String lastUseDate="";
    	lastUseDate = buyMapper.selectBuyUse(comNo);
    	BuyListVO buyVo = new BuyListVO();

    	if(lastUseDate == null) {
    		//사용중인 상품이 존재하지 않을 경우
    		LocalDate now = LocalDate.now();
    		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
    		String date = now.format(formatter);
    		//그룹웨어 시작날짜와 구매날짜 일치
    		buyVo.setBuyDate(date);
    		buyVo.setBuyUseStartDate(date);

    	}else {
    		buyVo = new BuyListVO();
    		buyVo.setBuyUseStartDate(lastUseDate);

    	}

        return buyVo;

    }

}