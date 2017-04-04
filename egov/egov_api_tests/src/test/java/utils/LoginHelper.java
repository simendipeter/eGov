package utils;


import builders.login.LoginRequestBuilder;
import com.jayway.restassured.response.Response;
import entities.requests.login.LoginRequest;
import entities.responses.login.LoginResponse;
import entities.responses.logout.LogoutResponse;
import org.testng.Assert;
import resources.LoginResource;

import java.io.IOException;
import java.util.Map;

public class LoginHelper {

    public static LoginResponse loginTestMethod(String username) throws IOException {
        LoginRequest request = new LoginRequestBuilder().withUsername(username).build();

        Map jsonString = RequestHelper.asMap(request);

        Response response = new LoginResource().login(jsonString);
        LoginResponse loginResponse = (LoginResponse)
                ResponseHelper.getResponseAsObject(response.asString(), LoginResponse.class);

        Assert.assertEquals(response.getStatusCode(), 200);
        Assert.assertEquals(loginResponse.getUserRequest().getUserName(), username);

        new APILogger().log("Login Test is Completed -- ");
        return loginResponse;
    }

    public static void logoutTestMethod(LoginResponse loginResponse) throws IOException {
        Response response1 = new LoginResource().logout(loginResponse.getAccess_token());
        LogoutResponse logoutResponse = (LogoutResponse)
                ResponseHelper.getResponseAsObject(response1.asString(), LogoutResponse.class);

        Assert.assertEquals(response1.getStatusCode(), 200);
        Assert.assertEquals(logoutResponse.getStatus(), "Logout successfully");

        new APILogger().log("Logout Test is Completed --");
    }
}
