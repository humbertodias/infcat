DOCKER := $(shell command -v docker)

docker-build:
	$(DOCKER) run --rm -it \
		-v $(PWD):/app \
		-w /app \
		pspdev/pspdev \
		bash -c "make all"

all: dep lib-cat infcat show-files

dep:
	apk add --no-cache boost-dev

lib-cat:
	cd libCat/trunk && $(MAKE) && $(MAKE) install
	cd libCat/trunk/test && $(MAKE)

lib-cat-clean:
	cd libCat/trunk && $(MAKE) clean
	cd libCat/trunk/test && $(MAKE) clean

infcat:
	cd InfCat/trunk/source/test/Def && $(MAKE)
	cd InfCat/trunk/source/test/SffViewer && $(MAKE)
	cd InfCat/trunk/source/test/TextReader && $(MAKE)

infcat-clean:
	cd InfCat/trunk/source/test/Def && $(MAKE) clean
	cd InfCat/trunk/source/test/SffViewer && $(MAKE) clean
	cd InfCat/trunk/source/test/TextReader && $(MAKE) clean

clean: lib-cat-clean infcat-clean

show-files:
	@echo Generated files:
	find . -name "*.elf"