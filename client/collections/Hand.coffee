class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  isBusted: ->
    console.log 'isBusted called'
    if @handScore() > 21
      return yes
    no

  handScore: ->
    if @scores()[1]? and @scores()[1] < 21
      # console.log 'handScore called, @scores()[1]: ', @scores()[1]
      return @scores()[1]
    else
      # console.log 'handScore called, @scores()[0]: ', @scores()[0]
      @scores()[0]

  hit: ->
    console.log 'hit called'
    hitCard = @add(@deck.pop()).last()
    if @isBusted()
      @trigger 'turnEnded', @
      console.log 'turnENded called due to bust in hit'
    if @handScore() is 21
      @trigger 'turnEnded', @
      console.log 'turnENded called due to 21 in hit'
    hitCard

  stand: ->
    console.log 'stand called'
    @trigger 'turnEnded', @

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
