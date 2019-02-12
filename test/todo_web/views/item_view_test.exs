defmodule TodoWeb.ItemViewTest do
  use TodoWeb.ConnCase, async: true

  alias TodoWeb.ItemView

  test "formatting dates" do
    assert ItemView.format_date(~D[2019-01-27]) == "Sun, Jan 27"
    assert ItemView.format_date(~D[2019-01-28]) == "Mon, Jan 28"
    assert ItemView.format_date(~D[2019-01-29]) == "Tue, Jan 29"
    assert ItemView.format_date(~D[2019-01-30]) == "Wed, Jan 30"
    assert ItemView.format_date(~D[2019-01-31]) == "Thu, Jan 31"
    assert ItemView.format_date(~D[2019-02-01]) == "Fri, Feb 1"
    assert ItemView.format_date(~D[2019-02-02]) == "Sat, Feb 2"
  end
end
