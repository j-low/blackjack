class window.Hand extends Backbone.Collection

  model: Card
  isPlayable: true

  initialize: (array, @deck, @isDealer) ->
    setTimeout (=>
      if @handScore() is 21
        @trigger 'blackjack', @
      ), 50

  isBusted: ->
    if @handScore() > 21
      @isPlayable = false
      return yes
    no

  handScore: ->
    if @scores()[1]? and @scores()[1] <= 21
      return @scores()[1]
    else
      @scores()[0]

  hit: ->
    if @isPlayable
      hitCard = @add(@deck.pop()).last()
      if @isBusted()
        @trigger 'turnEnded', @
      hitCard

  stand: ->
    if @isPlayable
      @trigger 'turnEnded', @
      @isPlayable = false

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  playHand: ->
    @unflip()
    while @handScore() < 17 and not @isBusted()
      @hit()
    @trigger 'turnEnded', @


  unflip: ->
    @each (card) ->
      if not card.get ('revealed') then card.flip()
    if @handScore() is 21 then @trigger 'blackjack', @

