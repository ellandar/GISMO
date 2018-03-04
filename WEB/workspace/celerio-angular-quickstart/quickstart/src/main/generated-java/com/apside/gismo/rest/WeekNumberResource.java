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

import com.apside.gismo.domain.WeekNumber;
import com.apside.gismo.dto.WeekNumberDTO;
import com.apside.gismo.dto.WeekNumberDTOService;
import com.apside.gismo.dto.support.PageRequestByExample;
import com.apside.gismo.dto.support.PageResponse;
import com.apside.gismo.repository.WeekNumberRepository;
import com.apside.gismo.rest.support.AutoCompleteQuery;

@RestController
@RequestMapping("/api/weekNumbers")
public class WeekNumberResource {

    private final Logger log = LoggerFactory.getLogger(WeekNumberResource.class);

    @Inject
    private WeekNumberRepository weekNumberRepository;
    @Inject
    private WeekNumberDTOService weekNumberDTOService;

    /**
     * Create a new WeekNumber.
     */
    @RequestMapping(value = "/", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<WeekNumberDTO> create(@RequestBody WeekNumberDTO weekNumberDTO) throws URISyntaxException {

        log.debug("Create WeekNumberDTO : {}", weekNumberDTO);

        if (weekNumberDTO.isIdSet()) {
            return ResponseEntity.badRequest().header("Failure", "Cannot create WeekNumber with existing ID").body(null);
        }

        WeekNumberDTO result = weekNumberDTOService.save(weekNumberDTO);

        return ResponseEntity.created(new URI("/api/weekNumbers/" + result.id)).body(result);
    }

    /**
    * Find by id WeekNumber.
    */
    @RequestMapping(value = "/{id}", method = GET, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<WeekNumberDTO> findById(@PathVariable Integer id) throws URISyntaxException {

        log.debug("Find by id WeekNumber : {}", id);

        return Optional.ofNullable(weekNumberDTOService.findOne(id)).map(weekNumberDTO -> new ResponseEntity<>(weekNumberDTO, HttpStatus.OK))
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    /**
     * Update WeekNumber.
     */
    @RequestMapping(value = "/", method = PUT, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<WeekNumberDTO> update(@RequestBody WeekNumberDTO weekNumberDTO) throws URISyntaxException {

        log.debug("Update WeekNumberDTO : {}", weekNumberDTO);

        if (!weekNumberDTO.isIdSet()) {
            return create(weekNumberDTO);
        }

        WeekNumberDTO result = weekNumberDTOService.save(weekNumberDTO);

        return ResponseEntity.ok().body(result);
    }

    /**
     * Find a Page of WeekNumber using query by example.
     */
    @RequestMapping(value = "/page", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<PageResponse<WeekNumberDTO>> findAll(@RequestBody PageRequestByExample<WeekNumberDTO> prbe) throws URISyntaxException {
        PageResponse<WeekNumberDTO> pageResponse = weekNumberDTOService.findAll(prbe);
        return new ResponseEntity<>(pageResponse, new HttpHeaders(), HttpStatus.OK);
    }

    /**
    * Auto complete support.
    */
    @RequestMapping(value = "/complete", method = POST, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<List<WeekNumberDTO>> complete(@RequestBody AutoCompleteQuery acq) throws URISyntaxException {

        List<WeekNumberDTO> results = weekNumberDTOService.complete(acq.query, acq.maxResults);

        return new ResponseEntity<>(results, new HttpHeaders(), HttpStatus.OK);
    }

    /**
     * Delete by id WeekNumber.
     */
    @RequestMapping(value = "/{id}", method = DELETE, produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<Void> delete(@PathVariable Integer id) throws URISyntaxException {

        log.debug("Delete by id WeekNumber : {}", id);

        try {
            weekNumberRepository.delete(id);
            return ResponseEntity.ok().build();
        } catch (Exception x) {
            // todo: dig exception, most likely org.hibernate.exception.ConstraintViolationException
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }
    }
}