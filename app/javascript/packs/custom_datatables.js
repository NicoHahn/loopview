$(document).ready( function () {
    $('#templates-table, #projects-table, #example').DataTable( {
        "language": {
            "length_menu": "",
            "zeroRecords": "Es wurden keine Einträge gefunden!",
            "info": "", //"Seite _PAGE_ von _PAGES_",
            "infoEmpty": "", //"Keine Einträge vorhanden!",
            "infoFiltered": "" //"(filtered from _MAX_ total records)"
        }
    } );
} );
