package entities.requests.propertyTax.masters.structureClass;

import entities.requests.propertyTax.masters.RequestInfo;
import org.codehaus.jackson.annotate.JsonProperty;

public class CreateStructureClassRequest {

    private StructureClasses[] structureClasses;

    @JsonProperty("RequestInfo")
    private RequestInfo RequestInfo;

    public StructureClasses[] getStructureClasses() {
        return this.structureClasses;
    }

    public void setStructureClasses(StructureClasses[] structureClasses) {
        this.structureClasses = structureClasses;
    }

    public RequestInfo getRequestInfo() {
        return this.RequestInfo;
    }

    public void setRequestInfo(RequestInfo RequestInfo) {
        this.RequestInfo = RequestInfo;
    }
}