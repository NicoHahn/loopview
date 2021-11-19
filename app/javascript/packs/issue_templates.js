$(document).on('click', '.add_attribute', function(e){
    console.log($(this).data('id'));
    console.log($('#issue_template_issue_template_attributes').val());


    let selected = $('#issue_template_issue_template_attributes').val(),
        id = $(this).data('id'),
        title = $('#issue_template_title').val();

    $.ajax('/issue_templates/add_attribute', {
        method: 'POST',
        data: {id: id, attribute_id: selected, title: title}
    }).done(function(data){
        location.href = data.location;
    })
    e.preventDefault();
});



