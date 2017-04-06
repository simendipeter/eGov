package tests.eGovEIS.searchEISMaster;

import builders.eGovEIS.searchEISMaster.RequestInfoBuilder;
import builders.eGovEIS.searchEISMaster.SearchEmployeeMasterRequestBuilder;
import com.jayway.restassured.response.Response;
import entities.requests.eGovEIS.searchEISMaster.RequestInfo;
import entities.requests.eGovEIS.searchEISMaster.SearchEmployeeMasterRequest;
import entities.responses.eGovEIS.searchEISMasters.position.SearchPositionResponse;
import entities.responses.login.LoginResponse;
import org.junit.Assert;
import org.testng.annotations.Test;
import resources.searchEISMaster.EISMasterResource;
import tests.BaseAPITest;
import utils.*;

import java.io.IOException;

public class EISPositionHierarchyTest extends BaseAPITest{

    @Test(groups = {Categories.HR, Categories.SANITY, Categories.DEV})
    public void searchPositionHierarchyTest() throws IOException {

        // Login Test
        LoginResponse loginResponse = LoginAndLogoutHelper.login("narasappa");

        // Search Designation Test
        searchPositionHierarchyTestMethod(loginResponse);
    }

    private void searchPositionHierarchyTestMethod(LoginResponse loginResponse)throws IOException {

        RequestInfo requestInfo = new RequestInfoBuilder()
                .withAuthToken(loginResponse.getAccess_token())
                .build();

        SearchEmployeeMasterRequest searchEmployeeMasterRequest = new SearchEmployeeMasterRequestBuilder()
                .withRequestInfo(requestInfo)
                .build();

        Response response = new EISMasterResource().
                searchPositionHierarchy(RequestHelper.getJsonString(searchEmployeeMasterRequest));

        Assert.assertEquals(response.getStatusCode() , 200);

        new APILogger().log("Search Position Test is Completed--");
    }

}