LANGUAGE := yo
DATADIR := data/$(LANGUAGE)/

XMLNAME := $(LANGUAGE)wiki-latest-pages-articles.xml.bz2
WIKIURL := https://dumps.wikimedia.org/$(LANGUAGE)wiki/latest/$(XMLNAME)
CORPUSNAME := wiki.$(LANGUAGE).text
MODELPATH := $(DATADIR)model_$(LANGUAGE).word2vec

$(MODELPATH): $(DATADIR)$(CORPUSNAME)
	python create_word2vec.py $(DATADIR)$(CORPUSNAME) $(MODELPATH)

$(DATADIR)$(CORPUSNAME): $(DATADIR)$(XMLNAME)
	python process_wiki.py $(DATADIR)$(XMLNAME) $(DATADIR)$(CORPUSNAME)

$(DATADIR)$(XMLNAME):
	mkdir -p $(DATADIR)
	wget -P $(DATADIR) $(WIKIURL)
