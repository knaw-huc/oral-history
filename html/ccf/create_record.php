<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
session_start();
error_reporting(-1);
require(dirname(__FILE__) . '/config/common.inc.php');
require(dirname(__FILE__) . '/config/ccf.config.inc.php');
require(dirname(__FILE__) . '/classes/CcfRecord.class.php');



emptySample();
$json = $_POST["ccData"];
$profileID = $_POST["ccProfileID"];
$struc = json_decode($json, 'JSON_OBJECT_AS_ARRAY'); // de recorddata die binnenkomt via ajax
//error_log("OK");
$cmdi = new DOMDocument();
$cmdi->preserveWhiteSpace = false;
$cmdi->load(dirname(__FILE__) . '/data/record_template.xml'); // hard coded Rob Zeeman
$record = new Ccfrecord();
$cmdi = $record->createComponents($struc, $profileID, $cmdi, CMDI_RECORD_PATH . "md" . $_SESSION["rec_id"] . "/resources/", CMDI_UPLOAD_PATH);
$cmdi->save(dirname(__FILE__) . '/data/records/inprogress/md' . $_SESSION["rec_id"] . '/' . METADATA_PATH . '/' . METADATA_FILENAME);
header('Location: '. BASE_URL);

function emptySample() {
    emptyDirectory(CMDI_RECORD_PATH . "metadata/");
    emptyDirectory(CMDI_RECORD_PATH . "resources/");
}



function emptyDirectory($dir) {
    $files = glob("$dir*"); 
    foreach ($files as $file) { 
        if (is_file($file))
            unlink($file); 
    }
}

