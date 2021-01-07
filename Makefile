love:
	zip -9r bin/monkune.love ./*

win32: love
ifeq (,$(wildcard bin/love-win32.zip))
	wget -O bin/love-win32.zip \
		https://github.com/love2d/love/releases/download/11.3/love-11.3-win32.zip
endif
	unzip -d bin/ bin/love-win32.zip
	mv bin/love-*-win32 bin/monkune-win32
	rm bin/monkune-win32/changes.txt
	rm bin/monkune-win32/readme.txt
	rm bin/monkune-win32/lovec.exe
	cat bin/monkune.love >> bin/monkune-win32/love.exe
	mv bin/monkune-win32/love.exe bin/monkune-win32/KunKune.exe
	cp lib/bin-license.txt bin/monkune-win32/license.txt
	zip -9jr bin/monkune-win32.zip bin/monkune-win32
	rm -rf bin/monkune-win32

test: love
	love bin/monkune.love

clean: 
	rm -rf ./bin/*

all: love win32
