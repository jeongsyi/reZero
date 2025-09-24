package com.sch.rezero.dto.user.follow;

import jakarta.validation.constraints.NotNull;

public record FollowCreateRequest(
    @NotNull
    Long followingId
) {

}
