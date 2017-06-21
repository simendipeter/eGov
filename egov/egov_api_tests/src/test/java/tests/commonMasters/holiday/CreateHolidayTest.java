package tests.commonMasters.holiday;

import builders.commonMaster.createHoliday.CalendarYearBuilder;
import builders.commonMaster.createHoliday.CreateHolidayRequestBuilder;
import builders.commonMaster.createHoliday.HolidayBuilder;
import builders.commonMaster.createHoliday.RequestInfoBuilder;
import com.jayway.restassured.response.Response;
import entities.requests.commonMasters.createHoliday.CalendarYear;
import entities.requests.commonMasters.createHoliday.CreateHolidayRequest;
import entities.requests.commonMasters.createHoliday.Holiday;
import entities.requests.commonMasters.createHoliday.RequestInfo;
import org.junit.Assert;
import org.testng.annotations.Test;
import resources.CommonMasterResource;
import tests.BaseAPITest;
import utils.APILogger;
import utils.Categories;
import utils.LoginAndLogoutHelper;
import utils.RequestHelper;

import java.io.IOException;

import static data.UserData.ADMIN;

public class CreateHolidayTest extends BaseAPITest {

    @Test(groups = {Categories.HR, Categories.SANITY})
    public void createHolidayTest() throws IOException {
        LoginAndLogoutHelper.loginFromPilotService(ADMIN); // Login
        createHoliday(); // Create Holiday
        pilotLogoutService(); // Logout
    }

    private void createHoliday() {
        RequestInfo requestInfo = new RequestInfoBuilder().build();
        CalendarYear calendarYear = new CalendarYearBuilder().build();

        Holiday holiday = new HolidayBuilder()
                .withCalendarYear(calendarYear)
                .withName("Good Friday")
                .withApplicableOn("14/04/2017")
                .build();

        CreateHolidayRequest createHolidayRequest = new CreateHolidayRequestBuilder()
                .withHoliday(holiday)
                .withRequestInfo(requestInfo)
                .build();

        Response response = new CommonMasterResource()
                .createHolidayResource(RequestHelper.getJsonString(createHolidayRequest));
        Assert.assertEquals(response.getStatusCode(), 200);
        new APILogger().log("Create Holiday Test is Completed --");
    }
}