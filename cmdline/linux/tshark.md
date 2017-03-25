# tshark
[tshark](https://www.wireshark.org/docs/man-pages/tshark.html) is a great utility for dumping and analyzing network traffic.

The [Billy Madison](https://www.vulnhub.com/entry/billy-madison-11,161/) VulnHub challenge will have you analyze a pcap full of email correspondence.  In reading through user [walkthroughs](http://www.mrb3n.com/?p=342) I saw a clever use of tshark to break apart the individual emails easily.  The syntax is:

	for stream in `tshark -r capture.cap -T fields -e tcp.stream | sort -n | uniq`
	do
	    echo $stream
	    tshark -r capture.cap -w stream-$stream.cap -Y "tcp.stream==$stream"
	done