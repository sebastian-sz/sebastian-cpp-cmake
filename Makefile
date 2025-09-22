# Default preset
PRESET ?= debug

build: configure
	cmake --build --preset=$(PRESET)

configure:
	cmake --preset=$(PRESET)

test: build
	ctest --preset=$(PRESET)

clean:
	rm -rf build/$(PRESET)

clean-all:
	rm -rf build
