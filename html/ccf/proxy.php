<?php
// $endpoint = "https://vocabularies.clarin.eu/clavas/public/api/autocomplete/";
function print_array($array) {
    echo '<pre>';
    print_r($array);
    echo '</pre>';
}
$endpoint = "https://skosmos.sd.di.huc.knaw.nl/" ;
// $endpoint = "https://skosmos.sd.di.huc.knaw.nl/" ;


// DEPENDANT UPON $endpoint

$type = 'skos'; // from?
$vocabulary = 'duplo'; // from?
if($type === 'skos') { // switch
    $specifics = "rest/v1/$vocabulary/search?unique=yes&query=";
} else {

    // stub
}


// echo $url;
$endpoint = $endpoint . $specifics;

$restQuery = $endpoint . $_GET["q"] . "*";
// echo $restQuery;
// die;

// die;
// $ch = curl_init($url . $_GET["q"]);

$ch = curl_init($restQuery);
// die('lul');

// https://skosmos.sd.di.huc.knaw.nl/rest/v1/iso639-3/search?query=dut*&unique=1
curl_setopt($ch, CURLOPT_HEADER, 0);
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-type: application/text'));

curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$json = curl_exec($ch);
curl_close($ch);
// echo $json;
// die;
$json = json_decode($json);
if (!$json) {
    $json = "";
}

// $php = json_decode($json);
// print_array($json);
$results = $json->results;

// print_array($results);
$suggestions = [];
foreach($results as $obj){
    $suggestions[] = $obj->prefLabel; // SKOS thingie
}
// print_array($sug);
// die;

$retArray = array("query" => "Unit", "suggestions" => $suggestions);

header('Content-Type: application/json; charset=utf-8');
// waarom is bovenstaande json header er niet?

echo json_encode($retArray);


