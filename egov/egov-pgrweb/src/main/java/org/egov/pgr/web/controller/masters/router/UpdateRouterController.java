/*
 * eGov  SmartCity eGovernance suite aims to improve the internal efficiency,transparency,
 * accountability and the service delivery of the government  organizations.
 *
 *  Copyright (C) <2017>  eGovernments Foundation
 *
 *  The updated version of eGov suite of products as by eGovernments Foundation
 *  is available at http://www.egovernments.org
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program. If not, see http://www.gnu.org/licenses/ or
 *  http://www.gnu.org/licenses/gpl.html .
 *
 *  In addition to the terms of the GPL license to be adhered to in using this
 *  program, the following additional terms are to be complied with:
 *
 *      1) All versions of this program, verbatim or modified must carry this
 *         Legal Notice.
 * 	Further, all user interfaces, including but not limited to citizen facing interfaces,
 *         Urban Local Bodies interfaces, dashboards, mobile applications, of the program and any
 *         derived works should carry eGovernments Foundation logo on the top right corner.
 *
 * 	For the logo, please refer http://egovernments.org/html/logo/egov_logo.png.
 * 	For any further queries on attribution, including queries on brand guidelines,
 *         please contact contact@egovernments.org
 *
 *      2) Any misrepresentation of the origin of the material is prohibited. It
 *         is required that all modified versions of this material be marked in
 *         reasonable ways as different from the original version.
 *
 *      3) This license does not grant any rights to any user of the program
 *         with regards to rights under trademark law for use of the trade names
 *         or trademarks of eGovernments Foundation.
 *
 *  In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
 */

package org.egov.pgr.web.controller.masters.router;

import org.egov.infra.admin.master.entity.BoundaryType;
import org.egov.infra.admin.master.service.BoundaryTypeService;
import org.egov.pgr.entity.ComplaintRouter;
import org.egov.pgr.service.ComplaintRouterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping(value = "/complaint/router")
class UpdateRouterController {

    private static final String ROUTER_UPDATE = "router-updateSearch";
    private static final String COMPLAINT_ROUTER = "complaintRouter";
    private static final String MESSAGE = "message";

    @Autowired
    private BoundaryTypeService boundaryTypeService;
    @Autowired
    private ComplaintRouterService complaintRouterService;

    @Autowired
    private ComplaintRouterValidator complaintRouterValidator;

    @ModelAttribute("boundaryTypes")
    public List<BoundaryType> boundaryTypes() {
        return boundaryTypeService.getBoundaryTypeByHierarchyTypeName("ADMINISTRATION");
    }

    @ModelAttribute
    public ComplaintRouter complaintRouter(@PathVariable final Long id) {
        return complaintRouterService.getRouterById(id);
    }

    @GetMapping("update/{id}")
    public String updateRouterForm() {
        return ROUTER_UPDATE;
    }

    @GetMapping("view/{id}")
    public String viewRouterForm() {
        return "router-view";
    }

    @PostMapping("update/{id}")
    public String update(@Valid ComplaintRouter complaintRouter,
                         BindingResult errors, RedirectAttributes redirectAttrs) {
        if (errors.hasErrors())
            return ROUTER_UPDATE;

        complaintRouterService.updateComplaintRouter(complaintRouter);
        redirectAttrs.addFlashAttribute(COMPLAINT_ROUTER, complaintRouter);
        redirectAttrs.addFlashAttribute(MESSAGE, "msg.router.update.success");
        return "redirect:/complaint/router/view/" + complaintRouter.getId();
    }

    @PostMapping("delete/{id}")
    public String delete(@Valid ComplaintRouter complaintRouter,
                         BindingResult errors, Model model,
                         RedirectAttributes redirectAttrs) {
        complaintRouterValidator.validate(complaintRouter, errors);
        if (errors.hasErrors()) {
            model.addAttribute(MESSAGE, "msg.router.cannot.delete");
            return ROUTER_UPDATE;
        } else {
            complaintRouterService.deleteComplaintRouter(complaintRouter);
            redirectAttrs.addFlashAttribute(MESSAGE, "msg.router.del.success");
            return "redirect:/complaint/router/search/update";
        }
    }
}