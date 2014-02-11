THEME ?= flask

README.html: README.asciidoc
	@asciidoc -b html5 -a toc1 -a theme=$(THEME) $<
