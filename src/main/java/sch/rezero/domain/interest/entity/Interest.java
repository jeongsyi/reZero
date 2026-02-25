package sch.rezero.domain.interest.entity;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import sch.rezero.domain.category.entity.Category;

@Entity
@Getter
@Table(name = "interests")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Interest {

    @EmbeddedId
    private InterestId id;

//    @ManyToOne
//    @MapsId("userId")
//    private User user;

    @ManyToOne
    @MapsId("categoryId")
    private Category category;
}
