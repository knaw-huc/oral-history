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
        obj = {$json};
        obj2 = JSON.parse(JSON.stringify(obj));

        $('document').ready(function () {literal}{{/literal}
            setEvents();
            formBuilder.start(obj);
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
