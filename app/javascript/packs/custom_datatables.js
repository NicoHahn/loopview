$(document).on("turbolinks:load", function () {
    $('#issue_templates-table:not(.dataTable), #projects-table:not(.dataTable)').DataTable( {
        "language": {
            "zeroRecords": "Es wurden keine Einträge gefunden!",
        },
        "searching": true,
        "lengthChange": false,
        "info": false
    } );
} );
