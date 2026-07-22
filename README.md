# twitcast-recorder

특정 트위캐스팅 사용자를 예약해두면 방송이 켜지는 순간을 감지해 자동 녹화하는 Shell 도구. Linux 전용.

## 주요 기능

- 아이디 예약 후 온에어 자동 감지·녹화
- 영상(.ts)·음성(.m4a) 분리 저장
- 비밀번호 방송 대응
- 저화질 백업 스트림 동시 녹화
- 여러 아이디를 독립 백그라운드 프로세스로 동시 감시

## 동작 방식

스트림 상태 API를 기본 10초 간격으로 폴링해 온에어를 감지하면, 수정된 `livedl`로 원본 화질을 받고(비밀번호는 md5 → 쿠키), 동시에 FFmpeg로 저화질 백업을 MPEG-TS로 저장한다. 녹화가 끝나면 `.ts`에서 음성만 추출해 `.m4a`를 만든다.

## 기술 스택

Bash, livedl(수정본), FFmpeg, curl. Linux/Ubuntu 전용.

기반: [printempw/live-stream-recorder](https://github.com/printempw/live-stream-recorder) · 다운로더: [himananiito/livedl](https://github.com/himananiito/livedl)
