doctype 5
html ->
  head ->
    title 'Cupcake and CoffeeCup'
    meta charset: 'utf-8'
    title "#{@title} | My Site" if @title?
    meta(name: 'description', content: @description) if @description?
    link(rel: 'canonical', href: @canonical) if @canonical?
    link rel: 'icon', href: '/favicon.png'

    script src: 'http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js'

    style '''
      header, nav, section, article, aside, footer {display: block}
      nav li {display: inline; margin:10px}
      #content {margin-left: 120px}
    '''
  body ->
    header ->
      a href: '/', title: 'Home', -> 'Home'

      nav ->
        ul ->
          for item in ['About', 'Pricing', 'Contact']
            li -> a href: "/#{item.toLowerCase()}", title: item, -> item

    div id: 'content', ->
      @body
    footer ->
      p -> a href: '/', -> '&copy; Your Name'

    coffeescript ->
      $(document).ready ->
        console.log "Ready"


