package sch.rezero.domain.interest.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import sch.rezero.domain.interest.entity.Interest;
import sch.rezero.domain.interest.entity.InterestId;

@Repository
public interface InterestRepository extends JpaRepository<Interest, InterestId> {

}
