function form_errors(form, r) {
  if(r.status == 403) {
    alert('Access Denied - make sure you are logged in. Try refreshing the page.');
  }
  else {
    errors = JSON.parse(r.responseText);
    error_str = '';

    for(idx in errors) {
      error_str += '<li>'+errors[idx]+'</li>';
    }

    form_errors_clear(form);
    form.prepend('<div class="alert alert-error">'+error_str+'</div>');
  }
}

function form_success(form) {
  callback_function = form.find('#success_function').val();
  if (callback_function != undefined && window[callback_function] !== undefined) {
    window[callback_function](form);
  }

  form_errors_clear(form);
  form[0].reset();
}

function form_errors_clear(form) {
  form.find('.alert-error').hide();
}

function success_notify(msg) {
  $(".alert-success").html(msg).slideDown('slow').delay(2000).slideUp('slow');
}

function error_notify(msg) {
  $(".alert-error").html(msg).slideDown('slow').delay(2000).slideUp('slow');
}

function info_notify(msg) {
  $(".alert-info").html(msg).slideDown('slow').delay(2000).slideUp('slow');
}

$(document).ready(function() {
  // Add access token to Data-remote forms
  $('form[data-remote]').each(function() {
    $(this).append('<input type="hidden" value="'+access_token+'" name="access_token" />');
  });

  // Form
  $('form[data-remote]').each(function() {
    $(this).bind('ajax:success', function(e) {
      form_success($(this));
    });

    $(this).bind('ajax:error', function(evt, xhr) {
      form_errors($(this), xhr);
    });
  });
});