/*
 * Source code generated by Celerio, a Jaxio product.
 * Documentation: http://www.jaxio.com/documentation/celerio/
 * Follow us on twitter: @jaxiosoft
 * Need commercial support ? Contact us: info@jaxio.com
 * Template pack-angular:src/main/java/dto/EntityDTOService.java.e.vm
 */
package com.apside.gismo.dto;

import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.apside.gismo.domain.CapitalSubtype;
import com.apside.gismo.domain.CapitalSubtype_;
import com.apside.gismo.dto.support.PageRequestByExample;
import com.apside.gismo.dto.support.PageResponse;
import com.apside.gismo.repository.CapitalSubtypeRepository;

/**
 * A simple DTO Facility for CapitalSubtype.
 */
@Service
public class CapitalSubtypeDTOService {

    @Inject
    private CapitalSubtypeRepository capitalSubtypeRepository;

    @Transactional(readOnly = true)
    public CapitalSubtypeDTO findOne(Integer id) {
        return toDTO(capitalSubtypeRepository.findOne(id));
    }

    @Transactional(readOnly = true)
    public List<CapitalSubtypeDTO> complete(String query, int maxResults) {
        List<CapitalSubtype> results = capitalSubtypeRepository.complete(query, maxResults);
        return results.stream().map(this::toDTO).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public PageResponse<CapitalSubtypeDTO> findAll(PageRequestByExample<CapitalSubtypeDTO> req) {
        Example<CapitalSubtype> example = null;
        CapitalSubtype capitalSubtype = toEntity(req.example);

        if (capitalSubtype != null) {
            ExampleMatcher matcher = ExampleMatcher.matching() //
                    .withMatcher(CapitalSubtype_.capitalsubtype2.getName(), match -> match.ignoreCase().startsWith())
                    .withMatcher(CapitalSubtype_.capitalitem.getName(), match -> match.ignoreCase().startsWith());

            example = Example.of(capitalSubtype, matcher);
        }

        Page<CapitalSubtype> page;
        if (example != null) {
            page = capitalSubtypeRepository.findAll(example, req.toPageable());
        } else {
            page = capitalSubtypeRepository.findAll(req.toPageable());
        }

        List<CapitalSubtypeDTO> content = page.getContent().stream().map(this::toDTO).collect(Collectors.toList());
        return new PageResponse<>(page.getTotalPages(), page.getTotalElements(), content);
    }

    /**
     * Save the passed dto as a new entity or update the corresponding entity if any.
     */
    @Transactional
    public CapitalSubtypeDTO save(CapitalSubtypeDTO dto) {
        if (dto == null) {
            return null;
        }

        final CapitalSubtype capitalSubtype;

        if (dto.isIdSet()) {
            CapitalSubtype capitalSubtypeTmp = capitalSubtypeRepository.findOne(dto.id);
            if (capitalSubtypeTmp != null) {
                capitalSubtype = capitalSubtypeTmp;
            } else {
                capitalSubtype = new CapitalSubtype();
                capitalSubtype.setId(dto.id);
            }
        } else {
            capitalSubtype = new CapitalSubtype();
        }

        capitalSubtype.setCapitalsubtype2(dto.capitalsubtype2);

        capitalSubtype.setCapitalitem(dto.capitalitem);

        capitalSubtype.setProjectId(dto.projectId);

        capitalSubtype.setTasktypeid(dto.tasktypeid);

        return toDTO(capitalSubtypeRepository.save(capitalSubtype));
    }

    /**
     * Converts the passed capitalSubtype to a DTO.
     */
    public CapitalSubtypeDTO toDTO(CapitalSubtype capitalSubtype) {
        return toDTO(capitalSubtype, 1);
    }

    /**
     * Converts the passed capitalSubtype to a DTO. The depth is used to control the
     * amount of association you want. It also prevents potential infinite serialization cycles.
     *
     * @param capitalSubtype
     * @param depth the depth of the serialization. A depth equals to 0, means no x-to-one association will be serialized.
     *              A depth equals to 1 means that xToOne associations will be serialized. 2 means, xToOne associations of
     *              xToOne associations will be serialized, etc.
     */
    public CapitalSubtypeDTO toDTO(CapitalSubtype capitalSubtype, int depth) {
        if (capitalSubtype == null) {
            return null;
        }

        CapitalSubtypeDTO dto = new CapitalSubtypeDTO();

        dto.id = capitalSubtype.getId();
        dto.capitalsubtype2 = capitalSubtype.getCapitalsubtype2();
        dto.capitalitem = capitalSubtype.getCapitalitem();
        dto.projectId = capitalSubtype.getProjectId();
        dto.tasktypeid = capitalSubtype.getTasktypeid();
        if (depth-- > 0) {
        }

        return dto;
    }

    /**
     * Converts the passed dto to a CapitalSubtype.
     * Convenient for query by example.
     */
    public CapitalSubtype toEntity(CapitalSubtypeDTO dto) {
        return toEntity(dto, 1);
    }

    /**
     * Converts the passed dto to a CapitalSubtype.
     * Convenient for query by example.
     */
    public CapitalSubtype toEntity(CapitalSubtypeDTO dto, int depth) {
        if (dto == null) {
            return null;
        }

        CapitalSubtype capitalSubtype = new CapitalSubtype();

        capitalSubtype.setId(dto.id);
        capitalSubtype.setCapitalsubtype2(dto.capitalsubtype2);
        capitalSubtype.setCapitalitem(dto.capitalitem);
        capitalSubtype.setProjectId(dto.projectId);
        capitalSubtype.setTasktypeid(dto.tasktypeid);
        if (depth-- > 0) {
        }

        return capitalSubtype;
    }
}