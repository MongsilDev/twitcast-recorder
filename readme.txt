※ linunx/ubuntu 전용

아래 프로젝트를 기반으로 하고 있으나 livedl 바이너리에 약간의 수정 있음 (비밀번호 걸린 캐스 녹화 가능하도록 대응)
https://github.com/printempw/live-stream-recorder

사전에 ffmpeg 설치 필요함 (sudo apt-get install ffmpeg)

sh 스크립트 및 livedl 바이너리에 execute 권한 줄 것

[사용법]

1. 녹화 에약 등록의 경우 아래와 같이 실행
./rr.sh <계정명> <비밀번호(optional)>
예1) ./rr.sh hariryu2434
예2) ./rr.sh rohalee2434 1212

※ 비밀번호 항목의 경우 계정 내에 고정되어 있는 경우에 사용 권장 (계속 바뀌는 경우 프로세스 kill 이후 비밀번호 변경하여 실행 필요)
※ 비밀번호를 입력하더라도 비밀번호가 없는 방송의 경우 정상 녹화됨 (비밀번호 항목 무시)

2. 녹화 파일의 경우 ts (영상+음성) 형식 및 m4a (음성) 형식으로 저장됨, backup에 저장되는 ts 파일의 경우 저화질+저음질 영상임

3. 녹화 예약 제거 시 ./proc_list.sh 실행하여 process 번호 확인한 이후 kill -9 <process 번호> 통해 제거

4. 로그의 경우 log 폴더에 남음, 정리하는 경우 rm log/*.ts.log로 날릴 것 (ts 안붙은 계정명 로그의 경우 삭제 시 자동녹화에 이상 생길 수 있음)