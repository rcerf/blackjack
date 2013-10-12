class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stay-button">Stay</button> <button class = "newGame-button">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  lostGameTemplate: _.template '
    <button class = "newGame-button">New Game</button>
      <div class = "lost"> You lost, sucka! </div>
    '

  wonGameTemplate: _.template '
    <button class = "newGame-button">New Game</button>
      <div class = "won"> You won!!!!! </div>
    '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stay-button": -> @model.get('playerHand').stay()
    "click .stay-button": -> @model.get('dealerHand').stay()
    "click .newGame-button": ->
      $('body').text('')
      new AppView(model: new App).$el.appendTo 'body'

  initialize: ->
    @render()
    @model.get('playerHand').on('lost', => @$el.html @lostGameTemplate())
    @model.get('playerHand').on('won', => @$el.html @wonGameTemplate())

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
