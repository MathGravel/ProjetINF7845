all:
	nitc -o midiparser ./Midi/midifile.nit
	nitc -o clustering ./HC/clusteralgorithm.nit
	nitc -o prefixspan ./Prefix/prefixspan.nit


Midi:
	nitc -o midiparser ./Midi/midifile.nit

Prefix:
	nitc -o prefixspan ./Prefix/prefixspan.nit

HC:
	nitc -o clustering ./HC/clusteralgorithm.nit
