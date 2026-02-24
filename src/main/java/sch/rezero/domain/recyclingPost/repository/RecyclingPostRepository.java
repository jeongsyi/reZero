package sch.rezero.domain.recyclingPost.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import sch.rezero.domain.recyclingPost.entity.RecyclingPost;

@Repository
public interface RecyclingPostRepository extends JpaRepository<RecyclingPost, Long> {

}
