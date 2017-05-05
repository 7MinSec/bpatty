#A quick and easy Linux script to get your stuff backed up!
#
#
#!/bin/bash
cd /backups
SRCDIR="/source-folder-to-back-up/"
DESTDIR="/where-to-put-the-backup/"
FILENAME=name-of-backup-$(date +%-Y%-m%-d).tgz
tar --create --gzip --file=$DESTDIR$FILENAME $SRCDIR
#To encrypt this you could do "zip -er FILENAME.ZIP THINGS-TO-ZIP"