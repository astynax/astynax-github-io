/* WARNING: If you hotlink this, I'm not saying that I will put code in it that sends me your user's login data. But I could. */

var AdBlockBar = function() {
  this.installed = true
  this.displayOnce = true

  this.appUrls = {
    "iPrison": "http://adblockios.com/",
    "adSkynet5000": "https://adblockplus.org/",
    "aRealComputer": "https://chrismatic.io/ublock/"
  }

  this.localStorageId = '__adblockbar_shown'

  if(navigator.userAgent.match(/(iPad|iPhone|iPod)/g))
    this.platform = 'iPrison'
  else if(navigator.userAgent.match(/Android/i))
    this.platform = 'adSkynet5000'
  else
    this.platform = 'aRealComputer'

  this.detect = function() {
    var bait = document.createElement('img')
    bait.onerror = function() {
      //this.parentNode.removeChild(this)
    }
    bait.id = '__adblockbar_bait'
    bait.style['position'] = 'absolute'
    bait.style['left'] = '-999em'
    bait.src = 'ad1.jpg'

    document.getElementsByTagName('body')[0].insertBefore(bait, document.getElementsByTagName('body')[0].firstChild)

    var self = this
    setTimeout(function() {
      if(!bait || bait.style.display != 'none')
        self.display()
    }, 200)
  }

  this.display = function() {
    if(this.displayOnce === true && localStorage.getItem(this.localStorageId) == 'true')
      return

    if(this.displayOnce === true)
      localStorage.setItem(this.localStorageId, 'true')

    var html = '<div id="'+this.bannerId+'" style="position: fixed; left: 0px; border-bottom: 1px solid #DFDDCB; top: 0px; margin: 0px; width: 100%; z-index: 99999; color: rgb(111, 109, 91); font-size: 10pt; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 252, 223); text-align: left;"><a href="'+this.appUrls[this.platform]+'" style="color: rgb(79, 77, 59); text-decoration: none; font: 10pt/14px &quot;Trebuchet MS&quot;,Arial,Helvetica; padding-right: 30px; display: block;" target="_blank"><span style="display: block;  color: #fff; float: left; padding: 10px 12px 10px 8px; background: #bd695b;">&#9888; Your browser is not using an ad blocker! </span><span style="display: block; padding: 10px 10px; float: left;">This makes your browser slower and hurts your privacy. For the best web experience, you should <span style="text-decoration: underline;">install an ad blocker</span>.</span></a> <a href="" style="position: absolute; text-decoration: none; width: 12px; border: medium none; padding: 3px; top: 6px; right: 14px; color: rgb(79, 77, 59); height: 14px; font: 10pt/16px &quot;Trebuchet MS&quot;,Arial,Helvetica;" onclick="this.parentNode.style.display = \'none\'; return false">&#x2716;</a></div>'

    var banner = document.createElement('div');
    banner.innerHTML = html;
    this.banner = banner.firstChild

    var body = document.getElementsByTagName('body')[0]
    body.insertBefore(this.banner, body.firstChild)

    //this.adjustPageMargin()
  }
}

window.onload = function() {
  var adBlockBar = new AdBlockBar()
  adBlockBar.detect()
}
