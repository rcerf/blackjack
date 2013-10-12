class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('add', => @hits())
    @get('playerHand').on('stay', => @dealerPlays())


  playerLoses: ->
    @trigger 'lost', @

  playerWins: ->
    @trigger 'won', @

  hits: ->
    playerScore = @get('playerHand').scores()
    dealerScore = +@get('dealerHand').scores() + +@get('dealerHand').hiddenCard()
    if playerScore > 21 then @playerLoses()

  dealerStays: ->
    @get('dealerHand').first().flip()
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()
    if dealerScore < 22 and dealerScore >= playerScore then @playerLoses()
    else @playerWins()

  dealerPlays: ->
    playerScore = +@get('playerHand').scores()
    dealerScore = +@get('dealerHand').scores() + +@get('dealerHand').hiddenCard()
    if dealerScore < 15 or dealerScore < playerScore
      @get('dealerHand').hit()
      @dealerPlays()
    else @dealerStays()