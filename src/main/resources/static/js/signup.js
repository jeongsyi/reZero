// 파일 선택 시 이미지 미리보기 기능
function previewImage(event) {
    const reader = new FileReader();
    const imagePreview = document.getElementById('imagePreview');

    if (event.target.files.length > 0) {
        reader.onload = function(){
            imagePreview.src = reader.result;
            imagePreview.style.display = 'block';
        };
        reader.readAsDataURL(event.target.files[0]);
    } else {
        imagePreview.src = '';
        imagePreview.style.display = 'none';
    }
}


document.addEventListener('DOMContentLoaded', () => {
    const signupForm = document.getElementById('signupForm');
    const globalErrorMsg = document.getElementById('signupErrorMsg');

    // 모든 에러 메시지 요소를 객체로 관리하여 쉽게 접근
    const errorMessages = {
        userId: document.getElementById('userIdError'),
        password: document.getElementById('passwordError'),
        name: document.getElementById('nameError'),
    };

    // 폼 제출 이벤트 핸들러
    signupForm.addEventListener('submit', async (e) => {
        e.preventDefault(); // 기본 폼 제출 방지

        // 모든 에러 메시지 초기화
        Object.values(errorMessages).forEach(el => el.textContent = '');
        globalErrorMsg.textContent = '';

        // 1. FormData 객체 생성 및 JSON 요청 본문 구성
        const formData = new FormData(signupForm);

        const profileRequest = {
            userId: formData.get('userId'),
            password: formData.get('password'),
            name: formData.get('name'),
            // ⭐️ 역할 선택 필드가 제거되었으므로 'USER'로 고정하여 전송합니다.
            role: 'USER',
            // 값이 없는 경우 null로 처리
            birth: formData.get('birth') || null,
            region: formData.get('region') || null,
        };

        // 2. RequestPart 'request' (JSON)을 Blob으로 변환하여 FormData에 추가
        const jsonBlob = new Blob([JSON.stringify(profileRequest)], { type: 'application/json' });

        // 기존의 필드들을 삭제하고, 새로운 'request' 파트를 추가
        formData.delete('userId');
        formData.delete('password');
        formData.delete('name');
        formData.delete('birth');
        formData.delete('region');
        // role은 HTML에 없으므로 삭제할 필요는 없으나, 혹시 몰라 region 아래에 추가했습니다.

        formData.append('request', jsonBlob, 'request.json');

        // 파일이 없으면 'profileImage' 파트를 전송하지 않도록 삭제
        const profileImageFile = formData.get('profileImage');
        if (!profileImageFile || profileImageFile.size === 0) {
            formData.delete('profileImage');
        }

        // 3. 서버로 요청 전송
        try {
            const response = await fetch('/api/auth/signup', {
                method: 'POST',
                body: formData
            });

            if (response.ok) {
                // HTTP 상태 코드 201 (Created) 성공 처리
                const data = await response.json();
                alert(`✅ 회원가입 성공! ${data.name}님 환영합니다.`);
                // 성공 시 로그인 페이지로 리디렉션
                window.location.href = 'login.html';
            } else {
                // HTTP 상태 코드 4xx, 5xx 에러 처리
                const errorData = await response.json();

                if (response.status === 400) {
                    // ProfileService의 'LoginId already exists' 에러 처리
                    if (errorData.message && errorData.message.includes("LoginId already exists")) {
                        errorMessages.userId.textContent = '이미 사용 중인 아이디입니다.';
                    } else if (errorData.errors) {
                        // Spring Validation 에러 처리 (ProfileCreateRequest)
                        errorData.errors.forEach(error => {
                            if (errorMessages[error.field]) {
                                errorMessages[error.field].textContent = error.defaultMessage;
                            }
                        });
                    } else {
                        globalErrorMsg.textContent = `🚨 회원가입 실패: ${errorData.message || response.statusText}`;
                    }
                } else {
                    globalErrorMsg.textContent = `🚨 서버 에러가 발생했습니다: ${response.status} ${response.statusText}`;
                }
            }

        } catch (error) {
            console.error('네트워크 에러:', error);
            globalErrorMsg.textContent = '🚨 네트워크 연결에 문제가 발생했습니다.';
        }
    });
});