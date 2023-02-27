
var page_count

// works:
function pageCount() {
    page_count = $("input[data-class='pageCount']").val();
    console.log("pageCount= " + page_count);
}

// works
function number(page) {
    try {
        return page.find('div[data-name="nr"]').children(1).children(0).val();
    } catch(error) {
        return page["children"]["1"]["children"]["1"]["children"]["0"]["value"];
    }
}

// works:
function setInzending(page, inzending) {
    try {
        page.find('div[data-name="inzending"]')[0].children[1].children[0].value = inzending;
    } catch(error) {
        page["children"]["3"]["children"]["1"]["children"]["0"]["value"] = inzending;
    }
}

// works:
function getInzending(page) {
    console.log('get inzending');
    try {
        return page.find('div[data-name="inzending"]')[0].children[1].children[0].value;
    } catch(error) {
        return page["children"]["3"]["children"]["1"]["children"]["0"]["value"];
    }
}

// works:
function setVolgorde(page, volgorde) {
    try {
        page.find('div[data-name="volgorde"]')[0].children[1].children[0].value = volgorde;
    } catch(error) {
//        console.log('setVolgorde: ' + error);
        page["children"]["4"]["children"]["1"]["children"]["0"]["value"] = volgorde;
    }
}

// works:
function volgorde(page) {
    console.log('volgorde');
    try {
        return page.find('div[data-name="volgorde"]')[0].children[1].children[0].value;
    } catch(error) {
//        console.log(page);
//        console.log(page["children"]["4"]);
//        console.log(page["children"]["4"]["children"]["1"]);
//        console.log(page["children"]["4"]["children"]["1"]["children"]["0"]);
        return page["children"]["4"]["children"]["1"]["children"]["0"]["value"];
    }
}

// works:
function kloeke(page) {
    try {
        return page.find('div[data-name="kloekeCode"]')[0].children[1].children[0]["value"];
    } catch(error) {
        return page["children"]["1"]["children"]["1"]["children"]["0"]["value"];
    }
 }

// works
function pageType(page) {
    try {
        return page.find('div[data-name="pageType"]')[0].children[1].children[0]["value"];
    } catch(error) {
        try {
            return page["children"]["5"]["children"]["1"]["children"]["0"]["value"];
        } catch(error) {
            try {
                return page["0"]["children"]["5"]["children"]["1"]["children"]["0"]["value"];
            } catch(error) {
                console.log(error);
            }
        }
    }
}

function getCurrentPage(pages,numberCP) {
    let c = 0;
    let pageFound = false;
    for (const page in pages) {
        if (number(pages[page]) == numberCP) {
            pageFound = true;
            break;
        }
        c += 1;
    }
    console.log('pagefound: ' + pageFound);
    if (pageFound) {
        return c;
    } else {
        return -1;
    }
}

function checkPrevious(currentPage) {
    let pages = $("div[data-class='page']");
    numberCP = number(currentPage);
    let c = getCurrentPage(pages, numberCP);
    let prevInzending = parseInt(getInzending(pages[c - 1]));
    kloekeCode = kloeke(currentPage);
    if (kloekeCode != '') {
        console.log('set volgorde = 1');
        setVolgorde(currentPage, 1);
        setInzending(pages[c],prevInzending + 1);
        return;
    }

    // kloekecode empty
    console.log('c: ' + c);
    setInzending(pages[c],prevInzending);

    //pages[c] is de huidige pagina
    let f = c;
    let kloekeFound = false;
    while (kloeke(pages[f])=='') {
        f -= 1;
        // check op null ??
        if (f<0) {
            break;
        }
    }
    //pages[f] is de eerste pagina van een respons
    if (f>-1) {
        kloekeFound = true;
    }
    console.log('kloekefound: ' + kloekeFound);
    console.log('f: ' + f);

    let v = c - 1;
    let verwachtFound = false;
    while (pageType(pages[v])!='als verwacht' && pageType(pages[v])!='losse aanvulling') {
        v -= 1;
        if (v<0) {
            break;
        }
    }
    // pages[v] is de laatste pagina 'als verwacht'
    console.log('v: ' + v);
    if (v>-1) {
        verwachtFound = true;
    }
    console.log('verwacht found: ' + verwachtFound);
    if (verwachtFound) {
        console.log('volgorde pages[v]: ' + volgorde(pages[v]));
    }
    prevVolgorde = parseInt(volgorde(pages[v]));
    if (prevVolgorde < page_count) {
        setVolgorde(pages[c], prevVolgorde + 1);
        console.log('volgorde is set.');
    } else {
        console.log('pageType: ' + pageType(currentPage));
        if (pageType(currentPage) == 'losse aanvulling') {
            setVolgorde(pages[c], prevVolgorde + 1);
            console.log('volgorde is set. (extra page)');
        } else {
            console.log('volgorde would exceed pageCount');
        }
    }
}

function scanHandler() {

    // TODO: luister naar data-class=pageCount, zet globale variabele pageCount
    $("input[data-class='pageCount']").on("click", function() {
            pageCount(); })
   
//    console.log($("div[data-class='page']"));
    $("div[data-class='page']").each(function () {
        $(this).on("click", function () {
            pageCount();
            showScan($(this).children(1).children(1).children(0).val());
//            $(this).children().find('volgorde')['']
//            console.log($(this).find('div[name="volgorde"]'))
            console.log("volgorde: " + volgorde($(this)));
            console.log('kloekecode: ' + kloeke($(this)));
            console.log('number: ' + number($(this)));
            console.log('pageType: ' + pageType($(this)));
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
    console.log("pageCount: " + page_count);
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
