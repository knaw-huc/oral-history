<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <title>{$title}</title>
<link rel="stylesheet" href="css/style.css" type="text/css"/>
<link rel="stylesheet" href="css/levels.css" type="text/css"/>
<link rel="stylesheet" href="https://cmdicdn.sd.di.huc.knaw.nl/css/ccfstyle.css" type="text/css"/>
<link rel="stylesheet" href="https://cmdicdn.sd.di.huc.knaw.nl/css/autocomplete.css" type="text/css"/>
<link rel="stylesheet" href="https://cmdicdn.sd.di.huc.knaw.nl/css/jquery-ui.css" type="text/css" />
<script type="text/javascript" src="https://cmdicdn.sd.di.huc.knaw.nl/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cmdicdn.sd.di.huc.knaw.nl/js/jquery.autocomplete.js"></script>
<script type="text/javascript" src="https://cmdicdn.sd.di.huc.knaw.nl/js/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="https://cmdicdn.sd.di.huc.knaw.nl/js/ccfparser.js"></script>
<script type="text/javascript" src="js/config/ccf_config_en.js"></script>
    <script>
        obj = {$json};
        obj2 = JSON.parse(JSON.stringify(obj));

        $('document').ready(function () {literal}{{/literal}
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
