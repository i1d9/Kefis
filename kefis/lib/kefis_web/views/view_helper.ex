defmodule KefisWeb.ViewHelper do

  def display(conn) do

    

    unless Phoenix.Controller.current_path(conn) == "/" do
      "display: none"
    end
  end

end
