package com.sch.rezero.repository.community;

import com.sch.rezero.entity.community.CommunityPost;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CommunityPostRepository extends JpaRepository<CommunityPost, Long>, CommunityPostQueryRepository {

  @Query("SELECT p FROM CommunityPost p WHERE p.user.id = :userId ORDER BY p.createdAt DESC")
  List<CommunityPost> findByUser_Id(@Param("userId") Long userId);

  @Query("SELECT p FROM CommunityPost p WHERE p.user.id IN :followingIds ORDER BY p.createdAt DESC")
  List<CommunityPost> findByUserIds(@Param("followingIds") List<Long> followingIds);

}
