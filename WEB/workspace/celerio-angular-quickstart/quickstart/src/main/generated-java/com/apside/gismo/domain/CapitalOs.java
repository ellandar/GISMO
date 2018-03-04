/*
 * Source code generated by Celerio, a Jaxio product.
 * Documentation: http://www.jaxio.com/documentation/celerio/
 * Follow us on twitter: @jaxiosoft
 * Need commercial support ? Contact us: info@jaxio.com
 * Template pack-angular:src/main/java/domain/Entity.java.e.vm
 */
package com.apside.gismo.domain;

import java.io.Serializable;
import java.util.logging.Logger;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import com.google.common.base.MoreObjects;
import com.google.common.base.Objects;

@Entity
@Table(name = "CAPITAL_OS")
public class CapitalOs implements Identifiable<Integer>, Serializable {
    private static final long serialVersionUID = 1L;
    private static final Logger log = Logger.getLogger(CapitalOs.class.getName());

    // Raw attributes
    private Integer id;
    private String ident;
    private String name;
    private Integer projectId;
    private Integer versionId;

    @Override
    public String entityClassName() {
        return CapitalOs.class.getSimpleName();
    }

    // -- [id] ------------------------

    @Override
    @Digits(integer = 10, fraction = 0)
    @NotNull
    @Column(name = "ID", precision = 10)
    @Id
    public Integer getId() {
        return id;
    }

    @Override
    public void setId(Integer id) {
        this.id = id;
    }

    public CapitalOs id(Integer id) {
        setId(id);
        return this;
    }

    @Override
    @Transient
    public boolean isIdSet() {
        return id != null;
    }
    // -- [ident] ------------------------

    @NotEmpty
    @Size(max = 20)
    @Column(name = "IDENT", nullable = false, unique = true, length = 20)
    public String getIdent() {
        return ident;
    }

    public void setIdent(String ident) {
        this.ident = ident;
    }

    public CapitalOs ident(String ident) {
        setIdent(ident);
        return this;
    }
    // -- [name] ------------------------

    @NotEmpty
    @Size(max = 255)
    @Column(name = "NAME", nullable = false, unique = true)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public CapitalOs name(String name) {
        setName(name);
        return this;
    }
    // -- [projectId] ------------------------

    @Digits(integer = 10, fraction = 0)
    @NotNull
    @Column(name = "PROJECT_ID", nullable = false, precision = 10)
    public Integer getProjectId() {
        return projectId;
    }

    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
    }

    public CapitalOs projectId(Integer projectId) {
        setProjectId(projectId);
        return this;
    }
    // -- [versionId] ------------------------

    @Digits(integer = 10, fraction = 0)
    @NotNull
    @Column(name = "VERSION_ID", nullable = false, precision = 10)
    public Integer getVersionId() {
        return versionId;
    }

    public void setVersionId(Integer versionId) {
        this.versionId = versionId;
    }

    public CapitalOs versionId(Integer versionId) {
        setVersionId(versionId);
        return this;
    }

    /**
     * Apply the default values.
     */
    public CapitalOs withDefaults() {
        return this;
    }

    /**
     * Equals implementation using a business key.
     */
    @Override
    public boolean equals(Object other) {
        return this == other || (other instanceof CapitalOs && hashCode() == other.hashCode());
    }

    private volatile int previousHashCode = 0;

    @Override
    public int hashCode() {
        int hashCode = Objects.hashCode(getIdent());

        if (previousHashCode != 0 && previousHashCode != hashCode) {
            log.warning("DEVELOPER: hashCode has changed!." //
                    + "If you encounter this message you should take the time to carefuly review equals/hashCode for: " //
                    + getClass().getCanonicalName());
        }

        previousHashCode = hashCode;
        return hashCode;
    }

    /**
     * Construct a readable string representation for this CapitalOs instance.
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        return MoreObjects.toStringHelper(this) //
                .add("id", getId()) //
                .add("ident", getIdent()) //
                .add("name", getName()) //
                .add("projectId", getProjectId()) //
                .add("versionId", getVersionId()) //
                .toString();
    }
}