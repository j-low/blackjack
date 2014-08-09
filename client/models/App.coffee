#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'winner' null

    @on 'turnEnded' ->
      # check if player is busted
      if (@get 'playerHand').isBusted
        # dealer wins
        @set 'winner', 'dealer'
        # if not, check if dealer busted
        if (@get 'dealerHand').isBusted
          # player wins
          @set 'winner', 'player'
      # if neither busted
      else
        # compare scores, determine winner
        @compareScores()

    @on 'change:winner' ->
      alert @get 'winner'

  compareScores: ->
    if (@get 'playerHand').handScore > (@get 'dealerHand').handScore
      @set 'winner', 'player'
    else
      @set 'winner', 'dealer'


