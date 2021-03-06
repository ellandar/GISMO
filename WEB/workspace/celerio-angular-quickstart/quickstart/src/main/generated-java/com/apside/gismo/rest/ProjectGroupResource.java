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

import com.apside.gismo.domain.ProjectGroup;
import com.apside.gismo.dto.ProjectGroupDTO;
import com.apside.gismo.dto.ProjectGroupDTOService;
import com.apside.gismo.dto.support.PageRequestByExample;
import com.apside.gismo.dto.support.PageResponse;
import com.apside.gismo.repository.ProjectGroupRepository;
import com.apside.gismo.rest.support.AutoCompleteQuery;

@RestController
@RequestMapping("/api/projectGroups")
public class ProjectGroupResource {

    private final Logger log = LoggerFactory.getLogger(ProjectGroupResource.class);

    @Inject
    private ProjectGroupRepository projectGroupRepository;
    @Inject
    private ProjectGroupDTOService projectGroupDTOService;

    /**
     * Create a new ProjectGroup.
     */
    @RequestMapping(value = "/", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<ProjectGroupDTO> create(@RequestBody ProjectGroupDTO projectGroupDTO) throws URISyntaxException {

        log.debug("Create ProjectGroupDTO : {}", projectGroupDTO);

        if (projectGroupDTO.isIdSet()) {
            return ResponseEntity.badRequest().header("Failure", "Cannot create ProjectGroup with existing ID").body(null);
        }

        ProjectGroupDTO result = projectGroupDTOService.save(projectGroupDTO);

        return ResponseEntity.created(new URI("/api/projectGroups/" + result.id)).body(result);
    }

    /**
    * Find by id ProjectGroup.
    */
    @RequestMapping(value = "/{id}", method = GET, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<ProjectGroupDTO> findById(@PathVariable Integer id) throws URISyntaxException {

        log.debug("Find by id ProjectGroup : {}", id);

        return Optional.ofNullable(projectGroupDTOService.findOne(id)).map(projectGroupDTO -> new ResponseEntity<>(projectGroupDTO, HttpStatus.OK))
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    /**
     * Update ProjectGroup.
     */
    @RequestMapping(value = "/", method = PUT, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<ProjectGroupDTO> update(@RequestBody ProjectGroupDTO projectGroupDTO) throws URISyntaxException {

        log.debug("Update ProjectGroupDTO : {}", projectGroupDTO);

        if (!projectGroupDTO.isIdSet()) {
            return create(projectGroupDTO);
        }

        ProjectGroupDTO result = projectGroupDTOService.save(projectGroupDTO);

        return ResponseEntity.ok().body(result);
    }

    /**
     * Find a Page of ProjectGroup using query by example.
     */
    @RequestMapping(value = "/page", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<PageResponse<ProjectGroupDTO>> findAll(@RequestBody PageRequestByExample<ProjectGroupDTO> prbe) throws URISyntaxException {
        PageResponse<ProjectGroupDTO> pageResponse = projectGroupDTOService.findAll(prbe);
        return new ResponseEntity<>(pageResponse, new HttpHeaders(), HttpStatus.OK);
    }

    /**
    * Auto complete support.
    */
    @RequestMapping(value = "/complete", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<List<ProjectGroupDTO>> complete(@RequestBody AutoCompleteQuery acq) throws URISyntaxException {

        List<ProjectGroupDTO> results = projectGroupDTOService.complete(acq.query, acq.maxResults);

        return new ResponseEntity<>(results, new HttpHeaders(), HttpStatus.OK);
    }

    /**
     * Delete by id ProjectGroup.
     */
    @RequestMapping(value = "/{id}", method = DELETE, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<Void> delete(@PathVariable Integer id) throws URISyntaxException {

        log.debug("Delete by id ProjectGroup : {}", id);

        try {
            projectGroupRepository.delete(id);
            return ResponseEntity.ok().build();
        } catch (Exception x) {
            // todo: dig exception, most likely org.hibernate.exception.ConstraintViolationException
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }
    }
}