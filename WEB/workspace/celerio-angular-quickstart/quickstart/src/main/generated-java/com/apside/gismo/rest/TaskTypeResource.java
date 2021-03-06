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

import com.apside.gismo.domain.TaskType;
import com.apside.gismo.dto.TaskTypeDTO;
import com.apside.gismo.dto.TaskTypeDTOService;
import com.apside.gismo.dto.support.PageRequestByExample;
import com.apside.gismo.dto.support.PageResponse;
import com.apside.gismo.repository.TaskTypeRepository;
import com.apside.gismo.rest.support.AutoCompleteQuery;

@RestController
@RequestMapping("/api/taskTypes")
public class TaskTypeResource {

    private final Logger log = LoggerFactory.getLogger(TaskTypeResource.class);

    @Inject
    private TaskTypeRepository taskTypeRepository;
    @Inject
    private TaskTypeDTOService taskTypeDTOService;

    /**
     * Create a new TaskType.
     */
    @RequestMapping(value = "/", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<TaskTypeDTO> create(@RequestBody TaskTypeDTO taskTypeDTO) throws URISyntaxException {

        log.debug("Create TaskTypeDTO : {}", taskTypeDTO);

        if (taskTypeDTO.isIdSet()) {
            return ResponseEntity.badRequest().header("Failure", "Cannot create TaskType with existing ID").body(null);
        }

        TaskTypeDTO result = taskTypeDTOService.save(taskTypeDTO);

        return ResponseEntity.created(new URI("/api/taskTypes/" + result.id)).body(result);
    }

    /**
    * Find by id TaskType.
    */
    @RequestMapping(value = "/{id}", method = GET, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<TaskTypeDTO> findById(@PathVariable Integer id) throws URISyntaxException {

        log.debug("Find by id TaskType : {}", id);

        return Optional.ofNullable(taskTypeDTOService.findOne(id)).map(taskTypeDTO -> new ResponseEntity<>(taskTypeDTO, HttpStatus.OK))
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    /**
     * Update TaskType.
     */
    @RequestMapping(value = "/", method = PUT, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<TaskTypeDTO> update(@RequestBody TaskTypeDTO taskTypeDTO) throws URISyntaxException {

        log.debug("Update TaskTypeDTO : {}", taskTypeDTO);

        if (!taskTypeDTO.isIdSet()) {
            return create(taskTypeDTO);
        }

        TaskTypeDTO result = taskTypeDTOService.save(taskTypeDTO);

        return ResponseEntity.ok().body(result);
    }

    /**
     * Find a Page of TaskType using query by example.
     */
    @RequestMapping(value = "/page", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<PageResponse<TaskTypeDTO>> findAll(@RequestBody PageRequestByExample<TaskTypeDTO> prbe) throws URISyntaxException {
        PageResponse<TaskTypeDTO> pageResponse = taskTypeDTOService.findAll(prbe);
        return new ResponseEntity<>(pageResponse, new HttpHeaders(), HttpStatus.OK);
    }

    /**
    * Auto complete support.
    */
    @RequestMapping(value = "/complete", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<List<TaskTypeDTO>> complete(@RequestBody AutoCompleteQuery acq) throws URISyntaxException {

        List<TaskTypeDTO> results = taskTypeDTOService.complete(acq.query, acq.maxResults);

        return new ResponseEntity<>(results, new HttpHeaders(), HttpStatus.OK);
    }

    /**
     * Delete by id TaskType.
     */
    @RequestMapping(value = "/{id}", method = DELETE, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<Void> delete(@PathVariable Integer id) throws URISyntaxException {

        log.debug("Delete by id TaskType : {}", id);

        try {
            taskTypeRepository.delete(id);
            return ResponseEntity.ok().build();
        } catch (Exception x) {
            // todo: dig exception, most likely org.hibernate.exception.ConstraintViolationException
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }
    }
}