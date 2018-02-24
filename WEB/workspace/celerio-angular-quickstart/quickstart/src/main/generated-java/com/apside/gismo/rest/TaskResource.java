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

import com.apside.gismo.domain.Task;
import com.apside.gismo.dto.TaskDTO;
import com.apside.gismo.dto.TaskDTOService;
import com.apside.gismo.dto.support.PageRequestByExample;
import com.apside.gismo.dto.support.PageResponse;
import com.apside.gismo.repository.TaskRepository;
import com.apside.gismo.rest.support.AutoCompleteQuery;

@RestController
@RequestMapping("/api/tasks")
public class TaskResource {

    private final Logger log = LoggerFactory.getLogger(TaskResource.class);

    @Inject
    private TaskRepository taskRepository;
    @Inject
    private TaskDTOService taskDTOService;

    /**
     * Create a new Task.
     */
    @RequestMapping(value = "/", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<TaskDTO> create(@RequestBody TaskDTO taskDTO) throws URISyntaxException {

        log.debug("Create TaskDTO : {}", taskDTO);

        if (taskDTO.isIdSet()) {
            return ResponseEntity.badRequest().header("Failure", "Cannot create Task with existing ID").body(null);
        }

        TaskDTO result = taskDTOService.save(taskDTO);

        return ResponseEntity.created(new URI("/api/tasks/" + result.id)).body(result);
    }

    /**
    * Find by id Task.
    */
    @RequestMapping(value = "/{id}", method = GET, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<TaskDTO> findById(@PathVariable Integer id) throws URISyntaxException {

        log.debug("Find by id Task : {}", id);

        return Optional.ofNullable(taskDTOService.findOne(id)).map(taskDTO -> new ResponseEntity<>(taskDTO, HttpStatus.OK))
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    /**
     * Update Task.
     */
    @RequestMapping(value = "/", method = PUT, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<TaskDTO> update(@RequestBody TaskDTO taskDTO) throws URISyntaxException {

        log.debug("Update TaskDTO : {}", taskDTO);

        if (!taskDTO.isIdSet()) {
            return create(taskDTO);
        }

        TaskDTO result = taskDTOService.save(taskDTO);

        return ResponseEntity.ok().body(result);
    }

    /**
     * Find a Page of Task using query by example.
     */
    @RequestMapping(value = "/page", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<PageResponse<TaskDTO>> findAll(@RequestBody PageRequestByExample<TaskDTO> prbe) throws URISyntaxException {
        PageResponse<TaskDTO> pageResponse = taskDTOService.findAll(prbe);
        return new ResponseEntity<>(pageResponse, new HttpHeaders(), HttpStatus.OK);
    }

    /**
    * Auto complete support.
    */
    @RequestMapping(value = "/complete", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<List<TaskDTO>> complete(@RequestBody AutoCompleteQuery acq) throws URISyntaxException {

        List<TaskDTO> results = taskDTOService.complete(acq.query, acq.maxResults);

        return new ResponseEntity<>(results, new HttpHeaders(), HttpStatus.OK);
    }

    /**
     * Delete by id Task.
     */
    @RequestMapping(value = "/{id}", method = DELETE, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<Void> delete(@PathVariable Integer id) throws URISyntaxException {

        log.debug("Delete by id Task : {}", id);

        try {
            taskRepository.delete(id);
            return ResponseEntity.ok().build();
        } catch (Exception x) {
            // todo: dig exception, most likely org.hibernate.exception.ConstraintViolationException
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }
    }
}