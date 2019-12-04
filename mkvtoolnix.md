### install
	sudo apt install mkvtoolinx

### view mkv info
	mkvinfo xxx.mkv

### extract subtitle
	mkvextract xxx.mkv tracks <track index>:xxx.srt

### remove subtitle

assume input.mkv has 3 subtitle tracks, remove subtitle track 2 (copy 1&3) from input.mkv & save to output.mkv
	mkvmerge -o output.mkv --subtitle-tracks 1,3 input.mkv

remove all subtitles (copy none)
	mkvmerge -o output.mkv --no-subtitles input.mkv


### remove attachments
	mkvmerge -o output.mkv --no-attachments input.mkv


