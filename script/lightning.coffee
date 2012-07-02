$ ->

  $canvas = $("#mainCanvas")
  # kill the text select cursor on drag
  $canvas[0].onselectstart = -> false

  $cont = $(".container")
  $start = $cont.find("#start")
  #$head = $(".page-header h1")

  #mouseX, mouseY
  #$(document).mousemove(function(e) {
  #  mouseX = e.pageX - $canvas.offset().left
  #  mouseY = e.pageY - $canvas.offset().top
  #}) 

  #$(document).mousedown(function(e) {
  #  console.log("doc")
  #  $canvas.trigger(e)
  #})

  #$canvas.mousedown(function (e) {
  #  console.log("can")
  #  e.stopPropagation()
  #})


  proc = new Processing $canvas[0], (p) ->

    FRAME_RATE = 10
    MIN_LIFE = 1 * FRAME_RATE
    MAX_LIFE = 5 * FRAME_RATE
    NEW_FREQ = 0.2
    GENERATIONS = 5
    MAX_OFFSET = 50
    SPLIT_FREQ = 0.3
    MAX_SPLIT_THETA = p.radians 20
    LENGTH_SCALE = 0.7
    W = null
    H = null
    HALFW = null
    HALFH = null

    v = p.PVector
    origin = new v(0,0)
    segment = (v1, v2, dim) -> start: v1, end: v2, dim: dim
    v.perp = (vec) -> new v(-vec.y, vec.x)
    p.vecline = (v1, v2) ->
      p.line v1.x, v1.y, v2.x, v2.y
    rotBranch = (vec, theta) ->
      sin = p.sin theta
      cos = p.cos theta
      new v(vec.x * cos - vec.y * sin,
            vec.x * sin + vec.y * cos)

    bolts = []
    circ = null
    mouseX = null
    mouseY = null

    p.setup = ->
      p.size $canvas.parent().width(),
             $cont.find("#start").innerHeight()
             #$cont.find("section").offset().top -
             #   $cont.find("

      W = p.width
      H = p.height
      HALFW = W/2
      HALFH = H/2

      circ = body
        pos: new v(5/8*W, HALFH)
        drag: 0.5
      circ.radius = 50
      circ.draw = ->
        w = 40
        h = 40
        p.fill 255
        p.stroke 0
        p.strokeWeight 2
        p.ellipse 0, 0, circ.radius, circ.radius

      p.frameRate FRAME_RATE
      p.noLoop()

    boltsOn = false

    startBolts = ->
      boltsOn = true
      p.loop()

    stopBolts = ->
      boltsOn = false
      bolts = []
      p.noLoop()
      p.redraw()

    p.mousePressed = ->
      # draw bolt to the mouse
      #console.log("down")
      mouseX = p.mouseX
      mouseY = p.mouseY
      startBolts()
      #p.redraw()

    p.mouseDragged = ->
      # draw bolt to the mouse
      mouseX = p.mouseX
      mouseY = p.mouseY

    p.mouseReleased = ->
      # draw circ, no bolts 
      #console.log("up")
      stopBolts()

    p.mouseMoved = ->
      mv = new v(p.mouseX, p.mouseY)
      diff = v.sub circ.pos, mv
        #console.log(circ.pos.toString(), mv.toString(), diff.toString(), diff.mag())
      if diff.mag() < 70
        #console.log(v.mult(diff.normalize(), 30).toString())
        circ.acc = v.add circ.acc, v.mult(v.normalize(diff), 5)
        #circ.move()
        p.loop()

    $("#toc li a").hover(
      ->
        # don't take over during drag
        $a = $(this).addClass "bolt"
        mouseX = $a.offset().left + $a.outerWidth() - $canvas.offset().left
        mouseY = $a.offset().top + $a.outerHeight()/2 - $canvas.offset().top
        startBolts()
      ->
        $(this).removeClass "bolt"
        # don't kill during drag
        stopBolts() if not p.__mousePressed
    )

    #$head.hover(
    #  (e) ->
    #    # don't take over during drag
    #    $head.addClass "bolt"
    #    mouseX = e.pageX#$a.offset().left + $a.outerWidth() - $canvas.offset().left
    #    mouseY = e.pageY#$a.offset().top + $a.outerHeight()/2 - $canvas.offset().top
    #    startBolts()
    #  ->
    #    console.log "out"
    #    console.log p.__mousePressed
    #    $head.removeClass "bolt"
    #    # don't kill during drag
    #    stopBolts() if not p.__mousePressed
    #)

    p.draw = ->
      preBolts()
      drawBolts() if boltsOn
      postBolts()

    preBolts = ->
      p.background 255

    postBolts = ->
      p.pushMatrix()

      p.translate circ.pos.x, circ.pos.y
      p.fill 0
      #rad *= p.random(0.9, 1.3)
      #rad = p.norm(rad, 50, 200)
      circ.draw()
      oldmag = circ.vel.mag()
      circ.move()
      if oldmag isnt 0 and circ.vel.mag() is 0
        p.noLoop()
      p.popMatrix()

    drawBolts = ->
      p.pushMatrix()

      p.translate circ.pos.x, circ.pos.y

      if p.random() < NEW_FREQ
        endpt = new v((p.random W/8, HALFW), 0)
        bolts.push
          endpt: endpt
          life: (p.random MIN_LIFE, MAX_LIFE) *
                (1 - p.norm (v.dist origin, endpt), 0, HALFW)
          rot: p.random p.TWO_PI

      #p.ellipse(mouseX-HALFW, mouseY-HALFH, 20, 20)
      bolts.push
        endpt: new v(mouseX-circ.pos.x, mouseY-circ.pos.y)
        color: 1
        life: 0
        rot: 0

      for bolt in bolts
        p.pushMatrix()
        p.rotate bolt.rot
        p.stroke if bolt.color > 0 then 0 else 150
        #p.stroke(255, 0, 0)
        #p.vecline(new v(0, 0), bolt.endpt)
        for seg in computeSegs bolt.endpt
          p.strokeWeight 2
          p.strokeWeight 1 if seg.dim
          p.vecline seg.start, seg.end
        p.popMatrix()
        bolt.life -= 1

      bolts = (bolt for bolt in bolts when bolt.life > 0)
      
      p.popMatrix()

    computeSegs = (endpt) ->
      segs = [segment origin, endpt]
      newSegs = []
      offset = MAX_OFFSET

      for g in [0..GENERATIONS]
        for seg in segs
          start = seg.start
          end = seg.end
          midpt = v.div v.add(start, end), 2
          newpt = v.add midpt, v.mult(v.perp(v.normalize v.sub(start, end)),
                                      (p.random -offset, offset))

          newSegs.push segment(start, newpt, seg.dim)
          newSegs.push segment(newpt, end, seg.dim)

          if p.random() < SPLIT_FREQ
            direction = v.sub newpt, start
            splitpt = v.add (v.mult (rotBranch direction, p.random MAX_SPLIT_THETA),
                                    LENGTH_SCALE),
                            newpt
            newSegs.push segment(newpt, splitpt, true)

        segs = newSegs
        newSegs = []
        offset *= 0.5
      
      segs

    body = (spec) ->
      me = {}
      me.pos = spec.pos ? new v(0,0)
      me.vel = spec.vel ? new v(0,0)
      me.acc = spec.acc ? new v(0,0)
      me.drag = spec.drag ? 0
      #console.log(
      #  me.acc
      #  me.drag
      #  spec
      #)

      me.move = ->
        #me.acc = v.sub(me.acc, v.mult(me.vel, me.drag))
        #me.vel = v.add(me.vel, me.acc)
        eps = if me.radius? then me.radius - 10 else 0
        if me.pos.x < 0 + eps or me.pos.x > W - eps
          me.vel.x = -me.vel.x
          me.acc.x = -me.acc.x
        if me.pos.y <= 0 + eps or me.pos.y > H - eps
          me.vel.y = -me.vel.y
          me.acc.y = -me.acc.y

        me.vel = v.sub(
          v.add me.vel, me.acc
          v.mult me.vel, me.drag
        )
        me.pos = v.add me.pos, me.vel
        me.acc = new v(0,0)

      me
