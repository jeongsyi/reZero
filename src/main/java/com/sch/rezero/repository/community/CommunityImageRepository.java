package com.sch.rezero.repository.community;

import com.sch.rezero.entity.community.CommunityImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommunityImageRepository extends JpaRepository<CommunityImage, Long> {

}
