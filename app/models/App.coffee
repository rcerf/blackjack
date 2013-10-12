#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('add', => @hits())
    @get('dealerHand').on('stay', => @dealerStays())


  playerLoses: ->
    @trigger 'lost', @

  playerWins: ->
    @trigger 'won', @

  hits: ->
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()
    if playerScore > 21 then @playerLoses()
    if dealerScore > 21 then @playerWins()

  dealerStays: ->
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()
    if dealerScore >= playerScore then @playerLoses()
    else @playerWins()

