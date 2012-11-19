LINK_VALIDATOR_REGEX = /^(https?):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

LINK_GSUB = /(?:http|https):\/\/[a-z0-9]+(?:[\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(?:(?::[0-9]{1,5})?\/[^\s]*)?/ix

IMAGE_VALIDATOR_REGEX = /^https?:\/\/(?:[a-z\-\d]+\.)+[a-z]{2,6}(?:\/[^\/#?]+)+\.(?:jpg|gif|png)$/ix

YOUTUBE_REGEX = /(http:\/\/www.youtube.com\/watch\?v=|http:\/\/youtu.be\/)/