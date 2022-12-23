<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <title>{$title}</title>
    <link rel="stylesheet" href="css/style.css" type="text/css"/>
    <link rel="stylesheet" href="css/ccfstyle.css" type="text/css"/>
    <link rel="stylesheet" href="css/autocomplete.css" type="text/css"/>
    <link rel="stylesheet" href="css/viewer.css"/>
    <link rel="stylesheet" href="css/vlb_extras.css"/>
    <script type="text/javascript" src="{$home_path}js/lib/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="{$home_path}js/lib/jquery.autocomplete.js"></script>
    {* <script type="text/javascript" src="{$home_path}js/config/ccf_config{if !isset($lang)}_en{else}_nl{$lang}{/if}.js"></script> *}
    <script type="text/javascript"
            src="{$home_path}js/config/ccf_config{if !isset($lang)}_en{else}_{$lang}{/if}.js"></script>
    <script type="text/javascript" src="{$home_path}js/src/ccfparser.js"></script>
    <script type="text/javascript" src="{$home_path}js/src/ccforms.js"></script>
    <script src="{$home_path}js/src/scanHandler.js"></script>
    <script src="{$home_path}js/src/viewer.js"></script>
    <script>
        // import Viewer from 'viewer.js';
        obj = {$json};
        obj2 = JSON.parse(JSON.stringify(obj));

        $('document').ready(function () {literal}{{/literal}
            setEvents();
            formBuilder.start(obj);

            let len = obj2.record[1].value[0].value.length;
            //console.log("len: "+ len);
            let scans = '';
            for (i = 1; i < len - 1; i++) {
                $("#scans").append(createScanListElement("{$home_path}data/records/inprogress/" + obj2.record[1].value[0].value[i].value[1].value));
            }
            viewer = new Viewer(document.getElementById('scans'), {
                inline: true,
                navbar: true,
                toolbar: true,
                backdrop: false,
                minHeight: 700,
                minWidth: 600,
                viewed() {
                    viewer.zoomTo(1);
                },
            });
            scanHandler();
            {literal}}{/literal});
    </script>
</head>
<body>
<div id="wrapper">
    <div id="header">{$title}</div>
    <div id="user">{$user}</div>
    <div id="homeBtn"></div>
    <div id="content">
        {block name="content"}
            <table style="width: 100%">
            <tr>
                <td style="width: 40%;">
                    <!-- <div><img id="scan" src="{$home_path}data/records/inprogress" alt="Scan"/>
                </div> -->
                    <div style="position: fixed;">
                        <ul id="scans" style="display: none;">
                        </ul>
                    </div>
                </td>
                <td style="width: 5%;"><br/></td>
                <td>
                    <div id="ccform"></div>
                </td>
            </tr>
            </table>{/block}
    </div>
</div>
<script>

</script>
</body>
</html>
