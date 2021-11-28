$(document).on('click', '.create_task', function(e) {
    let id = $(this).data('id');
    console.log(id)
    $('#loader').show();
    $('#prev_loader').hide();
    $.ajax('/concrete_issue_templates/send_to_jira', {
        method: 'POST',
        data: {id: id}
    }).done(function(data){
        $('#loader').hide();
        $('#prev_loader').show();
    })
    e.preventDefault();
});
