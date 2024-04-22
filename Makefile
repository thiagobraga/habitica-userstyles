PWD := $(shell pwd)
PATH := ${PWD}/node_modules/.bin:$(PATH)
.SILENT: clean install build release watch
all: install build watch

clean:
	/bin/rm -rf node_modules yarn*

install:
	yarn

build:
	stylus src -o theme.css && \
		css2userstyle --no-userscript theme.css && \
		/bin/rm -f theme.css

release:
	stylus src -o theme.css && \
		postcss theme.css --use autoprefixer --replace --no-map && \
		css2userstyle --no-userscript theme.css && \
		/bin/rm -f theme.css

watch:
	chokidar src -c 'make -s build'
