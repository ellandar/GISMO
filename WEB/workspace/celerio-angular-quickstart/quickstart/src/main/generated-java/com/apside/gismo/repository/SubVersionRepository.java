/*
 * Source code generated by Celerio, a Jaxio product.
 * Documentation: http://www.jaxio.com/documentation/celerio/
 * Follow us on twitter: @jaxiosoft
 * Need commercial support ? Contact us: info@jaxio.com
 * Template pack-angular:src/main/java/repository/EntityRepository.java.e.vm
 */
package com.apside.gismo.repository;

import java.util.List;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.*;

import com.apside.gismo.domain.SubVersion;
import com.apside.gismo.domain.SubVersion_;

public interface SubVersionRepository extends JpaRepository<SubVersion, Integer> {

    default List<SubVersion> complete(String query, int maxResults) {
        SubVersion probe = new SubVersion();
        probe.setName(query);

        ExampleMatcher matcher = ExampleMatcher.matching() //
                .withMatcher(SubVersion_.name.getName(), match -> match.ignoreCase().startsWith());

        Page<SubVersion> page = findAll(Example.of(probe, matcher), new PageRequest(0, maxResults));
        return page.getContent();
    }
}