# New tweak
```
xsl.sh -xsl:toTweak.xsl -s:DataEnvelope.xml > ../tweaks/DataEnvelopeTweak-new.xml
```

# Sync with the tweak
```
cd ../tweaks
mv DataEnvelopeTweak.xml DataEnvelopeTweak.xml.BAK
../profiles/xsl.sh -xsl:../../tweaker/mergeTweak.xsl -s:DataEnvelopeTweak-new.xml +tweak=DataEnvelopeTweak.xml.BAK > DataEnvelopeTweak.xml
```
