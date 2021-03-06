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

import com.apside.gismo.domain.SubProject;
import com.apside.gismo.dto.SubProjectDTO;
import com.apside.gismo.dto.SubProjectDTOService;
import com.apside.gismo.dto.support.PageRequestByExample;
import com.apside.gismo.dto.support.PageResponse;
import com.apside.gismo.repository.SubProjectRepository;
import com.apside.gismo.rest.support.AutoCompleteQuery;

@RestController
@RequestMapping("/api/subProjects")
public class SubProjectResource {

    private final Logger log = LoggerFactory.getLogger(SubProjectResource.class);

    @Inject
    private SubProjectRepository subProjectRepository;
    @Inject
    private SubProjectDTOService subProjectDTOService;

    /**
     * Create a new SubProject.
     */
    @RequestMapping(value = "/", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<SubProjectDTO> create(@RequestBody SubProjectDTO subProjectDTO) throws URISyntaxException {

        log.debug("Create SubProjectDTO : {}", subProjectDTO);

        if (subProjectDTO.isIdSet()) {
            return ResponseEntity.badRequest().header("Failure", "Cannot create SubProject with existing ID").body(null);
        }

        SubProjectDTO result = subProjectDTOService.save(subProjectDTO);

        return ResponseEntity.created(new URI("/api/subProjects/" + result.id)).body(result);
    }

    /**
    * Find by id SubProject.
    */
    @RequestMapping(value = "/{id}", method = GET, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<SubProjectDTO> findById(@PathVariable Integer id) throws URISyntaxException {

        log.debug("Find by id SubProject : {}", id);

        return Optional.ofNullable(subProjectDTOService.findOne(id)).map(subProjectDTO -> new ResponseEntity<>(subProjectDTO, HttpStatus.OK))
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    /**
     * Update SubProject.
     */
    @RequestMapping(value = "/", method = PUT, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<SubProjectDTO> update(@RequestBody SubProjectDTO subProjectDTO) throws URISyntaxException {

        log.debug("Update SubProjectDTO : {}", subProjectDTO);

        if (!subProjectDTO.isIdSet()) {
            return create(subProjectDTO);
        }

        SubProjectDTO result = subProjectDTOService.save(subProjectDTO);

        return ResponseEntity.ok().body(result);
    }

    /**
     * Find a Page of SubProject using query by example.
     */
    @RequestMapping(value = "/page", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<PageResponse<SubProjectDTO>> findAll(@RequestBody PageRequestByExample<SubProjectDTO> prbe) throws URISyntaxException {
        PageResponse<SubProjectDTO> pageResponse = subProjectDTOService.findAll(prbe);
        return new ResponseEntity<>(pageResponse, new HttpHeaders(), HttpStatus.OK);
    }

    /**
    * Auto complete support.
    */
    @RequestMapping(value = "/complete", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<List<SubProjectDTO>> complete(@RequestBody AutoCompleteQuery acq) throws URISyntaxException {

        List<SubProjectDTO> results = subProjectDTOService.complete(acq.query, acq.maxResults);

        return new ResponseEntity<>(results, new HttpHeaders(), HttpStatus.OK);
    }

    /**
     * Delete by id SubProject.
     */
    @RequestMapping(value = "/{id}", method = DELETE, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<Void> delete(@PathVariable Integer id) throws URISyntaxException {

        log.debug("Delete by id SubProject : {}", id);

        try {
            subProjectRepository.delete(id);
            return ResponseEntity.ok().build();
        } catch (Exception x) {
            // todo: dig exception, most likely org.hibernate.exception.ConstraintViolationException
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }
    }
}