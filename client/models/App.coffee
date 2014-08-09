#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'winner', undefined

    @on

    # PLAYER ENDED EVENT don't forget yo fatty arrows
    @get('playerHand').on 'turnEnded', =>
      # check if player is busted
      if (@get 'playerHand').isBusted()
        # dealer wins
        @set 'winner', 'dealer'
      # if not dealer plays
      else
        (@get 'dealerHand').playHand()


    #DEALER ENDED EVENT
    @get('dealerHand').on 'turnEnded', =>
      console.log 'dealer ends'
      if (@get 'dealerHand').isBusted()
        # dealer wins
        @set 'winner', 'player'
      else
        @compareScores()
      # if dealer busts, player wins
      # else compare scores

    @on 'change:winner', =>
      alert "The winner is: #{@get 'winner'} !!!!"

  compareScores: ->
    if (@get 'playerHand').handScore() > (@get 'dealerHand').handScore()
      @set 'winner', 'player'
    else
      @set 'winner', 'dealer'


