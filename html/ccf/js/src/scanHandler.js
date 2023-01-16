

var pageCount;

function pageCount() {
    pageCount = $("input[data-class='pageCount']").val();
    console.log("pageCount= " + pageCount);
}

function checkPrev() {
    console.log("checkPrev");
    return 1;
}

function setVolgorde(kloeke,volgordeveld) {
    console.log("setVolgorde");
    kloekeCode = kloeke[0].children[1].children[0]["value"];
    console.log("kloekecode: " + kloekeCode);
    if(kloekeCode!='') {
        console.log('kloekecode not empty')
        volgordeveld[0].children[1].children[0].value = 1;
    } else {
        // check previous page
        // volgordeveld[0].children[1].children[0].value = checkPrev() + 1;
    }
    volgorde = volgordeveld[0].children[1].children[0]["value"];
    console.log("volgorde: " + volgorde);
}

function scanHandler() {

    // TODO: luister naar data-class=pageCount, zet globale variabele pageCount

//    console.log($("div[data-class='page']"));
    pageCount();
    $("div[data-class='page']").each(function () {
        $(this).on("click", function () {
            showScan($(this).children(1).children(1).children(0).val());
//            $(this).children().find('volgorde')['']
//            console.log($(this).find('div[name="volgorde"]'))
//            console.log("volgorde: " + $(this).find('div[name="volgorde"]').val())
            setVolgorde($(this).find('div[data-name="kloekeCode"]'), $(this).find('div[data-name="volgorde"]'));
            //TODO:
            // we moeten een lijst maken van de pagina's in deze response:
            // 1. de huidige
            // 2 ... n-1 alle pagina's zonder kloeke code
            // n. de eerste van deze response, i.e. de pagina die een kloeke code heeft als we terug gaan in de pagina lijst
            // EVENT: de huidige pagina wordt actief
            // dan:
            //     0. dit is de volgende pagina in de response
            //     1. de vorige pagina is de pagina met type verwacht
            //     2. vorige.volgorde < pageCount zet dan huidige.volgorde op vorige.volgorde +1
            // EVENT: als KloekeCode wordt ingevuld op de huidige pagina
            // dan: 
            //     0. we beginnen dus aan een nieuwe response
            //     1. de eerste verwijst dan naar de vorige response, en we willen huidige.inzending = eerste.inzending +1
            //     2. dit is de eerste pagina van de response, dus we zetten huidige.volgorde op 1 
            // EVENT: als huidige.type op losse aanvulling wordt gezet
            // dan:
            //     0. dit is nog een extra pagina in de response
            //     1. de vorige pagina is de pagina met type extra
            //     2. huidige.volgorde op vorige.volgorde + 1
        });
    })
}


function showScan(scan) {
    console.log("clicked: " + scan);
    console.log("pageCount: " + pageCount);
    try {
        viewer.view(scan - 1);
    } catch (error) {
        console.log(error);
    }

};

function createScanListElement(path) {
    let li = document.createElement("li");
    let img = document.createElement("img");
    img.setAttribute("src", path);
    li.append(img);
    return li;
}
