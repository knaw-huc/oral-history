<?php
// $endpoint = "https://vocabularies.clarin.eu/clavas/public/api/autocomplete/";
include_once("includes/utility.php");

$endpoint = "http://vocabs.acdh.oeaw.ac.at/";

// $endpoint = "https://skosmos.sd.di.huc.knaw.nl/" ;
// https://skosmos.sd.di.huc.knaw.nl/rest/v1/duplo/search?query=c*&unique=yes
// https://skosmos.sd.di.huc.knaw.nl/rest/v1/iso639-3/search?query=dut*&unique=yes


// DEPENDENT UPON $endpoint

$type = 'skos'; // from?
$vocabulary = 'duplo'; // from?

if($type === 'skos') { // switch
    $specifics = "rest/v1/$vocabulary/search?unique=yes&query=";
} else {
    // stub
}

$endpoint = $endpoint . $specifics;
$restQuery = $endpoint . $_GET["q"] . "*";

// PHP CURL
$ch = curl_init($restQuery);
curl_setopt($ch, CURLOPT_HEADER, 0);
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-type: application/text'));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$json = curl_exec($ch);
curl_close($ch);

$json = json_decode($json); // make it a php structure
// print_array($json);

if (!$json) {
    $json = "";
}
$results = $json->results;

// print_array($results);

// morph into something autocomplete can understand
$suggestions = [];
foreach($results as $obj){
    $suggestions[] = $obj->prefLabel; // SKOS thingie
}
// print_array($sug);
// die;

$retArray = array("query" => "Unit", "suggestions" => $suggestions);

header('Content-Type: application/json; charset=utf-8');
// it's missing in the original one, why?
// make it json again
echo json_encode($retArray);


