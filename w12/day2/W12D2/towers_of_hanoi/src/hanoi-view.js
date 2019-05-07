class HanoiView {
  constructor (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupTowers();
    // this.render();
    this.clickTower();
  }

  setupTowers () {
    for (let i = 0; i < 3; i++) {
      const $ul = $('<ul>');
      this.$el.append($ul);
      $ul.data({pileNumber: i});
      for (let j = 1; j <= 3; j++) {
        const $li = $('<li>');
        $ul.append($li);
        if (i === 0) {
          $li.addClass(`disc-${j}`);
        }
      }
    }
  }
  // fromTower and toTower are an inteteger 1-3
  render(fromTower, toTower) {
    const $allLis = $('li');
    $allLis.removeClass();
    for (let i = 0; i < 3; i++) {
      const tower = this.game.towers[i];
      for (let j = 2; j >= 0; j--) {
        $(`.pile-${i} li:nth-child(${j})`).addClass(`disc-${tower[j]}`);
      } 
    }

    // const $fromTower = $(`.pile-${fromTower}`);
    // const $toTower = $(`.pile-${toTower}`);

    // const $fromTowerDiscs = $fromTower.children();
    // debugger
    // for (let i = 0; i < $fromTowerDiscs.length; i++) {
    //   const disc = $fromTowerDiscs[i];
    //   var $disc = $(disc);
    //   if ($disc.attr("class")) {
    //     break;
    //   }
    // }
    // const discClass = $disc.attr("class");

    // const $toTowerDiscs = $toTower.children();
    // for (let i = 0; i < $toTowerDiscs.length; i++) {
    //   const target = $toTowerDiscs[i];
    //   const $target = $(target);
    //   if (!$target.attr("class")) {
    //     $target.addClass(discClass);
    //     $disc.removeClass(discClass);
    //   }
    // }
  }

  clickTower() {
    const $ul = $("ul");
    $ul.on("click", (event) => {
      
      const tower = event.currentTarget;
      const $tower = $(tower);
      if (this.towerNumber === undefined) {
        this.towerNumber = $tower.data("pileNumber");
      } else {
        const nextTower = $tower.data("pileNumber")
        if (this.game.isValidMove(this.towerNumber, nextTower)) {
          this.game.move(this.towerNumber, nextTower);
          // this.towerNumber = int
          // nextTower = int
          this.render(this.towerNumber, nextTower);
          this.towerNumber = undefined;
        } else {
          alert('Invalid Move');
        }
      }
    });
  }
}

module.exports = HanoiView;