package com.sch.rezero.repository.stats;

import com.sch.rezero.dto.stats.AgeGroupCountDto;
import com.sch.rezero.dto.stats.RegionCountDto;
import com.sch.rezero.entity.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StatsRepository extends JpaRepository<User, Long> {
    @Query("""
            SELECT new com.sch.rezero.dto.stats.RegionCountDto(u.region, count(u))
            FROM User u
            WHERE u.region IS NOT NULL
            GROUP BY u.region
            ORDER BY COUNT(u) DESC
            """)
    List<RegionCountDto> countUsersByRegion();

    @Query("SELECT COUNT(u) FROM User u  WHERE u.region IS NOT NULL")
    Long allCountUsersByRegion();

    @Query(value = """
            WITH user_age AS (
                SELECT  EXTRACT(YEAR FROM AGE(NOW(), birth))::INT AS age
                FROM users
                WHERE birth IS NOT NULL
            )
            SELECT
                CASE
                    WHEN age < 20 THEN '10대'
                    WHEN age < 30 THEN '20대'
                    WHEN age < 40 THEN '30대'
                    WHEN age < 50 THEN '40대'
                    ELSE '50대 이상'
                END AS ageGroup,
                COUNT(*) AS count
            FROM user_age
            GROUP BY ageGroup
            ORDER BY ageGroup
            """, nativeQuery = true)
    List<AgeGroupCountDto> countUsersByAgeGroup();

    @Query("SELECT COUNT(u) FROM User u  WHERE u.birth IS NOT NULL")
    Long allCountUsersByAge();
}