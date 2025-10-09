package com.sch.rezero.repository.recycling;

import com.sch.rezero.dto.recycling.scrap.ScrapQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.recycling.Scrap;

public interface ScrapQueryRepository {
    CursorPageResponse<Scrap> findAllByUserId(ScrapQuery scrapQuery);
}
