<?php
include_once("includes/utility.php");

$ch = curl_init("https://skosmos.sd.di.huc.knaw.nl/rest/v1/" . $_GET["vocabulary"] . "/search?unique=yes&lang=en&query=" . "*" .  $_GET["q"] . "*");
curl_setopt($ch, CURLOPT_HEADER, 0);
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-type: application/text'));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$json = curl_exec($ch);
//echo $json;
$json = json_decode($json, true);
if (!$json) {
    $json = "";
}

$results = $json["results"];
$buffer = array();
foreach ($results as $result) {
    $buffer[] = $result["prefLabel"];
}
// print_array($buffer);
// die;
$retArray = array("query" => "Unit", "suggestions" => $buffer);

// print_array($retArray);
// die;
header('Content-Type: application/json; charset=UTF-8');
header('Access-Control-Allow-Origin: *');
echo json_encode($retArray);
curl_close($ch);