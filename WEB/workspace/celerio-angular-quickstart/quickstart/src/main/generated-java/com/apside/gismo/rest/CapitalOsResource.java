/*
 * Source code generated by Celerio, a Jaxio product.
 * Documentation: http://www.jaxio.com/documentation/celerio/
 * Follow us on twitter: @jaxiosoft
 * Need commercial support ? Contact us: info@jaxio.com
 * Template pack-angular:src/main/java/rest/EntityResource.java.e.vm
 */
package com.apside.gismo.rest;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;
import static org.springframework.web.bind.annotation.RequestMethod.DELETE;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.PUT;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Optional;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestBody;

import com.apside.gismo.domain.CapitalOs;
import com.apside.gismo.dto.CapitalOsDTO;
import com.apside.gismo.dto.CapitalOsDTOService;
import com.apside.gismo.dto.support.PageRequestByExample;
import com.apside.gismo.dto.support.PageResponse;
import com.apside.gismo.repository.CapitalOsRepository;
import com.apside.gismo.rest.support.AutoCompleteQuery;

@RestController
@RequestMapping("/api/capitalOss")
public class CapitalOsResource {

    private final Logger log = LoggerFactory.getLogger(CapitalOsResource.class);

    @Inject
    private CapitalOsRepository capitalOsRepository;
    @Inject
    private CapitalOsDTOService capitalOsDTOService;

    /**
     * Create a new CapitalOs.
     */
    @RequestMapping(value = "/", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<CapitalOsDTO> create(@RequestBody CapitalOsDTO capitalOsDTO) throws URISyntaxException {

        log.debug("Create CapitalOsDTO : {}", capitalOsDTO);

        if (capitalOsDTO.isIdSet()) {
            return ResponseEntity.badRequest().header("Failure", "Cannot create CapitalOs with existing ID").body(null);
        }

        CapitalOsDTO result = capitalOsDTOService.save(capitalOsDTO);

        return ResponseEntity.created(new URI("/api/capitalOss/" + result.id)).body(result);
    }

    /**
    * Find by id CapitalOs.
    */
    @RequestMapping(value = "/{id}", method = GET, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<CapitalOsDTO> findById(@PathVariable Integer id) throws URISyntaxException {

        log.debug("Find by id CapitalOs : {}", id);

        return Optional.ofNullable(capitalOsDTOService.findOne(id)).map(capitalOsDTO -> new ResponseEntity<>(capitalOsDTO, HttpStatus.OK))
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    /**
     * Update CapitalOs.
     */
    @RequestMapping(value = "/", method = PUT, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<CapitalOsDTO> update(@RequestBody CapitalOsDTO capitalOsDTO) throws URISyntaxException {

        log.debug("Update CapitalOsDTO : {}", capitalOsDTO);

        if (!capitalOsDTO.isIdSet()) {
            return create(capitalOsDTO);
        }

        CapitalOsDTO result = capitalOsDTOService.save(capitalOsDTO);

        return ResponseEntity.ok().body(result);
    }

    /**
     * Find a Page of CapitalOs using query by example.
     */
    @RequestMapping(value = "/page", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<PageResponse<CapitalOsDTO>> findAll(@RequestBody PageRequestByExample<CapitalOsDTO> prbe) throws URISyntaxException {
        PageResponse<CapitalOsDTO> pageResponse = capitalOsDTOService.findAll(prbe);
        return new ResponseEntity<>(pageResponse, new HttpHeaders(), HttpStatus.OK);
    }

    /**
    * Auto complete support.
    */
    @RequestMapping(value = "/complete", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<List<CapitalOsDTO>> complete(@RequestBody AutoCompleteQuery acq) throws URISyntaxException {

        List<CapitalOsDTO> results = capitalOsDTOService.complete(acq.query, acq.maxResults);

        return new ResponseEntity<>(results, new HttpHeaders(), HttpStatus.OK);
    }

    /**
     * Delete by id CapitalOs.
     */
    @RequestMapping(value = "/{id}", method = DELETE, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<Void> delete(@PathVariable Integer id) throws URISyntaxException {

        log.debug("Delete by id CapitalOs : {}", id);

        try {
            capitalOsRepository.delete(id);
            return ResponseEntity.ok().build();
        } catch (Exception x) {
            // todo: dig exception, most likely org.hibernate.exception.ConstraintViolationException
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }
    }
}