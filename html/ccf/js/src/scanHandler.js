

var pageCount;

function pageCount() {
    pageCount = $("input[data-class='pageCount']").val();
    console.log("pageCount= " + pageCount);
}

function checkPrev(page) {
    console.log("checkPrev");
    return 1;
}

function setVolgorde(page, number) {
    page.find('div[data-name="volgorde"]')[0].children[1].children[0].value = number;
}

function volgorde(page) {
    return page.find('div[data-name="volgorde"]')[0].children[1].children[0].value;
}

function kloeke(page) {
    let kloekeCode = page.find('div[data-name="kloekeCode"]')[0].children[1].children[0]["value"];
    return kloekeCode;
}

function checkPrevious(currentPage) {
    kloekeCode = kloeke(currentPage);
    if (kloekeCode != '') {
        console.log('set volgorde = 1');
        setVolgorde(currentPage, 1);
        return;
    }
    console.log("setVolgorde");
    let pages = $("div[data-class='page']");
    let c = 0;
    for (page in pages) {
        if (page == currentPage) {
            break;
        }
        c += 1;
    }
    console.log('c: ' + c);

/*    //pages[c] is de huidige pagina
    let f = c;
    while kloeke(pages[f]).val()=='' {
        f -= ;
    }
    //pages[f] is de eerste pagina van een respons
    let v = c;
    while type(pages[v]).val()!='verwacht' {
        v -= 1;
    }
    //pages[v ]is de laatste pagina 'zoals verwacht'
    setVolgorde(pages[c]), volgorde(pages[v])).val() + 1);
*/
    


    console.log('kloeke code: ' + kloeke(currentPage));
/*    console.log(kloeke.parentNode);
    console.log(kloeke.prevObject);
    console.log(kloeke.prevObject[0]);
    console.log(kloeke.prevObject[0]['previousSibling']);
    */
//    let prevkloekeCode = kloeke.prevObject[0]['previousSibling'].children[1].children[0]["value"];
//    console.log('prev kc: ' + prevkloekeCode)
    //console.log(kloeke.find('div[data-class="page"]').div);
    //console.log(kloeke.find('div[data-class="page"]').div.previousSibling);
    //console.log(kloeke.find('div[data-class="page"]').prevObject);
    //console.log(kloeke.find('div[data-class="page"]').prevObject.prevObject);
    //console.log(kloeke.find('previousSibling'));
//    console.log(kloeke.prevObject[0].children[1].children[1].children[0].val());
//    let kloekeCode = kloeke[0].children[1].children[0]["value"];
//    console.log("kloekecode: " + kloekeCode);
/*    if(kloekeCode!='') {
        console.log('kloekecode not empty')
        volgordeveld[0].children[1].children[0].value = 1;
    } else {
        console.log("page: " + volgordeveld[0]);
        checkPrev(volgordeveld);
        // check previous page
        volgordeveld[0].children[1].children[0].value = checkPrev() + 1;
    }
    volgorde = volgordeveld[0].children[1].children[0]["value"];
    console.log("volgorde: " + volgorde);
*/
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
            console.log("volgorde: " + $(this).find('div[name="volgorde"]').val())
            console.log('kloekecode: ');
            console.log(kloeke($(this)));
            checkPrevious($(this));

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
