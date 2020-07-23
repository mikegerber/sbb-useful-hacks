#!/bin/sh

# Fix XML declaration to avoid other tools introducing character references
# as substitutions for umlauts etc.
if ! grep -Fq '<?xml version="1.0" encoding="utf-8"?>' mets.xml; then
  ( echo '<?xml version="1.0" encoding="utf-8"?>'; cat mets.xml) > mets.xml.fix-xml-declaration
  mv mets.xml.fix-xml-declaration mets.xml
fi

# Fix the MIME type for PAGE files in known file groups
for fg in OCR-D-GT-SEG-PAGE OCR-D-GT-SEG-BLOCK; do
  xmlstarlet edit -P --inplace \
    -N mets="http://www.loc.gov/METS/" \
    --update "//mets:fileGrp[@USE='$fg']/mets:file[@MIMETYPE='image/jpeg']/@MIMETYPE" \
    --value "application/vnd.prima.page+xml" \
    mets.xml
done
