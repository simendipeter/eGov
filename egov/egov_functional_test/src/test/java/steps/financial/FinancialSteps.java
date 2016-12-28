package steps.financial;

import cucumber.api.PendingException;
import cucumber.api.java8.En;
import entities.financial.FinancialBankDetails;
import entities.financial.FinancialExpenseBillDetails;
import entities.financial.FinancialJournalVoucherDetails;
import entities.ptis.ApprovalDetails;
import entities.wcms.FieldInspectionDetails;
import org.junit.Assert;
import pages.financial.FinancialPage;
import steps.BaseSteps;
import utils.ExcelReader;

import java.text.ParseException;

/**
 * Created by vinaykumar on 20/12/16.
 */
public class FinancialSteps extends BaseSteps implements En {

    public FinancialSteps() {

        And("^officer will enter the journal voucher details as (\\w+)$", (String voucher) -> {
            FinancialJournalVoucherDetails financialJournalVoucherDetails = new ExcelReader(financialTestDataFileName).getJournalVoucherDetails(voucher);
            pageStore.get(FinancialPage.class).enterJournalVoucherDetails(financialJournalVoucherDetails);
        });

        And("^officer will enter the approval details as (\\w+)$", (String approveOfficer) -> {
            ApprovalDetails approvalDetails = new ExcelReader(ptisTestDataFileName).getApprovalDetails(approveOfficer);
            try {
                pageStore.get(FinancialPage.class).enterFinanceApprovalDetails(approvalDetails);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        });

        And("^officer will get successful voucher created and closes it$", () -> {
            String voucherNumber = pageStore.get(FinancialPage.class).getVoucherNumber();
            scenarioContext.setVoucherNumber(voucherNumber.split("\\ ")[1]);
            scenarioContext.setActualMessage(voucherNumber.split("\\ ")[2]);
        });

        Then("^the officer will click on the voucher number$", () -> {
            pageStore.get(FinancialPage.class).openVoucher(scenarioContext.getVoucherNumber());
        });

        And("^officer will closes the acknowledgement page$", () -> {
            String actualMessage = pageStore.get(FinancialPage.class).closePage();

            if(actualMessage.split("\\ ")[3].equals("forwarded")){
                scenarioContext.setActualMessage(actualMessage.split("\\ ")[3]);
            }
            else {
                scenarioContext.setActualMessage(actualMessage.split("\\ ")[4]);
            }
        });

        And("^officer click on approval of the voucher$", () -> {
            pageStore.get(FinancialPage.class).approvalPage();
        });

        Then("^officer will modify the results depending upon the fund and date as (\\w+)$", (String date) -> {
            pageStore.get(FinancialPage.class).billSearch(date);
        });

        And("^officer will act upon the above voucher$", () -> {
            pageStore.get(FinancialPage.class).actOnAboveVoucher();
        });

        And("^officer will verify the voucher number$", () -> {
            String voucher = pageStore.get(FinancialPage.class).verifyVoucher();
            Assert.assertEquals(voucher , scenarioContext.getVoucherNumber());
        });

        And("^officer will enter the bank details$", () -> {
            String bankDetails = "SBI";
            FinancialBankDetails financialBankDetails = new ExcelReader(financialTestDataFileName).getFinancialBankDetails(bankDetails);
            pageStore.get(FinancialPage.class).billPayment(financialBankDetails);
        });

        And("^officer will the expense bill details as (\\w+)$", (String expenseBill) -> {
            FinancialExpenseBillDetails financialBill = new ExcelReader(financialTestDataFileName).getFinancialExpenseBillDetails(expenseBill);
            pageStore.get(FinancialPage.class).createNewExpenseBill(financialBill);
        });

        And("^officer will enter the expense approval details as (\\w+)$", (String approveOfficer) -> {
            ApprovalDetails approvalDetails = new ExcelReader(ptisTestDataFileName).getApprovalDetails(approveOfficer);
            pageStore.get(FinancialPage.class).enterExpenseApprovalDetails(approvalDetails);
        });

        And("^officer will closes the expense acknowledgement page$", () -> {
            String expenseBillNumber = pageStore.get(FinancialPage.class).closesTheExpensePage();
            scenarioContext.setVoucherNumber(expenseBillNumber.split("\\ ")[2]);
            scenarioContext.setActualMessage(expenseBillNumber.split("\\ ")[3]);
        });
    }
}
