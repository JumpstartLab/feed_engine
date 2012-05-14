function post_added() {
  fetch_posts($('#user_posts'));
  success_notify('Your post has been added');
}

function render_posts(posts) {
  var content = '';
  for(idx in posts) {
    var post = posts[idx];
    content += render_post(post);
  }
  return content;
}

function render_post(post) {
  if($.isEmptyObject(post) == false) {
    post['created_at'] = $.timeago(post['created_at']);
    return Mustache.render($("#"+post.type+"Template").html(), post);
  }

  return "";
}

function fetch_posts(div) {
  if(display_name !== undefined) {
    url = "/api/feeds/"+display_name+"/items.json?access_token="+access_token;
    var prev_content = div.html();
    show_loading(div);

    $.ajax({
      url: url,
      success: function(data) {
        hide_loading(div);
        $(div).html(render_posts(data));
      },
      error: function(err) {
        if (err.status == 403) {
          div.html("<h4 style='text-align:center'>This user's feed is private.</h4>");
        }
      } 
    });
  }
}

$(document).ready(function() {
  fetch_posts($('#user_posts'));
});