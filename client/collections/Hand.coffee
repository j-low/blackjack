class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    # set isBusted variable
    @set 'isBusted', false
    @set 'handScore', 0

    # handle blackjack being dealt

  hit: ->
    @add(@deck.pop()).last()
    @set 'handScore', @collection.scores()[0]
    if @get 'handScore' > 21 ##bust and win condition for dealer
      @set 'isBusted', true
      @trigger 'turnEnded', @
    if @get 'handScore' is 21
      @trigger 'turnEnded', @

  stand: ->
    @trigger 'turnEnded', @

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.

    ##TODO: handle Ace score toggling
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
