for agent in "ocrd-typegroups" "ocrd-kraken" "ocrd-tesserocr" "ocrd-calamari" "ocrd-dinglehopper"; do
  xmlstarlet ed --inplace -N mets=http://www.loc.gov/METS/ -d "//mets:agent[starts-with(mets:name,'$agent')]" **/mets.xml
done
