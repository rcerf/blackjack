#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('add', => @hits())
    @get('dealerHand').on('add', => @hits())
    @get('playerHand').on('stay', => @dealerPlays())


  playerLoses: ->
    @trigger 'lost', @

  playerWins: ->
    @trigger 'won', @

  hits: ->
    console.log "hits"
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()
    if playerScore > 21 then @playerLoses()
    if dealerScore > 21 then @playerWins()

  dealerStays: ->
    console.log "delaerStays"
    @get('dealerHand').first().flip()
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()
    if dealerScore >= playerScore and dealerScore < 22 then @playerLoses()
    else if playerScore > dealerScore and playerScore < 22 then @playerWins()

  dealerPlays: ->
    console.log "dealerPlays"
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()
    if dealerScore < 15 or dealerScore < playerScore
      @get('dealerHand').hit()
      @dealerPlays()
    else @dealerStays()