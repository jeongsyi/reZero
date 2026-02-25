package sch.rezero.domain.complaint.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import sch.rezero.domain.complaint.entity.Complaint;

@Repository
public interface ComplaintRepository extends JpaRepository<Complaint, Long> {

}
