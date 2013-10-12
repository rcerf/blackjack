class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()

  dealer: -> while @scores() < 15 then @hit()

  stay: ->
    if @isDealer then @dealer()

  gameLost: -> @trigger 'lost', @; return ["You Lose"]

  gameWon: ->  @trigger 'won', @; return ["You Win!"]

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
    if !@isDealer and hasAce and score < 11 then [score + 10] else if score == 21 then @gameWon() else if score > 21 then @gameLost() else [score]
    