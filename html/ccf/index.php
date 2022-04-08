<?php

require(dirname(__FILE__) . '/config/common.inc.php');
require(dirname(__FILE__) . '/config/ccf.config.inc.php');
require(dirname(__FILE__) . '/classes/MySmarty.class.php');
require(dirname(__FILE__) . '/config/db.config.inc.php');
require(dirname(__FILE__) . '/classes/db.class.php');
require(dirname(__FILE__) . '/classes/CcfParser.class.php');
require(dirname(__FILE__) . '/includes/ccfparser.inc.php');
require(dirname(__FILE__) . '/includes/functions.php');
include_once(dirname(__FILE__) . '/includes/utility.php');


session_start();
error_reporting(E_ERROR);

// initialize();

if (!isset($_GET["page"]))
{
    list_records();
    // list_records_nodb();

    die;  
    // show_home(); 
    // show_profile();
}
 else {
    show_page($_GET);
}


