
DOWNLOAD = curl -s -L -o

build: vue.js hls.js plyr.css plyr.js plyr.svg

vue.js:
	$(DOWNLOAD) vue.js   https://cdn.jsdelivr.net/npm/vue@3.5.35/dist/vue.global.prod.js
hls.js:
	$(DOWNLOAD) hls.js   https://cdn.jsdelivr.net/npm/hls.js@1.6.16/dist/hls.min.js
	gsed -i -e '/sourceMappingURL=/d' hls.js
plyr.css:
	$(DOWNLOAD) plyr.css https://cdn.jsdelivr.net/npm/plyr@3.8.4/dist/plyr.css
plyr.js:
	$(DOWNLOAD) plyr.js  https://cdn.jsdelivr.net/npm/plyr@3.8.4/dist/plyr.polyfilled.min.js
	gsed -i -e '/sourceMappingURL=/d' plyr.js
plyr.svg:
	$(DOWNLOAD) plyr.svg https://cdn.jsdelivr.net/npm/plyr@3.8.4/dist/plyr.svg

clean:
	-rm -f vue.js
	-rm -f hls.js
	-rm -f plyr.css
	-rm -f plyr.js
	-rm -f plyr.svg

