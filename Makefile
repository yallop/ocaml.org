
production: script/ocamltohtml script/rss2html
	$(MAKE) ocaml.org
	bash script/gen.bash production site
	$(MAKE) syncotherfiles

local: script/relative_urls
	$(MAKE) staging
	find ocaml.org -type f | while read f; do \
	  script/relative_urls --path ocaml.org "$$f"; done

staging: script/ocamltohtml script/rss2html
	$(MAKE) ocaml.org
	bash script/gen.bash staging site
	$(MAKE) syncotherfiles

syncotherfiles:
	rsync --exclude '*.md' --exclude '*.html' -rltHprogv site/* ocaml.org/


clean:
	$(RM) -r ocaml.org *~ *.cmo *.cmi *.cma *.o
	$(RM) template/front_code_snippet.html
	$(RM) $(addprefix script/, *~ *.cmo *.cmi *.cma *.o)

include Makefile.common

.PHONY: production local syncotherfiles clean
