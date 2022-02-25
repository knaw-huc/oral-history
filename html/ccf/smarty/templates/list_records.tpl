{extends file="standardPage.tpl"}
{block name="content"}
    <h2>{$title}: list of records </h2>
                <table id="resultTable">
                    <tr>
                    {foreach from=$headings item=heading}
                        <th>{$heading}</th>
                    {/foreach}
                        <th>Creation date</th>
                        <th><a href="{$home_path}index.php?page=new_rec&profile={$profile_id}" id="addRec"><img src="{$home_path}img/add.ico" height="16px" width="16px"></a></th>
                        <th></th>
                        <th></th>
                    </tr>
                    {foreach from=$records item=record}
                        <tr class="{cycle values="odd,even"}">
                        {foreach from=$headings item=heading}
                            <td>{$record[$heading]}</td>
                        {/foreach}
                            <td>{$record.creation_date}</td>
                            <td><a href="{$home_path}index.php?page=metadata&id={$record.id}" title="Edit metadata"><img src="{$home_path}img/edit.png" height="16px" width="16px"></a></td>
                            <td><a href="{$home_path}index.php?page=profile&id={$record.id}&action=download_record" title="Download"><img src="{$home_path}img/download.png" height="16px" width="16px"></a></td>
                            <td><a href="#" title="Delete" class="myBtn" id="myBtn{$record.id}" onclick="deleteRecord({$record.id}, {$profile_id});"><img src="{$home_path}img/bin.png" height="16px" width="16px"></a></td>
                        </tr>
                    {/foreach}
                </table>
           

    <div id="dialog-confirm" title="Record Deletion Confirmation" style="display: none;">
        <p><span class="ui-icon ui-icon-alert" style="float:left; margin:12px 12px 20px 0;"></span>This record will be permanently deleted and cannot be recovered. Are you sure?</p>
    </div>


{literal}
    <!-- JQuery -->
    <script type="text/javascript">
        function deleteRecord(recordId, profileId) {
            let myBtn = document.getElementById(recordId);

            $( "#dialog-confirm" ).dialog({
                resizable: false,
                height: "auto",
                width: 400,
                modal: true,
                buttons: {
                    "DELETE": function() {
                        console.log("Deleting record: [" + recordId + "]\n");
                        $.ajax({
                            url: 'index.php?page=profile&id=' + recordId + '&action=delete_record&profile_id=' + profileId,
                            success: function() {
                                console.log("done");
                                location.reload();
                            },
                            error: function() {
                                console.log("failed");
                            }
                        });
                        $( this ).dialog( "close" );

                    },
                    Cancel: function() {
                        $( this ).dialog( "close" );
                    }
                }
            });
        }

    </script>

{/literal}

{/block}