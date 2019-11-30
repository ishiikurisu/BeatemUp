default: run

run:
	love game --terminal

build:
	cd game; zip -9 -r BeatemUp.love .
	mv game/BeatemUp.love .

clean:
	rm BeatemUp.love
