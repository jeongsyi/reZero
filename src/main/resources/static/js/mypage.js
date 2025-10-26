const API_BASE_URL = '/api/me';
const DEFAULT_PROFILE_IMG = 'img/default_profile.png';
let currentProfileUrl = DEFAULT_PROFILE_IMG;
let isImageRemoved = false; // ⭐️ 이미지 삭제 상태 추적 변수 추가

// 이미지 미리보기 함수 (공통)
function previewImage(event, previewElementId) {
  const reader = new FileReader();
  const imagePreview = document.getElementById(previewElementId);

  if (event.target.files.length > 0) {
    reader.onload = function(){
      imagePreview.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
    // ⭐️ 새 파일이 선택되면 삭제 요청을 취소합니다.
    isImageRemoved = false;
  }
}

// ⭐️ 이미지 삭제 처리 함수 수정
function handleImageRemoval() {
  const preview = document.getElementById('editProfileImagePreview');
  const fileInput = document.getElementById('editProfileImageFile');

  // 파일 입력 필드 초기화 (선택된 파일 제거)
  fileInput.value = '';

  // 미리보기 이미지를 기본 이미지로 변경
  preview.src = DEFAULT_PROFILE_IMG;

  // ⭐️ 삭제 요청 플래그 활성화
  isImageRemoved = true;
  alert("기존 이미지가 삭제 대기 상태입니다. '변경 내용 저장' 버튼을 눌러야 최종 반영됩니다.");
}


// 폼과 뷰 모드 전환
function toggleEditMode(isEdit) {
  document.getElementById('profileView').style.display = isEdit ? 'none' : 'block';
  document.getElementById('profileEditForm').style.display = isEdit ? 'block' : 'none';

  // 수정 모드 진입 시 에러 메시지 초기화
  document.getElementById('editFormErrorMsg').textContent = '';
  document.getElementById('editUserIdError').textContent = '';
  document.getElementById('editPasswordError').textContent = '';
  document.getElementById('editNameError').textContent = '';
}

// 프로필 데이터 표시 함수
function displayProfile(data) {
  currentProfileUrl = data.profileUrl || DEFAULT_PROFILE_IMG; // 현재 URL 저장

  // 뷰 모드 설정
  document.getElementById('viewProfileImage').src = currentProfileUrl;
  document.getElementById('viewName').textContent = data.name;
  document.getElementById('viewUserId').textContent = `@${data.userId}`;

  // ⭐️ 수정 부분 1: '일반 사용자'를 '사용자'로 변경
  document.getElementById('viewRole').textContent = data.role === 'USER' ? '사용자' : data.role;

  document.getElementById('viewBirth').textContent = data.birth ? data.birth : '미입력';
  document.getElementById('viewRegion').textContent = data.region ? data.region : '미입력';
  document.getElementById('viewFollowerCount').textContent = data.followerCount || 0;
  document.getElementById('viewFollowingCount').textContent = data.followingCount || 0;

  // 수정 폼 초기값 설정
  document.getElementById('editProfileImagePreview').src = currentProfileUrl;
  document.getElementById('editUserId').value = data.userId;
  document.getElementById('editName').value = data.name;
  document.getElementById('editBirth').value = data.birth || '';
  document.getElementById('editRegion').value = data.region || '';
  document.getElementById('editPassword').value = ''; // 비밀번호는 항상 비워둠
  document.getElementById('editProfileImageFile').value = ''; // 파일 입력 필드 초기화
  isImageRemoved = false; // ⭐️ 폼 로드 시 삭제 상태 초기화
}

// 1. 프로필 정보 조회 (GET /api/me)
async function fetchProfile() {
  // ... (기존 fetchProfile 로직 유지)
  const globalErrorMsg = document.getElementById('globalErrorMsg');
  globalErrorMsg.textContent = '';
  try {
    const response = await fetch(API_BASE_URL, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    });

    if (response.ok) {
      const data = await response.json();
      displayProfile(data);
    } else if (response.status === 401 || response.status === 403) {
      globalErrorMsg.textContent = '로그인이 필요하거나 권한이 없습니다.';
    } else {
      globalErrorMsg.textContent = '프로필 정보를 불러오는 데 실패했습니다.';
    }
  } catch (error) {
    console.error('Fetch error:', error);
    globalErrorMsg.textContent = '네트워크 연결에 문제가 발생했습니다.';
  }
}


// 2. 프로필 정보 수정 (PATCH /api/me)
document.getElementById('profileEditForm').addEventListener('submit', async (e) => {
  e.preventDefault();

  const form = e.target;
  const formData = new FormData(form);
  const editFormErrorMsg = document.getElementById('editFormErrorMsg');

  // 에러 메시지 초기화
  document.getElementById('editUserIdError').textContent = '';
  document.getElementById('editPasswordError').textContent = '';
  document.getElementById('editNameError').textContent = '';
  editFormErrorMsg.textContent = '';

  // ProfileUpdateRequest JSON 객체 구성
  const profileUpdateRequest = {
    userId: formData.get('userId'),
    password: formData.get('password') || null,
    name: formData.get('name'),
    birth: formData.get('birth') || null,
    region: formData.get('region') || null,
    // ⭐️ 수정: 백엔드 DTO에 추가된 필드를 가정하고 값을 전송합니다.
    deleteProfileImage: isImageRemoved
  };

  // 파일 객체 (MultipartFile)
  const profileImageFile = formData.get('profileImage');
  const sendFormData = new FormData();

  // 1. 새 파일이 선택된 경우에만 profileImage 파트를 전송합니다.
  if (profileImageFile && profileImageFile.size > 0) {
    sendFormData.append('profileImage', profileImageFile);
  }
  // ⭐️ 파일이 없는 경우 (기존 유지 또는 삭제 요청)에는 profileImage 파트를 전송하지 않습니다.
  // 이 경우 서버는 profileImage를 null로 받게 되며, deleteProfileImage 플래그로 삭제 여부를 결정합니다.

  // DTO JSON을 Blob으로 변환하여 FormData에 추가
  const jsonBlob = new Blob([JSON.stringify(profileUpdateRequest)], { type: 'application/json' });
  sendFormData.append('request', jsonBlob, 'request.json');


  try {
    const response = await fetch(API_BASE_URL, {
      method: 'PATCH',
      body: sendFormData
    });

    if (response.ok) {
      alert('✅ 프로필 정보가 성공적으로 업데이트되었습니다.');
      const data = await response.json();
      displayProfile(data); // 업데이트된 정보로 화면 갱신
      toggleEditMode(false); // 뷰 모드로 전환
    } else {
      const errorData = await response.json();

      if (response.status === 400) {
        if (errorData.message && errorData.message.includes("LoginId already exists")) {
          document.getElementById('editUserIdError').textContent = '이미 사용 중인 아이디입니다.';
        } else if (errorData.errors) {
          errorData.errors.forEach(error => {
            const errorId = `edit${error.field.charAt(0).toUpperCase() + error.field.slice(1)}Error`;
            const errorElement = document.getElementById(errorId);
            if(errorElement) errorElement.textContent = error.defaultMessage;
          });
        } else {
          editFormErrorMsg.textContent = `🚨 업데이트 실패: ${errorData.message || response.statusText}`;
        }
      } else {
        editFormErrorMsg.textContent = `🚨 서버 에러: ${errorData.message || response.statusText}`;
      }
    }
  } catch (error) {
    console.error('네트워크 에러:', error);
    editFormErrorMsg.textContent = '🚨 네트워크 연결에 문제가 발생했습니다.';
  }
});

// 3. 회원 탈퇴 (DELETE /api/me)
async function handleDeleteUser() {
  // ... (기존 handleDeleteUser 로직 유지)
  if (!confirm("정말로 회원 탈퇴를 하시겠습니까? 모든 데이터는 삭제되며 되돌릴 수 없습니다.")) {
    return;
  }

  try {
    const response = await fetch(API_BASE_URL, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json'
      }
    });

    if (response.ok) {
      alert('✅ 회원 탈퇴가 성공적으로 처리되었습니다. 이용해 주셔서 감사합니다.');
      window.location.href = 'index.html';
    } else {
      const errorData = await response.json();
      alert(`🚨 회원 탈퇴 실패: ${errorData.message || response.statusText}`);
    }
  } catch (error) {
    console.error('Delete error:', error);
    alert('🚨 네트워크 연결에 문제가 발생했습니다.');
  }
}

// 페이지 로드 시 프로필 정보 불러오기
document.addEventListener('DOMContentLoaded', fetchProfile);