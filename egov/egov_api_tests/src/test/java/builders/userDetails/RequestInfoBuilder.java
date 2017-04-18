package builders.userDetails;

import entities.requests.userDetails.RequestInfo;

public class RequestInfoBuilder {

    RequestInfo requestInfo = new RequestInfo();

    public RequestInfoBuilder() {
        requestInfo.setApiId("emp");
        requestInfo.setVer("1.0");
        requestInfo.setTs("10/03/2017");
        requestInfo.setAction("create");
        requestInfo.setDid("1");
        requestInfo.setKey("abcdkey");
        requestInfo.setMsgId("20170310130900");
        requestInfo.setRequesterId("req_id");
        requestInfo.setAuthToken("");
    }

    public RequestInfoBuilder withAuthToken(String authToken) {
        requestInfo.setAuthToken(authToken);
        return this;
    }

    public RequestInfo build() {
        return requestInfo;
    }


}