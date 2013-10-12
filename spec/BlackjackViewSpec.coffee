describe "Black Jack Game Play", ->
  deck = null
  hand = null

    beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  it "should end game when score is at 21", ->
    hand.score = 21
    expect(trigger).toBe('winner')
    expect(trigger).toBe('endGame')

  it "should end game when score is over 21", ->
    hand.score > 21
    expect(trigger).toBe('loser!')
    expect(trigger).toBe('endGame')
