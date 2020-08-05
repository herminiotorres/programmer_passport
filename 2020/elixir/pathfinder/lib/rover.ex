defmodule Pathfinder.Rover do
  defstruct point: {0, 0}, orientation: :north

  def new(), do: %__MODULE__{}

  def forward(%{orientation: :north, point: {x, y}} = rover) do
    %{rover | point: {x, y-1}}
  end
  def forward(%{orientation: :south, point: {x, y}} = rover) do
    %{rover | point: {x, y+1}}
  end
  def forward(%{orientation: :east, point: {x, y}} = rover) do
    %{rover | point: {x+1, y}}
  end
  def forward(%{orientation: :west, point: {x, y}} = rover) do
    %{rover | point: {x-1, y}}
  end

  def left(%{orientation: :north} = rover) do
    %{rover | orientation: :west}
  end
  def left(%{orientation: :south} = rover) do
    %{rover | orientation: :east}
  end
  def left(%{orientation: :east} = rover) do
    %{rover | orientation: :north}
  end
  def left(%{orientation: :west} = rover) do
    %{rover | orientation: :south}
  end
  def right(%{orientation: :north} = rover) do
    %{rover | orientation: :east}
  end
  def right(%{orientation: :south} = rover) do
    %{rover | orientation: :west}
  end
  def right(%{orientation: :east} = rover) do
    %{rover | orientation: :south}
  end
  def right(%{orientation: :west} = rover) do
    %{rover | orientation: :north}
  end
end
