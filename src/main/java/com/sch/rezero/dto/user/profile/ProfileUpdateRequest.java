package com.sch.rezero.dto.user.profile;

import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import java.time.LocalDate;

public record ProfileUpdateRequest(
    @Size(min = 4, max = 50)
    String userId,

    @Size(min = 8, max = 20, message = "비밀번호는 8자 이상 20자 이하여야 합니다")
    @Pattern(regexp = "^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*]).{8,}$",
        message = "비밀번호는 최소 8자 이상, 숫자, 문자, 특수문자를 포함해야 합니다")
    String password,

    @Size(max = 100)
    String name,

    @PastOrPresent
    LocalDate birth,

    @Size(max = 100)
    String region,

    Boolean deleteProfileImage
) {

}
