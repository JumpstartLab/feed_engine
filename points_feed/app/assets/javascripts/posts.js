var page_for_content = 1;
var auth_display_name = $("#auth_display_name").val();

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
   
    if(auth_display_name != post['feeder']['name'] && post['can_refeed'] == true) {
      post['refeedable'] = true;
    }

    post['avatar'] = post['feeder']['avatar'];

    if(post['refeed'] == true) { 
      post['avatar'] = post['refeeder']['avatar'];
    }
    
    return Mustache.render($("#"+post.type+"Template").html(), post);
  }

  return "";
}

function fetch_recent_posts(div) {
  url = "/api/feeds.json";
  $.get(url, function(data) {
    data = data.slice(0, 5);
    div.html(render_posts(data));
  });
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

function positionLightboxImage() {
  var top = ($(window).height() - $('#lightbox').height()) / 3;
  var left = ($(window).width() - $('#lightbox').width()) / 2;
  $('#lightbox')
    .css({
      'top': top,
      'left': left
    })
    .fadeIn();
}

function removeLightbox() {
  $('#overlay, #lightbox')
    .fadeOut('slow', function() {
      $(this).remove();
      $('body').css('overflow-y', 'auto'); // show scrollbars!
    });
}

function award_points() {
  var cookie = $.cookie('award_points_to').split(",");
  var id = cookie[0];
  var type = cookie[1];

  $.ajax({
    type: 'post',
    url: "/api/awards/",
    data: {
      'id': id,
      'type': type,
      'access_token': access_token
    },
    success: function(data) {
      $.cookie('award_points_to', null);
      var link = $(document).find("[data-id="+id+"]")
      var parent = link.parent();
      var points = parent.find(".points");
      var img = link.find('img');

      link.hide().parent().prepend(img);
      img.css('opacity', .5);

      points.html(parseInt(points.html()) + 1);
      points_notify($(document).find("[data-id="+id+"]").parent().parent().parent(), 'Point! awarded');
    },
    error: function(evt) {
      alert('Unable to award Points!®');
      $.cookie('award_points_to', null);
    }
  });
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
  fetch_recent_posts($('#recent_posts'));

  $('a[data-toggle="tab"][href="#image_post"]').on('shown', function (e) {
    $("#tab-background").find(".active").find("#links").show();
    $("#image-url").hide();
    $("#image-file").hide();
    //console.log(content);
    console.log($(".links"));
    $(".links").show();
  });

  $('#upload-url').live('click', function(){
    $('#image-url').show();
    $('#links').hide();
  });

  $('#upload-file').live('click', function(){
    $('#image-file').show();
    $('#links').hide();
  });

  $("#subscribe_button").click(function(e) {
    e.preventDefault();
    url = "/api/friends";
    $this = $(this);

    $.post(url, { "access_token": access_token, "friend_id": user_id }, function(data) {
      $this.addClass('disabled').text('Subscribed');
    });
  });

  $("#load_more").click(function(e) {
    e.preventDefault();
    page_for_content++;
    fetch_posts($("#user_posts"), page_for_content);
  }); 

  $(".refeed_link").live('click', function(e) {
    e.preventDefault();
    $this = $(this);

    $.ajax({
      type: 'post',
      url: "/api/feeds/"+$(this).data('user')+"/items/"+$(this).data('id')+"/refeeds.json",
      data: {
        'access_token': access_token
      },
      success: function(data) {
        $this.parent().html('Post has been refeeded').addClass('label label-info');
      },
      error: function(evt) {
        alert('unable to refeed');
      }
    });
  });

  $(".points_link").live('click', function(e) {
    e.preventDefault();
    $this = $(this);

    var id = $(this).data('id');
    var type = $(this).data('type');
    $.cookie('award_points_to', [id, type]);

    if(access_token == undefined || access_token == "" || access_token == null) {
      location.href = "/signin?award_points=true";
      return false;
    }

    award_points();
  });


  $("a.lightbox").live('click', function(e) {
    $('body').css('overflow-y', 'hidden');
    
    $('<div id="overlay"></div>')
      .css('top', 'top')
      .css('opacity', '0')
      .animate({'opacity': '0.5'}, 'slow')
      .appendTo('body');
      
    $('<div id="lightbox"></div>')
      .hide()
      .appendTo('body');
      
    $('<img>')
      .attr('src', $(this).attr('href'))
      .load(function() {
        positionLightboxImage();
      })
      .click(function() {
        removeLightbox();
      })
      .appendTo('#lightbox');
    
    return false;
  });

  if($.cookie('award_points_to') != null) {
    award_points();
  }

  // $('#bottom_of_page').waypoint(waypoint_reload, { offset: '100%' });
});



