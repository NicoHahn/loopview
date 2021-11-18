$(document).on("turbolinks:load", function () {
    $('#issue_templates-table, #projects-table, #example').DataTable( {
        "language": {
            "zeroRecords": "Es wurden keine Einträge gefunden!",
        },
        "searching": true,
        "lengthChange": false,
        "info": false
    } );
} );
