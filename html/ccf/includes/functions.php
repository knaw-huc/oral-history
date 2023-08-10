<?php

include_once("utility.php");
// $user = getUser();
// echo $user;

$smarty = new Mysmarty();
$db = new db();

function show_home()
{

  
    global $db;
    global $smarty;

    $profiles = $db->getProfiles();
    $smarty->assign('profiles', $profiles);
    $smarty->assign('title', APPLICATION_NAME);
    $smarty->view('home');
}

function show_page($params)
{
    global $db;

    switch ($params["page"]) {
        case "profile":
            if (isset($params["action"])) {
                // with action defined, we check the action first
                $recordId = $params["id"];
                $action = $params["action"];
                if ($action == "download_record") {
                    // download record; action download
                    download_record($recordId);
                } elseif ($action == "delete_record") {
                    // delete record; action delete
                    $profile_id = $params["profile_id"];
                    delete_record($recordId);
                    // header("Location: " . BASE_URL . "index.php?page=profile&id=$profile_id&state=records");
                    header("Location: " . BASE_URL . "index.php");

                } elseif ($action == "show_record") {
                    $recordId = $params["id"];
                    showCMDI(($recordId));

                }    
            } else {
                // no action; show profile page
                if (isset($params["id"]) && ($profile = $db->getProfile($params["id"]))) {
                    if (isset($params["state"])) {
                        show_profile($profile[0], $params["state"]);
                    } else {
                        show_profile($profile[0]);
                        
                    }
                }
            }
            break;
        case "metadata":
            if (isset($params["id"]) && ($profile = $db->getProfileByMetaDataID($params["id"]))) {
                // print_array($params);
                // print_array($profile);
                // print_r($profile); // $params["id"] = 1 (in de URL)levert op: 'Interview', 'en', 5
                show_metadata($profile[0]["name"], $profile[0]["language"], $params["id"]);
            } else {
                show_home();
            }
            break;
        case "new_rec":
            if (isset($params["profile"])) {
                add_record($params["profile"]);
            } else {
                show_home();
            }
            break;
        case "add_record":
            add_record();
            break;
        case "list_records":
            list_records();
            break;
        default:
            show_home();
    }
}


function list_records() {
    global $smarty;
    global $db;
    global $user;
    $titleheader = TITLE;
    $profilename = PROFILE;
    $profile = $db->getProfileData($profilename); // new function 
    // print_array($profile);
    $profile_id = $profile[0]['profile_id']; // hmm
    $state= 'records';
    $smarty->configLoad(ROOT . 'config/my.conf', 'Tabs');
    $parser = new Ccfparser();
    // $profile["json"] = $parser->cmdi2json($profile["content"]);
    $mdRecords = $db->getMetadataRecords($profile_id);
    // print_array($mdRecords);

    // $mdRecords = getMetadataRecords($profile_id);


    // die;
    // DONE EXTRACT WITH THE IDS the relevant information from the JSON XML files, date of interview and title
 
    $list = array();
    $listviewparameters = json_decode(file_get_contents(LISTVIEWCONFIG));
    // print_array($listviewparameters);
    $headings = [];
    foreach($listviewparameters as $va) {
        $headings[] = $va->heading;
      
    }
    // print_array($headings);

    foreach($mdRecords as $key => $value) {
        $recID = $value['id'];

        // $json = parse_metadata($profilename, 'en', $recID);
        // $jsonphp = json_decode($json);
        // $content = $jsonphp->record[2]->value[0]->value; // horrible hard not future proof
        // $title = $content[0]->value;
        // $interviewdate = $content[1]->value;

        $recordpath = CMDI_RECORD_PATH . 'md' . $recID . '/metadata/' . METADATA_FILENAME;
        $xml =  file_get_contents($recordpath);

        //TODO put the extra elements in configuration
    
        // $title = matchElement('Titel', $xml);
        // $interviewdate = matchElement('InterviewDatum', $xml);
        // $mdRecords[$key]['title'] = $title;
        // $mdRecords[$key]['interviewdate'] = $interviewdate;   
        

        foreach($listviewparameters as $k =>$v) {
            $heading = $v->heading;
            $schemaValue = $v->schemaValue;
            $match = matchElement($schemaValue, $xml); // XML/PHP experts may adapt the function matchElement with proper XML extraction methods
            $mdRecords[$key][$heading] = $match;
        }
        // die;
    }

    // print_array($mdRecords);


    $smarty->assign('state', $state);
    $smarty->assign('headings', $headings);
    $smarty->assign('user', $user);

    $smarty->assign('records', $mdRecords);
    $smarty->assign('profile', $profile);
    $smarty->assign('profile_id', $profile_id);
    $smarty->assign('profilename', $profilename);

    // profilename    
    $smarty->assign('title', $titleheader);
    $smarty->view('list_records');
}


function matchElement($needle, $haystack) {
    $doc = new DOMDocument();
    $doc->preserveWhiteSpace = false;
    $doc->loadXML($haystack);
    $query = "//cmd:$needle";
    $xpath = new DOMXPath($doc);
    $entries = $xpath->query($query);
    return $entries[0]->nodeValue;
}


function parse_metadata($name, $language, $recID) // new function 'copy' from show_metadata it returns the cmdi converted to json instead of showing
{
    global $smarty;
    // echo 'hoi';
    // echo $name, $language, $recID;
    $_SESSION["rec_id"] = $recID;

    $errors = array();
    $cmdi = PROFILE_PATH . "$name.xml";
    $tweakFile = TWEAK_PATH . $name . "Tweak.xml";
    $tweaker = TWEAKER;
    $parser = new Ccfparser();
    $record = get_record_file($recID);
    $smarty->assign('lang', $language);
    if (!file_exists($cmdi)) {
        $errors[] = "Profile $name not found on disc!";
        show_errors($errors);
    } else {
        if (!file_exists($tweakFile)) {
            $json = $parser->parseTweak($cmdi, null, null, $record);
            $smarty->assign('title', 'CMDI Form');
            $smarty->assign('json', $json);
            $smarty->view('formPage');
        } else {
            if (!file_exists(TWEAKER)) {
                $errors[] = "Tweaker xslt not found on disc!";
                show_errors($errors);
            } else {
                $json = $parser->parseTweak($cmdi, $tweakFile, $tweaker, $record);
                if ($json) {
                    // $smarty->assign('title', 'CMDI Form');
                    // $smarty->assign('json', $json);
                    // $smarty->view('formPage');
                    return $json;
                } else {
                    $errors[] = "Error detected in xslt tranformation!";
                    show_errors($errors);
                }
            }
        }
    }
}


function add_record($profile)
// $profile is here profileid
{
    global $db;
    global $smarty;

    //$profile = $_POST["profile_id"];
    $title = 'Another CMDI record';
    $md_id = $db->addRecord($title, $profile);

    // count the records + 1




    $mapName = CMDI_RECORD_PATH . "md$md_id";
    error_log($mapName);
    create_map($mapName);
    create_map("$mapName/resources");
    create_map("$mapName/metadata");
    header("Location: " . BASE_URL . "index.php?page=metadata&id=$md_id");
}

function show_profile($profile, $state = 'profile')
{
    global $smarty;
    global $db;
    $title = getenv('TITLE');

    // print_array($profile); // hier is $profile het gehele profiel 
    // die;
    $smarty->configLoad(ROOT . 'config/my.conf', 'Tabs');
    $profileTab = $smarty->getConfigVars('profileTab');
    $tweakTab = $smarty->getConfigVars('tweakTab');
    $recordsTab = $smarty->getConfigVars('recordsTab');

    $parser = new Ccfparser();
    $profile["json"] = $parser->cmdi2json($profile["content"]); // important! Creation of the json representation of cmdi
    //$profile["parsed"] = $parser->parseTweak($profile["tweak"]);
    $mdRecords = $db->getMetadataRecords($profile["profile_id"]);
   

    $smarty->assign('profileTab', $profileTab);
    $smarty->assign('tweakTab', $tweakTab);
    $smarty->assign('recordsTab', $recordsTab);
    $smarty->assign('state', $state);
    $smarty->assign('records', $mdRecords);
    $smarty->assign('profile', $profile);
    $smarty->assign('title', $title);
    $smarty->view('profile');
}



function show_metadata($name, $language, $recID)
{
    global $smarty;
    global $user;

    // echo 'hoi';
    // echo $name, $language, $recID;
    $title = getenv('TITLE');
    $_SESSION["rec_id"] = $recID;

    $errors = array();
    $cmdi = PROFILE_PATH . "$name.xml";
    $tweakFile = TWEAK_PATH . $name . "Tweak.xml";
    $tweaker = TWEAKER;
    $parser = new Ccfparser();
    $record = get_record_file($recID);
    $smarty->assign('lang', $language);
    $smarty->assign('user', $user);

    if (!file_exists($cmdi)) {
        $errors[] = "Profile $name not found on disc!";
        show_errors($errors);
    } else {
        if (!file_exists($tweakFile)) {
            $json = $parser->parseTweak($cmdi, null, null, $record);
            $smarty->assign('title', $title);
            $smarty->assign('json', $json);
            $smarty->view('formPage');
        } else {
            if (!file_exists(TWEAKER)) {
                $errors[] = "Tweaker xslt not found on disc!";
                show_errors($errors);
            } else {
                $json = $parser->parseTweak($cmdi, $tweakFile, $tweaker, $record);
                if ($json) {
                    $smarty->assign('title', $title);
                    // echo $json;die;

                    $smarty->assign('json', $json);
                    $smarty->view('formPage');
                } else {
                    $errors[] = "Error detected in xslt tranformation!";
                    show_errors($errors);
                }
            }
        }
    }
}

// http://localhost/ccf/index.php?page=profile&id=33&action=get_record_file



function showCMDI($id) {
    // echo $id;
    // echo 'hoi';
    $fileName = CMDI_RECORD_PATH . "md$id/metadata/record.cmdi";
    // echo $fileName;
    if(file_exists($fileName)){
        // echo 'yep';
    } else {
        // echo 'nope';
    }header('Content-type: text/xml');
    $xml = file_get_contents($fileName);
    // echo count($xml);
    echo $xml;
    die;
}

function get_record_file($id)
{
    $fileName = CMDI_RECORD_PATH . "md$id/metadata/record.cmdi";
    // echo $fileName;


    if (file_exists($fileName)) {
        return $fileName;
    } else {
        return null;
    }
}

function send_file_to_download_stream($fileName)
{
    $quoted = sprintf('"%s"', addcslashes(basename($fileName), '"\\'));
    $size = filesize($fileName);

    header('Content-Description: File Transfer');
    header('Content-Type: application/octet-stream');
    header('Content-Disposition: attachment; filename=' . $quoted);
    header('Content-Transfer-Encoding: binary');
    header('Connection: Keep-Alive');
    header('Expires: 0');
    header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
    header('Pragma: public');
    header('Content-Length: ' . $size);

    ob_clean();
    flush();
    readfile($fileName);
}

function download_record($id)
{
    $recordPath = CMDI_RECORD_PATH . "md$id";
    $downloadName = "md$id";
    $archiveName = "/tmp/${downloadName}.tar";
    $archiveZipName = "/tmp/${downloadName}.tar.gz";

    try {
        unlink($archiveName);
        unlink($archiveZipName);
        $archive = new PharData($archiveName, null, null, Phar::TAR);
        $archive->buildFromDirectory($recordPath);
        $archive->compress(Phar::GZ);
        send_file_to_download_stream($archiveZipName);
        return true;
    } catch (Exception $e) {
        echo "Error: ", $e->getMessage(), "\n";
        return false;
    }

}


function deleteDir($dirPath) {
    if (! is_dir($dirPath)) {
        throw new InvalidArgumentException("$dirPath must be a directory");
    }
    if (substr($dirPath, strlen($dirPath) - 1, 1) != '/') {
        $dirPath .= '/';
    }
    $files = glob($dirPath . '*', GLOB_MARK);
    foreach ($files as $file) {
        if (is_dir($file)) {
            deleteDir($file);
        } else {
            unlink($file);
        }
    }
    rmdir($dirPath);
}

function delete_record($id)
{
    global $db;

    // $folderToRemove = sprintf("%s/%s/%s", CMDI_RECORD_PATH, METADATA_PATH, METADATA_FILENAME);

    $id = (int) $id;
    $folderToRemove = CMDI_RECORD_PATH . 'md' . $id . '/'; 
    // echo $folderToRemove;
    // die;
    try {
        $db->removeRecord($id);
        deleteDir($folderToRemove);
        $start = BASE_URL;    
        header("Location: $start");
        exit;
        return true;
    } catch (Exception $e) {
        echo "Error: ", $e->getMessage(), "\n";
        return false;
    }

}

function show_errors($errors)
{
    $this->smarty->assign('errors', $errors);
    $this->smarty->assign('title', 'Error!');
    $this->smarty->view('errors');
}

function create_map($filename)
{
    if (!file_exists($filename)) {
        mkdir($filename);
    }
}

