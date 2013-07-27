/*
 *
 */
var baseUrl = "participants/list";
var tagQueryList = {};

jQuery(document).ready(function(){

    populateTagCloud();
    
    createTabs();
    
    // The grid containing the list of paricipants
    jQuery("#participants").jqGrid({
        url: baseUrl,
        datatype: 'xml',
        mtype: 'POST',
        colNames: ['First Name', 'Last Name', 'Suffix', 'Mailing #', 'Invite Status', 'Invitation<br/>Category', 'Acceptance', 'Survey', 'Publication<br/>First Name', 'Publication<br/>Last Name', 'Pub<br/>Suffix', 'survey id', 'lock'],
        colModel: [{
            name: 'person[first_name]',
            index: 'people.first_name',
            width: 150,
            editable: true,
            editoptions: {
                size: 20
            },
            formoptions: {
                rowpos: 1,
                label: "First Name",
                elmprefix: ""
            },
            editrules: {
                required: false
            }
        }, {
            name: 'person[last_name]',
            index: 'people.last_name',
            width: 150,
            editable: true,
            editoptions: {
                size: 20
            },
            formoptions: {
                rowpos: 2,
                label: "Last Name",
                elmprefix: "(*)"
            },
            editrules: {
                required: true
            }
        }, {
            name: 'person[suffix]',
            index: 'people.suffix',
            width: 50,
            editable: true,
            search: false,
            editoptions: {
                size: 20
            },
            formoptions: {
                rowpos: 3,
                label: "Suffix",
                elmprefix: ""
            },
            editrules: {
                required: false
            }
        }, {
            name: 'person[mailing_number]',
            index: 'mailing_number',
            width: 60,
            editable: true,
            hidden: false,
            editoptions: {
                size: 20,
                defaultValue: 0
            },
            formoptions: {
                rowpos: 4,
                label: "Mailing Number",
                elmprefix: ""
            },
            editrules: {
                required: false,
                edithidden: true
            }
        }, {
            name: 'person[invitestatus_id]',
            index: 'invitestatus_id',
            width: 100,
            editable: true,
            edittype: "select",
            search: true,
            stype: "select",
            searchoptions: {
                dataUrl: '/participants/invitestatuslistwithblank'
            },
            editoptions: {
                dataUrl: '/participants/invitestatuslist',
                defaultValue: 'Not Set'
            },
            formoptions: {
                rowpos: 5,
                elmprefix: "&nbsp;&nbsp;&nbsp;&nbsp;"
            }
        }, {
            name: 'person[invitation_category_id]',
            index: 'invitation_category_id',
            width: 100,
            editable: true,
            edittype: "select",
            search: true,
            stype: "select",
            searchoptions: {
                dataUrl: '/invitation_categories/list'
            },
            editoptions: {
                dataUrl: '/invitation_categories/list',
                defaultValue: 'Not Set'
            },
            formoptions: {
                rowpos: 6,
                elmprefix: "&nbsp;&nbsp;&nbsp;&nbsp;"
            }
        }, {
            name: 'person[acceptance_status_id]',
            index: 'acceptance_status_id',
            width: 100,
            editable: true,
            edittype: "select",
            search: true,
            stype: "select",
            searchoptions: {
                dataUrl: '/participants/acceptancestatuslistwithblank'
            },
            editoptions: {
                dataUrl: '/participants/acceptancestatuslist',
                defaultValue: 'Not Set'
            },
            formoptions: {
                rowpos: 7,
                elmprefix: "&nbsp;&nbsp;&nbsp;&nbsp;"
            }
        }, {
            name: 'person[hasSurvey]',
            width: 50,
            editable: false,
            sortable: false,
            search: false,
            hidden: false
        }, {
            name: 'person[pseudonym_attributes][first_name]',
            width: 150,
            index: 'pseudonyms.first_name',
            editable: true,
            sortable: false,
            editoptions: {
                size: 20
            },
            formoptions: {
                rowpos: 8,
                label: "Pub First Name"
            }
        }, {
            name: 'person[pseudonym_attributes][last_name]',
            width: 150,
            index: 'pseudonyms.last_name',
            editable: true,
            sortable: false,
            editoptions: {
                size: 20
            },
            formoptions: {
                rowpos: 9,
                label: "Pub Last Name"
            }
        }, {
            name: 'person[pseudonym_attributes][suffix]',
            width: 50,
            index: 'pseudonyms.suffix',
            editable: true,
            sortable: false,
            search: false,
            editoptions: {
                size: 20
            },
            formoptions: {
                rowpos: 10,
                label: "Pub Suffix"
            }
        }, {
            name: 'person[survey_respondent_attributes][id]',
            width: 3,
            index: 'survey_respondent.id',
            hidden: true,
            editable: false,
            sortable: false,
            search: false,
            formoptions: {
                rowpos: 11,
                label: "survey_respondent_id"
            }
        }, {
            name: 'person[lock_version]',
            width: 3,
            index: 'lock_version',
            hidden: true,
            editable: true,
            sortable: false,
            search: false,
            formoptions: {
                rowpos: 12,
                label: "lock"
            }
        }],
        pager: jQuery('#pager'),
        rowNum: 10,
        autowidth: false,
        height: "100%",
        rowList: [10, 20, 30],
        pager: jQuery('#pager'),
        sortname: 'people.last_name',
        sortorder: "asc",
        viewrecords: true,
        imgpath: 'stylesheets/cupertino/images',
        caption: 'Participants',
        editurl: '/participants?plain=true',
        onSelectRow: function(ids){
            loadTabs(ids);
            return false;
        }
    });
    
    // Set up the pager menu for add, delete, and search
    jQuery("#participants").navGrid('#pager', {
        view: false,
        search: false
    }, //options
    { // edit options
        height: 400,
        reloadAfterSubmit: true,
        jqModal: true,
        closeOnEscape: true,
        closeAfterEdit: true,
        bottominfo: "Fields marked with (*) are required",
        afterSubmit: processResponse,
        mtype: 'PUT',
        onclickSubmit : function(params, postdata) {
            params.url = '/participants/' + postdata.participants_id;
        },
    }, // edit options
    { // add options
        reloadAfterSubmit: false,
        jqModal: true,
        closeOnEscape: true,
        bottominfo: "Fields marked with (*) are required",
        afterSubmit: processAddResponse,
        closeAfterAdd: true
    }, // add options
    { // del options
        reloadAfterSubmit: false,
        jqModal: true,
        closeOnEscape: true,
        mtype: 'DELETE',
        onclickSubmit : function(params, postdata) {
            params.url = '/participants/' + postdata;
        },
    }, // del options
    {  // view options
        height: 150,
        jqModal: true,
        closeOnEscape: true
    });
    
    jQuery("#participants").jqGrid('filterToolbar', {
        stringResult: true,
        searchOnEnter: false
    });
});

function addToTagList(value){
    $("<div/>").text(value).prependTo("#tags-list");
    $("#tags-list").attr("scrollTop", 0);
    $("#tags").val('');
}

function initDialog(event, ui){

    $(".deletetag").click(function(event){
        // do the action etc
        var a = $(this), href = a.attr('href'), content = $('.message');
        
        content.load(href);// + " #content");
        populateTagCloud();
        var $tabs = $('#particpanttabs').tabs();
        var selected = $tabs.tabs('option', 'selected');
        $tabs.tabs('load', selected);
        
        jQuery("#participants").trigger("reloadGrid");
        
        event.preventDefault();
    });

    $('#edialog', ui.panel).jqm({
        ajax: '@href',
        trigger: 'a.entrydialog',
        onLoad: adjust,
        onHide: function(hash){
            var $tabs = $('#particpanttabs').tabs();
            var selected = $tabs.tabs('option', 'selected');
            $tabs.tabs('load', selected);
            hash.w.fadeOut('2000', function(){
                hash.o.remove();
            });
            jQuery("#participants").trigger("reloadGrid");
            populateTagCloud();
        }
    });
    
    $('.remove-form form', ui.panel).ajaxForm({
        target: '#tab-messages',
        success: function(response, status){
            var $tabs = $('#particpanttabs').tabs();
            var selected = $tabs.tabs('option', 'selected');
            $tabs.tabs('load', selected);
        }
    });
    
    $('.remove-form a', ui.panel).ajaxForm({
        target: '#tab-messages',
        success: function(response, status){
            var $tabs = $('#particpanttabs').tabs();
            var selected = $tabs.tabs('option', 'selected');
            $tabs.tabs('load', selected);
        }
    });
}

var currentDialog = null;
function adjust(dialog){
    currentDialog = dialog;
    $('.layerform', dialog.w).ajaxForm({
        target: '#form-response',
        error: function(response, r){
            var errText = $(response.responseText).find(".error"); // class error
            $('#form-response', currentDialog.w).append('ERROR: ' + errText.text());
        }
    });
}

function processResponse(response, postdata){
    // examine return for problem - look for errorExplanation in the returned HTML
    var text = $(response.responseText).find(".errorExplanation");
    if (text.size() > 0) {
        text.css('font-size', '6pt');
        text = $("<div></div>").append(text);
        return [false, text.html()];
    }
    
    var $tabs = $('#particpanttabs').tabs();
    var selected = $tabs.tabs('option', 'selected');
    $tabs.tabs('load', selected);
    
    return [true, "Success", ""];
}

function processAddResponse(response, postdata){
    // examine return for problem - look for errorExplanation in the returned HTML
    var text = jQuery(response.responseText).find(".errorExplanation");
    if (text.size() > 0) {
        text.css('font-size', '6pt');
        text = jQuery("<div></div>").append(text);
        return [false, text.html()];
    }
    
    // get the id of the new entry and change the id of the 
    var id = jQuery(response.responseText).find("#personid");
    
    return [true, "Success", id.text()]; // Last param is the id of the new item
}

function populateTagCloud(){
    /* Populate the tag cloud */
    $.ajax({ // /tags?class=Person
        url: "/tags?class=Person",
        dataType: "html",
        success: function(response){
            jQuery("#participant-tag-cloud").html(response);
            
            jQuery(".tag-select").click(function(event){
                var ctx = $(this).parents('.tag-group').find('.tag-context-title').text();
                var tag = $(this).text();
                
                if (!tagQueryList[ctx]) {
                    tagQueryList[ctx] = new Array();
                }
                
                // TODO - need to escape &
                if ($.inArray(tag, tagQueryList[ctx]) == -1) { // only push if it does not already exist
                    tagQueryList[ctx].push(tag);
                }
                
                issueTagQuery();
            });
        }
    });
}

function issueTagQuery(){
    var newUrl = baseUrl + "?" + createTagQuery();
    jQuery("#participants").jqGrid('setGridParam', {
        url: newUrl
    }).trigger("reloadGrid");
    
    jQuery("#participant-tag-facets").html(turnTagQueryToHTML());
    applyFilterEventHandler();
}

function createTagQuery(){
    // context='" + ctx + "'&tags='" + tag + "'"
    var posn = 0;
    var query = "";
    for (var key in tagQueryList) {
        query += "context[" + posn + "]=" + key + "&tags[" + posn + "]=";
        for (var i = 0; i < tagQueryList[key].length; i++) {
            query += escape(tagQueryList[key][i]) + ",";
        }
        query += "&";
        posn += 1;
    }
    return query;
}

function turnTagQueryToHTML(){
    var html = "<div class='tags'>";
    for (var key in tagQueryList) {
        html += "<div class='tag-group'>";
        html += "<div class='tag-context-title'>" + key + "</div>";
        html += "<div class='tag-area'>"
        html += "<div class='tag'>"
        for (var i = 0; i < tagQueryList[key].length; i++) {
            html += '<div class="tag-name">';
            html += tagQueryList[key][i];
            html += '</div>';
            html += '<a href="#context=' + key + '&tag=' + tagQueryList[key][i] + '" class="delete-filter-tag">';
            html += '<div class="ui-icon ui-icon-close" style="float: left;"/>';
            html += '</a>';
        }
        html += "</div>";
        html += "</div>";
        html += "</div>";
        html += "</div>";
    }
    html += "</div>";
    
    return html;
}

function applyFilterEventHandler(){
    jQuery(".delete-filter-tag").click(function(event){
        var q = $(this).attr('href');
        var strs = q.split('&');
        var ctx = strs[0].substr(9, strs[0].length);
        var tag = strs[1].substr(4, strs[1].length);
        // extract the context and tag and then remove these from the tag query collection
        // then force the elements to refresh
        var posn = $.inArray(tag, tagQueryList[ctx]);
        tagQueryList[ctx].splice(posn, 1);
        if (tagQueryList[ctx].length == 0) {
            delete tagQueryList[ctx];
        }
        issueTagQuery();
    });
}


function loadTabs(id){
    var data = jQuery("#participants").jqGrid('getRowData', id);
    var survey_id = data['person[survey_respondent_attributes][id]'];
    if (survey_id.trim().length <= 0) {
        survey_id = 0;
    }
    var allTabs = {
        0: 'participants/' + id + '/registrationDetails',
        1: 'participants/' + id + '/addresses',
        2: 'participants/' + id,
        3: 'participants/' + id + '/edited_bios',
        4: 'tags/' + id + '?class=Person',
        5: 'survey_respondents/reviews/' + survey_id,
        6: 'participants/' + id + '/availabilities',
        7: 'participants/' + id + '/programme_items',
    };
    $('#participant_id').text(id);
    $('#participant_name').text(data['person[first_name]'] + ' ' + data['person[last_name]'] + ' ' + data['person[suffix]']);
    var tabs = $('#particpanttabs').tabs();
    var selected = tabs.tabs('option', 'selected');
    
    for (i = 7; i >= 0; i--) {
        if (i != selected) {
            tabs.tabs('url', i, allTabs[i]).tabs('load', i);
        }
    };
    tabs.tabs('url', selected, allTabs[selected]).tabs('load', selected);
}

/* Initialize the tags - load is called when a new participant/person is selected in the grid */
function createTabs(){
    jQuery("#particpanttabs").tabs({
        ajaxOptions: {
            async: false
        },
        cache: false
    }).tabs({
        load: function(event, ui){
            $(".addressAccordian").accordion({
                header: 'h3',
                collapsible: true,
                autoHeight: false
            });
            
            $("#items-drop").button({}).click(function(){
                var newpid = jQuery('#current-person-id').text();
                $.ajax({
                    type: 'GET',
                    url: "/programme_items/drop?person_id=" + newpid,
                    dataType: "html",
                    success: function(response){
                        // reload the tab
                        var $tabs = $('#particpanttabs').tabs();
                        var selected = $tabs.tabs('option', 'selected');
                        $tabs.tabs('load', selected);
                    }
                });
            });

            initDialog(event, ui);
        }
    });
}