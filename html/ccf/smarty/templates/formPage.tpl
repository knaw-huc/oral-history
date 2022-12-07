<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <title>{$title}</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
        <link rel="stylesheet" href="css/ccfstyle.css" type="text/css" />
        <link rel="stylesheet" href="css/autocomplete.css" type="text/css" />
        <link rel="stylesheet" href="css/viewer.css" />
        <link rel="stylesheet" href="css/vlb_extras.css" />
        <script type="text/javascript" src="{$home_path}js/lib/jquery-3.2.1.min.js"></script>
        <script type="text/javascript" src="{$home_path}js/lib/jquery.autocomplete.js"></script>
        {* <script type="text/javascript" src="{$home_path}js/config/ccf_config{if !isset($lang)}_en{else}_nl{$lang}{/if}.js"></script> *}
        <script type="text/javascript" src="{$home_path}js/config/ccf_config{if !isset($lang)}_en{else}_{$lang}{/if}.js"></script>
        <script type="text/javascript" src="{$home_path}js/src/ccfparser.js"></script>
        <script type="text/javascript" src="{$home_path}js/src/ccforms.js"></script>
        <script src="{$home_path}js/src/viewer.js"></script>
        <script>
            // import Viewer from 'viewer.js';
            obj = {$json};
            $('document').ready(function(){literal}{{/literal}
            setEvents();
            formBuilder.start(obj);
            {literal}}{/literal});
//            let scan = obj.record[2].value[0].value[2].value[0]['value'];
//            scan = obj.record[1].value[0].value[1].value[1]['value'];
            len = obj.record[1].value[0].value.length;
            //console.log("len: "+ len);
            let scans = '';
            for (i=1;i<len-1;i++) {
                scans += '<li><img src="{$home_path}data/records/inprogress/md1/resources' + obj.record[1].value[0].value[i].value[1].value + '"></li>';
                console.log("scan: " + obj.record[1].value[0].value[i].value[1].value);
            }

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
                <td style="width: 25%;">
               <!-- <div><img id="scan" src="{$home_path}data/records/inprogress" alt="Scan"/>
                </div> -->
                <div style="position: fixed;">
                <ul id="scans" style="display: none;">
                </ul>
                </div>
                </td>
                <td style="width: 5%;"><br/></td>
                <td><div id="ccform"></div></td>
                </tr>
                </table>{/block}
            </div>
        </div>
        <script>
            // 'manipulating objects in a generated html page only works if you put the jscript below the html.
            let src = document.getElementById('scans').src;
            //console.log("old src:" + document.getElementById('scans'));
            const scansList = document.querySelector("#scans");
            scansList.innerHTML += scans;
            //console.log("new src:" + document.getElementById("scans"));
            const viewer = new Viewer(document.getElementById('scans'), {
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
            // function koppelen aan pagina's cue:class="page"
            // aanroepen met nr van pagina (en dan 1 aftrekken)
            function showScan(scan) {
                viewer.view(scan);
            };
        </script>
    </body>
</html>
