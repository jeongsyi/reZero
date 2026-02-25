package sch.rezero.domain.interest.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

@Embeddable
public class InterestId {

    @Column(name = "user_id")
    Long userId;

    @Column(name = "category_id")
    Long categoryId;
}
