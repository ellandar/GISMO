/*
 * Source code generated by Celerio, a Jaxio product.
 * Documentation: http://www.jaxio.com/documentation/celerio/
 * Follow us on twitter: @jaxiosoft
 * Need commercial support ? Contact us: info@jaxio.com
 * Template pack-angular:src/main/java/rest/SecurityResource.java.p.vm
 */
package com.apside.gismo.rest;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;
import static org.springframework.web.bind.annotation.RequestMethod.GET;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.*;

import com.apside.gismo.security.UserContext;

@RestController
@RequestMapping("/api")
public class SecurityResource {

    @RequestMapping(value = "/authenticated", method = GET, produces = APPLICATION_JSON_VALUE)
    public boolean isAuthenticated() {
        return UserContext.getId() != null;
    }
}