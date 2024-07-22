# Get the cues spreadsheet into shape
Download the spreadsheet as CSV as `./tweaks/cues.csv`
```
./xsl.sh -it:main -xsl:file:$PWD/csv2xml.xsl "csv=file:$PWD/../tweaks/cues.csv" > ../tweaks/cues.xml
```

# New tweak
Download the CMDI 1.2 XML version to `./profiles/Adoptie.xml`
```
cd profiles/
./xsl.sh -xsl:file:$PWD/toTweak.xsl -s:file:$PWD/Adoptie.xml +cues=file:$PWD/../tweaks/cues.xml> ../tweaks/AdoptieTweak-new.xml
```


# Sync with the tweak
```
cd ../tweaks
mv DataEnvelopeTweak.xml DataEnvelopeTweak.xml.BAK
../profiles/xsl.sh -xsl:../../tweaker/mergeTweak.xsl -s:DataEnvelopeTweak-new.xml +tweak=DataEnvelopeTweak.xml.BAK > DataEnvelopeTweak.xml
```


