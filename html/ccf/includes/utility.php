<?php

function print_array($array) {
    echo '<pre>';
    print_r($array);
    echo '</pre>';
}


function initialize() {
    if(! file_exists(CMDI_RECORD_COUNTER_PATH)){
        file_put_contents(CMDI_RECORD_COUNTER_PATH, 1);
    }

}