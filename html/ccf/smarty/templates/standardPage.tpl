<!DOCTYPE HTML>
<html lang="en">
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <title>{$title}</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
        <link rel="stylesheet" href="{$home_path}js/lib/jquery-ui/jquery-ui.css"/>
        <script type="text/javascript" src="{$home_path}js/lib/jquery-3.2.1.min.js"></script>
        <script type="text/javascript" src="{$home_path}js/lib/jquery-3.2.1.min.js"></script>
        <script type="text/javascript" src="{$home_path}js/lib/jquery-ui/jquery-ui.js"></script>
        <script type="text/javascript" src="{$home_path}js/src/ccforms.js"></script>
                {* <script type="text/javascript" src="{$home_path}js/src/sorttable.js"></script> *}


        <script>
            $('document').ready(function(){literal}{{/literal}
            setEvents();{literal}}{/literal});
        </script>
    </head>
    <body>
        <div id="wrapper">
        <div id="header">
            {$title}
        </div>
        <div id="user">{$user}</div>
        <div id="homeBtn"></div>
        <div id="content">
            {block name="content"}Content{/block}
        </div>
        </div>
    </body>
</html>
