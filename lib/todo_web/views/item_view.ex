defmodule TodoWeb.ItemView do
  use TodoWeb, :view

  def format_date(date) do
    day_of_week = day_of_week(date)
    month = month(date)
    "#{day_of_week}, #{month} #{date.day}"
  end

  defp day_of_week(date = %Date{}), do: date |> Date.day_of_week() |> day_of_week
  defp day_of_week(1), do: "Mon"
  defp day_of_week(2), do: "Tue"
  defp day_of_week(3), do: "Wed"
  defp day_of_week(4), do: "Thu"
  defp day_of_week(5), do: "Fri"
  defp day_of_week(6), do: "Sat"
  defp day_of_week(7), do: "Sun"

  defp month(date = %Date{}), do: date.month |> month
  defp month(1), do: "Jan"
  defp month(2), do: "Feb"
  defp month(3), do: "Mar"
  defp month(4), do: "Apr"
  defp month(5), do: "May"
  defp month(6), do: "Jun"
  defp month(7), do: "Jul"
  defp month(8), do: "Aug"
  defp month(9), do: "Sep"
  defp month(10), do: "Oct"
  defp month(11), do: "Nov"
  defp month(12), do: "Dec"
end
