require 'test_helper'

class Publications::PrintCellTest < Cell::TestCase
  test "display" do
    invoke :display
    assert_select "p"
  end
  
  test "javascript" do
    invoke :javascript
    assert_select "p"
  end
  
  test "templates" do
    invoke :templates
    assert_select "p"
  end
  

end
