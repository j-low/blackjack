#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'winner', undefined

    # player blackjack
    @get('playerHand').on 'blackjack', =>
      setTimeout (=> $(".blink_me").show()) , 50

    # PLAYER ENDED EVENT don't forget yo fatty arrows
    @get('playerHand').on 'turnEnded', =>
      # check if player is busted
      if (@get 'playerHand').isBusted()
        # dealer wins
        @set 'winner', 'dealer'
      # if not dealer plays
      else
        (@get 'dealerHand').playHand()

    # dealer blackjack
    @get('dealerHand').on 'blackjack', =>
      setTimeout (=> alert("dealer got blackjack! you suck!!")) , 50

    #DEALER ENDED EVENT
    @get('dealerHand').on 'turnEnded', =>
      if (@get 'dealerHand').isBusted()
        # dealer wins
        @set 'winner', 'player'
      else
        @compareScores()
      # if dealer busts, player wins
      # else compare scores

    @on 'change:winner', =>
      setTimeout (=> alert("The winner is: #{@get 'winner'} !!!!")) , 50
      #trigger game reinit on AppView

  compareScores: ->
    if (@get 'playerHand').handScore() > (@get 'dealerHand').handScore()
      @set 'winner', 'player'
    else
      @set 'winner', 'dealer'

  blackjack: ->



