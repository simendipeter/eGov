package entities.requests.eGovEIS;

import org.codehaus.jackson.annotate.JsonProperty;

public class SearchEmployeeRequest {

    @JsonProperty("RequestInfo")
    RequestInfo requestInfo;

    public RequestInfo getRequestInfo() {
        return requestInfo;
    }

    public void setRequestInfo(RequestInfo requestInfo) {
        this.requestInfo = requestInfo;
    }
}