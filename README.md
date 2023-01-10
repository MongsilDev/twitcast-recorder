[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FBlackOut-git%2Ftwitcast_recorder&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)  
**※ linunx/ubuntu 전용**  
Origin: https://github.com/printempw/live-stream-recorder
## ffmpeg 설치 및 권한 부여
```
apt-get update
apt-get upgrade
apt-get install python3
pip install --upgrade ffmpeg

chmod 755 livedl
chmod 755 *.sh
```
## 사용법
1. 녹화 예약 등록  
`./rr.sh <아이디> <비밀번호(선택)>`  
ex1)`./rr.sh <계정명>`  
ex2)`./rr.sh <계정명> <비밀번호>`  
※ 비밀번호가 변경되는 경우에는 아래의 항목에 따라 kill 이후 변경된 비밀번호로 재등록 필요  
※ 비밀번호를 입력했어도 비밀번호가 설정되지 않은 방송의 경우 정상적으로 녹화(비밀번호 무시)
2. 녹화 파일의 경우 ts (영상+음성) 형식 및 m4a (음성) 형식으로 저장, backup에 저장되는 ts 파일의 경우 저화질+저음질 영상
3. 녹화 예약 제거는 `./proc_list.sh` 로  process 번호 확인, `kill -9 <process 번호>`로 제거
4. 로그는 log 폴더에 남음, 정리하는 경우 `rm log/*.ts.log`이용 (ts 안붙은 계정명 로그의 경우 삭제 시 자동녹화에 이상 생길 수 있음)
