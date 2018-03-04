/*
 * Source code generated by Celerio, a Jaxio product.
 * Documentation: http://www.jaxio.com/documentation/celerio/
 * Follow us on twitter: @jaxiosoft
 * Need commercial support ? Contact us: info@jaxio.com
 * Template pack-angular:src/main/java/domain/Entity.java.e.vm
 */
package com.apside.gismo.domain;

import static javax.persistence.EnumType.STRING;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.logging.Logger;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;

import com.google.common.base.MoreObjects;
import com.google.common.base.Objects;

@Entity
@Table(name = "WEEK_NUMBER")
public class WeekNumber implements Identifiable<Integer>, Serializable {
    private static final long serialVersionUID = 1L;
    private static final Logger log = Logger.getLogger(WeekNumber.class.getName());

    // Raw attributes
    private Integer id;
    private Integer dateyear;
    private Integer dateweek;
    private WeekDay dateday;
    private LocalDate date;

    @Override
    public String entityClassName() {
        return WeekNumber.class.getSimpleName();
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

    public WeekNumber id(Integer id) {
        setId(id);
        return this;
    }

    @Override
    @Transient
    public boolean isIdSet() {
        return id != null;
    }
    // -- [dateyear] ------------------------

    @Digits(integer = 10, fraction = 0)
    @NotNull
    @Column(name = "DATEYEAR", nullable = false, precision = 10)
    public Integer getDateyear() {
        return dateyear;
    }

    public void setDateyear(Integer dateyear) {
        this.dateyear = dateyear;
    }

    public WeekNumber dateyear(Integer dateyear) {
        setDateyear(dateyear);
        return this;
    }
    // -- [dateweek] ------------------------

    @Digits(integer = 10, fraction = 0)
    @NotNull
    @Column(name = "DATEWEEK", nullable = false, precision = 10)
    public Integer getDateweek() {
        return dateweek;
    }

    public void setDateweek(Integer dateweek) {
        this.dateweek = dateweek;
    }

    public WeekNumber dateweek(Integer dateweek) {
        setDateweek(dateweek);
        return this;
    }
    // -- [dateday] ------------------------

    @NotNull
    @Column(name = "DATEDAY", nullable = false, length = 20)
    @Enumerated(STRING)
    public WeekDay getDateday() {
        return dateday;
    }

    public void setDateday(WeekDay dateday) {
        this.dateday = dateday;
    }

    public WeekNumber dateday(WeekDay dateday) {
        setDateday(dateday);
        return this;
    }
    // -- [date] ------------------------

    @NotNull
    @Column(name = "\"DATE\"", nullable = false, length = 8)
    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public WeekNumber date(LocalDate date) {
        setDate(date);
        return this;
    }

    /**
     * Apply the default values.
     */
    public WeekNumber withDefaults() {
        return this;
    }

    /**
     * Equals implementation using a business key.
     */
    @Override
    public boolean equals(Object other) {
        return this == other || (other instanceof WeekNumber && hashCode() == other.hashCode());
    }

    private IdentifiableHashBuilder identifiableHashBuilder = new IdentifiableHashBuilder();

    @Override
    public int hashCode() {
        return identifiableHashBuilder.hash(log, this);
    }

    /**
     * Construct a readable string representation for this WeekNumber instance.
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        return MoreObjects.toStringHelper(this) //
                .add("id", getId()) //
                .add("dateyear", getDateyear()) //
                .add("dateweek", getDateweek()) //
                .add("dateday", getDateday()) //
                .add("date", getDate()) //
                .toString();
    }
}