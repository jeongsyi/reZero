package com.sch.rezero.mapper.community;

import com.sch.rezero.dto.community.likes.LikeResponse;
import com.sch.rezero.entity.community.Like;
import org.mapstruct.Mapping;

public interface LikeMapper {

  LikeResponse toLikeResponse(Like like);

}
