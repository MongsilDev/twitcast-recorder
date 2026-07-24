# twitcast-recorder

특정 트위캐스팅 사용자를 예약해두면 온에어를 감지해 자동으로 녹화하는 Linux 전용 Bash 스크립트 모음이다. [printempw/live-stream-recorder](https://github.com/printempw/live-stream-recorder)를 기반으로 하며, 다운로더로는 비밀번호 방송을 받을 수 있게 수정한 [himananiito/livedl](https://github.com/himananiito/livedl) 바이너리를 동봉한다.

## 기능

- 아이디를 예약하면 온에어를 자동 감지해 녹화하고, 방송이 끝나면 다시 감시로 돌아간다
- 비밀번호가 걸린 방송 녹화를 지원하며, 비밀번호가 없는 방송에서는 해당 값이 무시된다
- 원본 화질 녹화와 동시에 저화질 백업 스트림을 `backup/`에 MPEG-TS로 저장한다
- 녹화가 끝나면 `.ts`에서 음성만 추출한 `.m4a`를 만든다
- 여러 아이디를 각각 백그라운드 프로세스로 동시 감시할 수 있고, `proc_list.sh`로 목록을 확인한다
- `batch_convert.sh`로 폴더 안의 `.ts` 전체를 한꺼번에 `.m4a`로 추출한다

## 동작 방식

`record_twitcast.sh`가 트위캐스팅 스트림 상태 API를 기본 10초 간격으로 폴링해 온에어를 감지한다. 방송이 시작되면 `livedl`이 원본 스트림을 받고, 동시에 FFmpeg가 저화질 m3u8 스트림을 `backup/`에 저장한다. 백업 스트림 요청에는 비밀번호를 md5 해시로 바꾼 쿠키를 붙이고, 녹화가 끝나면 `.ts`에서 음성을 복사해 `.m4a`를 만든다.

## 실행

FFmpeg가 필요하고, 스크립트와 `livedl` 바이너리에 실행 권한이 있어야 하며, 로그와 백업이 저장될 폴더를 미리 만들어야 한다.

```bash
sudo apt-get install ffmpeg
chmod +x *.sh livedl
mkdir -p log backup
```

녹화 예약은 `rr.sh`로 등록한다. 백그라운드로 돌며 로그는 `log/`에 남는다.

```bash
./rr.sh <계정명> [비밀번호]

# 예시
./rr.sh hariryu2434
./rr.sh rohalee2434 1212
```

예약을 제거하려면 프로세스 번호를 확인한 뒤 종료한다.

```bash
./proc_list.sh
kill -9 <프로세스 번호>
```

전면에서 직접 돌리려면 `record_twitcast.sh`를 쓴다. 세 번째 인자에 `once`를 주면 한 번 녹화 후 종료하고, 네 번째 인자로 폴링 간격 초를 바꿀 수 있다.

```bash
./record_twitcast.sh <계정명> [비밀번호] [loop|once] [간격]
```
