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
            let scan = obj.record[2].value[0].value[2].value[0]['value'];
            scan = obj.record[1].value[0].value[1].value[1]['value'];
            len = obj.record[1].value[0].value.length;
            for (i=1;i<len;i++) {
                console.log("scan: " + JSON.stringify(obj.record[1].value[0].value[i].value[1].value, null, 4));
            }
            //console.log("1: "+ JSON.stringify(obj.record[2], null, 4));
//            console.log("2: "+ JSON.stringify(obj.record[2].value, null, 4));
 //           console.log("2a: "+ JSON.stringify(obj.record[2].value[0], null, 4));
  //          console.log("3: "+ JSON.stringify(obj.record[2].value[0].value[2], null, 4));
   //         console.log("4: "+ JSON.stringify(obj.record[2].value[0].value[2].value[0], null, 4));
   //         console.log("scan: " + scan);
        </script>
    </head>
    <body>
        <div id="wrapper">
            <div id="header">{$title}</div>
            <div id="user">{$user}</div>
            <div id="homeBtn"></div>
            <div id="content">
                {block name="content"}
                <table>
                <tr>
                <td><div><img id="scan" width="400px" src="{$home_path}data/records/inprogress"/></div></td>
                <td><div id="ccform"></div></td>
                </tr>
                </table>{/block}
            </div>
        </div>
        <script>
            // 'manipulating objects in a generated html page only works if you put the jscript below the html.
            // console.log("document: " + document);
            let src = document.getElementById('scan').src;
            // console.log("old src:" + src);
            document.getElementById("scan").src = src + scan;
            // console.log("new src:" + document.getElementById("scan").src);
            const viewer = new Viewer(document.getElementById('scan'), {
                inline: true,
                toolbar: false,
                backdrop: false,
                minHeight: 300,
                viewed() {
                    viewer.zoomTo(1);
                },
            });
        </script>
    </body>
</html>
