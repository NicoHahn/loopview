$(document).on('click', '.add_attribute', function(e){
    let selected = $('#issue_template_issue_template_attributes').val(),
        id = $(this).data('id'),
        title = $('#issue_template_title').val();

    if (selected==="") {
        alert('Bitte ein Feld wählen!')
        e.preventDefault();
    } else {
        $.ajax('/issue_templates/add_attribute', {
            method: 'POST',
            data: {id: id, attribute_type: selected, title: title}
        }).done(function(data){
            location.href = data.location;
        })
        e.preventDefault();
    }
});

$(document).on('click', 'button[type=submit].aj_btn', function(e){
    $(this).children('#loader').show();
    $(this).children('#prev_loader').hide();
    e.preventDefault();
    $.ajax($(this).closest('form').data("url"), {
        method: 'PATCH',
        data: $(this).closest('form').serialize()
    }).done(function(data){
        $('#loader').hide();
        $('#prev_loader').show();
    })
    e.preventDefault();
});

