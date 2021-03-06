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

import com.apside.gismo.domain.CapitalOs;
import com.apside.gismo.domain.CapitalOs_;
import com.apside.gismo.dto.support.PageRequestByExample;
import com.apside.gismo.dto.support.PageResponse;
import com.apside.gismo.repository.CapitalOsRepository;

/**
 * A simple DTO Facility for CapitalOs.
 */
@Service
public class CapitalOsDTOService {

    @Inject
    private CapitalOsRepository capitalOsRepository;

    @Transactional(readOnly = true)
    public CapitalOsDTO findOne(Integer id) {
        return toDTO(capitalOsRepository.findOne(id));
    }

    @Transactional(readOnly = true)
    public List<CapitalOsDTO> complete(String query, int maxResults) {
        List<CapitalOs> results = capitalOsRepository.complete(query, maxResults);
        return results.stream().map(this::toDTO).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public PageResponse<CapitalOsDTO> findAll(PageRequestByExample<CapitalOsDTO> req) {
        Example<CapitalOs> example = null;
        CapitalOs capitalOs = toEntity(req.example);

        if (capitalOs != null) {
            ExampleMatcher matcher = ExampleMatcher.matching() //
                    .withMatcher(CapitalOs_.ident.getName(), match -> match.ignoreCase().startsWith())
                    .withMatcher(CapitalOs_.name.getName(), match -> match.ignoreCase().startsWith());

            example = Example.of(capitalOs, matcher);
        }

        Page<CapitalOs> page;
        if (example != null) {
            page = capitalOsRepository.findAll(example, req.toPageable());
        } else {
            page = capitalOsRepository.findAll(req.toPageable());
        }

        List<CapitalOsDTO> content = page.getContent().stream().map(this::toDTO).collect(Collectors.toList());
        return new PageResponse<>(page.getTotalPages(), page.getTotalElements(), content);
    }

    /**
     * Save the passed dto as a new entity or update the corresponding entity if any.
     */
    @Transactional
    public CapitalOsDTO save(CapitalOsDTO dto) {
        if (dto == null) {
            return null;
        }

        final CapitalOs capitalOs;

        if (dto.isIdSet()) {
            CapitalOs capitalOsTmp = capitalOsRepository.findOne(dto.id);
            if (capitalOsTmp != null) {
                capitalOs = capitalOsTmp;
            } else {
                capitalOs = new CapitalOs();
                capitalOs.setId(dto.id);
            }
        } else {
            capitalOs = new CapitalOs();
        }

        capitalOs.setIdent(dto.ident);

        capitalOs.setName(dto.name);

        capitalOs.setProjectId(dto.projectId);

        capitalOs.setVersionId(dto.versionId);

        return toDTO(capitalOsRepository.save(capitalOs));
    }

    /**
     * Converts the passed capitalOs to a DTO.
     */
    public CapitalOsDTO toDTO(CapitalOs capitalOs) {
        return toDTO(capitalOs, 1);
    }

    /**
     * Converts the passed capitalOs to a DTO. The depth is used to control the
     * amount of association you want. It also prevents potential infinite serialization cycles.
     *
     * @param capitalOs
     * @param depth the depth of the serialization. A depth equals to 0, means no x-to-one association will be serialized.
     *              A depth equals to 1 means that xToOne associations will be serialized. 2 means, xToOne associations of
     *              xToOne associations will be serialized, etc.
     */
    public CapitalOsDTO toDTO(CapitalOs capitalOs, int depth) {
        if (capitalOs == null) {
            return null;
        }

        CapitalOsDTO dto = new CapitalOsDTO();

        dto.id = capitalOs.getId();
        dto.ident = capitalOs.getIdent();
        dto.name = capitalOs.getName();
        dto.projectId = capitalOs.getProjectId();
        dto.versionId = capitalOs.getVersionId();
        if (depth-- > 0) {
        }

        return dto;
    }

    /**
     * Converts the passed dto to a CapitalOs.
     * Convenient for query by example.
     */
    public CapitalOs toEntity(CapitalOsDTO dto) {
        return toEntity(dto, 1);
    }

    /**
     * Converts the passed dto to a CapitalOs.
     * Convenient for query by example.
     */
    public CapitalOs toEntity(CapitalOsDTO dto, int depth) {
        if (dto == null) {
            return null;
        }

        CapitalOs capitalOs = new CapitalOs();

        capitalOs.setId(dto.id);
        capitalOs.setIdent(dto.ident);
        capitalOs.setName(dto.name);
        capitalOs.setProjectId(dto.projectId);
        capitalOs.setVersionId(dto.versionId);
        if (depth-- > 0) {
        }

        return capitalOs;
    }
}