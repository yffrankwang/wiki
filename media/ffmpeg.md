### install
	sudo apt install ffmpeg

### remove title

	ffmpeg -i in.mp4 -metadata title= -c:v copy -c:a copy out.mp4

