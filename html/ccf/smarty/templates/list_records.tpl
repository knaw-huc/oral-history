{extends file="standardPage.tpl"}
{block name="content"}


    <h2>list of records </h2>
                <table id="resultTable" class="sortable">
                    <thead><tr>
                    {foreach from=$headings item=heading}
                        <th>{$heading}</th>
                    {/foreach}
                        <th>Creation date</th>
                        <th><a href="{$home_path}index.php?page=new_rec&profile={$profile_id}" id="addRec"><img src="{$home_path}img/add.ico" height="16px" width="16px"></a></th>
                        <th></th>
                        <th></th>
                        <th></th>

                    </tr></thead><tbody>
                    {foreach from=$records item=record}
                        <tr>
                        {foreach from=$headings item=heading}
                            <td>{$record[$heading]}</td>
                        {/foreach}
                            <td>{$record.creation_date}</td>
                            <td><a href="{$home_path}index.php?page=metadata&id={$record.id}" title="Edit metadata"><img src="{$home_path}img/edit.png" height="16px" width="16px"></a></td>
                            <td><a href="{$home_path}index.php?page=profile&id={$record.id}&action=download_record" title="Download"><img src="{$home_path}img/download.png" height="16px" width="16px"></a></td>
                            <td><a href="{$home_path}index.php?page=profile&id={$record.id}&action=delete_record" title="Delete" class="myBtn delete" id="myBtn{$record.id}" onclick="deleteRecord({$record.id}, {$profile_id});"><img src="{$home_path}img/bin.png" height="16px" width="16px"></a></td>
                            <td><a href="{$home_path}index.php?page=profile&id={$record.id}&action=show_record" title="Show CMDI">CMDI</a></td>
        
                        </tr>
                    {/foreach}
                    </tbody></table>
                    <div id="paging-resultTable"></div>
<script>
    var datatable = new DataTable(document.querySelector('#resultTable'), {
    pageSize: 25,
    sort: [true, true, true, true],
    filters: [true, true, 'select', 'select'],
    filterText: 'Type to filter... ',
    pagingDivSelector: "#paging-resultTable"
    });
</script>          

    <div id="dialog-confirm" title="Record Deletion Confirmation" style="display: none;">
        <p><span class="ui-icon ui-icon-alert" style="float:left; margin:12px 12px 20px 0;"></span>This record will be permanently deleted and cannot be recovered. Are you sure?</p>
    </div>


<script>
    {literal}
    $(document).ready(function ()
    {
        $('.delete').click(function () {
            var answer = confirm('Dit record wordt verwijderd! This record will be removed! OK?');
            return answer; // answer is a boolean
        });


    });
    {/literal}
</script>


                <script type="text/javascript" src="{$home_path}js/src/sorttable.js"></script>


{/block}