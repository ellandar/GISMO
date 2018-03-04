/*
 * Source code generated by Celerio, a Jaxio product.
 * Documentation: http://www.jaxio.com/documentation/celerio/
 * Follow us on twitter: @jaxiosoft
 * Need commercial support ? Contact us: info@jaxio.com
 * Template pack-angular:src/main/java/dto/EntityDTO.java.e.vm
 */
package com.apside.gismo.dto;

import com.apside.gismo.domain.TaskFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Simple DTO for TaskType.
 */
public class TaskTypeDTO {
    public Integer id;
    public String name;
    public TaskFormat type;
    public Integer projectId;
    public Integer defaultTaskId;

    @JsonIgnore
    public boolean isIdSet() {
        return id != null;
    }
}