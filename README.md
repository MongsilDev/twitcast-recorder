# twitcast-recorder

예약해 둔 트위캐스팅 사용자의 방송이 켜지면 자동으로 녹화하는 Linux 전용 Bash 스크립트 모음입니다.\
[printempw/live-stream-recorder](https://github.com/printempw/live-stream-recorder)를 바탕으로 했고, 다운로더로는 비밀번호 방송을 받을 수 있게 고친 [himananiito/livedl](https://github.com/himananiito/livedl) 바이너리를 함께 넣었습니다.

## 기능

- 아이디를 예약하면 온에어를 감지해 녹화하고, 방송이 끝나면 다시 감시
- 비밀번호가 걸린 방송도 녹화.\
  비밀번호가 없는 방송에서는 이 값을 무시
- 원본 화질 녹화와 함께 저화질 백업 스트림을 `backup/`에 MPEG-TS로 저장
- 녹화가 끝나면 `.ts`에서 음성만 뽑아 `.m4a`로 저장
- 여러 아이디를 각각 백그라운드 프로세스로 동시에 감시하고, `proc_list.sh`로 목록 확인
- `batch_convert.sh`로 폴더 안의 `.ts`를 한꺼번에 `.m4a`로 추출

## 동작 방식

`record_twitcast.sh`가 트위캐스팅 스트림 상태 API를 기본 10초 간격으로 확인해 온에어를 감지합니다.\
방송이 시작되면 `livedl`이 원본 스트림을 받고, 동시에 FFmpeg가 저화질 m3u8 스트림을 `backup/`에 저장합니다.\
백업 스트림 요청에는 비밀번호를 md5 해시로 바꾼 쿠키를 붙이고, 녹화가 끝나면 `.ts`에서 음성을 복사해 `.m4a`를 만듭니다.

## 실행

FFmpeg가 필요합니다.\
스크립트와 `livedl` 바이너리에 실행 권한을 주고, 로그와 백업을 저장할 폴더를 미리 만들어 둡니다.

```bash
sudo apt-get install ffmpeg
chmod +x *.sh livedl
mkdir -p log backup
```

녹화 예약은 `rr.sh`로 등록합니다.\
예약한 녹화는 백그라운드에서 실행되고 로그는 `log/`에 남습니다.\
비밀번호는 계정에 고정해 둔 경우에만 넣는 것이 좋습니다.\
비밀번호가 바뀌면 예약을 종료한 뒤 새 비밀번호로 다시 등록해야 합니다.

```bash
./rr.sh <계정명> [비밀번호]

# 예시
./rr.sh example_user
./rr.sh example_user 1234
```

예약을 지우려면 프로세스 번호를 확인한 뒤 종료합니다.

```bash
./proc_list.sh
kill -9 <프로세스 번호>
```

로그를 정리할 때는 `rm log/*.ts.log`로 녹화 로그만 지웁니다.\
`.ts`가 붙지 않은 `<계정명>.log`를 지우면 자동 녹화가 제대로 동작하지 않을 수 있습니다.

터미널에서 직접 돌리려면 `record_twitcast.sh`를 씁니다.\
세 번째 인자에 `once`를 주면 한 번 녹화한 뒤 끝나고, 네 번째 인자로 확인 간격을 초 단위로 바꿀 수 있습니다.

```bash
./record_twitcast.sh <계정명> [비밀번호] [loop|once] [간격]
```
