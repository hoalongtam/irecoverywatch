package com.receivemoney;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.logging.Logger;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.paypal.adaptive.api.requests.PayRequest;
import com.paypal.adaptive.api.requests.PaymentDetailsRequest;
import com.paypal.adaptive.api.responses.PayResponse;
import com.paypal.adaptive.api.responses.PaymentDetailsResponse;
import com.paypal.adaptive.core.APICredential;
import com.paypal.adaptive.core.ActionType;
import com.paypal.adaptive.core.ClientDetails;
import com.paypal.adaptive.core.CurrencyCodes;
import com.paypal.adaptive.core.EndPointUrl;
import com.paypal.adaptive.core.PaymentDetails;
import com.paypal.adaptive.core.Receiver;
import com.paypal.adaptive.core.ServiceEnvironment;
import com.paypal.adaptive.exceptions.AuthorizationRequiredException;
import com.paypal.adaptive.exceptions.InvalidAPICredentialsException;
import com.paypal.adaptive.exceptions.InvalidResponseDataException;
import com.paypal.adaptive.exceptions.MissingAPICredentialsException;
import com.paypal.adaptive.exceptions.MissingParameterException;
import com.paypal.adaptive.exceptions.PayPalErrorException;
import com.paypal.adaptive.exceptions.PaymentExecException;
import com.paypal.adaptive.exceptions.PaymentInCompleteException;
import com.paypal.adaptive.exceptions.RequestFailureException;

@SuppressWarnings("serial")
public class ReceiveMoneyServlet extends HttpServlet {
	
	
	private static final Logger log = Logger.getLogger(ReceiveMoneyServlet.class.getName());


	private static APICredential credentialObj;

	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);

		// Get the value of APIUsername
		String APIUsername = getServletConfig().getInitParameter("PPAPIUsername"); 
		String APIPassword = getServletConfig().getInitParameter("PPAPIPassword"); 
		String APISignature = getServletConfig().getInitParameter("PPAPISignature"); 
		String AppID = getServletConfig().getInitParameter("PPAppID"); 
		String AccountEmail = getServletConfig().getInitParameter("PPAccountEmail");

		if(APIUsername == null || APIUsername.length() <= 0
				|| APIPassword == null || APIPassword.length() <=0 
				|| APISignature == null || APISignature.length() <= 0
				|| AppID == null || AppID.length() <=0 ) {
			// requires API Credentials not set - throw exception
			throw new ServletException("APICredential(s) missing");
		}

		credentialObj = new APICredential();
		credentialObj.setAPIUsername(APIUsername);
		credentialObj.setAPIPassword(APIPassword);
		credentialObj.setSignature(APISignature);
		credentialObj.setAppId(AppID);
		credentialObj.setAccountEmail(AccountEmail);
		log.info("Servlet initialized successfully");
	}
	
	/*
	 * Input Params: senderEmail, receiverEmail, amount, memo
	 * Output Params: authZUrl
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("text/plain");
		
		if(req.getParameter("return") != null){
			// user coming back from PayPal
			resp.getWriter().print("You've successfully authorized the payment - Thank you!");
			return;
		}
		
		if(req.getParameter("payKey") != null
				&& req.getParameter("payKey").length() > 0) {
			resp.getWriter().print(this.processPaymentDetails(resp, req.getParameter("payKey"), credentialObj));
			return;
		}
		
		if(req.getParameter("senderEmail") == null
				|| req.getParameter("senderEmail").length() <=0) {
			resp.getWriter().print("error=NoSenderEmail");
			return;
		}
		
		if(req.getParameter("receiverEmail") == null
				|| req.getParameter("receiverEmail").length() <=0) {
			resp.getWriter().print("error=NoReceiverEmail");
			return;
		}
		
		if(req.getParameter("amount") == null
				|| req.getParameter("amount").length() <=0) {
			resp.getWriter().print("error=NoAmount");
			return;
		}
		
		if(req.getParameter("memo") == null
				|| req.getParameter("memo").length() <=0) {
			resp.getWriter().print("error=NoMemo");
			return;
		}
		
		
			
		
		resp.getWriter().print(processPayRequest(req, req.getParameter("senderEmail"),
				req.getParameter("receiverEmail"), req.getParameter("amount"),
				req.getParameter("memo")));
				
	}
	
	// sends PayRequest and returns authZUrl or error
	private String processPayRequest(HttpServletRequest req, String senderEmail,
			String receiverEmail, String amount, String memo) throws IOException {

		try {

			StringBuilder url = new StringBuilder();
			url.append(req.getRequestURL());
			String returnURL = url.toString() + "?return=1&action=pay&payKey=${payKey}";
			String cancelURL = url.toString() + "?action=pay&cancel=1";
			
			PaymentDetails paymentDetails = new PaymentDetails(ActionType.PAY);
			
			
			
			PayRequest payRequest = new PayRequest("en_US", ServiceEnvironment.SANDBOX);
			Receiver rec1 = new Receiver();
			rec1.setAmount((new Double(amount).doubleValue()));
			rec1.setEmail(receiverEmail);
			paymentDetails.addToReceiverList(rec1);
			
			ClientDetails cl = new ClientDetails();
			cl.setIpAddress(req.getRemoteAddr());
			cl.setApplicationId("Request Money App");
			paymentDetails.setCancelUrl(cancelURL);
			paymentDetails.setReturnUrl(returnURL);
			paymentDetails.setSenderEmail(senderEmail);
			paymentDetails.setCurrencyCode(CurrencyCodes.USD);
			payRequest.setClientDetails(cl);

			payRequest.setPaymentDetails(paymentDetails);
			
			PayResponse payResp = payRequest.execute(credentialObj);
			
			// session.setAttribute("payResponseRef", payResp);
			if(payResp != null) {
				if(payResp.getPayErrorList() != null && payResp.getPayErrorList().size() > 0) {
					// error occured
					return "error=" + payResp.getPayErrorList().toString();
				} else {
					return "authZUrl=" + generateAuthorizeUrl(payResp.getPayKey(), ServiceEnvironment.SANDBOX);
				}
			} else {
				return "error=NoPayResponse";
			}

			
		} catch (IOException e) {
			return "error=ExceptionOccured";
		} catch (MissingAPICredentialsException e) {
			// No API Credential Object provided - log error
			e.printStackTrace();
			return "error=BadConfig";
		} catch (InvalidAPICredentialsException e) {
			// invalid API Credentials provided - application error - log error
			e.printStackTrace();
			return "error=BadConfig";
		} catch (MissingParameterException e) {
			// missing parameter - log  error
			e.printStackTrace();
			return "error=MissingParam";
		} catch (RequestFailureException e) {
			// HTTP Error - some connection issues ?
			e.printStackTrace();
			return "error=RequestFailure";
		} catch (InvalidResponseDataException e) {
			// PayPal service error 
			// log error
			e.printStackTrace();
			return "error=InvalidResponse";
		} catch (PayPalErrorException e) {
			// Request failed due to a Service/Application error
			e.printStackTrace();
			return "error=Failure";
		} catch (PaymentExecException e) {

			return "error=" + e.getPayErrorList().toString();
		}catch (PaymentInCompleteException e){
			return "error=" + e.getPayErrorList().toString();
		} catch (AuthorizationRequiredException e) {
			// redirect the user to PayPal for Authorization
			return "authZUrl=" + e.getAuthorizationUrl(ServiceEnvironment.SANDBOX);
		}
	}
	
	private String processPaymentDetails(HttpServletResponse resp, String payKey,
			APICredential credentialObj) throws IOException {

		try {


			PaymentDetailsRequest paymentDetailsRequest = new PaymentDetailsRequest("en_US",
					ServiceEnvironment.SANDBOX);

			if(payKey != null)
				paymentDetailsRequest.setPayKey(payKey);
						
			PaymentDetailsResponse response = paymentDetailsRequest.execute(credentialObj);
			
			return "status=" + response.getPaymentDetails().getStatus();
			
		} catch (IOException e) {
			return "error=Exception";
		} catch (Exception e) {
			return "error=" + e.toString();
		}

	}
	
	private String generateAuthorizeUrl(String paykey, ServiceEnvironment env) 
	throws UnsupportedEncodingException{
		StringBuilder outStr = new StringBuilder();
		outStr.append(EndPointUrl.getAuthorizationUrl(env));
		outStr.append("?cmd=_ap-payment&paykey=");
		outStr.append(java.net.URLEncoder.encode(paykey, "UTF-8"));
		return outStr.toString();
	}
	
}
