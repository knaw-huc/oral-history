let server = 'http://localhost/ccf/'

// let server = window.location.protocol + "//" + window.location.host + "/" + "ccf/";
// console.log('server: ', server);

var language = 'nl';

var ccfOptions = {
        "nl": {
            uploadButton: {
                actionURI: server + 'upload.php'
            },
            submitButton: {
                actionURI: 'create_record.php',
                label: 'OK'
            },
            saveButton: {
                actionURI: 'create_record.php',
                label: 'Bewaar'
            },
            resetButton: {
                actionURI: 'javascript:history.back()',
                label: 'Terug'
            },
            // language: 'nl',
            alert: {
                mandatory_field: 'Dit veld is verplicht!',
                mandatory_field_box: ' : verplicht!',
                no_valid_date: 'Dit is geen geldige datum!',
                no_valid_date_box: ': geen geldige datum',
                date_string: 'jjjj-mm-dd',
                int_field: 'De waarde van dit veld moet numeriek zijn!',
                int_field_box: ': moet numeriek zijn!',
                attr_not_empty_field: 'Attribuut is verplicht'
            }
        },
        "en":
            {
                uploadButton: {
                    actionURI: server + 'upload.php'
                },
                submitButton: {
                    actionURI: 'create_record.php',
                    label: 'Submit'
                },
                saveButton: {
                    actionURI: 'create_record.php',
                    label: 'Save'
                },
                resetButton: {
                    actionURI: 'javascript:history.back()',
                    label: 'Back'
                },
                // language: 'en',
                alert: {
                    mandatory_field: 'This field is mandatory!',
                    mandatory_field_box: ' : mandatory!',
                    no_valid_date: 'This is not a valid date!',
                    no_valid_date_box: ': not a valid date!',
                    date_string: 'yyyy-mm-dd',
                    int_field: 'The value of this field must be an integer!',
                    int_field_box: 'must be an integer!',
                    attr_not_empty_field: 'Attribute(s) mandatory'
                }
            }
    }
;



