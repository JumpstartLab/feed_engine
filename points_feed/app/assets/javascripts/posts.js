var page_for_content = 1;

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

function fetch_posts(div, page) {
  if(page == undefined) {
    $("#load_more").show();
    page = 1;
    page_for_content = 1;
  }

  if(display_name !== undefined) {
    url = "/api/feeds/"+display_name+"/items.json?access_token="+access_token+"&page="+page;
    var prev_content = div.html();
    show_loading($('#loading_posts'));

    $.ajax({
      url: url,
      success: function(data) {
        hide_loading($('#loading_posts'));

        if(data.length < 12) {
          // waypoint_remove();
          $("#load_more").hide();
        }

        if(page == 1) {
          $(div).html(render_posts(data));
        }
        else {
          $(div).append(render_posts(data));
        }
      },
      error: function(err) {
        if (err.status == 403) {
          div.html("<h4 style='text-align:center'>This user's feed is private.</h4>");
        }
      } 
    });
  }
}

// function waypoint_reload() {
//   console.log('ran');
//   page_for_content++;
//   fetch_posts($('#user_posts'), page_for_content);
// }

// function waypoint_remove() {
//   $('#bottom_of_page').waypoint('destroy');
// }

$(document).ready(function() {
  fetch_posts($('#user_posts'));

  $("#load_more").click(function(e) {
    e.preventDefault();
    page_for_content++;
    fetch_posts($("#user_posts"), page_for_content);
  }); 

  // $('#bottom_of_page').waypoint(waypoint_reload, { offset: '100%' });
});