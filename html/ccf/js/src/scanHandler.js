

function scanHandler() {


    console.log($("input[data-class='page']"));
    $("input[data-class='page']").each(function () {
        $(this).on("click", function () {
            showScan($(this).val());
        });
    })
}


function showScan(scan) {
    console.log("clcked: " + scan);
    viewer.view(scan - 1);
};

function createScanListElement(path) {
    let li = document.createElement("li");
    let img = document.createElement("img");
    img.setAttribute("src", path);
    li.append(img);
    return li;
}