package com.sch.rezero.controller.user;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.dto.user.follow.FollowCreateRequest;
import com.sch.rezero.dto.user.follow.FollowDto;
import com.sch.rezero.dto.user.follow.FollowQuery;
import com.sch.rezero.dto.user.follow.FollowResponse;
import com.sch.rezero.service.user.FollowService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("api/follows")
public class FollowController {

    private final FollowService followService;
    private final UserContext userContext;

    @GetMapping("/{id}/follower")
    public ResponseEntity<CursorPageResponse<FollowDto>> findAllFollower(@PathVariable Long id, @ModelAttribute FollowQuery query) {
        var follower = followService.findAllFollowerByUserId(id, query);
        return ResponseEntity.status(HttpStatus.OK).body(follower);
    }

    @GetMapping("/{id}/following")
    public ResponseEntity<CursorPageResponse<FollowDto>> findAllFollowing(@PathVariable Long id, @ModelAttribute FollowQuery query) {
        var following = followService.findAllFollowingByUserId(id, query);
        return ResponseEntity.status(HttpStatus.OK).body(following);
    }

    @PostMapping
    public ResponseEntity<FollowResponse> create(FollowCreateRequest followCreateRequest) {
        Long userId = userContext.getCurrentUserId();
        FollowResponse created = followService.create(userId, followCreateRequest);

        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @DeleteMapping("{id}")
    public ResponseEntity<Void> delete(@PathVariable long id) {
        Long userId = userContext.getCurrentUserId();
        followService.delete(userId, id);

        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

}
