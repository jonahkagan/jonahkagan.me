(function() {

  $(function() {
    var $canvas, $cont, $start, proc;
    $canvas = $("#mainCanvas");
    $canvas[0].onselectstart = function() {
      return false;
    };
    $cont = $(".container");
    $start = $cont.find("#start");
    return proc = new Processing($canvas[0], function(p) {
      var FRAME_RATE, GENERATIONS, H, HALFH, HALFW, LENGTH_SCALE, MAX_LIFE, MAX_OFFSET, MAX_SPLIT_THETA, MIN_LIFE, NEW_FREQ, SPLIT_FREQ, W, body, bolts, boltsOn, circ, computeSegs, drawBolts, mouseX, mouseY, origin, postBolts, preBolts, rotBranch, segment, startBolts, stopBolts, v;
      FRAME_RATE = 10;
      MIN_LIFE = 1 * FRAME_RATE;
      MAX_LIFE = 5 * FRAME_RATE;
      NEW_FREQ = 0.2;
      GENERATIONS = 5;
      MAX_OFFSET = 50;
      SPLIT_FREQ = 0.3;
      MAX_SPLIT_THETA = p.radians(20);
      LENGTH_SCALE = 0.7;
      W = null;
      H = null;
      HALFW = null;
      HALFH = null;
      v = p.PVector;
      origin = new v(0, 0);
      segment = function(v1, v2, dim) {
        return {
          start: v1,
          end: v2,
          dim: dim
        };
      };
      v.perp = function(vec) {
        return new v(-vec.y, vec.x);
      };
      p.vecline = function(v1, v2) {
        return p.line(v1.x, v1.y, v2.x, v2.y);
      };
      rotBranch = function(vec, theta) {
        var cos, sin;
        sin = p.sin(theta);
        cos = p.cos(theta);
        return new v(vec.x * cos - vec.y * sin, vec.x * sin + vec.y * cos);
      };
      bolts = [];
      circ = null;
      mouseX = null;
      mouseY = null;
      p.setup = function() {
        p.size($canvas.parent().width(), $cont.find("#start").innerHeight());
        W = p.width;
        H = p.height;
        HALFW = W / 2;
        HALFH = H / 2;
        circ = body({
          pos: new v(5 / 8 * W, HALFH),
          drag: 0.5
        });
        circ.radius = 50;
        circ.draw = function() {
          var h, w;
          w = 40;
          h = 40;
          p.fill(255);
          p.stroke(0);
          p.strokeWeight(2);
          return p.ellipse(0, 0, circ.radius, circ.radius);
        };
        p.frameRate(FRAME_RATE);
        return p.noLoop();
      };
      boltsOn = false;
      startBolts = function() {
        boltsOn = true;
        return p.loop();
      };
      stopBolts = function() {
        boltsOn = false;
        bolts = [];
        p.noLoop();
        return p.redraw();
      };
      p.mousePressed = function() {
        mouseX = p.mouseX;
        mouseY = p.mouseY;
        return startBolts();
      };
      p.mouseDragged = function() {
        mouseX = p.mouseX;
        return mouseY = p.mouseY;
      };
      p.mouseReleased = function() {
        return stopBolts();
      };
      p.mouseMoved = function() {
        var diff, mv;
        mv = new v(p.mouseX, p.mouseY);
        diff = v.sub(circ.pos, mv);
        if (diff.mag() < 70) {
          circ.acc = v.add(circ.acc, v.mult(v.normalize(diff), 5));
          return p.loop();
        }
      };
      $("#toc li a").hover(function() {
        var $a;
        $a = $(this).addClass("bolt");
        mouseX = $a.offset().left + $a.outerWidth() - $canvas.offset().left;
        mouseY = $a.offset().top + $a.outerHeight() / 2 - $canvas.offset().top;
        return startBolts();
      }, function() {
        $(this).removeClass("bolt");
        if (!p.__mousePressed) {
          return stopBolts();
        }
      });
      p.draw = function() {
        preBolts();
        if (boltsOn) {
          drawBolts();
        }
        return postBolts();
      };
      preBolts = function() {
        return p.background(255);
      };
      postBolts = function() {
        var oldmag;
        p.pushMatrix();
        p.translate(circ.pos.x, circ.pos.y);
        p.fill(0);
        circ.draw();
        oldmag = circ.vel.mag();
        circ.move();
        if (oldmag !== 0 && circ.vel.mag() === 0) {
          p.noLoop();
        }
        return p.popMatrix();
      };
      drawBolts = function() {
        var bolt, endpt, seg, _i, _j, _len, _len1, _ref;
        p.pushMatrix();
        p.translate(circ.pos.x, circ.pos.y);
        if (p.random() < NEW_FREQ) {
          endpt = new v(p.random(W / 8, HALFW), 0);
          bolts.push({
            endpt: endpt,
            life: (p.random(MIN_LIFE, MAX_LIFE)) * (1 - p.norm(v.dist(origin, endpt), 0, HALFW)),
            rot: p.random(p.TWO_PI)
          });
        }
        bolts.push({
          endpt: new v(mouseX - circ.pos.x, mouseY - circ.pos.y),
          color: 1,
          life: 0,
          rot: 0
        });
        for (_i = 0, _len = bolts.length; _i < _len; _i++) {
          bolt = bolts[_i];
          p.pushMatrix();
          p.rotate(bolt.rot);
          p.stroke(bolt.color > 0 ? 0 : 150);
          _ref = computeSegs(bolt.endpt);
          for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
            seg = _ref[_j];
            p.strokeWeight(2);
            if (seg.dim) {
              p.strokeWeight(1);
            }
            p.vecline(seg.start, seg.end);
          }
          p.popMatrix();
          bolt.life -= 1;
        }
        bolts = (function() {
          var _k, _len2, _results;
          _results = [];
          for (_k = 0, _len2 = bolts.length; _k < _len2; _k++) {
            bolt = bolts[_k];
            if (bolt.life > 0) {
              _results.push(bolt);
            }
          }
          return _results;
        })();
        return p.popMatrix();
      };
      computeSegs = function(endpt) {
        var direction, end, g, midpt, newSegs, newpt, offset, seg, segs, splitpt, start, _i, _j, _len;
        segs = [segment(origin, endpt)];
        newSegs = [];
        offset = MAX_OFFSET;
        for (g = _i = 0; 0 <= GENERATIONS ? _i <= GENERATIONS : _i >= GENERATIONS; g = 0 <= GENERATIONS ? ++_i : --_i) {
          for (_j = 0, _len = segs.length; _j < _len; _j++) {
            seg = segs[_j];
            start = seg.start;
            end = seg.end;
            midpt = v.div(v.add(start, end), 2);
            newpt = v.add(midpt, v.mult(v.perp(v.normalize(v.sub(start, end))), p.random(-offset, offset)));
            newSegs.push(segment(start, newpt, seg.dim));
            newSegs.push(segment(newpt, end, seg.dim));
            if (p.random() < SPLIT_FREQ) {
              direction = v.sub(newpt, start);
              splitpt = v.add(v.mult(rotBranch(direction, p.random(MAX_SPLIT_THETA)), LENGTH_SCALE), newpt);
              newSegs.push(segment(newpt, splitpt, true));
            }
          }
          segs = newSegs;
          newSegs = [];
          offset *= 0.5;
        }
        return segs;
      };
      return body = function(spec) {
        var me, _ref, _ref1, _ref2, _ref3;
        me = {};
        me.pos = (_ref = spec.pos) != null ? _ref : new v(0, 0);
        me.vel = (_ref1 = spec.vel) != null ? _ref1 : new v(0, 0);
        me.acc = (_ref2 = spec.acc) != null ? _ref2 : new v(0, 0);
        me.drag = (_ref3 = spec.drag) != null ? _ref3 : 0;
        me.move = function() {
          var eps;
          eps = me.radius != null ? me.radius - 10 : 0;
          if (me.pos.x < 0 + eps || me.pos.x > W - eps) {
            me.vel.x = -me.vel.x;
            me.acc.x = -me.acc.x;
          }
          if (me.pos.y <= 0 + eps || me.pos.y > H - eps) {
            me.vel.y = -me.vel.y;
            me.acc.y = -me.acc.y;
          }
          me.vel = v.sub(v.add(me.vel, me.acc), v.mult(me.vel, me.drag));
          me.pos = v.add(me.pos, me.vel);
          return me.acc = new v(0, 0);
        };
        return me;
      };
    });
  });

}).call(this);
